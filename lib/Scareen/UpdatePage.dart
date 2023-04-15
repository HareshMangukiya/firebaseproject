import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebaseproject/Scareen/ViewProduct.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class UpdatePage extends StatefulWidget {
  var updateid="";
  UpdatePage({required this.updateid});



  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  TextEditingController _productname = TextEditingController();
  TextEditingController _price = TextEditingController();
  var selected = "gujarati";
  var name1 = "";

  var gr = "";
  var dp = "";
  var _grp = "Simple";
  _hanleRadio(val) {
    setState(() {
      _grp = val!;
    });
  }
  var oldimagename="";
  var oldimageurl="";
  bool isloding=false;

  getsingle()async{
    await FirebaseFirestore.instance.collection( "Products").doc(widget.updateid).get().then((document){
      _productname.text = document["productname"];
      _price.text = document["price"];
      setState(() {
         selected = document["categary"];
        _grp = document["type"];
        oldimageurl=document["fileurl"];
         oldimagename=document["filename"];
      });
    });
  }
  ImagePicker _picker = ImagePicker();
  File? selectedfile;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getsingle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:(isloding)?Center(
        child: CircularProgressIndicator(),
      ):SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 25.0,),
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  (selectedfile==null)?(oldimageurl=="")?
                  Image.network("https://media.istockphoto.com/id/1387646380/photo/shot-of-a-group-of-unrecognizable-businesspeople-holding-plants-in-dirt-at-work.jpg?b=1&s=170667a&w=0&k=20&c=7zT7_-WRxiJDSN71tNQEtIy0OZsZ5r0AkyNNayryha4=",fit: BoxFit.cover,width: 50,height: 50,):
                  Image.network(
                    oldimageurl,
                    fit: BoxFit.cover,
                    width: 50,
                    height: 50,
                  ):Image.file(selectedfile!,width: 100,),
                  IconButton(
                      onPressed: () async {
                        XFile? photo = await _picker.pickImage(source: ImageSource.camera);
                        setState(() {
                          selectedfile = File(photo!.path);

                        });
                      }, icon: Icon(Icons.camera_alt_outlined)),
                  IconButton(
                      onPressed: () async{
                        XFile? photo = await _picker.pickImage(source: ImageSource.gallery);
                        setState(() {
                          selectedfile = File(photo!.path);
                        });
                      }, icon: Icon(Icons.browse_gallery)),
                ],
              ),
              SizedBox(
                height: 25.0,
              ),
              TextField(
                controller: _productname,
                decoration: InputDecoration(
                  hintText: "Enter Product Name",
                  labelText: "Product Name",
                  hintStyle: TextStyle(color: Colors.cyan),
                  fillColor: Colors.blue,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.red, width: 2.0),
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
                    borderSide: const BorderSide(color: Colors.red, width: 2.0),
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
                child: ElevatedButton(onPressed: ()async {
                  setState(() {
                    isloding=true;
                  });
                  var name = _productname.text.toString();
                  var price = _price.text.toString();
                  var type = _grp.toString();
                  var categary = selected.toString();

                  if(selectedfile==null)
                    {
                      await FirebaseFirestore.instance.collection("Products")
                          .doc(widget.updateid).update({
                        "productname":name,
                        "price":price,
                        "categary":categary,
                        "type":type,
                      }).then((value){
                        setState(() {
                          isloding=false;
                        });
                            Navigator.of(context).pop();
                      });
                    }
                  else
                    {
                      await FirebaseStorage.instance.ref(oldimagename).delete()
                          .then((value)async{
                        var uuid = Uuid();
                        var filename = uuid.v1();
                    await FirebaseStorage.instance.ref(filename).
                    putFile(selectedfile!).whenComplete((){}).then((filedata)async{
                    await filedata.ref.getDownloadURL().then((fileurl)async{
                      await FirebaseFirestore.instance.collection("Products")
                          .doc(widget.updateid).update({
                        "productname":name,
                        "price":price,
                        "categary":categary,
                        "type":type,
                        "filename":filename,
                        "fileurl":fileurl,
                      }).then((value){
                        setState(() {
                          isloding=false;
                        });
                        Navigator.of(context).pop();
                      });

                    });
                        });
                      });
                    };




                }, child: Text("Add")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
