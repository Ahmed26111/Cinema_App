import 'dart:developer';

import 'package:cinema_app/data/models/cast_model.dart';
import 'package:cinema_app/data/models/company_model.dart';
import 'package:cinema_app/data/models/genre_model.dart';
import 'package:cinema_app/data/models/movie_model.dart';
import 'package:cinema_app/data/repositories/movie_repository.dart';
import 'package:cinema_app/data/services/dio_helper.dart';
import 'package:flutter/material.dart';

void main(){
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
