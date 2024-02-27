import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talk_pro/utils/auth-helper.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    logout() {
      AuthHelper.authHelper.signOut();
      Get.toNamed('/');
    }

    double h = MediaQuery.sizeOf(context).height;
    double w = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: h / 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: w / 30,
                  ),
                  Text(
                    "Talk Pro",
                    style: GoogleFonts.playball().copyWith(
                      fontSize: 28,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      logout();
                    },
                    icon: const Icon(Icons.favorite_border),
                    splashRadius: 5,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.chat_bubble_outline),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
