import 'package:flutter/material.dart';
import 'survey_page.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String burnoutStatus = 'No Burnout'; // Initial burnout status

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.deepPurple.shade900, Colors.purpleAccent.shade200],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome, [User Name]',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Montserrat',
                ),
              ),
              SizedBox(height: 40),
              Text(
                'Burnout Status: $burnoutStatus',
                style: TextStyle(fontSize: 24, color: Colors.white, fontFamily: 'Montserrat'),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  backgroundColor: Colors.purpleAccent.shade400,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 8,
                  shadowColor: Colors.black38,
                ),
                onPressed: () async {
                  // Navigate to Survey page
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SurveyPage()),
                  );

                  if (result != null && result is String) {
                    setState(() {
                      burnoutStatus = result; // Update burnout status
                    });
                  }
                },
                child: Text(
                  'Take Survey',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
