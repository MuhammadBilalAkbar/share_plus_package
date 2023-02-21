import 'package:flutter/material.dart';

import 'pages/share_plus_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Share Plus Plugin Demo',
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: const Color(0x9f4376f8),
          appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(fontSize: 30),
            backgroundColor: Colors.orange,
          ),
          textTheme: const TextTheme(
            bodyLarge: TextStyle(fontSize: 30.0),
            titleMedium: TextStyle(fontSize: 30.0),
            labelLarge: TextStyle(fontSize: 25.0),
          ),
        ),
        home: const SharePlusPage(),
      );
}
