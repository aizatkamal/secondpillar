import 'package:flutter/material.dart';
import 'package:second_pillar/home.dart';
import 'package:second_pillar/loading.dart';
import 'package:second_pillar/location.dart';

void main() => runApp(MaterialApp(
  title: 'Second Pillar',
  theme: ThemeData(
    primarySwatch: Colors.indigo,
  ),
  initialRoute: '/loading',
  routes: {
    '/home': (context) => Home(),
    '/loading': (context) => Loading(),
    '/location': (context) => Location(),
  },
));