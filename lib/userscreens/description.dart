import 'package:flutter/material.dart';

class Description extends StatelessWidget {
  const Description(
      {super.key,
      required this.title,
      required this.imagePath,
      required this.description}); //receive info as title

  final String title; //send info as title
  final String imagePath;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            title), //tekan title1 at homepage, tittle1 display in description page
      ),
      body: SingleChildScrollView(
        //easy to scroll
        child: Padding(
          // padding tepi
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Image.asset(imagePath),
              const SizedBox(
                height: 20,
              ),
              Text(
                title, //tekan title1 at homepage, tittle1 display in description page
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                description,
                style: const TextStyle(
                    fontSize: 15, fontWeight: FontWeight.normal),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
