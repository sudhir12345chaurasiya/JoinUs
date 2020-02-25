import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:message_app/chat.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:message_app/global.dart';
import 'package:message_app/home.dart';
import 'package:message_app/main.dart';
import 'package:message_app/myhome.dart';
import 'package:message_app/register.dart';
import 'package:message_app/global.dart' as globals;


class loginp extends StatefulWidget
{

  static const String id="loginpage";
  @override

  State<StatefulWidget> createState() {
    // TODO: implement createState
    return  login();
  }
}
class login extends State<loginp> {


  String _email, _password;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

// ignore: must_call_super

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(

        body: Container(decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/bg.jpg"),
                fit: BoxFit.cover)),
            child: Center(child: Form(key: _formKey, child: Padding(
              padding: EdgeInsets.all(20.0), child: ListView(children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: <Widget>[

                  Hero(tag: 'logo',
                    child: Container(
                        width: 210.0, height: 250.0, child: Image.asset(
                        'images/d.png')
                    ),
                  ),

                  Text("Join uS", style: Theme
                      .of(context)
                      .textTheme
                      .headline,),


                ],


              ),
              Padding(padding: EdgeInsets.all(20.0), child: TextFormField(
                validator: (input) {
                  if (input.isEmpty) {
                    return "Please enter your email ID";
                  }
                },
                onSaved: (input) {
                  _email = input.toString().trim();
                },

                keyboardType: TextInputType.emailAddress,
                autofocus: false,


                decoration: InputDecoration(
                  hintText: 'Email',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  border: OutlineInputBorder(borderRadius: BorderRadius
                      .circular(32.0)),
                ),
              ),


              ),
              Padding(padding: EdgeInsets.all(20.0), child: TextFormField(
                autofocus: false,
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  border: OutlineInputBorder(borderRadius: BorderRadius
                      .circular(32.0)),
                ),

                validator: (input) {
                  if (input.isEmpty) {
                    return "Please enter your password";
                  }

                  if (input.length < 6) {
                    return "Incorrect Password";
                  }
                },
                onSaved: (input) {
                  _password = input.toString().trim();
                },


              ),
              ),

              Padding(
                padding: EdgeInsets.all(5.0),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),

                  onPressed:
                  signIn
                  ,

                  color: Colors.lightGreen,
                  child: Text('Log In', style: TextStyle(color: Colors.white)),
                ),
              ),

              Padding(
                padding: EdgeInsets.all(5.0),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),

                  onPressed:
                      () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => register()));
                  }
                  ,

                  color: Colors.lightBlueAccent,
                  child: Text('Signup', style: TextStyle(color: Colors.white)),
                ),
              ),


              FlatButton(
                child: Text(
                  'Forgot password?',
                  style: TextStyle(color: Colors.black54),
                ),
                onPressed: () {},
              ),


            ],
            ),
            ),
            )
            )
        )
    );
  }

  Future<void> signIn() async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      try {
        FirebaseUser user = (await FirebaseAuth.instance.
        signInWithEmailAndPassword(email: _email, password: _password))
            .user;
if(_email=="jain@join.com") {
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            MyHomePage(
              user: user,
            ),
      )
  );
}
else{ Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) =>
          MyHomePage1(
            user: user,
          ),
    )
);}
      }
      catch (e) {
        print(e);
      }
    }
  }

}

