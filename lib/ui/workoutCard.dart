import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

Widget workoutCard(String img, String diff) {
  return Neumorphic(
    boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
    margin: EdgeInsets.all(10.0),
    style: NeumorphicStyle(
      shape: NeumorphicShape.concave,
      lightSource: LightSource.bottomLeft,
      depth: 8,
      color: Colors.grey[100]
    ),
      child:  Column(
          children: <Widget>[
            FittedBox(
              fit: BoxFit.fill,
              child: Image.asset(
                "assets/$img.png",
                width: 400,
                fit: BoxFit.fill,
              )
              ),
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
  );
}