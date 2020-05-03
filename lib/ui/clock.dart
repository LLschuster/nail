
import 'package:flutter/material.dart';

Widget clock(Duration duration){
  var elapsedMinutes = duration.inMinutes;
  var elapsedSeconds = duration.inSeconds - (elapsedMinutes * 60);
  return Container(
    padding: EdgeInsets.symmetric(vertical: 10.0),
    child: Text("$elapsedMinutes : $elapsedSeconds", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
  );
}