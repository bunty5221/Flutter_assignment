import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fullapp/view/screens/home.dart';
import 'package:fullapp/view/screens/register.dart';
import 'package:fullapp/view/widget/input_field.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email= TextEditingController();
  TextEditingController password= TextEditingController();

  Future loginuser()async{
    FirebaseAuth auth = FirebaseAuth.instance;
    try {

      await auth.signInWithEmailAndPassword(
          email: email.text,
          password: password.text,

      ).then((value)  {
        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>HomePage()));
        Fluttertoast.showToast(
            msg: "Login Succesfull",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0
        );
      });

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {

        Fluttertoast.showToast(
            msg: "user not found",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      } else if (e.code == 'wrong-password') {
        print("wroong password");
        Fluttertoast.showToast(
            msg: "Wrong password",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("Login"),),


        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 100,),
               InputField('Email', email),
              InputField('Password', password),
              SizedBox(height: 20,),

              GestureDetector(
                onTap: () {
                  loginuser();
                },
                child: Container(
                  height: 50,
                  width: 180,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.indigo),
                  child: Center(
                    child: Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                ),
              ),
SizedBox(height: 10,),

              Container(child:  RichText(
                text: TextSpan(
                  children: [
                    WidgetSpan(
                      child: Text('Already have account?',
                          style: TextStyle(color: Colors.black)),
                    ),
                    WidgetSpan(
                      child: InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterScreen()));
                          },
                          child: Text(
                            'Register Now',
                            style: TextStyle(color: Colors.indigo),
                          )),
                    ),
                  ],
                ),
              ),),
            ],
          ),
        )



    );
  }
}
