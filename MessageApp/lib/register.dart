import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:message_app/inputField.dart';
import 'package:message_app/login.dart';
import 'package:message_app/textButton.dart';
import 'package:message_app/roundedButton.dart';
import 'package:message_app/validations.dart';
import 'package:message_app/authentication.dart';
import 'package:message_app/style.dart';

class register extends StatefulWidget {
  static const String id="signup";
  const register({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SignUpScreenState();
  }


}

class SignUpScreenState extends State<register> {



  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  UserData newUser = new UserData();
  UserAuth userAuth = new UserAuth();
  bool _autovalidate = false;
  Validations _validations = new Validations();

  _onPressed() {
    print("button clicked");
  }

  void showInSnackBar(String value) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
  }

  void _handleSubmitted() {
    final FormState form = _formKey.currentState;
    if (!form.validate()) {
      _autovalidate = true; // Start validating on every change.
      showInSnackBar('Please fix the errors in red before submitting.');
    } else {
      form.save();
      userAuth.createUser(newUser).then((onValue) {
        showInSnackBar(onValue);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>loginp()));
      }).catchError((Object onError) {
        showInSnackBar(onError.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Size screenSize = MediaQuery.of(context).size;
    //print(context.widget.toString());
    return (MaterialApp(debugShowCheckedModeBanner: false,      home:
    Scaffold(
        key: _scaffoldKey,
        body:  Container(decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/bg.jpg"),
                fit: BoxFit.cover)),child:new SingleChildScrollView(
          child: new Container(
            padding: new EdgeInsets.all(16.0),

            child: new Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new SizedBox(
                    height: screenSize.height / 2,
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Text(
                          "Join uS",
                          textAlign: TextAlign.center,
                           style: TextStyle(fontSize: 60.0,),
                        ),
                        SizedBox(height: 20.0,),
                        Text(
                          "SIGN UP",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 30.0),
                        )
                      ],
                    )),
                new SizedBox(
                  height: screenSize.height / 2,
                  child: new Column(
                    children: <Widget>[
                      new Form(
                          key: _formKey,
                          autovalidate: _autovalidate,
                          //onWillPop: _warnUserAboutInvalidData,
                          child: new Column(
                            children: <Widget>[

                               InputField(

                                hintText: "Username",
                                obscureText: false,
                                textInputType: TextInputType.text,
                                icon: Icons.person_outline,
                                iconColor: Colors.blue,
                                bottomMargin: 20.0,
                                validateFunction: _validations.validateName,
                                onSaved: (String name) {
                                  newUser.displayName = name;
                                },
                              ),
                              new InputField(
                                  hintText: "Email",
                                  obscureText: false,
                                  textInputType: TextInputType.emailAddress,

                                  icon: Icons.mail_outline,
                                  iconColor: Colors.green,
                                  bottomMargin: 20.0,
                                  validateFunction: _validations.validateEmail,
                                  onSaved: (String email) {
                                    newUser.email = email;
                                  }),
                              new InputField(
                                  hintText: "Password",
                                  obscureText: true,
                                  textInputType: TextInputType.text,


                                  icon: Icons.lock_open,
                                  iconColor: Colors.lightBlueAccent,
                                  bottomMargin: 40.0,
                                  validateFunction:
                                  _validations.validatePassword,
                                  onSaved: (String password) {
                                    newUser.password = password;
                                  }),
                              new RoundedButton(
                                  buttonName: "Continue",
                                  onTap: _handleSubmitted,
                                  width: screenSize.width,
                                  height: 50.0,
                                  buttonColor: Colors.lightBlueAccent,
                                  bottomMargin: 10.0,
                                  borderWidth: 1.0)
                            ],
                          )),

                    ],
                  ),
                )
              ],
            ),
          ),
        )))));
  }
}