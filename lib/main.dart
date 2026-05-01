import 'dart:developer';
import 'package:cinema_app/data/models/ticket/ticket_model.dart';
import 'package:cinema_app/data/models/user/user_model.dart';
import 'package:cinema_app/utils/shared/hive_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:uuid/uuid.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveHandler.init();
  await dotenv.load(fileName: "keys.env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Placeholder(),
    );
  }
}
