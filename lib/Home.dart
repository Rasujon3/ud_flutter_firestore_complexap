import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Pages/ItemOne.dart';
import 'Pages/ItemTwo.dart';
import 'Pages/ItemThree.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _indexpage = 1;
  final pageOptions = [
    ItemOne(),
    ItemTwo(),
    ItemThree(),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Complex App"),
        backgroundColor: Colors.deepOrange,
      ),

      body: pageOptions[_indexpage],

      bottomNavigationBar: CurvedNavigationBar(
        items: [
          Icon(Icons.poll,size: 30.0,color: Colors.white,),
          Icon(Icons.home,size: 30.0,color: Colors.white,),
          Icon(Icons.library_books,size: 30.0,color: Colors.white,),
        ],
        color: Colors.deepOrange,
        buttonBackgroundColor: Colors.black,
        backgroundColor: Colors.green,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 300),
        index: 1,
        onTap: (int index){
          setState(() {
            _indexpage = index;
          });
        },
      ),

    );
  }
}
