

import 'dart:ui' as prefix0;

import 'package:message_app/menu/about_tile.dart';
import 'package:message_app/menu/uidata.dart';
import 'package:flutter/material.dart';
import 'package:message_app/chat.dart';
import 'package:message_app/menu//common_drawer.dart';
import 'package:message_app/menu/custom_float.dart';
import 'package:message_app/menu/uidata.dart';
import 'package:message_app/chat1.dart';

import 'package:message_app/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:message_app/global.dart' as globals;

import 'package:firebase_auth/firebase_auth.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:message_app/newuser.dart';
import 'package:message_app/notify.dart';
import 'package:message_app/search.dart';

import 'developer.dart';
class MyHomePage extends StatefulWidget {
  static const String id="home";
  final FirebaseUser user;

  const MyHomePage({Key key, this.user}) : super(key: key);


  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _firestore = Firestore.instance;
  @override
  var selectedPageIndex = 0;

  var pages = [
    loginp(),

  ];
  Widget build(BuildContext context) {
    return new MaterialApp(debugShowCheckedModeBanner: false, theme: ThemeData(


      scaffoldBackgroundColor: Colors.white60,
    ), home: Scaffold(appBar: AppBar(
      backgroundColor: Colors.lightBlue,
      title: Text("Home", style: TextStyle(color: Colors.black),),
      actions: <Widget>[

        IconButton(icon: Icon(Icons.add), onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    newuser(
                    ),
              )
          );
        },

        ),



        IconButton(
          icon: Icon(FontAwesomeIcons.signOutAlt,color: Colors.white,),
          onPressed: () {
            _auth.signOut();
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
        ),

      ],

    ), drawer: commondrawer(), body:StreamBuilder(
      stream: Firestore.instance.collection('group').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(child: CircularProgressIndicator(),);

        return ListView.builder(itemBuilder: (context, index) =>
            listitems(context, snapshot.data.documents[index]),
          itemExtent: 80.0,
          itemCount: snapshot.data.documents.length,);
      },
    )

      ,




      //pages[selectedPageIndex],
      bottomNavigationBar: BottomNavigationBar(elevation:2.0  ,items: [
        BottomNavigationBarItem(
          title: Text(""),
          icon: Icon(FontAwesomeIcons.home, color: selectedPageIndex == 0? Colors.blue : Colors.blueGrey,),
        ),
        BottomNavigationBarItem(
          title: Text(""),
          icon: Icon(FontAwesomeIcons.search, color: selectedPageIndex == 1? Colors.blue : Colors.blueGrey,),
        ),
        BottomNavigationBarItem(
            title: Text(""),
            icon: Icon(FontAwesomeIcons.bell, color: selectedPageIndex == 2? Colors.blue : Colors.blueGrey,)
        ),
        BottomNavigationBarItem(
          title: Text(""),
          icon: Icon(FontAwesomeIcons.user, color: selectedPageIndex == 3? Colors.blue : Colors.blueGrey,),
        ),
      ], onTap: (index) {
        setState(() {
          selectedPageIndex = index;
          if(selectedPageIndex==1)
          {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchPage()));

          }
          else if(selectedPageIndex==2){

            Navigator.push(context, MaterialPageRoute(builder: (context)=>NotificationPage()));
          }
          else if(selectedPageIndex==3){

            Navigator.push(context, MaterialPageRoute(builder: (context)=>Sif()));

          }
        });
      }, currentIndex: selectedPageIndex,),


/*
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(
          title: Text(""),
          icon: Icon(Icons.home, color:  Colors.blue ),
        ),
        BottomNavigationBarItem(
          title: Text(""),
          icon: Icon(Icons.search, color : Colors.lightGreen ),
        ),
        BottomNavigationBarItem(
            title: Text(""),
            icon: Icon(Icons.notifications, color: Colors.blueGrey,)

        ),

      ], onTap: (index) {
        setState(() {

        });
      }, ),*/



    )
    );
  }









  Widget listitems(BuildContext context,DocumentSnapshot document) {




    return ListTile(

        title: Card(elevation: 10.0,borderOnForeground: true, shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0)), child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[

              Expanded(child: Text(document['name'],style: Theme
                  .of(context)
                  .textTheme
                  .headline,)
              ),






              IconButton(
                  icon: Icon(Icons.message, color: Colors.green), onPressed:  ()
              {


                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => chat(user: widget.user,names: document['name'],),
                    )
                );

              }
              ),


        IconButton(
        icon: Icon(Icons.delete, color: Colors.green), onPressed:()
        {

        Firestore.instance.collection("group").document(document['name']).delete();



        }
        ),




        ]

        )
        )

    );

  }


  Widget commondrawer(){


    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[

          UserAccountsDrawerHeader(
            accountName: Text(
              "",
            ),
            accountEmail: Text(widget.user.email),
            currentAccountPicture: new CircleAvatar(
              backgroundImage: new AssetImage(UIData.pkImage),
            ),
          ),
          new ListTile(
            title: Text(
              "Profile",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
            ),
            leading: Icon(
              Icons.person,
              color: Colors.blue,
            ),
          ),

          Divider(),
          new ListTile(
            title: Text(
              "Settings",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
            ),
            leading: Icon(
              Icons.settings,
              color: Colors.brown,
            ),
          ),
          Divider(),
          MyAboutTile()
        ],
      ),
    );
  }
}































