import 'package:flutter/material.dart';

class ExcerciseScreen extends StatefulWidget {
  static String route = "exercise";
  const ExcerciseScreen({Key? key}) : super(key: key);

  @override
  _ExcerciseScreenState createState() => _ExcerciseScreenState();
}

class _ExcerciseScreenState extends State<ExcerciseScreen> {
  _buildExerciseLists(String title, int index) {
    return Card(
      color: Colors.blue[120],
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListTile(
          onTap: () => print(index),
          leading: const Icon(
            Icons.fitness_center,
            size: 36.0,
          ),
          title: Text(title),
          //subtitle: Text('Tap here to see $title suggestions.'),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final verticalPadding = MediaQuery.of(context).size.height / 32;
    const listTitles = [
      "Walking",
      "Cycling",
      "Swimming",
      "Team sports",
      "Aerobic dance",
      "Weight lifting",
      "Resistance band exercises",
      "Calisthenics",
      "Yoga",
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text("Exercise List"),
        backgroundColor: const Color(0xFFF53935),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF44226),
              Color(0xFFFF5722),
              Color(0xFFF47043),
              Color(0xFFF53935),
            ],
            stops: [0.1, 0.4, 0.7, 0.9],
          ),
        ),
        child: Padding(
          padding:
              EdgeInsets.symmetric(vertical: verticalPadding, horizontal: 20.0),
          child: ListView.builder(
            //padding: const EdgeInsets.all(8),
            itemCount: listTitles.length,
            itemBuilder: (BuildContext context, int index) {
              return _buildExerciseLists(listTitles[index], index);
            },
          ),
        ),
      ),
    );
  }
}
