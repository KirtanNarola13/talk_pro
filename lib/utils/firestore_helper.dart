import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:talk_pro/utils/auth-helper.dart';

import '../modules/screens/chat-app/model/chat-model.dart';

class FireStoreHelper {
  //singleTurn
  FireStoreHelper._();
  static final FireStoreHelper fireStoreHelper = FireStoreHelper._();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  //AddUser

  Future<void> addUser() async {
    log("Execute");
    await firestore
        .collection("users")
        .doc(AuthHelper.auth.currentUser?.uid)
        .set({
      'name': (AuthHelper.auth.currentUser?.displayName == null)
          ? "${AuthHelper.auth.currentUser?.email?.split("@")[0].capitalizeFirst}"
          : "${AuthHelper.auth.currentUser?.displayName}",
      'email': "${AuthHelper.auth.currentUser?.email}",
      'uid': "${AuthHelper.auth.currentUser?.uid}",
      'dp': (AuthHelper.auth.currentUser?.photoURL == null)
          ? "https://e7.pngegg.com/pngimages/799/987/png-clipart-computer-icons-avatar-icon-design-avatar-heroes-computer-wallpaper-thumbnail.png"
          : AuthHelper.auth.currentUser?.photoURL,
    });
    log("User Added");
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getPost() {
    return firestore.collection('posts').snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchUser() {
    return firestore
        .collection('users')
        .where('uid', isNotEqualTo: AuthHelper.auth.currentUser?.uid)
        .snapshots();
  }

  Future<void> sendMessage({required Chat chatdetails}) async {
    //todo:my current user
    String u1 = chatdetails.sender;
    String u2 = chatdetails.receiver;
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await firestore.collection('chats').get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> fetchedChatID =
        querySnapshot.docs;
    bool isChatRoomAvailable = false;
    String fetchedUser1 = '';
    String fetchedUser2 = '';
    for (QueryDocumentSnapshot element in fetchedChatID) {
      String user1 = element.id.split('_')[0];
      String user2 = element.id.split('_')[1];
      if ((user1 == u1 || user1 == u2) && (user2 == u1 || user2 == u2)) {
        isChatRoomAvailable = true;
        fetchedUser1 = element.id.split('_')[0];
        fetchedUser2 = element.id.split('_')[1];
      }
    }
    if (isChatRoomAvailable == true) {
      log("CHAT ROOM IS AVAILABLE");
      await firestore
          .collection("chats")
          .doc("${fetchedUser1}_${fetchedUser2}")
          .collection("messages")
          .add({
        "sentby": chatdetails.sender,
        "receivedby": chatdetails.receiver,
        "message": chatdetails.message,
        "timestamp": FieldValue.serverTimestamp(),
      });
    } else {
      log("CHAT ROOM IS NOT AVAILABLE");
      await firestore
          .collection("chats")
          .doc("${chatdetails.receiver}_${chatdetails.sender}")
          .set({
        "sender": chatdetails.sender,
        "receiver": chatdetails.receiver,
      });

      await firestore
          .collection("chats")
          .doc("${chatdetails.receiver}_${chatdetails.sender}")
          .collection("messages")
          .add({
        "sentby": chatdetails.sender,
        "receivedby": chatdetails.receiver,
        "message": chatdetails.message,
        "timestamp": FieldValue.serverTimestamp(),
      });
    }
  }

  Future<Stream<QuerySnapshot<Map<String, dynamic>>>> fetchMessage(
      {required Chat chatdetails}) async {
    //todo:my current user
    String u1 = chatdetails.sender;
    String u2 = chatdetails.receiver;
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await firestore.collection('chats').get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> fetchedChatID =
        querySnapshot.docs;
    bool isChatRoomAvailable = false;
    String fetchedUser1 = '';
    String fetchedUser2 = '';
    for (QueryDocumentSnapshot element in fetchedChatID) {
      String user1 = element.id.split('_')[0];
      String user2 = element.id.split('_')[1];
      if ((user1 == u1 || user1 == u2) && (user2 == u1 || user2 == u2)) {
        isChatRoomAvailable = true;
        fetchedUser1 = element.id.split('_')[0];
        fetchedUser2 = element.id.split('_')[1];
      }
    }
    if (isChatRoomAvailable == true) {
      log("CHAT ROOM IS AVAILABLE");
      return firestore
          .collection("chats")
          .doc("${fetchedUser1}_${fetchedUser2}")
          .collection("messages")
          .orderBy('timestamp', descending: true)
          .snapshots();
    } else {
      log("CHAT ROOM IS NOT AVAILABLE");
      await firestore
          .collection("chats")
          .doc("${chatdetails.receiver}_${chatdetails.sender}")
          .set({
        "sender": chatdetails.sender,
        "receiver": chatdetails.receiver,
      });

      return firestore
          .collection("chats")
          .doc("${chatdetails.receiver}_${chatdetails.sender}")
          .collection("messages")
          .orderBy('timestamp', descending: true)
          .snapshots();
    }
  }
}
