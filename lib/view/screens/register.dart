import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fullapp/view/screens/login.dart';
import 'package:fullapp/view/widget/input_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController fName = TextEditingController();
  TextEditingController lName = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController mobile = TextEditingController();

  Future register() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = FirebaseAuth.instance.currentUser;

    try {
      await auth
          .createUserWithEmailAndPassword(
              email: email.text, password: password.text)
          .then((signedInUser) {
        print(signedInUser.user!.uid);
        FirebaseFirestore.instance
            .collection('Users')
            .doc(signedInUser.user!.uid)
            .set({
          'fname': fName.text,
          'lname': lName.text,
          'email': email.text,
          'dob': dob.text,
          'gender': gender.text,
          'mobile': mobile.text,
        }).then((signedInUser) {
          Fluttertoast.showToast(
              msg: "Login Succesfull",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.TOP,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 16.0
          );
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginPage()));
        });
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Register"),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          InputField('First name', fName),
          InputField('Last name', lName),
          InputField('Email', email),
          InputField('Password', password),
          InputField('Mobile', mobile),
          InputField(
            'Date of Birth',
            dob,
          ),
          InputField('Gender', gender),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              register();
            },
            child: Container(
              height: 50,
              width: 180,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.indigo),
              child: Center(
                child: Text(
                  "Register",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
            ),
          ),
          SizedBox(height: 10,),
          Container(
            child: RichText(
              text: TextSpan(
                children: [
                  WidgetSpan(
                    child: Text('Already have account?',
                        style: TextStyle(color: Colors.black)),
                  ),
                  WidgetSpan(
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                      },
                        child: Text(
                      'Login Now',
                      style: TextStyle(color: Colors.indigo),
                    )),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
