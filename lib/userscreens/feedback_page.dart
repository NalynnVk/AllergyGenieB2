import 'package:calendar/userscreens/profile_page.dart';
import 'package:flutter/material.dart';

class FeedbackPage extends StatefulWidget {
  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  String _selectedRating = '5 Stars';
  final TextEditingController _feedbackController = TextEditingController();

  List<String> _ratings = [
    '5 Stars',
    '4 Stars',
    '3 Stars',
    '2 Stars',
    '1 Star'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Feedback'),
        backgroundColor: const Color(0xFF4A90E2), // Modern color
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return ProfilePage();
                },
              ),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Your Feedback',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4A90E2), // Modern color
                ),
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _selectedRating,
                items: _ratings.map((String rating) {
                  return DropdownMenuItem<String>(
                    value: rating,
                    child: Text(
                      rating,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Color(0xFF4A90E2), // Modern color
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedRating = newValue!;
                  });
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _feedbackController,
                maxLines: 5,
                style:
                    const TextStyle(color: Color(0xFF4A90E2)), // Modern color
                decoration: const InputDecoration(
                  labelText: 'Share your feedback',
                  labelStyle: TextStyle(
                    color: Color(0xFF4A90E2), // Modern color
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  String rating = _selectedRating;
                  String feedback = _feedbackController.text;

                  // Save feedback to your database or send it to your server

                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Feedback Submitted'),
                        content:
                            const Text('Thank you for your valuable feedback!'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );

                  _feedbackController.clear();
                },
                child: const Text('Submit Feedback'),
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xFF4A90E2), // Modern color
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
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
