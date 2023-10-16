import 'package:calendar/adminscreens/admin_profile_page.dart';
import 'package:calendar/adminscreens/user_profile_list.dart';
import 'package:calendar/main.dart';
import 'package:flutter/material.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // titleSpacing: 35.0,
        title: const Padding(
          padding:
              EdgeInsets.symmetric(), // Adjust the horizontal padding as needed
          child: Text('Admin Dashboard'),
        ),
        backgroundColor: Colors.deepPurple,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: SizedBox(
              child: IconButton(
                icon: const Icon(
                  Icons.account_circle,
                  size: 30,
                ), // Set the size of the icon
                onPressed: () {
                  // Navigate to admin profile settings page
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        AdminProfilePage(), // Replace with AdminProfilePage
                  ));
                },
              ),
            ),
          ),
        ],
      ),
      drawer: SafeArea(
        child: Drawer(
          child: Column(
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(color: Colors.amber),
                child: ListTile(
                  title: Text(
                    'Allergy Genie',
                    style: TextStyle(color: Colors.black, fontSize: 20.0),
                  ),
                ),
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(Icons.settings),
                title: const Text(
                  'Settings',
                  style: TextStyle(color: Colors.black, fontSize: 20.0),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    //pushReplacement - buang given existing back button
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return const LoginPage();
                      },
                    ),
                  );
                },
                leading: const Icon(Icons.logout),
                title: const Text(
                  'Logout',
                  style: TextStyle(color: Colors.black, fontSize: 20.0),
                ),
              ),
            ],
          ),
        ),
      ), // Drawer - tambah 3 garis / logout drawer
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Row(
              //   children: [
              //     const Padding(
              //       padding: EdgeInsets.all(16.0),
              //       child: Text(
              //         'Dashboard',
              //         style:
              //             TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              //       ),
              //     ),
              //     const Spacer(),
              //     IconButton(
              //       icon: const Icon(Icons.account_circle, size: 30),
              //       onPressed: () {
              //         // Navigate to admin profile settings page
              //         Navigator.of(context).push(MaterialPageRoute(
              //           builder: (context) =>
              //               AdminProfilePage(), // Replace with AdminProfilePage
              //         ));
              //       },
              //     ),
              //   ],
              // ),
              const SizedBox(height: 13),
              Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      DashboardCard(
                        icon: Icons.person,
                        label: 'User',
                        onPressed: () {
                          // Navigate to admin profile settings page
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => UserProfileList(),
                          ));
                        },
                      ),
                      DashboardCard(
                        icon: Icons.healing,
                        label: 'Symptom',
                        onPressed: () {
                          // Navigate to symptom page
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      DashboardCard(
                        icon: Icons.medication,
                        label: 'Medication',
                        onPressed: () {
                          // Navigate to medication page
                        },
                      ),
                      DashboardCard(
                        icon: Icons.folder_shared_sharp,
                        label: 'Care Plan',
                        onPressed: () {
                          // Navigate to care plan page
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      DashboardCard(
                        icon: Icons.article,
                        label: 'Resources',
                        onPressed: () {
                          // Navigate to resources page
                        },
                      ),
                      DashboardCard(
                        icon: Icons.contact_phone_rounded,
                        label: 'Emergency Contact',
                        onPressed: () {
                          // Navigate to resources page
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      DashboardCard(
                        icon: Icons.analytics,
                        label: 'Report',
                        onPressed: () {
                          // Navigate to feedback page
                        },
                      ),
                      DashboardCard(
                        icon: Icons.feedback,
                        label: 'Feedback',
                        onPressed: () {
                          // Navigate to feedback page
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onPressed;

  const DashboardCard({
    required this.icon,
    required this.label,
    this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
          width: 140, // Set width to ensure equal-sized cards
          height: 140, // Set height to ensure equal-sized cards
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 50,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(height: 8),
                Text(
                  label,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center, // Center-align text
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
