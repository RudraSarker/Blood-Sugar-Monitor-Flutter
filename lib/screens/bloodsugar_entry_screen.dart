import 'package:blood_sugar_monitor/db/blood_sugar_database.dart';
import 'package:blood_sugar_monitor/models/blood_sugar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:blood_sugar_monitor/utilities/constants.dart';

class BloodSugarEntryScreen extends StatefulWidget {
  static String route = "blood_sugar_entry";

  const BloodSugarEntryScreen({Key? key}) : super(key: key);
  @override
  _BloodSugarEntryScreenState createState() => _BloodSugarEntryScreenState();
}

class _BloodSugarEntryScreenState extends State<BloodSugarEntryScreen> {
  Widget _buildDynamicTF(
      {required String text,
      required IconData micon,
      required TextInputType inputType,
      required TextEditingController inputController,
      required String hint}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          text,
          style: kLabelStyle,
        ),
        const SizedBox(height: 10.0),
        Container(
          decoration: kBoxDecorationStyle,
          height: 40.0,
          child: TextField(
            keyboardType: inputType,
            controller: inputController,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(top: 7.0),
              prefixIcon: Icon(
                micon,
                color: Colors.white,
              ),
              hintText: hint,
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitBtn() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 4.0,
        onPressed: () {
          double beforeFood = 0.0;
          double afterFood = 0.0;
          String date = "1/1/1";
          String time = "12:00";
          if (_txtAfterFoodController.value.text.isNotEmpty ||
              _txtBeforeFoodController.value.text.isNotEmpty ||
              _txtDateFoodController.value.text.isNotEmpty ||
              _txtTimeFoodController.value.text.isNotEmpty) {
            if (double.tryParse(
                    _txtBeforeFoodController.value.text.toString()) !=
                null) {
              beforeFood =
                  double.parse(_txtBeforeFoodController.value.text.toString());
            } else {
              final snackBar = SnackBar(
                content: const Text('Blood Sugar type have to be number'),
                action: SnackBarAction(
                  label: 'Failed',
                  onPressed: () {
                    // Some code to undo the change.
                  },
                ),
              );

              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              return;
            }

            if (double.tryParse(
                    _txtAfterFoodController.value.text.toString()) !=
                null) {
              afterFood =
                  double.parse(_txtAfterFoodController.value.text.toString());
            } else {
              final snackBar = SnackBar(
                content: const Text('Blood Sugar type have to be number'),
                action: SnackBarAction(
                  label: 'Failed',
                  onPressed: () {
                    // Some code to undo the change.
                  },
                ),
              );

              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              return;
            }

            date = _txtDateFoodController.value.text.toString();
            time = _txtTimeFoodController.value.text.toString();

            if (date.isEmpty) {
              final snackBar = SnackBar(
                content: const Text('Date Can not be Empty'),
                action: SnackBarAction(
                  label: 'Failed',
                  onPressed: () {
                    // Some code to undo the change.
                  },
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              return;
            }
            if (time.isEmpty) {
              final snackBar = SnackBar(
                content: const Text('Time Can not be Empty'),
                action: SnackBarAction(
                  label: 'Failed',
                  onPressed: () {
                    // Some code to undo the change.
                  },
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              return;
            }

            BloodSugarDatabase.instance.createBloodSugarEntry(BloodSugar(
                beforeFood: beforeFood,
                afterFood: afterFood,
                date: date,
                time: time));
            //Clear textController
            _txtBeforeFoodController.clear();
            _txtAfterFoodController.clear();
            _txtDateFoodController.clear();
            _txtTimeFoodController.clear();
            //Show SnackBar
            final snackBar = SnackBar(
              content: const Text('Yay! Entry Successfully Stored!'),
              action: SnackBarAction(
                label: 'Successful',
                onPressed: () {
                  // Some code to undo the change.
                },
              ),
            );
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          } else {
            final snackBar = SnackBar(
              content: const Text('Fields Can not be empty!'),
              action: SnackBarAction(
                label: 'Failed',
                onPressed: () {
                  // Some code to undo the change.
                },
              ),
            );

            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        padding: const EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: const Color(0xFFFFFFFA),
        child: const Text(
          'SUBMIT',
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  Widget _buildGotoHomeBtn() {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: RichText(
        text: const TextSpan(
          children: [
            TextSpan(
              text: 'Go back to Home Screen-> ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Home',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextEditingController _txtBeforeFoodController = TextEditingController();
  TextEditingController _txtAfterFoodController = TextEditingController();
  TextEditingController _txtDateFoodController = TextEditingController();
  TextEditingController _txtTimeFoodController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
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
              ),
              SizedBox(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 80.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        'Enter blood Sugar Level',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'OpenSans',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      _buildDynamicTF(
                          text: "Before Food",
                          micon: Icons.bloodtype_outlined,
                          inputController: _txtBeforeFoodController,
                          inputType: TextInputType.number,
                          hint:
                              "Enter blood sugar level before food consuption"),
                      const SizedBox(
                        height: 10.0,
                      ),
                      _buildDynamicTF(
                          text: "After Food",
                          micon: Icons.bloodtype_sharp,
                          inputController: _txtAfterFoodController,
                          inputType: TextInputType.number,
                          hint:
                              "Enter blood sugar level before food consuption"),
                      const SizedBox(
                        height: 10.0,
                      ),
                      _buildDynamicTF(
                          text: "Date & Time",
                          micon: Icons.date_range,
                          inputType: TextInputType.datetime,
                          inputController: _txtDateFoodController,
                          hint: "dd/MM/yyyy - HH:mm"),
                      const SizedBox(
                        height: 10.0,
                      ),
                      _buildDynamicTF(
                          text: "Enter Time",
                          micon: Icons.timer,
                          inputType: TextInputType.datetime,
                          inputController: _txtTimeFoodController,
                          hint: "HH:mm:SS"),
                      const SizedBox(
                        height: 10.0,
                      ),
                      _buildSubmitBtn(),
                      _buildGotoHomeBtn(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFF35609),
        onPressed: () async {
          //await showInformationDialog(context);
        },
        tooltip: "Add Medication",
        child: const Icon(
          Icons.history,
        ),
      ),
    );
  }
}
