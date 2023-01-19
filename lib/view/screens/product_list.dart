import 'package:flutter/material.dart';

class ProductList extends StatelessWidget {
  final String name;
  final String description;
  final String category;
  final String price;
  const ProductList({
    required this.name,
    required this.description,
    required this.category,
    required this.price,


  }) ;

  @override
  Widget build(BuildContext context) {
    return       SizedBox(
      height :100,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text("name"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("description"),
                  ),
                  Text("category",),
                  Text("price"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(name),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(description,style: TextStyle(fontSize: 12),),
                  ),
                  Text(category,style: TextStyle(fontSize: 16),),
                  Text(price,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                ],
              ),

            ],

          ),
        ),
      ),
    );
  }
}
