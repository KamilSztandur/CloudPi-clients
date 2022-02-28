import 'package:app/common/auth/auth_interceptor.dart';
import 'package:app/common/auth/auth_manager.dart';
import 'package:app/common/core/config.dart';
import 'package:app/common/preferences/app_shared_preferences.dart';
import 'package:app/common/preferences/view_mode_cubit.dart';
import 'package:app/contracts/api.swagger.dart';
import 'package:app/features/app/widgets/picloud_app.dart';
import 'package:app/features/file_explorer/data/directory_manager.dart';
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
        Provider(create: (context) => AppSharedPreferences(context.read())),
        Provider(create: (context) => DirectoryManager(context.read())),
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
