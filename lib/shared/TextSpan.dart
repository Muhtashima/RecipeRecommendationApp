import 'package:flutter/material.dart';
class StyleText{
  String text;
  List<String?> keywords;

  StyleText({required this.text, required this.keywords});

  Text highlight(){

       List<TextSpan> spans = [];


      RegExp regExp = RegExp(keywords.join('|'));

      text.splitMapJoin(regExp, onMatch: (Match match) {
        spans.add(TextSpan(text: match.group(0), style: TextStyle(color: Colors.red)));
        return match.group(0)!;
      }, onNonMatch: (String text) {
        spans.add(TextSpan(text:text));
        return text;
      });



// Create a Text widget with the RichText widget and the list of TextSpans
      return Text.rich(
      TextSpan(children: spans),
    );
  }

// Use the richText widget in your UI

}