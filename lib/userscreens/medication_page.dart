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
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Scaffold(
        // borderRadius: BorderRadius.circular(15),
        // appBar: AppBar(
        //   title: Text('Medication Reminders'),
        //   centerTitle: true,
        // ),
        body: ListView.builder(
          itemCount: medications.length,
          itemBuilder: (context, index) {
            final medication = medications[index];
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 5.0,
              margin: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListTile(
                  title: Text(
                    medication.name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Dosage   : ${medication.dosage}'),
                      Text('Time        : ${medication.time.format(context)}'),
                      // Text(
                      //     'Repeat   : ${_getRepetitionText(medication.repetition)}'),
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
                          Icons.edit,
                          color: Theme.of(context).primaryColor,
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
                      // IconButton(
                      //   icon: Icon(
                      //     Icons.delete,
                      //     color: Colors.red,
                      //   ),
                      //   onPressed: () {
                      //     setState(() {
                      //       medications.removeAt(index);
                      //     });
                      //   },
                      // ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            editedMedication = null;
            _showAddDialog(context);
          },
          child: Icon(Icons.add),
        ),
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

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _showDeleteDialog(BuildContext context, int index) async {
    final medication = medications[index];

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Medication Reminder'),
          content:
              Text('Are you sure you want to delete this medication reminder?'),
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
                  medications.removeAt(index);
                });
                Navigator.of(context).pop(); // Close the dialog explicitly
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showAddDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          title: Center(child: Text('Medication Reminder')),
          content: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(labelText: 'Medication Name'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextField(
                      controller: dosageController,
                      decoration: InputDecoration(labelText: 'Dosage'),
                    ),
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
                  ListTile(
                    title: Text(
                      'Repetition:',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    trailing: DropdownButton<MedicationRepetition>(
                      value: selectedRepetition,
                      items: MedicationRepetition.values
                          .map(
                            (repetition) =>
                                DropdownMenuItem<MedicationRepetition>(
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
                  ),
                ],
              );
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            if (editedMedication != null)
              TextButton(
                onPressed: () {
                  _showDeleteDialog(
                      context, medications.indexOf(editedMedication!));
                },
                child: Text('Delete'),
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

//   Future<void> _showEditDialog(BuildContext context, int index) async {
//   final medication = medications[index]; // Get the medication being edited

//   // Set the initial values for the controllers and selected values
//   nameController.text = medication.name;
//   dosageController.text = medication.dosage;
//   selectedTime = medication.time;
//   selectedRepetition = medication.repetition;

//   await showDialog(
//     context: context,
//     builder: (context) {
//       return AlertDialog(
//         title: Text('Edit Medication Reminder'),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             TextField(
//               controller: nameController,
//               decoration: InputDecoration(labelText: 'Medication Name'),
//             ),
//             TextField(
//               controller: dosageController,
//               decoration: InputDecoration(labelText: 'Dosage'),
//             ),
//             ListTile(
//               title: Text(
//                 'Time:',
//                 style: TextStyle(fontSize: 18.0),
//               ),
//               trailing: TextButton(
//                 onPressed: () async {
//                   final selectedNewTime = await showTimePicker(
//                     context: context,
//                     initialTime: selectedTime,
//                   );
//                   if (selectedNewTime != null) {
//                     setState(() {
//                       selectedTime = selectedNewTime;
//                     });
//                   }
//                 },
//                 child: Text(
//                   selectedTime.format(context),
//                   style: TextStyle(
//                     fontSize: 18.0,
//                     color: Theme.of(context).primaryColor,
//                   ),
//                 ),
//               ),
//             ),
//             Text('Repetition:'),
//             DropdownButton<MedicationRepetition>(
//               value: selectedRepetition,
//               items: MedicationRepetition.values
//                   .map(
//                     (repetition) => DropdownMenuItem<MedicationRepetition>(
//                       value: repetition,
//                       child: Text(_getRepetitionText(repetition)),
//                     ),
//                   )
//                   .toList(),
//               onChanged: (value) {
//                 setState(() {
//                   selectedRepetition = value!;
//                 });
//               },
//             ),
//           ],
//         ),
//         actions: <Widget>[
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             child: Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () {
//               setState(() {
//                 final editedMedication = medications[index]; // Get the edited medication
//                 medications[index] = Medication(
//                   nameController.text,
//                   dosageController.text,
//                   selectedTime,
//                   repetition: selectedRepetition,
//                   isEnabled: editedMedication.isEnabled,
//                 );
//                 nameController.clear();
//                 dosageController.clear();
//                 editedMedication = null;
//                 Navigator.of(context).pop();
//               });
//             },
//             child: Text('Save'),
//           ),
//         ],
//       );
//     },
//   );
// }
}
