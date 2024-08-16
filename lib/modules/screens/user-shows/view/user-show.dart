import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talk_pro/constants/string.dart';
import 'package:talk_pro/modules/screens/chat-app/model/chat-model.dart';
import 'package:talk_pro/modules/screens/gemini/view/gemini.dart';
import 'package:talk_pro/utils/auth-helper.dart';
import 'package:talk_pro/utils/firestore_helper.dart';

class UserShow extends StatelessWidget {
  const UserShow({Key? key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.sizeOf(context).height;
    double w = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: (AuthHelper.auth.currentUser?.displayName == null)
            ? Text(
                "${AuthHelper.auth.currentUser?.email?.split("@")[0].capitalizeFirst}",
                style: titleTextStyle(),
              )
            : Text(
                "${AuthHelper.auth.currentUser?.displayName}",
                style: titleTextStyle(),
              ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_sharp),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Image.asset(
              (Get.isDarkMode == true)
                  ? "lib/assets/vedio-white.png"
                  : "lib/assets/vedio-black.png",
              height: h / 28,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Image.asset(
              (Get.isDarkMode == true)
                  ? "lib/assets/edit-white.png"
                  : "lib/assets/edit-black.png",
              height: h / 40,
            ),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FireStoreHelper.fireStoreHelper.fetchUser(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else if (snapshot.hasData) {
            List<QueryDocumentSnapshot<Map<String, dynamic>>>? users =
                snapshot.data?.docs;
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Container(
                      padding: const EdgeInsets.only(left: 20),
                      height: h / 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: (Get.isDarkMode == true)
                            ? Colors.grey.shade200
                            : Colors.grey.shade200,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.search,
                            color: Colors.grey.shade500,
                          ),
                          SizedBox(
                            width: w / 30,
                          ),
                          Text(
                            "Search",
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 16,
                            ),
                          )
                        ],
                      )),
                ),
                Expanded(
                  flex: 4,
                  child: ListView.builder(
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
                  ),
                ),
                ListTile(
                  onTap: () async {
                    Get.to(GeminiBot());
                  },
                  title: Text(
                    "Gemini Chat Bot",
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  subtitle: const Text("Sent 2h ago"),
                  trailing: IconButton(
                    onPressed: () {},
                    icon: Image.asset(
                      (Get.isDarkMode == true)
                          ? "lib/assets/camera-white.png"
                          : "lib/assets/camera-black.png",
                      height: h / 30,
                    ),
                  ),
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(
                        "https://storage.googleapis.com/gweb-uniblog-publish-prod/images/IO24_WhatsInAName_Hero_1.width-1200.format-webp.webp"),
                  ),
                ),
                Expanded(
                  flex: 20,
                  child: ListView.builder(
                    itemCount: users?.length,
                    itemBuilder: (ctx, i) {
                      return ListTile(
                        onTap: () async {
                          Chat chatDetails = Chat(
                            message: '',
                            receiver: users?[i]['uid'],
                            sender: AuthHelper.auth.currentUser!.uid,
                          );
                          fetchedmsg = await FireStoreHelper.fireStoreHelper
                              .fetchMessage(chatdetails: chatDetails);
                          Get.toNamed('/chat', arguments: [
                            "${users?[i]['name']}",
                            "${users?[i]['dp']}",
                            "${users?[i]['uid']}",
                          ]);
                        },
                        title: Text(
                          "${users?[i]['name']}",
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        subtitle: const Text("Sent 2h ago"),
                        trailing: IconButton(
                          onPressed: () {},
                          icon: Image.asset(
                            (Get.isDarkMode == true)
                                ? "lib/assets/camera-white.png"
                                : "lib/assets/camera-black.png",
                            height: h / 30,
                          ),
                        ),
                        leading: CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage("${users?[i]['dp']}"),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  TextStyle titleTextStyle() => const TextStyle(
        fontSize: 20,
      );
}
