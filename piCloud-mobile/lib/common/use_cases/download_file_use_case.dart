import 'package:android_path_provider/android_path_provider.dart';
import 'package:app/common/auth/auth_manager.dart';
import 'package:app/common/core/config.dart';
import 'package:app/common/widgets/download_indicator_popup.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class DownloadFileUseCase {
  const DownloadFileUseCase(this._authManager);

  final AuthManager _authManager;

  Future<void> invoke(
    String name,
    String pubId, {
    BuildContext? context,
  }) async {
    final headers = await _getHeaders();
    final requestUrl = '${Config.apiBaseUrl}/files/file/$pubId';

    final downloadsPath = await AndroidPathProvider.downloadsPath;
    final fullPath = '$downloadsPath/$name';

    if (context != null) {
      await _downloadWithGUIIndicator(headers, requestUrl, fullPath, context);
    } else {
      await _downloadWithoutGUIIndicator(headers, requestUrl, fullPath);
    }
  }

  Future<void> _downloadWithGUIIndicator(
    Map<String, String> headers,
    String requestUrl,
    String fullPath,
    BuildContext context,
  ) async {
    try {
      if (await Permission.storage.isDenied) {
        await Permission.storage.request();
      }

      if (await Permission.storage.isGranted) {
        final progressIndicator = DownloadIndicatorPopup(
          context: context,
          requestUrl: requestUrl,
          fullPath: fullPath,
          headers: headers,
        );

        await progressIndicator.start();
      }
    } catch (exception) {
      rethrow;
    }
  }

  Future<void> _downloadWithoutGUIIndicator(
    Map<String, String> headers,
    String requestUrl,
    String fullPath,
  ) async {
    final dioClient = dio.Dio();

    try {
      if (await Permission.storage.isDenied) {
        await Permission.storage.request();
      }

      if (await Permission.storage.isGranted) {
        await dioClient.download(
          requestUrl,
          fullPath,
          options: dio.Options(headers: headers),
        );
      }
    } catch (exception) {
      rethrow;
    }
  }

  Future<Map<String, String>> _getHeaders() async {
    return {'Authorization': 'Bearer ${await _authManager.getAccessToken()}'};
  }
}
