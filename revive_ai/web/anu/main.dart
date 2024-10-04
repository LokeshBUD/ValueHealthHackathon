import 'package:flutter/material.dart';
import 'login_page.dart';
import 'dashboard_page.dart';
import 'survey_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Burnout Tracker',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        fontFamily: 'Roboto',
        textTheme: TextTheme(
           bodyLarge: TextStyle(fontSize: 16.0, fontFamily: 'Hind'),
        ),
      ),
      initialRoute: '/dashboard',  // Set to /dashboard instead of '/'
      routes: {
        '/': (context) => LoginPage(),
        '/dashboard': (context) => DashboardPage(),
        '/survey': (context) => SurveyPage(),
      },
    );
  }
}
