import 'package:flutter/material.dart';

class UserProfile {
  final String name;
  final String email;

  UserProfile({required this.name, required this.email});
}

class UserProfileList extends StatefulWidget {
  @override
  _UserProfileListState createState() => _UserProfileListState();
}

class _UserProfileListState extends State<UserProfileList> {
  List<UserProfile> userProfiles = [
    UserProfile(name: 'User 1', email: 'user1@example.com'),
    UserProfile(name: 'User 2', email: 'user2@example.com'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profiles'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to add user profile page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddUserProfilePage(),
                ),
              ).then((result) {
                if (result != null && result is UserProfile) {
                  // Add the new user profile to the list
                  setState(() {
                    userProfiles.add(result);
                  });
                }
              });
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: userProfiles.length,
        itemBuilder: (context, index) {
          final userProfile = userProfiles[index];
          return Card(
            elevation: 5,
            margin: EdgeInsets.all(8),
            child: ListTile(
              title: Text(
                userProfile.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                userProfile.email,
                style: TextStyle(fontSize: 16),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.blue),
                    onPressed: () {
                      // Navigate to edit user profile page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditUserProfilePage(
                            userProfile: userProfile,
                          ),
                        ),
                      ).then((result) {
                        if (result != null && result is UserProfile) {
                          // Update the user profile in the list
                          setState(() {
                            userProfiles[index] = result;
                          });
                        }
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      // Delete the user profile from the list
                      setState(() {
                        userProfiles.removeAt(index);
                      });
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class AddUserProfilePage extends StatefulWidget {
  @override
  _AddUserProfilePageState createState() => _AddUserProfilePageState();
}

class _AddUserProfilePageState extends State<AddUserProfilePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add User Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // Validate input and save the new user profile
                final name = nameController.text;
                final email = emailController.text;
                if (name.isNotEmpty && email.isNotEmpty) {
                  Navigator.pop(
                    context,
                    UserProfile(name: name, email: email),
                  );
                } else {
                  // Show error message if input is invalid
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please enter valid name and email.'),
                    ),
                  );
                }
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}

class EditUserProfilePage extends StatefulWidget {
  final UserProfile userProfile;

  EditUserProfilePage({required this.userProfile});

  @override
  _EditUserProfilePageState createState() => _EditUserProfilePageState();
}

class _EditUserProfilePageState extends State<EditUserProfilePage> {
  late TextEditingController nameController;
  late TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.userProfile.name);
    emailController = TextEditingController(text: widget.userProfile.email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit User Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // Validate input and update the user profile
                final name = nameController.text;
                final email = emailController.text;
                if (name.isNotEmpty && email.isNotEmpty) {
                  Navigator.pop(
                    context,
                    UserProfile(name: name, email: email),
                  );
                } else {
                  // Show error message if input is invalid
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please enter valid name and email.'),
                    ),
                  );
                }
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
