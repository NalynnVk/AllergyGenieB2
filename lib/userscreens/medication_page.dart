import 'package:flutter/material.dart';

class MedPage extends StatefulWidget {
  @override
  _MedPageState createState() => _MedPageState();
}

enum MedicationRepetition { Once, Daily, Weekdays }

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
                        'Medication: ${medication.name}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Dosage: ${medication.dosage}'),
                          Text('Time: ${medication.time.format(context)}'),
                          Row(
                            children: <Widget>[
                              Text(
                                  'Enabled: ${medication.isEnabled ? 'Yes' : 'No'}'),
                              SizedBox(width: 16.0),
                              Text(
                                  'Repeats: ${_getRepetitionText(medication.repetition)}'),
                            ],
                          ),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Switch(
                            value: medication.isEnabled,
                            onChanged: (value) {
                              setState(() {
                                medication.isEnabled = value;
                              });
                            },
                          ),
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
          showDialog(
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
                          .map((repetition) =>
                              DropdownMenuItem<MedicationRepetition>(
                                value: repetition,
                                child: Text(_getRepetitionText(repetition)),
                              ))
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
                        medications.add(Medication(
                          nameController.text,
                          dosageController.text,
                          selectedTime,
                          repetition: selectedRepetition,
                        ));
                        nameController.clear();
                        dosageController.clear();
                        Navigator.of(context).pop();
                      });
                    },
                    child: Text('Save'),
                  ),
                ],
              );
            },
          );
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
      case MedicationRepetition.Weekdays:
        return 'Mon to Fri';
      default:
        return 'Unknown';
    }
  }
}
