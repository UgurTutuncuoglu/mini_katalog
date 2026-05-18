import 'package:flutter/material.dart';
import 'shopping_screen.dart';
import '../models/product_model.dart';
import '../services/api_service.dart';
import '../components/product_card.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState()
      =>_HomeScreenState();

}

class _HomeScreenState
extends State<HomeScreen>{

  List<Product> products=[];
  String? errorMessage;
  bool isLoading=true;

  void loadProducts() async{
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      products = await ApiService.getProducts();
      if (products.isEmpty) {
        setState(() {
          errorMessage = 'No Data Found.';
        });
      }
    } catch (error) {
      errorMessage = 'Products could not be loaded.';
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  void initState(){

    super.initState();

    loadProducts();

  }

  @override
  Widget build(BuildContext context){

    return Scaffold(

      appBar: AppBar(

        backgroundColor:
        Colors.black,

        title: const Text(

          "Trend Shop",

          style: TextStyle(

              color: Colors.white,
              fontWeight:
              FontWeight.bold

          ),

        ),

        actions: [
    IconButton(
      onPressed: () {
          Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const ShoppingScreen(),
          ),
        );
      },
      icon: const Icon(
        Icons.shopping_cart,
        color: Colors.white,
      ),
    ),
  ],

      ),

      body:isLoading

          ?const Center(

        child:
        CircularProgressIndicator(),

      )

          :errorMessage != null
          ? Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            errorMessage!,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
        ),
      )
      
      
      
      :Column(
  children: [

    Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 8),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search Products",
          prefixIcon: const Icon(Icons.search),

          filled: true,
          fillColor: Colors.grey.shade200,

          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    ),

    Padding(
  padding: const EdgeInsets.symmetric(horizontal: 10),
  child: ClipRRect(
    borderRadius: BorderRadius.circular(15),
    child: SizedBox(
      height: 120, 
      width: double.infinity,
      child: Image.network(
        "https://wantapi.com/assets/banner.png",
        fit: BoxFit.cover, 
      ),
    ),
  ),
),



    const SizedBox(height: 10),

    Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: GridView.builder(
          itemCount: products.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.70,
          ),
          itemBuilder: (context, index) {
            return ProductCard(
              product: products[index],
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DetailScreen(
                      product: products[index],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    ),
  ],
)

    );

  }

}