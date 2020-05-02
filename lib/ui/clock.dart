
import 'package:flutter/material.dart';

Widget clock(Duration duration){
  var elapsedMinutes = duration.inMinutes;
  var elapsedSeconds = duration.inSeconds - (elapsedMinutes * 60);
  return Container(
    child: Text("$elapsedMinutes : $elapsedSeconds")
  );
}