import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseproject/Scareen/UpdatePage.dart';
import 'package:flutter/material.dart';

class ViewProduct extends StatefulWidget {
  const ViewProduct({Key? key}) : super(key: key);

  @override
  State<ViewProduct> createState() => _ViewProductState();
}

class _ViewProductState extends State<ViewProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ViewProduct"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Products").snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshots) {
          if (snapshots.hasData) {
            if (snapshots.data!.size <= 0) {
              return Center(
                child: Text("No Data"),
              );
            } else {
              return ListView(
                children: snapshots.data!.docs.map((document) {
                  return Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        color: Colors.cyanAccent,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Column(
                          children: [
                            Image.network(document["fileurl"].toString()),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Name:-"),
                                Text(document["productname"].toString()),
                              ],
                            ),
                            SizedBox(height: 10.0,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Price:-"),
                                Text(document["price"].toString()),
                              ],
                            ),
                            SizedBox(height: 10.0,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("categary:-"),
                                Text(document["categary"].toString()),
                              ],
                            ),
                            SizedBox(height: 10.0,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("type:-"),
                                Text(document["type"].toString()),
                              ],
                            ),
                            SizedBox(height: 10.0,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                child: IconButton(onPressed:(){
                                  AlertDialog alert = new AlertDialog(
                                    title: Text("Are You Sure!"),
                                    actions: [
                                      ElevatedButton(onPressed:()async{
                                        
                                        var docid = document.id.toString();
                                        await FirebaseFirestore.instance.collection("Products").doc(docid).delete().then((value){
                                          Navigator.of(context).pop();
                                        });

                                        Navigator.pop(
                                            context, 'yes');
                                      }, child:Text("Yes")),
                                      ElevatedButton(onPressed:(){
                                        Navigator.pop(
                                            context, 'No');
                                      }, child:Text("No")),


                                    ],
                                  );
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return alert;
                                      });
                                }, icon:Icon(Icons.delete)),
                            ),
                                SizedBox(width: 25.0,),
                                CircleAvatar(
                                  child: IconButton(onPressed:(){


                                    var docid = document.id.toString();
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>UpdatePage(
                                      updateid: docid,
                                    )));
                                  }, icon:Icon(Icons.update)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
