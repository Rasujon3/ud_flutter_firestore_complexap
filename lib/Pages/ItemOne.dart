import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'ItemThree.dart';
import 'ItemTwo.dart';

class ItemOne extends StatefulWidget {
  @override
  _ItemOneState createState() => _ItemOneState();
}

class _ItemOneState extends State<ItemOne> {
  Future getPost() async {
    var firestore = Firestore.instance;
    QuerySnapshot snapshot =
        await firestore.collection("itemone").getDocuments();
    return snapshot.documents;
  }

  Future<Null> getRefresh() async {
    await Future.delayed(Duration(seconds: 3));
    setState(() {
      getPost();
    });
  }

  List<MaterialColor> colorItems = [
    Colors.deepOrange,
    Colors.blueGrey,
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.green,
    Colors.yellow,
  ];

  MaterialColor color;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getPost(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return RefreshIndicator(
              onRefresh: getRefresh,
              child: ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  var ourData = snapshot.data[index];

                  color = colorItems[index % colorItems.length];

                  return Container(
                    height: 220.0,
                    margin: EdgeInsets.all(5.0),
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Image.network(
                                ourData.data['image'],
                                height: 219.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text(
                                    ourData.data['title'],
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Container(
                                  child: Text(
                                    ourData.data['des'],
                                    maxLines: 5,
                                    style: TextStyle(
                                      fontSize: 17.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: InkWell(
                                    onTap: () {
                                      customDialog(
                                          context,
                                          ourData.data['image'],
                                          ourData.data['title'],
                                          ourData.data['des']);
                                    },
                                    child: Container(
                                      height: 40.0,
                                      padding: EdgeInsets.all(10.0),
                                      margin: EdgeInsets.all(
                                        10.0,
                                      ),
                                      //width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        color: color,
                                        //borderRadius: BorderRadius.circular(20.0),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Text(
                                        "View Details",
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }

  customDialog(BuildContext context, String image, String title, String des) {
    return showDialog(
        context: context,
        builder: (BuildContext) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Container(
              height: MediaQuery.of(context).size.height / 1.28,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Colors.deepPurple,
                      Colors.deepOrange,
                      Colors.green,
                      Colors.red,
                    ]),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 250.0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Image.network(
                          image,
                          height: 150.0,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 6.0,
                    ),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        title.toUpperCase(),
                        style: TextStyle(
                          fontSize: 22.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 6.0,
                    ),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        des,
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
