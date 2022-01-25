import 'package:blood_sugar_monitor/screens/about_screen.dart';
import 'package:blood_sugar_monitor/screens/bloodsugar_entry_screen.dart';
import 'package:blood_sugar_monitor/screens/excercise_screen.dart';
import 'package:blood_sugar_monitor/screens/food_screen.dart';
import 'package:blood_sugar_monitor/screens/history_screen.dart';
import 'package:blood_sugar_monitor/screens/medication_screen.dart';
import 'package:blood_sugar_monitor/widgets/bottom_app_bar.dart';
import 'package:blood_sugar_monitor/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  static String route = 'home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  _buildDynamicGridView(
      {required String title,
      required String subtitle,
      required IconData icon,
      required function}) {
    return Card(
      shadowColor: const Color(0xFF6CA8F1),
      color: const Color(0xFFF44336),
      child: InkWell(
        onTap: function,
        child: Stack(
          alignment: Alignment.topLeft,
          fit: StackFit.loose,
          children: [
            Positioned(
              top: 60,
              left: 60,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25.0),
                child: Icon(
                  icon,
                  size: 50.0,
                ),
              ),
            ),
            Positioned(
              top: 5.0,
              left: 35.0,
              child: Text(
                title,
                style: kLabelStyle,
              ),
            ),
            Positioned(
              bottom: 5.0,
              left: 20.0,
              child: Text(
                subtitle,
                style: kLabelStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }

  goToBloodSugarEntryScrn() {
    return Navigator.pushNamed(context, BloodSugarEntryScreen.route);
  }

  goToHistoryScreen() {
    return Navigator.pushNamed(context, HistoryScreen.route);
  }

  goToAboutScreen() {
    return Navigator.pushNamed(context, AboutScreen.route);
  }

  goToMdicationEntryScrn() {
    return Navigator.pushNamed(context, MedicationScreen.route);
  }

  goToExerciseScreen() {
    return Navigator.pushNamed(context, ExcerciseScreen.route);
  }

  goToFoodScrn() {
    return Navigator.pushNamed(context, FoodScreen.route);
  }

  @override
  Widget build(BuildContext context) {
    final verticalPadding = MediaQuery.of(context).size.height / 48;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
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
                Color(0xFFECEFF1),
                Color(0xFFECEFF1),
                Color(0xFFECEFF1),
                Color(0xFFFFFFFF),
              ],
              stops: [0.1, 0.4, 0.7, 0.9],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: verticalPadding, horizontal: 20.0),
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 20.0,
              mainAxisSpacing: 20.0,
              children: <Widget>[
                _buildDynamicGridView(
                  title: "Blood Sugar",
                  subtitle: "Click Here to enter\nblood sugar measure",
                  icon: Icons.bloodtype,
                  function: goToBloodSugarEntryScrn,
                ),
                _buildDynamicGridView(
                  title: "History Chart",
                  subtitle: "Click Here to See\nblood sugar history",
                  icon: Icons.history,
                  function: goToHistoryScreen,
                ),
                _buildDynamicGridView(
                  title: "Food Suggestion",
                  subtitle: "Click Here to see\nFood Suggestion",
                  icon: Icons.food_bank,
                  function: goToFoodScrn,
                ),
                _buildDynamicGridView(
                  title: "Medications",
                  subtitle: "Click Here to see\nmedications list",
                  icon: Icons.medication,
                  function: goToMdicationEntryScrn,
                ),
                _buildDynamicGridView(
                  title: "Exercise",
                  subtitle: "Click Here to see\nexercise list",
                  icon: Icons.fitness_center,
                  function: goToExerciseScreen,
                ),
                _buildDynamicGridView(
                  title: "Details History",
                  subtitle: "Click Here to see\nDrinks List",
                  icon: Icons.local_drink,
                  function: goToAboutScreen,
                ),
              ],
            ),
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   child: const Icon(Icons.search),
      //   tooltip: 'Create',
      //   backgroundColor: const Color(0xFFF53935),
      //   foregroundColor: Colors.white,
      //   focusColor: Colors.black,
      // ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: myBottomAppBar(
          //fabLocation: FloatingActionButtonLocation.centerDocked,
          //shape: CircularNotchedRectangle(),
          ),
    );
  }
}
