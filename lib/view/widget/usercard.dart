import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final String title;
 final String first;
  final String second;
   const UserCard({required this.first, required this.second,required this.title }) ;

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 6),
      child: SizedBox(
        height: 60,
        child: Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,


            children: [
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(title),
              ),
              SizedBox(width: 130,),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(first),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(second),
              ),
            ],
          ),

        ),
      ),
    );
  }
}
