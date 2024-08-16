import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ecom/utils/colors.dart';
import 'package:ecom/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import '../../data/model/cart_model.dart';
import 'confirmation_page.dart'; // Update this with your actual import path

class CheckoutPage extends StatelessWidget {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<CartModel>(context);
    isLoading = Provider.of<CartModel>(context, listen: false).isLoading;

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(
                height: height * 0.05,
              ),
              Center(
                child: Text(
                  'Checkout',
                  style: GoogleFonts.lato(
                      fontWeight: FontWeight.bold,
                      fontSize: width * 0.07,
                      color: AppColors.colorMainTheme),
                ),
              ),
              SizedBox(height: width * 0.04),
              ...cart.cartItems.map((item) => ListTile(
                    leading: Container(
                      height: height * 0.05,
                      width: width * 0.08,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        image: DecorationImage(
                          image: AssetImage("assets/images/tshirt.PNG"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: Text(
                      item['name'],
                      style: GoogleFonts.lato(
                          fontWeight: FontWeight.bold,
                          fontSize: width * 0.05,
                          color: AppColors.colorBlack),
                    ),
                    trailing: Text(
                      "\$${item['price'].toStringAsFixed(2)}",
                      style: GoogleFonts.lato(
                          fontWeight: FontWeight.bold,
                          fontSize: width * 0.05,
                          color: AppColors.colorBlack),
                    ),
                  )),
              Spacer(),
              Text(
                'Total: \$${cart.totalPrice.toStringAsFixed(2)}',
                style: GoogleFonts.lato(
                    fontWeight: FontWeight.bold,
                    fontSize: width * 0.055,
                    color: AppColors.colorBlue),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () async {
                  if (!isLoading) {
                    await _processPayment(context, cart.totalPrice);
                  }
                },
                child: Container(
                  height: height * 0.055,
                  width: width,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.colorMainTheme,
                      borderRadius: BorderRadius.circular(width * 0.04),
                    ),
                    child: Center(
                      child: isLoading
                          ? CircularProgressIndicator(color: AppColors.colorWhite,)
                          : Text(
                              'Proceed to Payment',
                              style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                  fontSize: width * 0.045,
                                  color: AppColors.colorWhite,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _processPayment(BuildContext context, double amount) async {
    try {
      await Provider.of<CartModel>(context, listen: false).loadingStatusChange();
      // 1. Create a PaymentIntent on your server
      final paymentIntentData = await createPaymentIntent(amount.toInt());
    await   Provider.of<CartModel>(context, listen: false).loadingStatusChange();

      // 2. Initialize the payment sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentData['client_secret'],
          merchantDisplayName: 'Flutter Demo Store',
        ),
      );

      // 3. Display the payment sheet
      await Stripe.instance.presentPaymentSheet();

      // 4. Handle payment success
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(SnackBar(content: Text("Payment Successful")));
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => ConfirmationPage()));
    } catch (e) {
      if (e is StripeException) {
        // Handle Stripe-specific errors
        _handleStripeError(context, e);
      } else {
        // Handle other errors, such as network issues
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Payment Failed: $e")));
      }
    }
  }

  void _handleStripeError(BuildContext context, StripeException e) {
    String errorMessage;

    if (e.error.code.toString() == 'FailureCode.Canceled') {
      errorMessage = "Payment was canceled by the user.";
    } else if (e.error.code == 'FailureCode.Failed') {
      errorMessage = "Payment failed. Please try again.";
    } else {
      errorMessage = "${e.error.message}";
    }

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(errorMessage)));
  }

  Future<Map<String, dynamic>> createPaymentIntent(int amount) async {
    Dio dio = Dio();
    try {
      var response = await dio.post(
          'https://stripe-tjal.onrender.com/create-payment-intent',
          data: {
            'amount': amount * 100, // Stripe expects the amount in cents
            'currency': 'usd',
          });
      if (response.statusCode == 200) {
        return jsonDecode(response.toString());
      } else {
        throw Exception('Failed to create payment intent');
      }
    } catch (e) {
      log('Exception: $e');
      throw Exception('Failed to create payment intent: $e');
    }
  }
}
