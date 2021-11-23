import 'package:app/contracts/api.swagger.dart';
import 'package:app/contracts/client_index.dart';
import 'package:app/features/app/widgets/picloud_app.dart';
import 'package:app/features/file_explorer/data/directory_manager.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider(
          create: (context) => ChopperClient(
            converter: $JsonSerializableConverter(),
            baseUrl: 'http://100.106.232.78:8080/api',
          ),
        ),
        Provider(create: (context) => Api.create(context.read())),
        Provider(create: (context) => DirectoryManager(context.read())),
      ],
      child: const PICloudApp(),
    ),
  );
}
