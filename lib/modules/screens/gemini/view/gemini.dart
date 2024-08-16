import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get/get.dart';
import 'package:talk_pro/utils/firestore_helper.dart';

import '../../../../constants/theme-controller.dart';
import '../../../../constants/theme.dart';

class GeminiBot extends StatefulWidget {
  const GeminiBot({super.key});

  @override
  State<GeminiBot> createState() => _GeminiBotState();
}

class _GeminiBotState extends State<GeminiBot> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    String? resultGemini;
    String? message;
    final messageController = TextEditingController();
    sendToGemini(String message) async {
      Gemini gemini = Gemini.instance;
      String? resul;
      await gemini.text(message).then((value) {
        resul = value!.output;
        FirebaseFirestore.instance.collection('gemini').add({
          'message': message,
          'response': resul,
          'time': DateTime.now().toString(),
        });
      });
      setState(() {
        resultGemini = resul as String;
      });
      log("From Gemini : $resultGemini");
    }

    Container instagramStyleTextField() {
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
                  )),
            ),
            IconButton(
              onPressed: () {
                sendToGemini(message!);
                messageController.clear();
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
                const CircleAvatar(
                  radius: 15,
                  foregroundImage: NetworkImage(
                      "https://storage.googleapis.com/gweb-uniblog-publish-prod/images/IO24_WhatsInAName_Hero_1.width-1200.format-webp.webp"),
                ),
                SizedBox(
                  width: w / 30,
                ),
                GestureDetector(
                  onTap: () {},
                  child: const Text(
                    "Gemini Bot",
                    style: TextStyle(fontSize: 15, color: Colors.white),
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
                        child: Column(
                          children: [
                            const Text(
                              'Theme',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 150, right: 150),
                              child: Divider(),
                            ),
                            Expanded(
                              child: ListView.builder(
                                  itemCount: ThemeConstance.theme.length,
                                  itemBuilder: (context, index) {
                                    List<Map<String, RxString>> theme =
                                        ThemeConstance.theme;
                                    return Column(
                                      children: [
                                        ListTile(
                                          title:
                                              Text("${theme[index]['name']}"),
                                          leading: CircleAvatar(
                                            foregroundImage: NetworkImage(
                                                "${theme[index]['img']}"),
                                          ),
                                          onTap: () {
                                            controller.changeTheme(
                                              theme: theme[index]['img']!,
                                              name: theme[index]['name']!,
                                            );
                                            Get.back();
                                          },
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(
                                            left: 30,
                                            right: 30,
                                          ),
                                          child: Divider(),
                                        ),
                                      ],
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ),
                      enableDrag: true,
                      elevation: 2,
                      onDragStart: (_) {},
                      showDragHandle: true,
                      dragHandleColor: (Get.isDarkMode == false)
                          ? Colors.black
                          : Colors.white,
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: StreamBuilder(
                stream: FireStoreHelper.fireStoreHelper.getGeminiChat(),
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
                              alignment: (messages?[i]['response'] != null)
                                  ? Alignment.centerLeft
                                  : Alignment.centerRight,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                        top: 20,
                                      ),
                                      constraints: const BoxConstraints(
                                        maxWidth:
                                            350.0, // Set your desired maximum width
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(
                                            0.5), // Set your desired color
                                        borderRadius: BorderRadius.circular(
                                            8.0), // Adjust the radius as needed
                                      ),
                                      padding: const EdgeInsets.all(
                                          8.0), // Adjust padding as needed
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "You",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          Text(
                                            "${messages?[i]['message']}",
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                        top: 20,
                                      ),
                                      constraints: const BoxConstraints(
                                        maxWidth:
                                            350.0, // Set your desired maximum width
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(
                                            0.5), // Set your desired color
                                        borderRadius: BorderRadius.circular(
                                            8.0), // Adjust the radius as needed
                                      ),
                                      padding: const EdgeInsets.all(
                                          8.0), // Adjust padding as needed
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Gemini",
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          const SizedBox(
                                            height: 30,
                                          ),
                                          Text(
                                            "${messages?[i]['response']}",
                                            style: const TextStyle(
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
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
                child: instagramStyleTextField(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
