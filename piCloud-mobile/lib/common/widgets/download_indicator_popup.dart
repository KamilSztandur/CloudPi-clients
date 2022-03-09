import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';

class DownloadIndicatorPopup {
  DownloadIndicatorPopup({
    required this.context,
    required this.headers,
    required this.requestUrl,
    required this.fullPath,
  });

  final BuildContext context;
  final Map<String, String> headers;
  final String requestUrl, fullPath;
  Future? _response;

  int? _progress;

  void close() => AutoRouter.of(context).pop();

  Future<void> start() async {
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            if (_response == null) {
              final dioClient = dio.Dio();

              _response = dioClient.download(
                requestUrl,
                fullPath,
                onReceiveProgress: (received, total) {
                  final percents = _getPercentProgress(received, total);

                  if (percents == 100) {
                    print('zamykam');
                    close();
                  } else {
                    setState(() {
                      _progress = percents;
                    });
                  }
                },
                options: dio.Options(headers: headers),
              );
            }

            return AlertDialog(
              backgroundColor: Colors.transparent,
              elevation: 0,
              content: Stack(
                children: [
                  Center(child: _buildCircleIndicator()),
                  Center(child: _buildTextIndicator()),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildCircleIndicator() {
    final size = MediaQuery.of(context).size.shortestSide * 0.5;
    return SizedBox(
      height: size,
      width: size,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        backgroundColor: Colors.white,
        value: _isProgressValid() ? _progress! / 100 : null,
      ),
    );
  }

  Widget _buildTextIndicator() {
    final message = _isProgressValid() ? '$_progress%' : 'Downloading...';

    return Text(
      message,
      style: TextStyle(
        color: Theme.of(context).primaryColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  bool _isProgressValid() =>
      _progress != null && (_progress! <= 100 && _progress! >= 0);

  int _getPercentProgress(int received, int total) =>
      ((received / total) * 100).floor();
}
