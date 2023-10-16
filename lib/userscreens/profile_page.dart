import 'package:calendar/userscreens/feedback_page.dart';
import 'package:flutter/material.dart';
import 'package:calendar/userscreens/edit_profile.dart';
import 'package:calendar/userscreens/care_plan.dart';
// import 'package:calendar/userscreens/feedback_page.dart';
import 'package:calendar/main.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Profile Page'),
      // ),
      body: ListView(
        children: <Widget>[
          const SizedBox(height: 30.0),

          // ROW 1: Profile Picture & User Name and Edit Profile Text
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 45.0,
                backgroundImage: AssetImage(
                  'images/profile_image2.jpg',
                ), // Replace with your image
              ),
              const SizedBox(width: 20.0),
              Column(
                children: [
                  const Text(
                    'Davikah Sharma',
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 3.0),
                  GestureDetector(
                    onTap: () {
                      // Navigate to the EditProfile page and pass user data if needed
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return EditProfile(); // Navigate to EditProfile
                          },
                        ),
                      );
                    },
                    child: const Text(
                      'Edit Profile',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          // ROW 2: GAB

          const SizedBox(height: 20.0),
          // ROW 3: Share Care Plan Button
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(
              horizontal: 30.0,
              vertical: 10.0,
            ),
            decoration: BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  spreadRadius: 2,
                  blurRadius: 2,
                  offset: Offset(2, 2),
                ),
              ],
            ),
            child: ListTile(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return const CarePlan();
                    },
                  ),
                );
              },
              title: const Text(
                "SHARE CARE PLAN",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white, // Text color
                  fontSize: 18, // Text size
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          // NEW
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(
              horizontal: 30.0,
              vertical: 10.0,
            ),
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  spreadRadius: 2,
                  blurRadius: 2,
                  offset: Offset(2, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                ListTile(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return const LoginPage();
                        },
                      ),
                    );
                  },
                  title: const Text(
                    "  Contact",
                    style: TextStyle(fontSize: 18),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return const LoginPage();
                        },
                      ),
                    );
                  },
                  title: const Text(
                    "  Report",
                    style: TextStyle(fontSize: 18),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return FeedbackPage();
                        },
                      ),
                    );
                  },
                  title: const Text(
                    "  Feedback",
                    style: TextStyle(fontSize: 18),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return const LoginPage();
                        },
                      ),
                    );
                  },
                  title: const Text(
                    "  Setting",
                    style: TextStyle(fontSize: 18),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return const LoginPage();
                        },
                      ),
                    );
                  },
                  title: const Text(
                    '  Logout',
                    style: TextStyle(fontSize: 18),
                  ),
                  trailing: const Icon(Icons.logout),
                ),
              ],
            ),
          ),

          // ROW 4: Logout
        ],
      ),
    );
  }
}
