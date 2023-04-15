import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddEmploy extends StatefulWidget {
  const AddEmploy({Key? key}) : super(key: key);

  @override
  State<AddEmploy> createState() => _AddEmployState();
}

class _AddEmployState extends State<AddEmploy> {
  TextEditingController _name = TextEditingController();
  TextEditingController _salary = TextEditingController();
  var selected = "Fullter";
  var name1 = "";


  var gr = "";
  var dp = "";
  var _gender ="";




  var result ="0";

  _hanleRadio(val)
  {
    setState((){
      _gender = val!;
    });
  }

  var name = "";
  var salry ="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AddEmploy"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(

          child:  Column(
            children: [
              SizedBox(height: 20.0,),
              TextField(
                controller: _name,
                decoration: InputDecoration(
                  hintText:" Name",
                  labelText: " Name",
                  hintStyle: TextStyle(color: Colors.cyan),
                  fillColor: Colors.blue,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.red,width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 3.0,color: Colors.amber),
                  ),
                ),
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 20.0,),

              TextField(
                controller: _salary,
                decoration: InputDecoration(
                  hintText: "Salary",
                  labelText: "Salary",
                  hintStyle: TextStyle(color: Colors.cyan),
                  fillColor: Colors.blue,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.red,width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 3.0,color: Colors.amber),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Categary"),
                  SizedBox(width: 25.0,),
                  DropdownButton(
                    value: selected,
                    onChanged: (val) {
                      setState(() {
                        selected = val!;
                      });
                    },
                    items: [
                      DropdownMenuItem(

                        child: Text("Java"),
                        value: "Java",
                      ),
                      DropdownMenuItem(
                        child: Text("c"),
                        value: "c++",
                      ),
                      DropdownMenuItem(
                        child: Text("Fullter"),
                        value: "Fullter",
                      ),
                      DropdownMenuItem(
                        child: Text("Web"),
                        value: "Web",
                      ),
                    ],
                  ),
                ],

              ),
              SizedBox(height: 20.0,),
              Row(
                children: [
                  Radio(
                    value: "Male",
                    groupValue:_gender ,
                    onChanged: _hanleRadio,
                  ),
                  Text("Male"),
                  Radio(
                    value: "Female",
                    groupValue: _gender,
                    onChanged: _hanleRadio,
                  ),
                  Text("Female")
                ],
              ),
              Center(
                child: ElevatedButton(onPressed: () async{
                  var ename = _name.text.toString();
                  var esalary = _salary.text.toString();
                  var egender = _gender.toString();
                  var edeprment = selected.toString();


                  await FirebaseFirestore.instance.collection("Emplus").add({
                    "name":ename,
                    "salary":esalary,
                    "gender":egender,
                    "edeprment":edeprment,
                  }).then((value){
                    print("Data Added");
                    _name.text="";
                    _salary.text="";
                    _gender="";
                    selected="";


                  });




                }, child: Text("Add")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
