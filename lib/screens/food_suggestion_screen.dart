import 'dart:convert';

import 'package:blood_sugar_monitor/models/food_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FoodLists extends StatefulWidget {
  static String route = "foodlist";
  final int value;
  const FoodLists({Key? key, required this.value}) : super(key: key);

  @override
  _FoodListsState createState() => _FoodListsState();
}

class _FoodListsState extends State<FoodLists> {
  _buildFoodLists(String title, int index) {
    return Card(
      color: Colors.blue[120],
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListTile(
          onTap: () => print(index),
          leading: const Icon(
            Icons.star_border,
            size: 36.0,
          ),
          title: Text(title),
          //subtitle: Text('Tap here to see $title suggestions.'),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    await Future.delayed(const Duration(seconds: 2));
    var foodJson = await rootBundle.loadString("assets/files/foods.json");
    final decodedJason = jsonDecode(foodJson);
    var foodsData = decodedJason["foods"];
    //print(foodsData);
    FoodModel.foods = List.from(foodsData)
        .map<Foods>((foods) => Foods.fromMap(foods))
        .toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final verticalPadding = MediaQuery.of(context).size.height / 32;
    return Scaffold(
      appBar: (FoodModel.foods.isNotEmpty)
          ? AppBar(
              title: Text(FoodModel.foods[(widget.value)].name),
              backgroundColor: const Color(0xFFF53935),
            )
          : null,
      body: (FoodModel.foods.isNotEmpty)
          ? Container(
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
                  itemCount: FoodModel.foods[(widget.value)].items.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _buildFoodLists(
                        FoodModel.foods[(widget.value)].items[index], index);
                  },
                ),
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
