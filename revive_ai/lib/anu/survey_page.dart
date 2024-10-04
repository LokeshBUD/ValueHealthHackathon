import 'package:flutter/material.dart';

class SurveyPage extends StatefulWidget {
  @override
  _SurveyPageState createState() => _SurveyPageState();
}

class _SurveyPageState extends State<SurveyPage> {
  double _surveyResult = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Survey'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'How stressed are you?',
              style: TextStyle(fontSize: 20),
            ),
            Slider(
              value: _surveyResult,
              min: 0,
              max: 100,
              divisions: 10,
              label: _surveyResult.toInt().toString(),
              onChanged: (value) {
                setState(() {
                  _surveyResult = value;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, _surveyResult);  // Pop with the result
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
