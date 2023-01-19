import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fullapp/view/widget/input_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddProducts extends StatefulWidget {
  const AddProducts({Key? key}) : super(key: key);

  @override
  State<AddProducts> createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {

  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController category = TextEditingController();
  TextEditingController price = TextEditingController();


  final  firestore = FirebaseFirestore.instance.collection('Products');

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        centerTitle: true,
        title: Text("Add Products"),),
      body: SingleChildScrollView(
        child: Column(

          children: [
            SizedBox(height: 20,),
            InputField("Name", name),
            InputField("Description", description),
            InputField("Category", category),
            InputField("Price", price),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: (){
              String id = DateTime.now().microsecondsSinceEpoch.toString();


              firestore
                  .doc(id)
                  .set({
                'id':id,
                'name' : name.text.toString(),
                'description' : description.text.toString(),
                'category' : category.text.toString(),
                'price' : price.text.toString(),

              })
                  .then((value) => {
                Fluttertoast.showToast(
                    msg: "Logout Succesfull",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                    fontSize: 16.0
                ),
              })
                  .onError((error, stackTrace) => {});
              Navigator.pop(context);
            }, child: Text("        Add  Products       "), ),


          ],
        ),
      ),
    );

  }
}
