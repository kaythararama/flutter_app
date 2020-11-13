


import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyButton extends StatelessWidget{

  Widget build(BuildContext context){
    return GestureDetector(
      onTap:(){
print('onTap onTap');
      },

      child: Container(
        height: 36,
          padding: EdgeInsets.all(8),
        margin: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.red[900]
        ),
        child: Center(
          child: Text('Engage'),
        ),
      )

    );
  }
}