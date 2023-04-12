import 'package:flutter/material.dart';
const textInputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 2.0),
  ),
  focusedBorder:OutlineInputBorder(
    borderSide: BorderSide(color: Colors.pink, width: 2.0),
  ),
);

class Decorate{
  double width;
  double height;
  double radius;
  Color boxColor;

  Decorate({required this.width, required this.height, required this.radius, required this.boxColor});
  Container withBox(String text){
    return Container(
      width: width!,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: boxColor,
      ),
      child: Center(
          child: Text(text,
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
            ),
          )
      ),
    );
  }

}