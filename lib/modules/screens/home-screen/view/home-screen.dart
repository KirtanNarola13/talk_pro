import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talk_pro/modules/screens/home-screen/model/post.dart';
import 'package:talk_pro/utils/auth-helper.dart';
import 'package:talk_pro/utils/firestore_helper.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    logout() {
      AuthHelper.authHelper.signOut();
      Get.toNamed('/login');
    }

    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
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
                      fontSize: 32,
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
          Expanded(
            child: StreamBuilder(
              stream: FireStoreHelper.fireStoreHelper.getPost(),
              builder: (context, snapshot) {
                log("executed");
                if (snapshot.hasError) {
                  return Center(child: Text("${snapshot.error}"));
                } else if (snapshot.hasData) {
                  log("else if");
                  List<QueryDocumentSnapshot<Map<String, dynamic>>>? posts =
                      snapshot.data?.docs;
                  return ListView.builder(
                    itemCount: posts?.length,
                    itemBuilder: (context, i) {
                      log("return");
                      return Column(
                        children: [
                          SizedBox(
                            height: h / 2.2,
                            width: double.infinity,
                            child: Image.network(
                              "${posts?[i]['post']}",
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
