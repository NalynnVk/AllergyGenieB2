// import 'package:calendar/main.dart';
import 'package:flutter/material.dart';
import 'package:calendar/userscreens/widgets/insight_widget.dart';

class InsightPage extends StatefulWidget {
  const InsightPage({super.key});

  @override
  State<InsightPage> createState() => _InsightPageState();
}

class _InsightPageState extends State<InsightPage> {
  Color backgroundColor = Colors.white;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      // appBar: AppBar(
      //   actions: [
      //     IconButton(
      //       onPressed: () {
      //         setState(() {
      //           if (backgroundColor == Colors.white) {
      //             backgroundColor = Colors.redAccent;
      //           } else {
      //             backgroundColor = Colors.white;
      //           }
      //         });
      //       },
      //       icon: const Icon(Icons.color_lens),
      //     ), // for theme color modification
      //   ],
      //   title: const Text("Allergy Genie"),
      // ), //Appbar = SaAtT
      // drawer: SafeArea(
      //   child: Drawer(
      //     child: Column(
      //       children: [
      //         const DrawerHeader(
      //           decoration: BoxDecoration(color: Colors.amber),
      //           child: ListTile(
      //             title: Text(
      //               'Allergy Genie',
      //               style: TextStyle(color: Colors.black, fontSize: 20.0),
      //             ),
      //           ),
      //         ),
      //         ListTile(
      //           onTap: () {},
      //           leading: const Icon(Icons.settings),
      //           title: const Text(
      //             'Settings',
      //             style: TextStyle(color: Colors.black, fontSize: 20.0),
      //           ),
      //         ),
      //         ListTile(
      //           onTap: () {
      //             Navigator.of(context).pushReplacement(
      //               //pushReplacement - buang given existing back button
      //               MaterialPageRoute(
      //                 builder: (BuildContext context) {
      //                   return const LoginPage();
      //                 },
      //               ),
      //             );
      //           },
      //           leading: const Icon(Icons.logout),
      //           title: const Text(
      //             'Logout',
      //             style: TextStyle(color: Colors.black, fontSize: 20.0),
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ), // Drawer - tambah 3 garis / logout drawer
      body: const SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
              // child: Wrap(
              //   spacing: 20,
              //   children: [
              //     ElevatedButton(
              //       onPressed: () {
              //         Navigator.of(context).push(
              //           MaterialPageRoute(
              //             builder: (context) {
              //               return const LoginPage();
              //             },
              //           ),
              //         );
              //       },
              //       style: ElevatedButton.styleFrom(
              //         shape: const StadiumBorder(),
              //       ),
              //       child: const Text("Food Allergies"),
              //     ),
              //     ElevatedButton(
              //       onPressed: () {
              //         Navigator.of(context).push(
              //           MaterialPageRoute(
              //             builder: (context) {
              //               return const LoginPage();
              //             },
              //           ),
              //         );
              //       },
              //       style: ElevatedButton.styleFrom(
              //         shape: const StadiumBorder(),
              //       ),
              //       child: const Text("Medication Allergies"),
              //     ),
              //     ElevatedButton(
              //       onPressed: () {
              //         Navigator.of(context).push(
              //           MaterialPageRoute(
              //             builder: (context) {
              //               return const LoginPage();
              //             },
              //           ),
              //         );
              //       },
              //       style: ElevatedButton.styleFrom(
              //         shape: const StadiumBorder(),
              //       ),
              //       child: const Text("Management Strategies"),
              //     ),
              //     ElevatedButton(
              //       onPressed: () {
              //         Navigator.of(context).push(
              //           MaterialPageRoute(
              //             builder: (context) {
              //               return const LoginPage();
              //             },
              //           ),
              //         );
              //       },
              //       style: ElevatedButton.styleFrom(
              //         shape: const StadiumBorder(),
              //       ),
              //       child: const Text("Treatment"),
              //     ),
              //   ],
              // ),
            ), // Wrap replace Row
            // big widget so have their own page => insight_widget.dart
            InsightWidget(
                title: 'New Meat Allergy Linked to Tick Bites',
                imagePath: 'images/Food Allergies.jpg',
                description:
                    'The Lone Star tick, which is found in the southeastern United States, can transmit a protein called alpha-gal to humans when it bites them. This protein can cause a severe allergic reaction to red meat, such as beef, pork, and lamb. Symptoms of a tick-induced meat allergy can include hives, wheezing, difficulty breathing, and anaphylaxis. This allergy is relatively new, and was first identified in 2009. It is thought to be caused by the alpha-gal protein binding to antibodies in the human immune system. The alpha-gal protein is found in many different types of red meat, but not in poultry, fish, or eggs. The good news is that most people with a tick-induced meat allergy can avoid reactions by avoiding red meat. However, it is important to be aware of the allergy and to carry an epinephrine auto-injector in case of an accidental exposure.'),
            InsightWidget(
                title: 'Penicillin: Side effects vs. allergic reaction',
                imagePath: 'images/Medication Allergies.jpg',
                description:
                    'This is because many people confuse the side effects of penicillin with an allergic reaction. Side effects of penicillin can include nausea, vomiting, diarrhea, and rash. However, an allergic reaction to penicillin is much more serious and can include symptoms such as hives, wheezing, difficulty breathing, and anaphylaxis. If you think you may be allergic to penicillin, it is important to see a doctor to get tested. There are a number of tests that can be done to determine if you are truly allergic to penicillin. If you are not allergic to penicillin, you may be able to take penicillin-based antibiotics safely in the future.'),
            InsightWidget(
                title:
                    'Personalized Food Allergy Management: A New Era of Hope',
                imagePath: 'images/Management Strategies.png',
                description:
                    'There is a growing trend towards personalized food allergy management strategies. This means that people with food allergies are working with their doctors and other healthcare professionals to develop individualized plans that meet their specific needs. For example, some people with food allergies may be able to tolerate small amounts of their allergen without having a reaction. Others may be able to undergo oral immunotherapy, which involves gradually exposing themselves to their allergen in small amounts over time.'),
            // Spacer()
          ],
        ),
      ),
    );
  }
}
