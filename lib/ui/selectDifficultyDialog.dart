

import 'package:flutter/material.dart';

class SelectDifficultyDialog extends StatefulWidget{
  @override
  State<SelectDifficultyDialog> createState() { 
    return SelectDifficultyDialogState();
  }
}

class SelectDifficultyDialogState extends State<SelectDifficultyDialog> {
double difficultyLevel;

@override
  void initState() {
    super.initState();
    difficultyLevel = 1.0;
  }
@override
  Widget build(BuildContext context) {
    
        return SimpleDialog(
          title: Text("How challenging it was?"),
          children: <Widget>[
            Slider(
              onChanged: (value) {
              setState(() {
                difficultyLevel = value;
              });
              print(value);
            },
            activeColor: Colors.blue,
            max: 5.0,
            min: 1.0,
            value: difficultyLevel,
            divisions: 5,),
            SimpleDialogOption(
            onPressed: () { Navigator.pop(context, difficultyLevel); },
            child: const Text('Confirm'),
          ),
          ]
        );
  }
}