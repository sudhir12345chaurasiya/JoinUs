

import "package:flutter/material.dart";

void main()
{
  runApp(
      MaterialApp(title: "MyProfile",
        debugShowCheckedModeBanner: false,
        home:Sif() ,
        theme: ThemeData(
            buttonColor: Colors.green,
            brightness: Brightness.dark,
            primaryColor: Colors.deepPurple


        ),

      )


  );
}
class Sif extends StatefulWidget
{


  @override
  State<StatefulWidget> createState() {

    return _Si();
  }
}
class _Si extends State<Sif>
{
  @override

  final minimum=50.0;

  Widget build(BuildContext context) {
    // TODO: implement build
    TextStyle textStyle=Theme.of(context).textTheme.title;

    return Scaffold(appBar:AppBar(title:Text("MyProfile",textAlign:TextAlign.center ,),leading: Icon(Icons.person),),body:  Container(margin: EdgeInsets.all(20.0),child: ListView(children: <Widget>[


      getasset(),

      Padding(padding:EdgeInsets.only(top: 20.0,bottom: 10.0),child: Text("Join uS Messenger is a freeware that connects people from different departments, cross-platform messaging  over IP service owned by Samyak Jain and Co. It allows users to send text messages . ",style: Theme
          .of(context)
          .textTheme
          .headline,textAlign: TextAlign.center,)





      ),





    ],


    )
    )

      ,) ;

  }
  Widget getasset()
  {
    AssetImage assetImage=AssetImage('images/we.jpg');
    Image image=Image(image: assetImage,width: 125.0,height: 120.0,);
    return Container(child:image,margin: EdgeInsets.all(minimum),);
  }
}