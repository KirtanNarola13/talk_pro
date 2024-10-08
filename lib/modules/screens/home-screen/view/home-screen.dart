import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talk_pro/modules/screens/reel/view/reel.dart';
import 'package:talk_pro/utils/auth-helper.dart';
import 'package:talk_pro/utils/firestore_helper.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    logout() {
      AuthHelper.authHelper.signOut();
      Get.toNamed('/login');
    }

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: h / 25,
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: w / 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Talk Pro",
                  style: GoogleFonts.playball().copyWith(
                    fontSize: 32,
                    letterSpacing: 2,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Image(
                        image: AssetImage(
                          Get.isDarkMode == true
                              ? "lib/assets/like-white.png"
                              : "lib/assets/like-dark.png",
                        ),
                        height: h / 40,
                      ),
                      onPressed: () {
                        logout();
                      },
                      splashRadius: 5,
                    ),
                    IconButton(
                      onPressed: () {
                        FireStoreHelper.fireStoreHelper.uploadToStorage();
                      },
                      icon: const Icon(Icons.upload),
                    ),
                    IconButton(
                      onPressed: () {
                        Get.to(const Reel());
                      },
                      icon: const Icon(Icons.video_camera_back_outlined),
                    ),
                    IconButton(
                      onPressed: () {
                        Get.toNamed('/userShow');
                      },
                      icon: Image(
                        image: AssetImage(
                          Get.isDarkMode == true
                              ? "lib/assets/message-white.png"
                              : "lib/assets/message-black.png",
                        ),
                        height: h / 40,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            height: h / 8,
            child: StreamBuilder(
              stream: FireStoreHelper.fireStoreHelper.fetchUser(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<QueryDocumentSnapshot<Map<String, dynamic>>>? users =
                      snapshot.data?.docs;
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: users?.length,
                    itemBuilder: (context, i) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: h / 20,
                              child: CircleAvatar(
                                radius: 40,
                                foregroundImage:
                                    NetworkImage("${users?[i]['dp']}"),
                              ),
                            ),
                            Text(
                              "${users?[i]['name']}",
                              style: const TextStyle(fontSize: 10),
                            )
                          ],
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text("${snapshot.error}"));
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
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
                      return Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      foregroundImage:
                                          NetworkImage(posts?[i]['dp']),
                                      radius: 21,
                                    ),
                                    SizedBox(
                                      width: w / 80,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          posts?[i]['username'],
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const Text(
                                          "4 minutes ago",
                                          style: TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Image(
                                    image: AssetImage(Get.isDarkMode == true
                                        ? "lib/assets/dots-white.png"
                                        : "lib/assets/dots-dark.png"),
                                    height: h / 40,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Container(
                              height: h / 2,
                              width: double.infinity,
                              child: Image.network(
                                "${posts?[i]['post']}",
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: Image(
                                    image: AssetImage(Get.isDarkMode == true
                                        ? "lib/assets/like-white.png"
                                        : "lib/assets/like-dark.png"),
                                    height: h / 35,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Image(
                                    image: AssetImage(Get.isDarkMode == true
                                        ? "lib/assets/com-white.png"
                                        : "lib/assets/com-dark.png"),
                                    height: h / 35,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Image(
                                    image: AssetImage(Get.isDarkMode == true
                                        ? "lib/assets/send-white.png"
                                        : "lib/assets/send-black.png"),
                                    height: h / 35,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(
                              posts?[i]['description'],
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
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
