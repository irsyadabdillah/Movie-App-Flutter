import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app_flutter/style/colors.dart';
import 'package:movie_app_flutter/widgets/setting_item.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: white,
        centerTitle: true,
        title: const Text(
          "Setting",
          style: TextStyle(color: black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const SizedBox(
                    height: 40.0,
                  ),
                  CachedNetworkImage(
                    imageUrl:
                        "https://avatars.githubusercontent.com/u/78635608?s=96&v=4",
                    imageBuilder: (context, imageProvider) => CircleAvatar(
                        backgroundImage: imageProvider, radius: 40),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Text(
                    "Irsyad Abdillah",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                  const Text("+62812 5477 8169")
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            SettingItem(
                icon: Icons.account_circle_outlined,
                title: "Account And Security",
                onTap: () {}),
            SettingItem(
                icon: Icons.history_rounded, title: "History", onTap: () {}),
            SettingItem(
                icon: Icons.favorite_border_outlined,
                title: "Favorit",
                onTap: () {}),
            SettingItem(
                icon: Icons.language_outlined, title: "Language", onTap: () {}),
            SettingItem(
                icon: Icons.privacy_tip_outlined,
                title: "Privacy",
                onTap: () {}),
            SettingItem(icon: Icons.info_outline, title: "About", onTap: () {}),
            SettingItem(
                icon: Icons.logout_outlined,
                title: "Logout",
                onTap: () {
                  showConfirmLogout();
                }),
          ],
        ),
      ),
    );
  }

  showConfirmLogout() {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        message: const Text("Would you like to log out?"),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {},
            child: const Text(
              "Log Out",
              style: TextStyle(color: actionColor),
            ),
          )
        ],
        cancelButton: CupertinoActionSheetAction(
          child: const Text("Cancel"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }
}
