import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:flutter_paystack/src/models/bank.dart';
import 'package:paystack_integration/constant/key.dart';

class MakePayment{

  MakePayment({required this.ctx, required this.price, required this.email});

  BuildContext ctx;

  int price;

  String email;

  PaystackPlugin paystackPlugin = PaystackPlugin();

  String _getReference() {
    String platform;
    if (Platform.isIOS) {
      platform = 'iOS';
    } else {
      platform = 'Android';
    }

    return 'ChargedFrom${platform}_${DateTime.now().millisecondsSinceEpoch}';
  }

  PaymentCard _getCardUI() {
    return PaymentCard(
      number: "", 
      cvc: " ", 
      expiryMonth: 0, 
      expiryYear: 0
      );
}


  Future initializePlugin() async {
    await paystackPlugin.initialize(publicKey: ConstantKey.PAYSTACK_KEY);
  }

  chargeCardAndMakePayment() async {
    initializePlugin().then((_) async{
      Charge charge = Charge()
        ..amount = price * 100
        ..email = email
        ..reference = _getReference()
        ..card = _getCardUI();

      
      CheckoutResponse checkoutResponse = 
      await paystackPlugin.checkout(
        ctx, 
        charge: charge,
        method: CheckoutMethod.card,
        fullscreen: false,
        logo:const FlutterLogo(
          size: 24,)
        );

        print("checkoutResponse $checkoutResponse");

        if(checkoutResponse.status == true){
          print("Transaction Successfull");
        }else {
          print("Transaction Failed!");
        }
    });
  }
}

