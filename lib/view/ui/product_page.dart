import 'package:ecom/utils/colors.dart';
import 'package:ecom/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../data/model/cart_model.dart';
import 'checkout_page.dart';

class ProductPage extends StatelessWidget {
  final String productName = "Flutter T-shirt";
  final String productDescription = "A comfortable Flutter-themed T-shirt.";
  final double productPrice = 20.0;

  @override
  Widget build(BuildContext context) {
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height * 0.05,
              ),
              Center(
                child: Text(
                  "Product Page",
                  style: GoogleFonts.lato(
                      fontWeight: FontWeight.bold,
                      fontSize: width * 0.07,
                      color: AppColors.colorMainTheme),
                ),
              ),
              SizedBox(height: width * 0.04),
              Container(
                height: height * 0.5,
                width: width,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  image: DecorationImage(
                    image: AssetImage("assets/images/tshirt.PNG"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: width * 0.04),
              Text(
                "Brand : $productName",
                style: GoogleFonts.lato(
                    fontWeight: FontWeight.bold,
                    fontSize: width * 0.055,
                    color: AppColors.colorBlue),
              ),
              SizedBox(height: 8),
              Text(
                "Desc : $productDescription",
                style: GoogleFonts.lato(
                    fontWeight: FontWeight.w400,
                    fontSize: width * 0.04,
                    color: AppColors.colorGrey),
              ),
              SizedBox(height: 8),
              Text(
                "\$${productPrice.toStringAsFixed(2)}",
                style: GoogleFonts.lato(
                    fontWeight: FontWeight.bold,
                    fontSize: width * 0.05,
                    color: AppColors.colorBlack),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  Provider.of<CartModel>(context, listen: false)
                      .addToCart(productName, productPrice);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CheckoutPage()));
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
                      child: Text(
                        'Add to Cart',
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
}
