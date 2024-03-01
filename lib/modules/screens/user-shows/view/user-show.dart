import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talk_pro/utils/auth-helper.dart';
import 'package:talk_pro/utils/firestore_helper.dart';

class UserShow extends StatelessWidget {
  const UserShow({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: (AuthHelper.auth.currentUser?.displayName == null)
            ? Text(
                "${AuthHelper.auth.currentUser?.email?.split("@")[0].capitalizeFirst}")
            : Text("${AuthHelper.auth.currentUser?.displayName}"),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back_sharp),
        ),
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
            return ListView.builder(
                shrinkWrap: true,
                itemCount: users?.length,
                itemBuilder: (ctx, i) {
                  return ListTile(
                    onTap: () {
                      Get.toNamed('/chat');
                    },
                    title: Text("${users?[i]['name']}"),
                    subtitle: Text("${users?[i]['email']}"),
                    leading: CircleAvatar(
                      radius: 25,
                      foregroundImage: NetworkImage("${users?[i]['dp']}"),
                    ),
                    tileColor: Colors.transparent,
                  );
                });
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
