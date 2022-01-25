import 'package:blood_sugar_monitor/db/medicine_database.dart';
import 'package:blood_sugar_monitor/models/medicine_model.dart';
import 'package:flutter/material.dart';

class MedicationScreen extends StatefulWidget {
  static String route = "medication_entry";
  const MedicationScreen({Key? key}) : super(key: key);

  @override
  _MedicationScreenState createState() => _MedicationScreenState();
}

class _MedicationScreenState extends State<MedicationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> showInformationDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          final TextEditingController _textEditingController =
              TextEditingController();
          final TextEditingController _textMorningController =
              TextEditingController();
          final TextEditingController _textNoonController =
              TextEditingController();
          final TextEditingController _textNightController =
              TextEditingController();

          bool isChecked = false;
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: _textEditingController,
                        validator: (value) {
                          return value!.isNotEmpty ? null : "Invalid Field";
                        },
                        decoration: const InputDecoration(
                            hintText: "Enter Medication Name"),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        " Morning : Noon : Night ",
                        style: TextStyle(fontSize: 18.0, color: Colors.black54),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(":"),
                          Container(
                            width: 20.0,
                            child: TextFormField(
                              controller: _textMorningController,
                              validator: (value) {
                                return value!.isNotEmpty
                                    ? null
                                    : "Invalid Field";
                              },
                              decoration:
                                  const InputDecoration(hintText: "0/1"),
                            ),
                          ),
                          const Text(":"),
                          Container(
                            width: 20.0,
                            child: TextFormField(
                              controller: _textNoonController,
                              validator: (value) {
                                return value!.isNotEmpty
                                    ? null
                                    : "Invalid Field";
                              },
                              decoration:
                                  const InputDecoration(hintText: "0/1"),
                            ),
                          ),
                          const Text(":"),
                          Container(
                            width: 20.0,
                            child: TextFormField(
                              controller: _textNightController,
                              validator: (value) {
                                return value!.isNotEmpty
                                    ? null
                                    : "Invalid Field";
                              },
                              decoration:
                                  const InputDecoration(hintText: "0/1"),
                            ),
                          ),
                        ],
                      )
                    ],
                  )),
              actions: <Widget>[
                TextButton(
                  child: Text('Okay'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Do something like updating SharedPreferences or User Settings etc.
                      String name = "";
                      name = _textEditingController.value.text.toString();
                      int morning = 0;
                      int noon = 0;
                      int night = 0;

                      if (int.tryParse(
                              _textMorningController.value.text.toString()) !=
                          null) {
                        morning = int.parse(
                            _textMorningController.value.text.toString());
                      }
                      if (int.tryParse(
                              _textNoonController.value.text.toString()) !=
                          null) {
                        noon = int.parse(
                            _textNoonController.value.text.toString());
                      }
                      if (int.tryParse(
                              _textNightController.value.text.toString()) !=
                          null) {
                        night = int.parse(
                            _textNightController.value.text.toString());
                      }

                      MedicationDatabase.instance.create(Medicine(
                          name: name,
                          morning: morning,
                          noon: noon,
                          night: night));
                      print(
                          "Nmae: $name,mor: $morning,noon: $noon,night: $night");
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            );
          });
        });
  }

  _buildMedicationList(String title, int index) {
    return Card(
      color: Colors.blue[120],
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListTile(
          onTap: () {
            print(index);
          },
          onLongPress: () {
            int id = int.parse(meds[index].id.toString());

            MedicationDatabase.instance.delete(id);
            refreshNotes();
          },
          leading: const Icon(
            Icons.medication_outlined,
            size: 56.0,
          ),
          title: Text(title),
          subtitle: Text(
              '$title Mornig: ${meds[index].morning}, Noon: ${meds[index].noon}, Night: ${meds[index].night}'),
        ),
      ),
    );
  }

  //Show Medicattions
  late List<Medicine> meds = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshNotes();
  }

  // @override
  // void dispose() {
  //   MedicationDatabase.instance.close();
  //   setState(() => isLoading = false);
  //   super.dispose();
  // }

  Future refreshNotes() async {
    setState(() => isLoading = true);

    meds = await MedicationDatabase.instance.readAllMedicine();

    setState(() => isLoading = false);
  }

  static final listTitles = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Medication Screen"),
        backgroundColor: const Color(0xFFF53935),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.refresh,
              size: 36.0,
            ),
            tooltip: 'Add Medication',
            onPressed: () {
              refreshNotes();
            },
          )
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : meds.isEmpty
              ? const Center(
                  child: Text("No meds listed"),
                )
              : buildMedicationList(context),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFF53935),
        onPressed: () async {
          await showInformationDialog(context);
          refreshNotes();
        },
        tooltip: "Add Medication",
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget buildMedicationList(BuildContext context) {
    final verticalPadding = MediaQuery.of(context).size.height / 32;
    refreshNotes();
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
          itemCount: meds.length,
          itemBuilder: (BuildContext context, int index) {
            return _buildMedicationList(meds[index].name, index);
          },
        ),
      ),
    );
  }
}
