import 'package:app/common/auth/auth_interceptor.dart';
import 'package:app/common/auth/auth_manager.dart';
import 'package:app/common/core/config.dart';
import 'package:app/common/preferences/app_shared_preferences.dart';
import 'package:app/common/preferences/view_mode_cubit.dart';
import 'package:app/contracts/api.swagger.dart';
import 'package:app/features/app/widgets/picloud_app.dart';
import 'package:app/features/favorites_page/data/favorites_manager.dart';
import 'package:app/features/file_explorer/data/directory_manager.dart';
import 'package:app/features/media_reader/data/media_reader_service.dart';
import 'package:app/features/search_page/data/search_engine.dart';
import 'package:app/features/shared_page/data/shared_manager.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final authManager = AuthManager(const FlutterSecureStorage());
  await authManager.init();

  final sharedPreferences = await SharedPreferences.getInstance();

  final appSharedPreferences = AppSharedPreferences(sharedPreferences);
  await appSharedPreferences.init();

  runApp(
    MultiProvider(
      providers: [
        Provider.value(value: authManager),
        Provider.value(value: sharedPreferences),
        Provider(
          create: (context) => ChopperClient(
            converter: $JsonSerializableConverter(),
            baseUrl: Config.apiBaseUrl,
            interceptors: <RequestInterceptor>[AuthInterceptor(context.read())],
          ),
        ),
        Provider(create: (context) => Api.create(context.read())),
        Provider(create: (context) => appSharedPreferences),
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
          create: (context) => FavoritesManager(
            context.read(),
            context.read(),
          ),
        ),
        Provider(
          create: (context) => SharedManager(
            context.read(),
            context.read(),
          ),
        ),
        Provider(
          create: (context) => MediaReaderService(
            context.read<AuthManager>(),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ViewModeCubit(context.read())),
        ],
        child: const PICloudApp(),
      ),
    ),
  );
}
