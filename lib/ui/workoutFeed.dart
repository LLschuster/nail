


import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:nail/repositories/base.dart';
import 'package:nail/ui/workoutCard.dart';
import 'package:nail/ui/workoutDetail.dart';
import 'package:provider/provider.dart';

class WorkoutFeed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final store = Provider.of<Base>(context);

    void handleCardTap(String workoutImg) {
      store.mutateCurrentImg(workoutImg);
      Navigator.push(context, MaterialPageRoute(builder: (context) => WorkoutFeedDetail()));
    }

    return SafeArea(
      child: Container(
        color: Colors.grey[100],
        child:       ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        children: <Widget>[
          GestureDetector(
            onTap:(){
              handleCardTap("cardimg1");
            } ,
            child: Hero(tag: "detail", child: workoutCard("cardimg1", "3.8")) ,
            ),
          GestureDetector(
            onTap: (){
              handleCardTap("cardimg2");
            } ,
            child: Hero(tag: "detail2", child: workoutCard("cardimg2", "4.0")) ,
            ),
          GestureDetector(
            onTap: (){
              handleCardTap("cardimg3");
            } ,
            child: workoutCard("cardimg3", "4.5"),
            ),
        ]
      ),
      ) 

    );
  }
}