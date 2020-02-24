import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:message_app/chat.dart';
import 'package:message_app/login.dart';
import 'package:message_app/login.dart' as prefix0;
import 'package:message_app/myhome.dart';
import 'package:message_app/register.dart';
import 'package:message_app/home.dart';
import 'package:message_app/menu.dart';
import 'package:message_app/global.dart' as globals;



void main() {
  var flag=1;
  runApp(MyApp());



}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,      home:loginp(),
        routes: {
          MyHomePage.id: (context) => MyHomePage(),
          menu.id:(context)=>menu(),
          register.id: (context) => register(),
          loginp.id: (context) => loginp(),
          chat.id: (context) => chat(),
        }, theme: ThemeData(




    )
    );
  }
}

/*
class inapp extends StatefulWidget {
  @override

  final FirebaseUser user;

  const inapp({Key key, this.user}) : super(key: key);
  _inappState createState() => _inappState();
}

class _inappState extends State<inapp> {
  @override

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _firestore = Firestore.instance;


  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => inme(context));
  }
  Widget build(BuildContext context) {
    return   inme(context);;
  }
  Widget inme(BuildContext context )
  {
    debugPrint("sas");
    if (globals.isLoggedIn) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MyHomePage(
              user: widget.user ,
            ),
          )
      );
    }
    else
    {

      loginp();

    }
  }

}


class myhome extends StatelessWidget {
  static const String id="homescreen";
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(

      body: Center(child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: <Widget>[


          Row(
mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              Hero(tag:'logo',child: Container(width: 200.0 ,height: 200.0,child: Image.asset('images/s.png')
              ),
              ),

              /*Text("S.S.S", style: Theme
                  .of(context)
                  .textTheme
                  .headline,),

*/


            ],


          ),
        SizedBox(
        height: 50.0,
      ),
      custombutton(
        text: "Log In",
        callback: () {
          Navigator.of(context).pushNamed(loginp.id);
        },
      ),
      custombutton(
        text: "Signup",
        callback: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>register()));
        },
      ),
        ],


      ),

      ),
    );
  }


}
class custombutton extends StatelessWidget
{
 final VoidCallback callback;
 final String text;

  const custombutton({Key key, this.callback, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Colors.lightBlueAccent,
        elevation: 6.0,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: callback,
          minWidth: 200.0,
          height: 45.0,
          child: Text(text),
        ),
      ),
    );
  }
}*/