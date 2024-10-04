import 'package:flutter/material.dart';

class SurveyPage extends StatefulWidget {
  @override
  _SurveyPageState createState() => _SurveyPageState();
}

class _SurveyPageState extends State<SurveyPage> {
  List<String> selectedValues = List<String>.filled(11, '');
  bool formValid = true;

  List<List<String>> categoriesOrder = [
    ['Low', 'Moderate', 'High'],
    ['Negative', 'Neutral', 'Positive'],
    ['Poor', 'Average', 'Good'],
    ['Low', 'Moderate', 'High'],
    ['Low', 'Normal', 'Extended', 'Overworking'],
    ['Dissatisfied', 'Neutral', 'Very Satisfied'],
    ['Low', 'Moderate', 'High'],
    ['Low Balance', 'Moderately Balanced', 'Balanced'],
    ['None', 'Occasional', 'Frequent', 'Constant'],
    ['Unclear', 'Somewhat Clear', 'Very Clear'],
    ['Low', 'Moderate', 'High'],
  ];

  List<String> categoryLabels = [
    'Stress Level',
    'Mood Rating',
    'Sleep Quality',
    'Energy Level',
    'Work Hours Per Day',
    'Job Satisfaction',
    'Workload Intensity',
    'Break Frequency',
    'Overtime Frequency',
    'Role Clarity',
    'Autonomy in Work',
  ];

  String? burnoutLevel; // Variable to store the burnout level

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Burnout Survey', style: TextStyle(fontFamily: 'Montserrat', fontSize: 22)),
        backgroundColor: Colors.deepPurpleAccent,
        elevation: 4,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: categoriesOrder.length,
                itemBuilder: (context, index) {
                  return _buildDropdownQuestion(index);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurpleAccent,
        onPressed: () {
          if (_validateForm()) {
            // Detect burnout and set the level
            if (isBurnoutDetected(selectedValues)) {
              burnoutLevel = determineBurnoutLevel(selectedValues);
            } else {
              burnoutLevel = 'No Burnout';
            }
            Navigator.pop(context, burnoutLevel);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Please fill all fields!', style: TextStyle(fontFamily: 'Montserrat')),
                backgroundColor: Colors.redAccent,
              ),
            );
          }
        },
        child: Icon(Icons.check),
      ),
    );
  }

  Widget _buildDropdownQuestion(int index) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              categoryLabels[index],
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.deepPurple,
                fontFamily: 'Montserrat',
              ),
            ),
            SizedBox(height: 10),
            DropdownButton<String>(
              value: selectedValues[index] != '' ? selectedValues[index] : null,
              hint: Text('Select ${categoryLabels[index]}', style: TextStyle(color: Colors.grey[700])),
              items: categoriesOrder[index]
                  .map((value) => DropdownMenuItem<String>(
                        value: value,
                        child: Text(value, style: TextStyle(color: Colors.black87)),
                      ))
                  .toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedValues[index] = newValue!;
                });
              },
              isExpanded: true,
            ),
          ],
        ),
      ),
    );
  }

  bool isBurnoutDetected(List<String> surveyAnswers) {
    int burnoutIndicators = 0;
    List<String> highBurnoutResponses = [
      'High', 'Negative', 'Poor', 'Low', 'Overworking',
      'Dissatisfied', 'High', 'Low Balance', 'Frequent', 'Unclear', 'Low'
    ];

    for (String answer in surveyAnswers) {
      if (highBurnoutResponses.contains(answer)) {
        burnoutIndicators++;
      }
    }
    return burnoutIndicators >= 5; // Burnout if 5 or more indicators
  }

  String determineBurnoutLevel(List<String> surveyAnswers) {
    int burnoutIndicators = 0;
    List<String> seriousResponses = ['High', 'Overworking', 'Dissatisfied'];
    
    for (String answer in surveyAnswers) {
      if (seriousResponses.contains(answer)) {
        burnoutIndicators++;
      }
    }
    
    if (burnoutIndicators >= 4) {
      return 'Very Serious Burnout';
    } else if (burnoutIndicators >= 2) {
      return 'Serious Burnout';
    } else {
      return 'Mild Burnout';
    }
  }

  bool _validateForm() {
    return selectedValues.every((value) => value.isNotEmpty);
  }
}
