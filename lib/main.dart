import 'package:flutter/material.dart';
import 'package:project3/details_page.dart';
import 'package:project3/main_page.dart';


void main() {
  var title ;
  var content;

  runApp(MaterialApp(
    initialRoute: "/",
    routes: {
      "/" :(context) =>  MainPage(),
      "/details" :(context) =>  Details(title , content),
    },
  ));
}


