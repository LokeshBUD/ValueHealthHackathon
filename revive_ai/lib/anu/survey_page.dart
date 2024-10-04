import 'package:flutter/material.dart';

class SurveyPage extends StatefulWidget {
  @override
  _SurveyPageState createState() => _SurveyPageState();
}

class _SurveyPageState extends State<SurveyPage> {
  // Store selected values for each category
  List<String> selectedValues = List<String>.filled(11, ''); // Initially empty

  // Define the categories and their options
  List<List<String>> categoriesOrder = [
    ['Low', 'Moderate', 'High'],             // Stress Level
    ['Negative', 'Neutral', 'Positive'],     // Mood Rating
    ['Poor', 'Average', 'Good'],             // Sleep Quality
    ['Low', 'Moderate', 'High'],             // Energy Level
    ['Low', 'Normal', 'Extended', 'Overworking'],  // Work Hours Per Day
    ['Dissatisfied', 'Neutral', 'Very Satisfied'], // Job Satisfaction
    ['Low', 'Moderate', 'High'],             // Workload Intensity
    ['Low Balance', 'Moderately Balanced', 'Balanced'],  // Break Frequency
    ['None', 'Occasional', 'Frequent', 'Constant'],      // Overtime Frequency
    ['Unclear', 'Somewhat Clear', 'Very Clear'],         // Role Clarity
    ['Low', 'Moderate', 'High'],              // Autonomy in Work
  ];

  // Define the labels for each category
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Burnout Survey', style: TextStyle(fontFamily: 'Montserrat', fontSize: 22)),
        backgroundColor: Colors.deepPurpleAccent,
        elevation: 4,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade200, Colors.pink.shade200],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: categoriesOrder.length,
          itemBuilder: (context, index) {
            return _buildDropdownQuestion(index);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurpleAccent,
        onPressed: () {
          // Handle form submission logic here
          print("Survey Results: $selectedValues");
          Navigator.pop(context, selectedValues);  // Pass the selected values back
        },
        child: Icon(Icons.check),
      ),
    );
  }

  // Helper method to build a dropdown for each category
  Widget _buildDropdownQuestion(int index) {
    Color cardColor = index.isEven ? Colors.white : Colors.yellow[50]!; // Alternate card colors

    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      color: cardColor,
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
              hint: Text(
                'Select ${categoryLabels[index]}',
                style: TextStyle(color: Colors.grey[700], fontFamily: 'Montserrat'),
              ),
              dropdownColor: Colors.white,
              icon: Icon(Icons.arrow_drop_down, color: Colors.deepPurpleAccent),
              underline: Container(),  // Remove default underline
              items: categoriesOrder[index]
                  .map((value) => DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(fontFamily: 'Montserrat', color: Colors.black87),
                        ),
                      ))
                  .toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedValues[index] = newValue!;
                });
              },
              isExpanded: true,
              style: TextStyle(color: Colors.black87, fontSize: 16, fontFamily: 'Montserrat'),
            ),
          ],
        ),
      ),
    );
  }
}
