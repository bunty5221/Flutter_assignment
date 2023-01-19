import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class UserDetails extends StatefulWidget {
  const UserDetails({Key? key}) : super(key: key);

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
String fName = "demo";
String lName = "demo";
String email = "demo";
String mobile = "demo";
String dob = "demo";
String gender = "demo";


  void getdata() async{
    User? user = await FirebaseAuth.instance.currentUser;
    var userdata = await FirebaseFirestore.instance.collection('Users').doc(user!.uid).get();
     setState(() {
       fName= userdata.data()!['fname'];
       lName= userdata.data()!['lname'];
       email= userdata.data()!['email'];
       mobile= userdata.data()!['mobile'];
       dob= userdata.data()!['dob'];
       gender= userdata.data()!['gender'];





     });
  }

  @override
  void initstate(){
    getdata();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(fName,style: TextStyle(color: Colors.white,fontSize: 20),),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(lName,style: TextStyle(color: Colors.white,fontSize: 20),),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(email,style: TextStyle(color: Colors.white,fontSize: 20),),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(mobile,style: TextStyle(color: Colors.white,fontSize: 20),),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(dob,style: TextStyle(color: Colors.white,fontSize: 20),),
          ),
    Text(gender,style: TextStyle(color: Colors.white,fontSize: 20),)


        ],
      ),
    );
  }
}
