import 'package:flutter/material.dart';

Widget workoutCard(String img, String diff) {
  return Center(
    child: Card(
      elevation: 20,
      margin: EdgeInsets.all(10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            child: Image.asset(
              "assets/$img.png",
              width: 400.0,
              height: 200.0, 
            )),
            ListTile(
            leading: Icon(Icons.album),
            title: Text('Full body workout'),
            subtitle: Row(
              children: <Widget>[
                Icon(Icons.star),
                Icon(Icons.star),
                Icon(Icons.star),
                Icon(Icons.star),
                Icon(Icons.star),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 4.0),
                  child: Text("$diff")
                  )
              ]
            ),
          ),

        ],
      ),
    ),
  );
}