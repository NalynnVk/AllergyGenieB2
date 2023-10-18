import 'package:flutter/material.dart';

class MedPage extends StatefulWidget {
  @override
  _MedPageState createState() => _MedPageState();
}

enum MedicationRepetition { Once, Daily, MonToFri }

class Medication {
  String name;
  String dosage;
  TimeOfDay time;
  bool isEnabled; // To enable/disable the reminder
  MedicationRepetition repetition; // To set repetition

  Medication(this.name, this.dosage, this.time,
      {this.isEnabled = true, this.repetition = MedicationRepetition.Once});
}

class _MedPageState extends State<MedPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController dosageController = TextEditingController();
  TimeOfDay selectedTime = TimeOfDay.now();
  MedicationRepetition selectedRepetition = MedicationRepetition.Once;
  Medication? editedMedication;
  List<Medication> medications = [
    // Default reminders (you can edit or change these)
    Medication('Medication 1', 'Dosage 1', TimeOfDay(hour: 8, minute: 0)),
    Medication('Medication 2', 'Dosage 2', TimeOfDay(hour: 12, minute: 0)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: medications.length,
              itemBuilder: (context, index) {
                final medication = medications[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 23.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(16.0),
                      title: Text(
                        medication.name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Dosage : ${medication.dosage}'),
                          Text('Time : ${medication.time.format(context)}'),
                          Row(
                            children: <Widget>[
                              Text(
                                  'Repeats : ${_getRepetitionText(medication.repetition)}'),
                            ],
                          ),
                        ],
                      ),
                      trailing: Wrap(
                        spacing: 12, // Spacing between buttons
                        children: [
                          Column(
                            children: [
                              Switch(
                                value: medication.isEnabled,
                                onChanged: (value) {
                                  setState(() {
                                    medication.isEnabled = value;
                                  });
                                },
                              ),
                              Text(
                                'Enabled',
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.edit,
                                  color: Color.fromARGB(255, 255, 104, 139),
                                ),
                                onPressed: () {
                                  setState(() {
                                    editedMedication = medication;
                                    nameController.text = medication.name;
                                    dosageController.text = medication.dosage;
                                    selectedTime = medication.time;
                                    selectedRepetition = medication.repetition;
                                  });
                                  _showEditDialog(context, index);
                                },
                              ),
                              Text(
                                'Edit',
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: Color.fromARGB(255, 255, 104, 139),
                                ),
                                onPressed: () {
                                  setState(() {
                                    medications.removeAt(index);
                                  });
                                },
                              ),
                              Text(
                                'Delete',
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          editedMedication = null;
          _showAddDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  String _getRepetitionText(MedicationRepetition repetition) {
    switch (repetition) {
      case MedicationRepetition.Once:
        return 'Once';
      case MedicationRepetition.Daily:
        return 'Daily';
      case MedicationRepetition.MonToFri:
        return 'Mon to Fri';
      default:
        return 'Unknown';
    }
  }

  Future<void> _showAddDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Medication Reminder'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Medication Name'),
              ),
              TextField(
                controller: dosageController,
                decoration: InputDecoration(labelText: 'Dosage'),
              ),
              ListTile(
                title: Text(
                  'Time:',
                  style: TextStyle(fontSize: 18.0),
                ),
                trailing: TextButton(
                  onPressed: () async {
                    final selectedNewTime = await showTimePicker(
                      context: context,
                      initialTime: selectedTime,
                    );
                    if (selectedNewTime != null) {
                      setState(() {
                        selectedTime = selectedNewTime;
                      });
                    }
                  },
                  child: Text(
                    selectedTime.format(context),
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
              Text('Repetition:'),
              DropdownButton<MedicationRepetition>(
                value: selectedRepetition,
                items: MedicationRepetition.values
                    .map(
                      (repetition) => DropdownMenuItem<MedicationRepetition>(
                        value: repetition,
                        child: Text(_getRepetitionText(repetition)),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedRepetition = value!;
                  });
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  if (editedMedication == null) {
                    medications.add(Medication(
                      nameController.text,
                      dosageController.text,
                      selectedTime,
                      repetition: selectedRepetition,
                    ));
                  } else {
                    final index = medications.indexOf(editedMedication!);
                    medications[index] = Medication(
                      nameController.text,
                      dosageController.text,
                      selectedTime,
                      repetition: selectedRepetition,
                    );
                  }
                  nameController.clear();
                  dosageController.clear();
                  editedMedication = null;
                  Navigator.of(context).pop();
                });
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showEditDialog(BuildContext context, int index) async {
    await _showAddDialog(context);
  }
}
