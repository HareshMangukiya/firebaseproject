import 'package:firebaseproject/Scareen/AddEmploy.dart';
import 'package:firebaseproject/Scareen/AddMenu.dart';
import 'package:firebaseproject/Scareen/ViewEmploy.dart';
import 'package:firebaseproject/Scareen/ViewProduct.dart';
import 'package:flutter/material.dart';

class firebase extends StatefulWidget {
  const firebase({Key? key}) : super(key: key);

  @override
  State<firebase> createState() => _firebaseState();
}

class _firebaseState extends State<firebase> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firebase"),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            SizedBox(height: 75.0,),
            Container(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AddMenu()));
                },
                child: Text("Add Product Details"),
              ),
            ),
            SizedBox(height: 25.0,),
            Container(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ViewProduct()));
                },
                child: Text("View Product"),
              ),
            ),
            SizedBox(height: 25.0,),
            Container(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AddEmploy()));
                },
                child: Text("Add Employ"),
              ),
            ),
            SizedBox(height: 25.0,),
            Container(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ViewEmploy()));
                },
                child: Text("View Employ"),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
