import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:message_app/home.dart';


class newuser extends StatefulWidget {
  @override
  _newuserState createState() => _newuserState();
}

class _newuserState extends State<newuser> {
  @override
  TextEditingController users = TextEditingController();


  Widget build(BuildContext context) {

    someMethod() async {
      Firestore.instance.collection("group").document(users.text).setData({'name':users.text});

      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      print(user);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>MyHomePage(user: user,),
          )
      );
    }



    return MaterialApp(debugShowCheckedModeBanner: false,home:Scaffold(body:

    Container(margin: EdgeInsets.all(20.0),child: ListView(children: <Widget>[





      Padding(padding:EdgeInsets.only(top: 10.0,bottom: 10.0),child:   TextFormField(
        key: Key('email'),
        decoration: InputDecoration(labelText: 'Group Name'),
        //validator: EmailFieldValidator.validate,

        controller:users ,
      ),

      ),

      RaisedButton(

        child: Text('Create', style: TextStyle(fontSize: 20.0)),
        onPressed: ()=>someMethod(),
      ),

    ]
    )

    )
    )
    );
  }
}