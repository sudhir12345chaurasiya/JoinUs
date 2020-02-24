import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:message_app/home.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class chat extends StatefulWidget {
  static const String id = "CHAT";
  final FirebaseUser user;
  final String names;


  const chat({Key key, this.user,this.names}) : super(key: key);


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ChatState();
  }


}

class _ChatState extends State<chat> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _firestore = Firestore.instance;

  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();

  Future<void> callback() async {
    if (messageController.text.length > 0) {
      await _firestore.collection(widget.names).add({
        'text': messageController.text,
        'from': widget.user.email,
        'date': DateTime.now().toIso8601String().toString(),



      });
      messageController.clear();
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 300),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Hero(
          tag: 'logo',
          child: Container(
            height: 40.0,
            child: Image.asset("images/d.png"),
          ),
        ),
        title: Text(widget.names),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.power_settings_new),
            onPressed: () {
              _auth.signOut();
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          )
        ],
      ),
      body: SafeArea(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
                child: SizedBox(
                  height: 200.0,

                  child:  StreamBuilder<QuerySnapshot>(
                    stream: _firestore
                        .collection(widget.names)
                        .orderBy('date')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData)
                        return Center(
                          child: CircularProgressIndicator(),
                        );

                      List<DocumentSnapshot> docs = snapshot.data.documents;

                      List<Widget> messages = docs
                          .map((doc) => Message(
                        from: doc.data['from'],
                        text: doc.data['text'],
                        me: widget.user.email == doc.data['from'],
                      ))
                          .toList();

                      return ListView(
                        controller: scrollController,
                        children: <Widget>[
                          ...messages,
                        ],
                      );
                    },
                  ),
                )
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onSubmitted: (value) => callback(),
                      decoration: InputDecoration(
                        hintText: "Enter a Message...",
                        border:  OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                      ),
                      controller: messageController,
                    ),
                  ),
                  SendButton(
                    text: "Send",

                    callback: callback,
                  )
                ],
              ),
            ),
          ],
        ),
      ),

    );
  }
}

class SendButton extends StatelessWidget {
  final String text;
  final VoidCallback callback;

  const SendButton({Key key, this.text, this.callback}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(focusColor: Colors.deepOrangeAccent,
      child:Icon(Icons.send),
      onPressed: callback,

    );
  }
}

class Message extends StatelessWidget {

  final String from;
  final String text;

  final bool me;

  const Message({Key key, this.from, this.text, this.me}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child:Card(    color: me ? Colors.yellow : Colors.white,elevation: 10.0,shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.circular(10.0)),child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.account_circle, size: 60.0, color: Colors.grey,),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Container(child: RichText(
                          text: TextSpan(
                              children: [
                                TextSpan(text:from, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18.0, color: Colors.black),),


                              ]
                          ),overflow: TextOverflow.ellipsis,
                        )),flex: 5,
                      ),

                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(text, style: TextStyle(fontSize: 18.0),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[

                      Icon(FontAwesomeIcons.reply, color: Colors.grey,),
                     pressed(),

                      Icon(Icons.forward, color: Colors.grey,),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
      ),
    );
    Divider();

  }
}
class pressed extends StatefulWidget {
  @override
  _pressedState createState() => _pressedState();
}

class _pressedState extends State<pressed> {
  bool liked=false;

  @override
  Widget build(BuildContext context) {
    return IconButton(icon: Icon(liked? Icons.favorite : Icons.favorite_border , color:liked? Colors.red:Colors.grey ),


        onPressed: ()
        {
          setState(() //<--whenever icon is pressed, force redraw the widget
          {
            liked=!liked;
          });
        }
    );
  }
}
