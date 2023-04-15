import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class AddMenu extends StatefulWidget {
  const AddMenu({Key? key}) : super(key: key);

  @override
  State<AddMenu> createState() => _AddMenuState();
}

class _AddMenuState extends State<AddMenu> {
  TextEditingController _productname = TextEditingController();
  TextEditingController _price = TextEditingController();
  var selected = "gujarati";
  var name1 = "";

  var gr = "";
  var dp = "";
  var _grp = "Simple";

  ImagePicker _picker = ImagePicker();

  var result = "0";
  bool isloding = false;

  _hanleRadio(val) {
    setState(() {
      _grp = val!;
    });
  }

  var product = "";

  File? selectedfile;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AddMenu"),
      ),
      body: SafeArea(
        child:(isloding)?Center(
          child: CircularProgressIndicator(),
        ): SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    (selectedfile==null)?
                    Image.network("https://media.istockphoto.com/id/1387646380/photo/shot-of-a-group-of-unrecognizable-businesspeople-holding-plants-in-dirt-at-work.jpg?b=1&s=170667a&w=0&k=20&c=7zT7_-WRxiJDSN71tNQEtIy0OZsZ5r0AkyNNayryha4=",fit: BoxFit.cover,width: 50,height: 50,)
                    :Image.file(selectedfile!,width: 100,),
                    IconButton(onPressed: () async{
                      XFile? photo = await _picker.pickImage(source: ImageSource.camera);
                      setState(() {
                        selectedfile = File(photo!.path);

                      });

                    }, icon:Icon(Icons.camera_alt_outlined)),
                    IconButton(onPressed: () async{
                      XFile? photo = await _picker.pickImage(source: ImageSource.gallery);
                      setState(() {
                        selectedfile = File(photo!.path);
                      });
                    }, icon:Icon(Icons.browse_gallery)),
                  ],
                ),
                SizedBox(height: 25.0,),
                TextField(
                  controller: _productname,
                  decoration: InputDecoration(
                    hintText: "Enter Product Name",
                    labelText: "Product Name",
                    hintStyle: TextStyle(color: Colors.cyan),
                    fillColor: Colors.blue,
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                      const BorderSide(color: Colors.red, width: 2.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 3.0, color: Colors.amber),
                    ),
                  ),
                  keyboardType: TextInputType.text,
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextField(
                  controller: _price,
                  decoration: InputDecoration(
                    hintText: "Product Price",
                    labelText: "price",
                    hintStyle: TextStyle(color: Colors.cyan),
                    fillColor: Colors.blue,
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                      const BorderSide(color: Colors.red, width: 2.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 3.0, color: Colors.amber),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Categary"),
                    SizedBox(
                      width: 25.0,
                    ),
                    DropdownButton(
                      value: selected,
                      onChanged: (val) {
                        setState(() {
                          selected = val!;
                        });
                      },
                      items: [
                        DropdownMenuItem(
                          child: Text("Gujarati"),
                          value: "gujarati",
                        ),
                        DropdownMenuItem(
                          child: Text("Eco"),
                          value: "eco",
                        ),
                        DropdownMenuItem(
                          child: Text("Ba"),
                          value: "ba",
                        ),
                        DropdownMenuItem(
                          child: Text("Sp"),
                          value: "sp",
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    Radio(
                      value: "Simple",
                      groupValue: _grp,
                      onChanged: _hanleRadio,
                    ),
                    Text("Simple"),
                    Radio(
                      value: "Variable",
                      groupValue: _grp,
                      onChanged: _hanleRadio,
                    ),
                    Text("Variable")
                  ],
                ),
                Center(
                  child: ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          isloding=true;
                        });
                        var name = _productname.text.toString();
                        var price = _price.text.toString();
                        var type = _grp.toString();
                        var categary = selected.toString();





                        var uuid = Uuid();
                        var filename = uuid.v1();
                        await FirebaseStorage.instance.ref(filename).
                        putFile(selectedfile!).whenComplete((){}).then((filedata)async{
                          await filedata.ref.getDownloadURL().then((fileurl)async{
                            await FirebaseFirestore.instance.collection("Products").add({
                              "productname":name,
                              "price":price,
                              "categary":categary,
                              "type":type,
                              "filename":filename,
                              "fileurl":fileurl,

                            }).then((value){

                              print("Data Added");
                              _productname.text="";
                              _price.text="";

                              setState(() {
                                selectedfile=null;
                                isloding=false;
                                _grp = "Simple";
                                selected = "gujarati";
                              });

                            });
                          });
                        });







                      },
                      child: Text("Add")),
                ),
              ],
            ),
          ),
        ),
      ),

    );
  }
}
