import 'package:flutter/material.dart';

class EditProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        backgroundColor: Colors.deepPurple, // Customize app bar color
        actions: [
          CircleAvatar(
              // backgroundImage: AssetImage('assets/profile_image.png'), // Add a profile image
              ),
          SizedBox(width: 20),
        ],
      ),
      body: EditProfilePage(),
    );
  }
}

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final List<Map<String, dynamic>> allergensList = [];

  void _addNewAllergen() {
    setState(() {
      allergensList.add({'allergen': 'Select Allergen', 'severity': 1});
    });
  }

  void _saveProfile() {
    // Implement code to save/update the user's profile information here.
    // You can use the controllers to access the user's input.
    // Ensure the data is properly saved to your database or storage.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.amberAccent, // Set a light grey background color.
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildInputField(nameController, 'Name', Icons.person),
                  const SizedBox(height: 15.0),
                  _buildInputField(emailController, 'Email', Icons.email),
                  const SizedBox(height: 15.0),
                  _buildInputField(phoneController, 'Phone', Icons.phone),
                  const SizedBox(height: 15.0),
                  _buildInputField(passwordController, 'Password', Icons.lock),
                  const SizedBox(height: 20.0),
                  for (int i = 0; i < allergensList.length; i++)
                    _buildAllergenInputFields(i),
                  ElevatedButton(
                    onPressed: _addNewAllergen,
                    child: const Text(
                      'Add Allergen',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).highlightColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      minimumSize: const Size(300, 60),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: _saveProfile,
                    child: const Text(
                      'Save/Update Profile',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).highlightColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      minimumSize: const Size(300, 60),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(
      TextEditingController controller, String label, IconData icon) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: 'Enter your $label',
          labelText: label,
          filled: true,
          fillColor: Colors.white, // Set the text field background color
          prefixIcon: Icon(
            icon,
            color: Theme.of(context).primaryColor,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildAllergenInputFields(int index) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color:
                    Colors.white, // Set the allergen container background color
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: DropdownButton<String>(
                          value: allergensList[index]['allergen'],
                          onChanged: (String? newValue) {
                            setState(() {
                              allergensList[index]['allergen'] = newValue;
                            });
                          },
                          items: <String>[
                            'Select Allergen',
                            'Dairy products (eg: milk)',
                            'Eggs (eg: chicken eggs)',
                            // ... (add other allergen options here)
                          ].map<DropdownMenuItem<String>>(
                            (String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            },
                          ).toList(),
                        ),
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const SizedBox(width: 10),
                      const Text(
                        'Severity:',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${allergensList[index]['severity']}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).highlightColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Slider(
              value: allergensList[index]['severity'].toDouble(),
              min: 1,
              max: 10,
              onChanged: (double value) {
                setState(() {
                  allergensList[index]['severity'] = value.round();
                });
              },
              divisions: 9,
              label: allergensList[index]['severity'].toString(),
            ),
          ],
        ),
      ),
    );
  }
}
