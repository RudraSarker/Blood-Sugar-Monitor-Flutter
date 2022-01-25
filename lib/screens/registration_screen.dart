import 'package:blood_sugar_monitor/screens/home_screen.dart';
import 'package:blood_sugar_monitor/screens/login_screen.dart';
import 'package:blood_sugar_monitor/widgets/dynamic_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:blood_sugar_monitor/utilities/constants.dart';
import 'package:form_field_validator/form_field_validator.dart';

class RegistrationScreen extends StatefulWidget {
  static String route = "registration";

  const RegistrationScreen({Key? key}) : super(key: key);
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String dropdownValue = 'Male';
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String password = "";
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'password is required'),
    MinLengthValidator(6, errorText: 'password must be at least 6 digits long'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText: 'passwords must have at least one special character')
  ]);

  final emailValidator = MultiValidator([
    RequiredValidator(errorText: 'email is required'),
    EmailValidator(errorText: 'enter a valid email address')
  ]);

  final multiValidator = MultiValidator([
    RequiredValidator(errorText: 'field is required'),
  ]);

  /*
  final confirmPassValidator = MultiValidator([
    RequiredValidator(errorText: 'password is required'),
    MatchValidator(errorText: 'passwords do not match')
        .validateMatch(a, b),
  ]); */

  Widget _buildConfirmPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          "Confirm Password",
          style: kLabelStyle,
        ),
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            controller: confirmPassController,
            //onChanged: ,
            validator: (val) => MatchValidator(
                    errorText: 'passwords do not match')
                .validateMatch(passController.text, confirmPassController.text),
            keyboardType: TextInputType.visiblePassword,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 7.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: 'Confirm your Password',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSignupBtn() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          if (formKey.currentState!.validate()) {
            Navigator.popAndPushNamed(context, HomeScreen.route);
          }
        },
        padding: const EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: const Text(
          'SIGN UP',
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

  Widget _buildGotoLoginBtn() {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, LoginScreen.route),
      child: RichText(
        text: const TextSpan(
          children: [
            TextSpan(
              text: 'Already have an Account? ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Sign In',
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

  _buildGenderDropdown() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          "Select Gender : ",
          style: kLabelStyle,
        ),
        DropdownButton<String>(
          value: dropdownValue,
          dropdownColor: Color(0xFF6CA8F1),
          icon: const Icon(
            Icons.arrow_downward,
            color: Colors.white,
          ),
          iconSize: 18,
          elevation: 16,
          style: kLabelStyle,
          underline: Container(
            height: 2,
            color: Colors.white,
          ),
          onChanged: (String? newValue) {
            setState(() {
              dropdownValue = newValue!;
            });
          },
          items: <String>['Male', 'Female', 'Other']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        )
      ],
    );
  }

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
                  child: Form(
                    key: formKey,
                    autovalidateMode: AutovalidateMode.always,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'OpenSans',
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 30.0),
                        DynamicFormField(
                          text: "Email",
                          micon: Icons.email,
                          inputType: TextInputType.emailAddress,
                          validator: emailValidator,
                          controlerChoice: emailController,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        DynamicFormField(
                          text: "Password",
                          micon: Icons.lock,
                          inputType: TextInputType.visiblePassword,
                          validator: passwordValidator,
                          controlerChoice: passController,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        _buildConfirmPasswordTF(),
                        const SizedBox(
                          height: 10.0,
                        ),
                        DynamicFormField(
                          text: "Name",
                          micon: Icons.email,
                          inputType: TextInputType.name,
                          validator: multiValidator,
                          controlerChoice: nameController,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        DynamicFormField(
                          text: "Height",
                          micon: Icons.lock,
                          inputType: TextInputType.text,
                          validator: multiValidator,
                          controlerChoice: heightController,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        DynamicFormField(
                          text: "Weigh",
                          micon: Icons.lock,
                          inputType: TextInputType.text,
                          validator: multiValidator,
                          controlerChoice: weightController,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        _buildGenderDropdown(),
                        _buildSignupBtn(),
                        _buildGotoLoginBtn(),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
