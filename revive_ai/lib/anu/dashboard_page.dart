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
            colors: [Colors.deepPurple, Colors.purpleAccent],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome, [User Name]',
                style: TextStyle(
                  fontSize: 28,
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
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  backgroundColor: Colors.purple[300],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 5,
                ),
                onPressed: () async {
                  // Navigate to Survey page
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SurveyPage()),
                  );

                  if (result != null && result is List<String>) {
                    setState(() {
                      // Assuming the result is a list of strings representing the survey results
                      burnoutLevel = _calculateBurnoutLevel(result);
                    });
                  }
                },
                child: Text(
                  'Take Survey',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
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
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [Colors.purpleAccent, Colors.deepPurple],
          center: Alignment.center,
          radius: 0.85,
        ),
        borderRadius: BorderRadius.circular(120),
        boxShadow: [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Burnout Level',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 10),
          Text(
            '${burnoutLevel.toStringAsFixed(1)}%',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
