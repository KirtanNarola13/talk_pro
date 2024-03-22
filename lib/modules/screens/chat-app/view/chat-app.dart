import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:talk_pro/constants/string.dart';
import 'package:talk_pro/constants/theme-controller.dart';
import 'package:talk_pro/utils/auth-helper.dart';
import 'package:talk_pro/utils/firestore_helper.dart';

import '../../../../constants/theme.dart';
import '../model/chat-model.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> arguments =
        ModalRoute.of(context)!.settings.arguments as List<String>;
    double h = MediaQuery.sizeOf(context).height;
    double w = MediaQuery.sizeOf(context).width;
    ThemeController controller = Get.put(ThemeController());
    return Obx(
      () => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              "${controller.themeModel.currentTheme}",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Row(
              children: [
                CircleAvatar(
                  radius: 15,
                  foregroundImage: NetworkImage(arguments[1]),
                ),
                SizedBox(
                  width: w / 30,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(
                      '/chat-detail',
                      arguments: [
                        arguments[0],
                        arguments[1],
                        arguments[2],
                      ],
                    );
                  },
                  child: Text(
                    arguments[0].capitalizeFirst!,
                    style: const TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
              ],
            ),
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back_sharp,
                color: Colors.white,
              ),
            ),
            actions: [
              Transform.scale(
                scale: 0.6,
                child: Image.asset(
                  'lib/assets/vedio-white.png',
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.bottomSheet(
                    BottomSheet(
                      onClosing: () {},
                      builder: (context) => Container(
                        padding: const EdgeInsets.only(top: 50),
                        child: Column(
                          children: ThemeConstance.theme
                              .map(
                                (e) => ListTile(
                                  title: Text("${e['name']}"),
                                  leading: CircleAvatar(
                                    foregroundImage:
                                        NetworkImage("${e['img']}"),
                                  ),
                                  onTap: () {
                                    controller.changeTheme(
                                      theme: e['img']!,
                                      name: e['name']!,
                                    );
                                    Get.back();
                                  },
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                  );
                },
                child: Transform.scale(
                  scale: 0.5,
                  child: Image.asset(
                    'lib/assets/theme-white.png',
                  ),
                ),
              ),
            ],
          ),
          body: Column(
            children: [
              Expanded(
                  child: StreamBuilder(
                stream: fetchedmsg,
                builder: (ctx, snapshot) {
                  if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  } else if (snapshot.hasData) {
                    List<QueryDocumentSnapshot<Map<String, dynamic>>>?
                        messages = snapshot.data?.docs;

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                          reverse: true,
                          itemCount: messages?.length,
                          itemBuilder: (ctx, i) {
                            return Align(
                              alignment:
                                  (arguments[2] != messages?[i]['receivedby'])
                                      ? Alignment.centerLeft
                                      : Alignment.centerRight,
                              child: Container(
                                margin: const EdgeInsets.only(
                                  top: 20,
                                ),
                                constraints: const BoxConstraints(
                                  maxWidth:
                                      200.0, // Set your desired maximum width
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(
                                      0.5), // Set your desired color
                                  borderRadius: BorderRadius.circular(
                                      8.0), // Adjust the radius as needed
                                ),
                                padding: const EdgeInsets.all(
                                    8.0), // Adjust padding as needed
                                child: Text(
                                  "${messages?[i]['message']}",
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            );
                          }),
                    );
                  }
                  return const CircularProgressIndicator();
                },
              )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: instagramStyleTextField(receiver: arguments[2]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container instagramStyleTextField({required String receiver}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade700,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.camera_alt_outlined,
              color: Colors.white.withOpacity(0.5),
            ),
          ),
          Expanded(
            child: TextFormField(
              style: TextStyle(color: Colors.white.withOpacity(0.8)),
              cursorColor: Colors.black,
              controller: messageController,
              onChanged: (val) {
                message = val;
              },
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Send message...',
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              log("$message");
              messageController.clear();
              Chat chat = Chat(
                message: message!,
                receiver: receiver,
                sender: AuthHelper.auth.currentUser!.uid,
              );
              FireStoreHelper.fireStoreHelper.sendMessage(chatdetails: chat);
              message = null;
            },
            icon: Icon(
              Icons.send,
              color: Colors.white.withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }
}
