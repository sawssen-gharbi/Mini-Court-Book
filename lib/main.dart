import 'package:device_preview_plus/device_preview_plus.dart';
import 'package:flutter/material.dart';
import 'package:mini_court_book/core/theme/theme.dart';

void main() =>
    runApp(DevicePreview(enabled: true, builder: (context) => MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      title: 'Mini CourtBook',
      theme: AppTheme.theme,
      home: SizedBox(),
    );
  }
}
