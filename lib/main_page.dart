// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project3/details_page.dart';

//presentation layer
class MainPage extends StatefulWidget{
  const MainPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState(){
    return _MainPage();
  }
}

      //build the main page ui
class _MainPage extends State<MainPage>{
  //instance from fetched data
  late Future<List<ListData>> doctors ;

  @override
  void initState() {
    super.initState();
    doctors = GetData().fetchListData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Doctors"),),
      body: FutureBuilder(
        future: doctors,
        builder: (context, snapshot) {
        if(snapshot.hasData){
          var _appDoctors = (snapshot.data as List<ListData>);

          return ListView.builder(
            itemCount: _appDoctors.length ,
            itemBuilder: (context , index) => Item(_appDoctors[index]),
            );
        }else if(snapshot.hasError){
          return Container(
            child: Center(
              child: Text("Error Page"),
            ),
          );
        }

        //builder must return wedget
        return Center(child: CircularProgressIndicator(),);
      },) ,
    );
  }
}

//item class for display data
class Item extends StatelessWidget{

  //expected 0 argument find 1 solution
  var _owener ;

  Item(this._owener);
  

  @override
  Widget build(BuildContext context) {
   return Container(
    height: MediaQuery.of(context).size.height / 8,
    child: Center(
      child: Card(
        child: Container(
          padding: EdgeInsets.only(top: 11 , bottom: 11),
          child: ListTile(
            dense: true,
            visualDensity: VisualDensity(vertical: 3),
            leading: Image.network(_owener.picture),
            title: Text(_owener.title),
            onTap: () { Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Details(_owener.title , _owener.content))
              );
            }
          ),
        ),
      )
    ),
   );
  }

}
//data layer
class ListData{
  String title;
  String picture;
  String content;
  String id;

  //constructor
  ListData(this.title , this.picture , this.content , this.id);

  factory ListData.jsonData(Map <String , dynamic> json){
    return ListData(
      json["title"],
      json["picture"],
      json["content"],
      json["id"],
    );
  }
}


//class that fetch data
class GetData {
  Future<List<ListData>> fetchListData() async {
    var content = await http.get(Uri.parse("https://62d4154fcd960e45d452f790.mockapi.io/api/article"));
    if(content.statusCode == 200){
      var contentData = jsonDecode(content.body);

      var contentList = (contentData as List);

      var list = contentList.map((item) => ListData.jsonData(item)).toList();

      return list;
    }
    else{
      throw Exception('Can not fetch user');
    }
  }
}