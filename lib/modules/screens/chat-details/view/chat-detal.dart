import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talk_pro/constants/theme-controller.dart';

class ChatDetail extends StatelessWidget {
  const ChatDetail({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> arguments =
        ModalRoute.of(context)!.settings.arguments as List<String>;
    double h = MediaQuery.sizeOf(context).height;
    double w = MediaQuery.sizeOf(context).width;
    ThemeController controller =
        Get.put(ThemeController(), tag: 'themeController');
    return Scaffold(
      appBar: AppBar(
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
            flex: 5,
            child: Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 40,
                    foregroundImage: NetworkImage(arguments[1]),
                  ),
                  Text(
                    arguments[0],
                    style: const TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.person,
                              size: 30,
                            ),
                          ),
                          const Text('Profile'),
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.search,
                              size: 30,
                            ),
                          ),
                          const Text('Search'),
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.notifications_none,
                              size: 30,
                            ),
                          ),
                          const Text('Notification'),
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.more_horiz,
                              size: 30,
                            ),
                          ),
                          const Text('More'),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Obx(
                    () => ListTile(
                      title: const Text('Theme'),
                      subtitle: Text("${controller.themeModel.currentName}"),
                      leading: CircleAvatar(
                        foregroundImage: NetworkImage(
                            "${controller.themeModel.currentTheme}"),
                      ),
                    ),
                  ),
                  const ListTile(
                    title: Text('Privacy and safety'),
                    leading: Icon(Icons.lock_outline),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 10,
            child: Container(),
          ),
        ],
      ),
    );
  }
}
