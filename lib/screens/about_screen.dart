import 'package:blood_sugar_monitor/db/blood_sugar_database.dart';
import 'package:blood_sugar_monitor/models/blood_sugar.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatefulWidget {
  static String route = "about_screen";
  const AboutScreen({Key? key}) : super(key: key);

  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  _buildBloodSugarList(String title, int index) {
    return Card(
      color: Colors.blue[120],
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListTile(
          onTap: () {
            print(index);
          },
          onLongPress: () {
            int id = int.parse(bloodSugarList[index].id.toString());

            BloodSugarDatabase.instance.delete(id);
            refreshData();
          },
          leading: const Icon(
            Icons.medication_outlined,
            size: 56.0,
          ),
          title: Text(title),
          subtitle: Text(
              'Before Food: ${bloodSugarList[index].beforeFood}, \nAfter Food: ${bloodSugarList[index].afterFood},\n Date: ${bloodSugarList[index].date}'),
        ),
      ),
    );
  }

  //Show Medicattions
  late List<BloodSugar> bloodSugarList = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshData();
  }

  // @override
  // void dispose() {
  //   MedicationDatabase.instance.close();
  //   setState(() => isLoading = false);
  //   super.dispose();
  // }

  Future refreshData() async {
    setState(() => isLoading = true);

    bloodSugarList = await BloodSugarDatabase.instance.readAllBloodsugar();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detailed Blood Sugar Screen"),
        backgroundColor: const Color(0xFFF53935),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.refresh,
              size: 36.0,
            ),
            tooltip: 'Add Medication',
            onPressed: () {
              refreshData();
            },
          )
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : bloodSugarList.isEmpty
              ? const Center(
                  child: Text("No meds listed"),
                )
              : buildBloodSugar(context),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: const Color(0xFFF53935),
      //   onPressed: () {},
      //   tooltip: "Add Medication",
      //   child: const Icon(Icons.add),
      // ),
    );
  }

  Widget buildBloodSugar(BuildContext context) {
    final verticalPadding = MediaQuery.of(context).size.height / 32;
    //refreshNotes();
    return Container(
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
          itemCount: bloodSugarList.length,
          itemBuilder: (BuildContext context, int index) {
            return _buildBloodSugarList(bloodSugarList[index].time, index);
          },
        ),
      ),
    );
  }
}
