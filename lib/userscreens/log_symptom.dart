import 'package:flutter/material.dart';

class Event {
  final String foodOrMedication;
  final String symptomCategory;
  final String notes;
  final int severity;
  final DateTime timestamp;

  Event({
    required this.foodOrMedication,
    required this.symptomCategory,
    required this.notes,
    required this.severity,
    required this.timestamp,
  });
}

class EventDetailsPage extends StatefulWidget {
  final Event event;

  EventDetailsPage({required this.event});

  @override
  _EventDetailsPageState createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  late TextEditingController _eventController;
  late TextEditingController _symptomCategoryController;
  late TextEditingController _severityController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _eventController =
        TextEditingController(text: widget.event.foodOrMedication);
    _symptomCategoryController =
        TextEditingController(text: widget.event.symptomCategory);
    _severityController =
        TextEditingController(text: widget.event.severity.toString());
    _descriptionController = TextEditingController(text: widget.event.notes);
  }

  @override
  void dispose() {
    _eventController.dispose();
    _symptomCategoryController.dispose();
    _severityController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _updateEvent() {
    final updatedEvent = Event(
      foodOrMedication: _eventController.text,
      symptomCategory: _symptomCategoryController.text,
      severity: int.parse(_severityController.text),
      notes: _descriptionController.text,
      timestamp: widget.event.timestamp,
    );

    Navigator.of(context).pop(updatedEvent);
  }

  void _deleteEvent() {
    Navigator.of(context).pop(true); // Signal for event deletion
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Details'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Delete Event'),
                    content:
                        Text('Are you sure you want to delete this event?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          _deleteEvent();
                        },
                        child: Text('Delete'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _eventController,
                decoration:
                    InputDecoration(labelText: 'Food and/or Medication'),
              ),
              TextFormField(
                controller: _symptomCategoryController,
                decoration: InputDecoration(labelText: 'Symptom Category'),
              ),
              TextFormField(
                controller: _severityController,
                decoration: InputDecoration(labelText: 'Severity (0-10)'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Notes'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _updateEvent,
                child: Text('Update Event'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
