import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewEmploy extends StatefulWidget {
  const ViewEmploy({Key? key}) : super(key: key);

  @override
  State<ViewEmploy> createState() => _ViewEmployState();
}

class _ViewEmployState extends State<ViewEmploy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ViewEmploy"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Emplus").snapshots(),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Name:-"),
                                Text(document["name"].toString()),
                              ],
                            ),
                            SizedBox(height: 10.0,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Deprment:-"),
                                Text(document["edeprment"].toString()),
                              ],
                            ),
                            SizedBox(height: 10.0,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Gender:-"),
                                Text(document["gender"].toString()),
                              ],
                            ),
                            SizedBox(height: 10.0,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Salary:-"),
                                Text(document["salary"].toString()),
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
                                        ElevatedButton(onPressed:(){
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
                                  child: IconButton(onPressed:(){}, icon:Icon(Icons.update)),
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
