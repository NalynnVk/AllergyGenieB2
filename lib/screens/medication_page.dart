import 'package:flutter/material.dart';

class MedPage extends StatefulWidget {
  @override
  _MedPageState createState() => _MedPageState();
}

class Medication {
  final String id;
  final String name;
  final String dosage;

  Medication({
    required this.id,
    required this.name,
    required this.dosage,
  });
}

class _MedPageState extends State<MedPage> {
  List<Medication> medications = [];
  TextEditingController nameController = TextEditingController();
  TextEditingController dosageController = TextEditingController();

  void addMedication() {
    setState(() {
      final newMedication = Medication(
        id: DateTime.now().toString(),
        name: nameController.text,
        dosage: dosageController.text,
      );
      medications.add(newMedication);
      nameController.clear();
      dosageController.clear();
    });
  }

  void updateMedication(String id) {
    // Find medication by id and update it
    final medicationIndex = medications.indexWhere((med) => med.id == id);
    if (medicationIndex >= 0) {
      setState(() {
        medications[medicationIndex] = Medication(
          id: id,
          name: nameController.text,
          dosage: dosageController.text,
        );
        nameController.clear();
        dosageController.clear();
      });
    }
  }

  void deleteMedication(String id) {
    setState(() {
      medications.removeWhere((med) => med.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medication Reminder'),
      ),
      body: ListView.builder(
        itemCount: medications.length,
        itemBuilder: (context, index) {
          final medication = medications[index];
          return ListTile(
            title: Text(medication.name),
            subtitle: Text(medication.dosage),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                deleteMedication(medication.id);
              },
            ),
            onTap: () {
              // Update medication
              nameController.text = medication.name;
              dosageController.text = medication.dosage;
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Edit Medication'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: nameController,
                          decoration: InputDecoration(labelText: 'Name'),
                        ),
                        TextField(
                          controller: dosageController,
                          decoration: InputDecoration(labelText: 'Dosage'),
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          updateMedication(medication.id);
                          Navigator.of(context).pop();
                        },
                        child: Text('Update'),
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Add Medication'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(labelText: 'Name'),
                    ),
                    TextField(
                      controller: dosageController,
                      decoration: InputDecoration(labelText: 'Dosage'),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      addMedication();
                      Navigator.of(context).pop();
                    },
                    child: Text('Add'),
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
}
