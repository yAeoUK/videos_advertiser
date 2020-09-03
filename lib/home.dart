import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:videos_advertiser/main.dart';

import 'videoList.dart';

class HomePage extends StatefulWidget{
  @override
  HomePageState createState()=>HomePageState();
}

class HomePageState extends State<HomePage>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          RaisedButton(
            child:Text(
              MyApp.al.translate('VIDEOS')
            ),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (cont)=>VideoListPage()));
            },
          )
        ],
      ),
    );
  }
}