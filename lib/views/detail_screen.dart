import 'package:flutter/material.dart';
import '../services/cart_manager.dart';

class DetailScreen extends StatelessWidget {

final dynamic product;

const DetailScreen({
  super.key,
required this.product
});

@override
Widget build(BuildContext context) {

return Scaffold( appBar: AppBar(), body:Padding(
  padding:EdgeInsets.all(20), child: Column(
    children: [ Image.network(product.image),
    
    SizedBox(height:20),

    Text(product.name,
    style: const TextStyle(
      fontSize: 26,
      fontWeight: FontWeight.bold,
      color: Colors.black
    ),
  ),

  const SizedBox(height:20),

     Text( product.description,
     style: TextStyle(
      fontSize: 14,
      color: Colors.grey[800],
      height: 1.5
     ),),
     
      ElevatedButton(
        onPressed:(){
              CartManager.add(product);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content:Text("Added to Cart"))
          );
        },
        child:
        Text(
    "Buy for ${product.price}",
    style: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
      ),),],
    ),
  ),
 );

}
}