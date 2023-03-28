// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:paystack_integration/constant/payment/paystack_payment_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var selectedIndex;

  int price = 0;

  String email = "iamkingace68@gmail.com";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Plan"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              child: const Text("Choose\nYour Plan", 
              textAlign: TextAlign.center, 
               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
               ),
            ),
            const SizedBox(height: 20,),
            Expanded(
            child: GridView(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, 
              crossAxisSpacing: 3, 
              mainAxisSpacing: 10),

              children: List.generate(plan.length, (index){
                final data = plan[index];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                      price = data['price']!;
                    });
                  },
                  child: Card(
                    shadowColor: Colors.green,
                    elevation: 5,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: selectedIndex == null 
                        ? null 
                        : selectedIndex == index  
                        ?Colors.green 
                        : null
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("N ${data['price']}",
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold
                          ),),
                          Text("Get ${data['item']} More "),
                          const Text("Items")
                        ],
                      ),
                    ),
                  ),
                );
              }),
              ),
              ),
              GestureDetector(
                onTap: () {
                  if (selectedIndex == null){
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content:Text("Please Select a plan."))
                    );
                  }else {
                    print(price);
                    MakePayment(
                      ctx: context, 
                      price: price, 
                      email: email).chargeCardAndMakePayment();
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(14),
                  decoration: const BoxDecoration(
                    color: Colors.green,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.security, color: Colors.white,),
                      SizedBox(width: 15,),
                      Text("Proceed to payment", style: TextStyle(color: Colors.white),)
                    ],
                  ),
                ),
              )
          ],
        ),
      ),
     );
  }

  final plan = [
    {
      'price' : 500,
      'item' : 4
    },
      {
      'price' : 1000,
      'item' : 6
    },
      {
      'price' : 3500,
      'item' : 9
    },
      {
      'price' : 5000,
      'item' : 14
    },
  ];
}
