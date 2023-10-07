import 'package:calendar/screens/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false, //debug banner buang
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Colors.deepPurple), //appbar color
        useMaterial3: false, //appbar appearance
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 182, 232, 255),
      //Scaffold (widget) - white screen | skeleton of the app
      //anything about background need to do here (Scaffold)
      // appBar: AppBar(
      //   title: const Text("Allergy Genie"),
      //   centerTitle: true,
      // ), //appBar - top of the application
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Welcome!",
              style: TextStyle(
                  color: Colors.pinkAccent,
                  fontSize: 55,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10.0,
            ),
            const Text(
              "to Allergy Genie",
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 166, 195),
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 30.0,
            ),
            Image.asset('images/login.png'),
            const SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  //pushReplacement - buang given existing back button
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return const HomePage();
                    },
                  ),
                );
              },
              child: const Text('Login'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink,
                minimumSize: const Size(300, 40),
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text("Register"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: const Size(300, 40),
              ),
            )
          ], // children - refactor and select widget children to add multiple text
        ),
      ), // body - to be center
    );
  }
}
