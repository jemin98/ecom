import 'package:ecom/utils/colors.dart';
import 'package:ecom/utils/const.dart';
import 'package:ecom/view/ui/product_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _navigateToNextPage();
    super.initState();
  }

  _navigateToNextPage() async {
    // Wait for 3 seconds on the splash screen
    await Future.delayed(const Duration(milliseconds: 2000));

    // After waiting, check the authentication state
    // FirebaseAuth.instance.authStateChanges().first.then((User? user)

    // var user;
    // setState(() {
    //   user = FirebaseAuth.instance.currentUser;
    // });
    {
      // if (user == null)
      {
        // If no user is logged in, navigate to the OnboardingScreens

        // Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => MasterPage(),
        //     ));
      }

      // else {
      // If a user is logged in, navigate to the MasterPage
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ProductPage(),
          ));
      // // // }
    }
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      // backgroundColor: colorMainTheme,
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: height * 0.35,
            ),
            SizedBox(
                height: height * 0.18,
                width: width * 0.45,
                child: Icon(
                  Icons.shopping_bag,
                  size: width * 0.4,
                  color: AppColors.colorBlue,
                )),
            SizedBox(
              height: height * 0.01,
            ),
            Text(
              "Ecommerce",
              style: GoogleFonts.lato(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: AppColors.colorMainTheme),
            ),
            Text(
              "Prepared By Jemin Sohaliya",
              style: GoogleFonts.lato(
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                  color: AppColors.colorBlue),
            ),
          ],
        ),
      ),
    );
  }
}
