import 'package:flutter/material.dart';
import 'package:mini_court_book/core/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mini CourtBook',
      theme: AppTheme.theme,
      home: SizedBox(),
    );
  }
}
