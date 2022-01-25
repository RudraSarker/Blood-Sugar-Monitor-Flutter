import 'package:blood_sugar_monitor/screens/food_suggestion_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FoodScreen extends StatefulWidget {
  static String route = "food-screen";
  const FoodScreen({Key? key}) : super(key: key);
  @override
  _FoodScreenState createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  _buildFoodSuggestion(String title, int index) {
    return Card(
      color: Colors.blue[120],
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListTile(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => FoodLists(value: index),
              ),
            );
            print(index);
          },
          leading: const Icon(
            Icons.food_bank_outlined,
            size: 56.0,
          ),
          title: Text(title),
          subtitle: Text('Tap here to see $title suggestions.'),
          trailing: const Icon(Icons.arrow_right),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final verticalPadding = MediaQuery.of(context).size.height / 32;
    const listTitles = [
      "Fruits",
      "Vegitables",
      "Whole Grain",
      "Fatty Fish",
      "Beans",
      "Nuts",
      "Spices",
      "Oils",
      "Chocolate",
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Foods"),
        backgroundColor: const Color(0xFFF53935),
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
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
            padding: EdgeInsets.symmetric(
                vertical: verticalPadding, horizontal: 20.0),
            child: ListView.builder(
              //padding: const EdgeInsets.all(8),
              itemCount: listTitles.length,
              itemBuilder: (BuildContext context, int index) {
                return _buildFoodSuggestion(listTitles[index], index);
              },
            ),
          ),
        ),
      ),
    );
  }
}
