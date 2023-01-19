import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fullapp/view/screens/add_products.dart';
import 'package:fullapp/view/screens/login.dart';
import 'package:fullapp/view/screens/product_list.dart';
import 'package:fullapp/view/widget/usercard.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final firestore =
      FirebaseFirestore.instance.collection("Products").snapshots();

  String fName = "demo";
  String lName = "demo";
  String email = "demo";
  String mobile = "demo";
  String dob = "demo";
  String gender = "demo";

  getdata() async {
    User? user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(user!.uid)
        .get()
        .then((value) => {
              lName = value.data()!['lname'],
              fName = value.data()!['fname'],
              email = value.data()!['email'],
              mobile = value.data()!['mobile'],
              dob = value.data()!['dob'],
              gender = value.data()!['gender'],
            });
  }

  @override
  void initstate() {
    getdata();
    super.initState();
  }

  void _signOut() {
    FirebaseAuth.instance.signOut().then((value) => {

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage())),
    Fluttertoast.showToast(
    msg: "Logout Succesfull",
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.black,
    textColor: Colors.white,
    fontSize: 16.0
    ),
    });
    User? user = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text("Homepage"),
          actions: [
            ElevatedButton.icon(
                onPressed: _signOut,
                icon: Icon(Icons.logout),
                label: Text("LogOut"))
          ],
          bottom: TabBar(tabs: [
            Tab(
              text: "products",
              icon: Icon(Icons.list),
            ),
            Tab(
              text: "Profile",
              icon: Icon(Icons.person_outlined),
            ),
          ]),
        ),
        body: TabBarView(
          children: [
            Column(
              children: [
                StreamBuilder<QuerySnapshot>(
                    stream: firestore,
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting)
                        return CircularProgressIndicator();
                      if (snapshot.hasError) return Text("some errror");

                      return Expanded(
                        child: ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  ProductList(name: snapshot.data!.docs[index]['name'].toString(), description: snapshot.data!.docs[index]['description'].toString(), category: snapshot.data!.docs[index]['category'].toString(), price: snapshot.data!.docs[index]['price'].toString()),

                                ],

                              );
                            }),
                      );
                    }),
              ],
            ),
            Container(
              child: FutureBuilder(
                future: getdata(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        UserCard(first: fName, second: lName, title: "Name"),
                        UserCard(first: email, second: "", title: "Email"),
                        UserCard(first: mobile, second: "", title: "Mobile"),
                        UserCard(
                            first: dob, second: "", title: "Date of Birth"),
                        UserCard(first: gender, second: "", title: "Gender"),
                      ],
                    );
                  }
                  return CircularProgressIndicator();
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddProducts()));
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
