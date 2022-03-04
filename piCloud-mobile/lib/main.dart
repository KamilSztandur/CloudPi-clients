import 'package:app/common/auth/auth_interceptor.dart';
import 'package:app/common/auth/auth_manager.dart';
import 'package:app/common/core/config.dart';
import 'package:app/contracts/api.swagger.dart';
import 'package:app/features/app/widgets/picloud_app.dart';
import 'package:app/features/file_explorer/data/directory_manager.dart';
import 'package:app/features/media_reader/data/media_reader_service.dart';
import 'package:app/features/search_page/data/search_engine.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final authManager = AuthManager(const FlutterSecureStorage());
  await authManager.init();

  runApp(
    MultiProvider(
      providers: [
        Provider.value(value: authManager),
        Provider(
          create: (context) => ChopperClient(
            converter: $JsonSerializableConverter(),
            baseUrl: Config.apiBaseUrl,
            interceptors: <RequestInterceptor>[AuthInterceptor(context.read())],
          ),
        ),
        Provider(create: (context) => Api.create(context.read())),
        Provider(
          create: (context) => DirectoryManager(
            context.read<Api>(),
            context.read<AuthManager>(),
          ),
        ),
        Provider(
          create: (context) => SearchEngine(
            context.read<AuthManager>(),
          ),
        ),
        Provider(
          create: (context) => MediaReaderService(
            context.read<AuthManager>(),
          ),
        ),
      ],
      child: const PICloudApp(),
    ),
  );
}
