import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String label;


  InputField( this.label,this.controller );



 TextEditingController controller =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(8),
      child: TextFormField(

        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10)
          ),
          label: Text(label),
        ),
      ),



    );
  }
}
