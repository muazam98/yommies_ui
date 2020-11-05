import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:yommie/class/alertDialog.dart';
import 'package:yommie/class/hex_color.dart';
import 'package:yommie/models/signUpModels.dart';
import 'package:flutter/services.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  String dataPick;

  InputBorder focusedErrorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(30.0)),
    borderSide: BorderSide(color: HexColor("#FFF5CC"), width: 2),
  );
  InputBorder errorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(30.0)),
    borderSide: BorderSide(color: HexColor("#FFF5CC"), width: 2),
  );
  InputBorder enabledBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(30.0)),
    borderSide: BorderSide(color: HexColor("#FFF5CC"), width: 2),
  );
  InputBorder focusedBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(30.0)),
    borderSide: BorderSide(color: HexColor("#FFF5CC")),
  );

  final username = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  final dateOfBirth = TextEditingController();

  var maskFormatter = new MaskTextInputFormatter(
      mask: '##/##/####', filter: {"#": RegExp(r'[0-9]')});

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    if (this.mounted) super.dispose();
  }

  validationForm() {
    if (_formKey.currentState.validate()) {
      if (password.text == confirmPassword.text) {
        if (dataPick != null) {
          _formKey.currentState.save();
          var jsons = {};
          jsons["username"] = username.text;
          jsons["email"] = email.text;
          jsons["password"] = password.text;
          jsons["dateOfBirth"] = dateOfBirth.text;
          jsons["gender"] = dataPick;
          SignUpModels().registerPhp(jsons, context);
        } else {
          DialogAction().alertDialogOneButton(context, "Failed",
              CoolAlertType.error, "Please select your gender", "Ok", () {
            Navigator.of(context).pop();
          });
        }
      } else {
        DialogAction().alertDialogOneButton(
            context,
            "Failed",
            CoolAlertType.error,
            "Please try again your password not matched",
            "Ok", () {
          Navigator.of(context).pop();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height:130),
                      Container(
                        width: double.infinity,
                        height: 100,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/yomiesKL.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      nameInput(),
                      SizedBox(height: 15),
                      emailInput(),
                      SizedBox(height: 15),
                      passwordInput(),
                      SizedBox(height: 15),
                      confirmPasswordInput(),
                      SizedBox(height: 15),
                      dateOfBirthInput(),
                      SizedBox(height: 15),
                      Container(
                        width: double.infinity,
                        height: 50.0,
                        padding: EdgeInsets.only(left: 25),
                        decoration: BoxDecoration(
                          color: HexColor("#FFF5CC"),
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(
                            color: HexColor("#FFF5CC"),
                          ),
                        ),
                        child: DropdownButton<String>(
                          underline: SizedBox(),
                          value: dataPick,
                          focusColor: Colors.black,
                          iconDisabledColor: Colors.black,
                          iconEnabledColor: Colors.black,
                          isExpanded: true,
                          style: TextStyle(color: Colors.black),
                          dropdownColor: HexColor("#FFF5CC"),
                          hint: Text(
                            "Gender",
                            style: TextStyle(color: Colors.black54),
                          ),
                          items: <String>['Male', 'Female'].map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              dataPick = value;
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 30),
                      SizedBox(
                        height: 40,
                        width: 200,
                        child: RaisedButton(
                          color: HexColor('#CAF8FC'),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          onPressed: () {
                            validationForm();
                          },
                          child: Text("SUBMIT"),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 5,
              left: 15,
              child: SafeArea(
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget nameInput() {
    return TextFormField(
      controller: username,
      textCapitalization: TextCapitalization.words,
      keyboardType: TextInputType.text,
      focusNode: FocusNode(),
      validator: (name) {
        if (name == "") {
          return 'Invalid username';
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 30),
        hintText: 'Username',
        hintStyle: TextStyle(
          color: Colors.black54,
        ),
        filled: true,
        fillColor: HexColor("#FFF5CC"),
        focusedErrorBorder: focusedErrorBorder,
        errorBorder: errorBorder,
        enabledBorder: enabledBorder,
        focusedBorder: focusedBorder,
      ),
      textInputAction: TextInputAction.next,
    );
  }

  Widget emailInput() {
    return TextFormField(
      controller: email,
      textCapitalization: TextCapitalization.none,
      keyboardType: TextInputType.emailAddress,
      focusNode: FocusNode(),
      validator: (email) {
        Pattern pattern =
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
        RegExp regex = new RegExp(pattern);
        if (!regex.hasMatch(email)) {
          return 'Invalid email';
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 30),
        hintText: 'Email',
        hintStyle: TextStyle(
          color: Colors.black54,
        ),
        filled: true,
        fillColor: HexColor("#FFF5CC"),
        focusedErrorBorder: focusedErrorBorder,
        errorBorder: errorBorder,
        enabledBorder: enabledBorder,
        focusedBorder: focusedBorder,
      ),
      textInputAction: TextInputAction.next,
    );
  }

  Widget passwordInput() {
    return TextFormField(
      controller: password,
      obscureText: true,
      textCapitalization: TextCapitalization.none,
      keyboardType: TextInputType.text,
      focusNode: FocusNode(),
      validator: (password) {
        if (password == "") {
          return 'Invalid password';
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 30),
        hintText: 'Password',
        hintStyle: TextStyle(
          color: Colors.black54,
        ),
        filled: true,
        fillColor: HexColor("#FFF5CC"),
        focusedErrorBorder: focusedErrorBorder,
        errorBorder: errorBorder,
        enabledBorder: enabledBorder,
        focusedBorder: focusedBorder,
      ),
      textInputAction: TextInputAction.next,
    );
  }

  Widget confirmPasswordInput() {
    return TextFormField(
      controller: confirmPassword,
      obscureText: true,
      textCapitalization: TextCapitalization.none,
      keyboardType: TextInputType.text,
      focusNode: FocusNode(),
      validator: (confirmPassword) {
        if (confirmPassword == "") {
          return 'Invalid confirm password';
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 30),
        hintText: 'Confirm Password',
        hintStyle: TextStyle(
          color: Colors.black54,
        ),
        filled: true,
        fillColor: HexColor("#FFF5CC"),
        focusedErrorBorder: focusedErrorBorder,
        errorBorder: errorBorder,
        enabledBorder: enabledBorder,
        focusedBorder: focusedBorder,
      ),
      textInputAction: TextInputAction.next,
    );
  }

  Widget dateOfBirthInput() {
    return TextFormField(
      controller: dateOfBirth,
      textCapitalization: TextCapitalization.words,
      keyboardType: TextInputType.number,
      autocorrect: true,
      validator: (dateOfBirth) {
        if (dateOfBirth == "") {
          return 'Invalid date of birth';
        } else {
          return null;
        }
      },
      inputFormatters: [maskFormatter],
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 30),
        hintText: 'dd/mm/yyyy',
        hintStyle: TextStyle(color: Colors.black54),
        filled: true,
        fillColor: HexColor("#FFF5CC"),
        focusedErrorBorder: focusedErrorBorder,
        errorBorder: errorBorder,
        enabledBorder: enabledBorder,
        focusedBorder: focusedBorder,
      ),
      textInputAction: TextInputAction.next,
    );
  }
}
