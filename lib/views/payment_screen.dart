import 'package:flutter/material.dart';
import 'home_screen.dart';
import '../services/cart_manager.dart';
class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  String paymentMethod = "cash";
  String cardType = "visa";

  double parsePrice(String price) {
  return double.parse(
    price.replaceAll("\$", "").replaceAll(",", ""),
  );
}

double getTotalPrice() {
  double total = 0;

  for (var item in CartManager.items) {
    total += parsePrice(item.product.price) * item.quantity;
  }

  return total;
}

  void submitPayment() {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Text("Processing payment..."),
            ],
          ),
        ),
      );

      Future.delayed(const Duration(seconds: 2), () {
        if (!mounted) return;

        Navigator.pop(context);
        CartManager.clear();
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
          (route) => false,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [

              const Text(
                "Checkout",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              Text(
                "Total: \$${getTotalPrice().toStringAsFixed(2)}",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 20),

              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Full Name"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Name required";
                  }

                  if (!RegExp(r'^[a-zA-ZçÇğĞıİöÖşŞüÜ\s]+$').hasMatch(value)) {
                    return "Only letters allowed (Turkish supported)";
                  }

                  return null;
                },
              ),

              TextFormField(
                controller: addressController,
                decoration: const InputDecoration(labelText: "Address"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Address required";
                  }

                  if (!RegExp(r'^[a-zA-Z0-9çÇğĞıİöÖşŞüÜ\s,.-]+$')
                      .hasMatch(value)) {
                    return "Invalid address format";
                  }

                  return null;
                },
              ),

              TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(labelText: "Phone Number"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Phone required";
                  }
                  if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                    return "Only numbers allowed";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20), 

              const Text(
                "Payment Method",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),


              RadioGroup<String>(
                  groupValue: paymentMethod,
                  onChanged: (value) {
                    setState(() {
                      paymentMethod = value!;
                    });
                  },
                  child: Column(
                    children: [
                      RadioListTile(
                        value: "cash",
                        title: const Text("Cash"),
                      ),
                      RadioListTile(
                        value: "card",
                        title: const Text("Credit Card"),
                        
                      ),
                    ],
                  ),
              ),
              if (paymentMethod == "card") ...[
                const SizedBox(height: 10),

                DropdownButtonFormField<String>(
                  value: cardType,
                  decoration: const InputDecoration(
                    labelText: "Card Type",
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: "visa",
                      child: Text("Visa"),
                    ),
                    DropdownMenuItem(
                      value: "master",
                      child: Text("MasterCard"),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      cardType = value!;
                    });
                  },
                ),
              ],
              const SizedBox(height: 30),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.all(14),
                ),
                onPressed: submitPayment,
                child: const Text(
                  "Pay Now",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}