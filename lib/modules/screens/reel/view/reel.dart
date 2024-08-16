import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:talk_pro/utils/firestore_helper.dart';
import 'package:video_player/video_player.dart';

class Reel extends StatefulWidget {
  const Reel({super.key});

  @override
  State<Reel> createState() => _ReelState();
}

class _ReelState extends State<Reel> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.networkUrl(Uri.parse(
        'https://firebasestorage.googleapis.com/v0/b/talk-pro-d9726.appspot.com/o/video%2F33.mp4?alt=media&token=0ddcfa39-bf95-49d0-88a3-cca124e0565b'))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  playVideo(String url) {
    _controller = VideoPlayerController.networkUrl(Uri.parse(url))
      ..initialize().then((_) {
        _controller.play();
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
        title: const Text(
          "Reel",
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert,
            ),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FireStoreHelper.fireStoreHelper.fetchReel(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return CircularProgressIndicator();
          } else if (snapshot.hasData) {
            List<QueryDocumentSnapshot<Map<String, dynamic>>>? data =
                snapshot.data?.docs;
            return _controller.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: playVideo(data![0]['url']),
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  );
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
