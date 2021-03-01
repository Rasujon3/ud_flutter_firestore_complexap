import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'ItemOne.dart';
import 'ItemTwo.dart';

class ItemThree extends StatefulWidget {
  @override
  _ItemThreeState createState() => _ItemThreeState();
}

class _ItemThreeState extends State<ItemThree> {

  Future getGridView() async{
    var firestore = Firestore.instance;
    QuerySnapshot snapshot = await firestore.collection("gridData").getDocuments();
    return snapshot.documents;
  }

  Future<Null> getRefresh() async {
    // pull to refresh
    await Future.delayed(Duration(seconds: 3));
    setState(() {
      getGridView();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getGridView(),
        builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }else{
            return RefreshIndicator(
                onRefresh: getRefresh,
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                  itemCount: snapshot.data.length,
                  itemBuilder: (context,index){

                    var ourData = snapshot.data[index];

                    return Card(
                      elevation: 10.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: InkWell(
                          onTap: (){
                            customDialog(
                              context,
                              ourData.data['img'],
                            );
                          },
                          child: Image.network(ourData.data['img'],
                          fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  }),
            );
          }
        },
      ),
    );
  }

  customDialog(BuildContext context, String image) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Container(
              height: MediaQuery.of(context).size.height / 1.20,
              width: MediaQuery.of(context).size.width,
              // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.circular(20.0),
              //   gradient: LinearGradient(
              //       begin: Alignment.topRight,
              //       end: Alignment.bottomLeft,
              //       colors: [
              //         Colors.deepPurple,
              //         Colors.deepOrange,
              //         Colors.green,
              //         Colors.red,
              //       ]),
              // ),

              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Image.network(
                          image,
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
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
