import 'package:ecom/utils/colors.dart';
import 'package:ecom/utils/const.dart';
import 'package:ecom/view/ui/product_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../data/model/cart_model.dart';

class ConfirmationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<CartModel>(context, listen: false);
    cart.clearCart(); // Clear the cart after successful payment

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
        child: Column(
          children: [
            SizedBox(
              height: height * 0.05,
            ),
            Center(
              child: Text(
                "Payment Confirmation",
                style: GoogleFonts.lato(
                    fontWeight: FontWeight.bold,
                    fontSize: width * 0.07,
                    color: AppColors.colorMainTheme),
              ),
            ),
            SizedBox(
              height: height * 0.15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 75),
              child: Image.asset(
                "assets/images/done.png",
                scale: 0.8,
              ),
            ),
            SizedBox(
              height: height * 0.1,
            ),
            Text(
              'Payment Successful!',
              style: GoogleFonts.lato(
                  fontWeight: FontWeight.bold,
                  fontSize: width * 0.065,
                  color: AppColors.colorBlue),
            ),
            SizedBox(
              height: height * 0.3,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => ProductPage()),
                  (route) => false,
                );
              },
              child: Container(
                height: height * 0.055,
                width: width * 0.92,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.colorMainTheme,
                    borderRadius: BorderRadius.circular(width * 0.04),
                  ),
                  child: Center(
                    child: Text(
                      'DONE',
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
    );
  }
}
