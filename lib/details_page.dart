
// ignore_for_file: prefer_typing_uninitialized_variables, use_key_in_widget_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';

class Details extends StatelessWidget{

  var title ;
  var content;

  Details(this.title , this.content);

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Container(
          child: Text(content),
        ),
      ),
    );
  }

}