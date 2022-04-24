import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Layout_translet.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'المترجم حسان',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        appBarTheme: AppBarTheme(systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.cyan
        ))
      ),
      home:TransletScreen(),
    );
  }
}
