import 'package:flutter/material.dart';
import 'survey_page.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  double burnoutLevel = 0; // Initial burnout level set to 0%

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
              BurnoutGauge(burnoutLevel: burnoutLevel),
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

                  if (result != null && result is List<String>) {
                    setState(() {
                      burnoutLevel = _calculateBurnoutLevel(result);
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

  // Function to calculate the burnout level from survey results
  double _calculateBurnoutLevel(List<String> results) {
    // Implement your logic to calculate the burnout level based on survey results
    return 0; // Placeholder
  }
}

class BurnoutGauge extends StatelessWidget {
  final double burnoutLevel;

  BurnoutGauge({required this.burnoutLevel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [Colors.deepPurple.shade600, Colors.purpleAccent.shade100],
          center: Alignment.center,
          radius: 0.85,
        ),
        borderRadius: BorderRadius.circular(150),
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 25,
            spreadRadius: 8,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Burnout Level',
            style: TextStyle(
              fontSize: 22,
              color: Colors.white70,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 15),
          Text(
            '${burnoutLevel.toStringAsFixed(1)}%',
            style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 10),
          Text(
            burnoutLevel < 50
                ? 'Keep Going!'
                : burnoutLevel < 80
                    ? 'Take a Break!'
                    : 'Seek Help!',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white70,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}
