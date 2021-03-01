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
        title: Text("সুজন এর রাফখাতা"),
        backgroundColor: Colors.deepOrange,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountEmail:  Text(
                "rasujon3@gmail.com",
                style: TextStyle(fontSize: 15.0,),
              ),
              accountName: Text(
                "সুজন এর রাফখাতা",
                style: TextStyle(fontSize: 20.0),
              ),
              decoration: BoxDecoration(
                color: Colors.deepOrange,
              ),
            ),

            ListTile(
              onTap: (){
                Navigator.of(context).pop();
                Navigator.of(context).push(new MaterialPageRoute(builder: (c)=>ItemOne()));
              },
              title: Text("First Item",
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.black,
              ),
              ),
              leading: Icon(Icons.more,color: Colors.black,),
            ),
            ListTile(
              onTap: (){
                Navigator.of(context).pop();
                Navigator.of(context).push(new MaterialPageRoute(builder: (c)=>ItemTwo()));
              },
              title: Text("Second Item",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                ),
              ),
              leading: Icon(Icons.home,color: Colors.black,),
            ),
            ListTile(
              onTap: (){
                Navigator.of(context).pop();
                Navigator.of(context).push(new MaterialPageRoute(builder: (c)=>ItemThree()));
              },
              title: Text("Third Item",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                ),
              ),
              leading: Icon(Icons.photo_album,color: Colors.black,),
            ),

          ],
        ),
      ),
      body: pageOptions[_indexpage],
      bottomNavigationBar: CurvedNavigationBar(
        items: [
          Icon(
            Icons.poll,
            size: 30.0,
            color: Colors.white,
          ),
          Icon(
            Icons.home,
            size: 30.0,
            color: Colors.white,
          ),
          Icon(
            Icons.library_books,
            size: 30.0,
            color: Colors.white,
          ),
        ],
        color: Colors.deepOrange,
        buttonBackgroundColor: Colors.black,
        backgroundColor: Colors.green,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 300),
        index: 1,
        onTap: (int index) {
          setState(() {
            _indexpage = index;
          });
        },
      ),
    );
  }
}
