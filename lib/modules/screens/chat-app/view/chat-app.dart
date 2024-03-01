import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talk_pro/constants/string.dart';
import 'package:talk_pro/utils/auth-helper.dart';
import 'package:talk_pro/utils/firestore_helper.dart';

import '../model/chat-model.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> arguments =
        ModalRoute.of(context)!.settings.arguments as List<String>;
    double h = MediaQuery.sizeOf(context).height;
    double w = MediaQuery.sizeOf(context).width;
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
              "https://e0.pxfuel.com/wallpapers/672/579/desktop-wallpaper-black-gradient-red-gradient.jpg"),
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
              Text(arguments[0]),
            ],
          ),
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_sharp),
          ),
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
                  List<QueryDocumentSnapshot<Map<String, dynamic>>>? messages =
                      snapshot.data?.docs;

                  return ListView.builder(
                      reverse: true,
                      itemCount: messages?.length,
                      itemBuilder: (ctx, i) {
                        return Align(
                          alignment:
                              (arguments[2] != messages?[i]['receivedby'])
                                  ? Alignment.centerLeft
                                  : Alignment.centerRight,
                          child: Chip(
                            label: Text("${messages?[i]['message']}"),
                          ),
                        );
                      });
                }
                return CircularProgressIndicator();
              },
            )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: chatTextField(receiver: arguments[2]),
            ),
          ],
        ),
      ),
    );
  }

  TextFormField chatTextField({required String receiver}) => TextFormField(
        cursorColor: Colors.black,
        controller: messageController,
        onChanged: (val) {
          message = val;
        },
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: () {
              log("$message");

              Chat chat = Chat(
                message: message!,
                receiver: receiver,
                sender: AuthHelper.auth.currentUser!.uid,
              );
              FireStoreHelper.fireStoreHelper.sendMessage(chatdetails: chat);
              messageController.clear();
            },
            icon: Icon(Icons.send),
          ),
          hintText: 'send message....',
        ),
      );
}
