import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io' show Platform;

import '../engine/storage.dart';
import '../widgets/drawerItem.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  bool switchChange = false;

  Map<String, dynamic> userInfo = {
    "Id": "",
    "Name": "",
    "Email": "",
  };

  checkLogin() async {
    Storage storage = Storage();

    final user = await storage.loadUser();

    if (user == null) {
      Navigator.pushReplacementNamed(context, "/login");
    }
    else {
      setState(() {
        userInfo = user;
      });
    }
  }

  logoutMaterial() async {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(
              Icons.warning,
              size: 30,
              color: Colors.red.shade300,
            ),
            SizedBox(
              width: 6,
            ),
            Text(
              "Çikişi Onayla",
              style: TextStyle(
                color: Colors.black87,
                fontSize: 25,
              ),
            ),
          ],
        ),
        content: Text(
          "Çikiş yapmak istediğine emin misin?",
          style: TextStyle(
            color: Colors.black54,
            fontSize: 16,
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () async {
              Storage storage = Storage();
              await storage.clearUser();
              Navigator.pushNamedAndRemoveUntil(
                  context, "/welcome", (route) => false);
            },
            child: Text(
              "Onayla",
              style: TextStyle(
                color: Colors.black87,
                fontSize: 15,
              ),
            ),
          ),
          ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                "İptal",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 15,
                ),
              )),
        ],
      ),
    );
  }

  logoutIOS() async {
    showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => CupertinoAlertDialog(
        title: Row(
          children: [
            Icon(
              Icons.warning,
              size: 30,
              color: Colors.red.shade300,
            ),
            SizedBox(
              width: 6,
            ),
            Text(
              "Çikişi Onayla",
              style: TextStyle(
                color: Colors.black87,
                fontSize: 20,
              ),
            ),
          ],
        ),
        content: Text(
          "Çikiş yapmak istediğine emin misin?",
          style: TextStyle(
            color: Colors.black54,
            fontSize: 16,
          ),
        ),
        actions: [
          CupertinoDialogAction(
            onPressed: () async {
              Storage storage = Storage();
              await storage.clearUser();
              Navigator.pushNamedAndRemoveUntil(
                  context, "/welcome", (route) => false);
            },
            child: Text(
              "Onayla",
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            isDestructiveAction: true,
          ),
          CupertinoDialogAction(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              "İptal",
              style: TextStyle(
                color: Colors.black87,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: switchChange
            ? Color.fromARGB(255, 40, 32, 25)
            : Color.fromARGB(255, 251, 251, 251),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(
              color: switchChange
                  ? Color.fromARGB(255, 185, 185, 185)
                  : Colors.black87),
          title: Text(
            "@berkayt",
            style: TextStyle(
                color: switchChange
                    ? Color.fromARGB(255, 225, 224, 223)
                    : Colors.black87),
          ),
          actions: [
            Container(
              height: 20,
              child: Transform.scale(
                scale: 0.8,
                child: Switch(
                  value: switchChange,
                  onChanged: (value) {
                    setState(() {
                      switchChange = value;
                    });
                  },
                  activeThumbImage: AssetImage("assets/images/nightMode.png"),
                  inactiveThumbImage: AssetImage("assets/images/lightMode.png"),
                  activeTrackColor: Colors.white,
                  trackOutlineColor: MaterialStatePropertyAll(switchChange
                      ? Color.fromARGB(255, 185, 185, 185)
                      : Colors.grey),
                  thumbColor: MaterialStatePropertyAll(Colors.white),
                ),
              ),
            ),
          ],
        ),
        drawer: Drawer(
          backgroundColor: Color.fromARGB(255, 251, 251, 251),
          surfaceTintColor: Color.fromARGB(255, 251, 251, 251),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    right: 6, left: 6, top: 50, bottom: 30),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(255, 132, 132, 132),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: CircleAvatar(
                          backgroundImage:
                              AssetImage("assets/images/profil1.jpg"),
                          radius: 40,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "${userInfo["Name"]}",
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Divider(
                      color: Color.fromARGB(136, 155, 155, 155),
                    ),
                    DrawerItem(
                      name: "Oynatma Listeleri",
                      icon: Icon(Icons.library_music, size: 22),
                      onTapRoute: () {
                        Navigator.pushNamed(context, '/library');
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 15),
                      child: Row(
                        children: [
                          Icon(Icons.message, size: 22),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Bize Ulaşin",
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              final Uri uri = Uri.parse("https://github.com/deepString");
                              launchUrl(uri);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: SvgPicture.asset(
                                "assets/icons/github.svg",
                                height: 30,
                              ),
                            ),
                          ),
                          SizedBox(width: 5,),
                          InkWell(
                            onTap: () {
                              final Uri uri = Uri.parse("tel:+901234567899");
                              launchUrl(uri);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Icon(Icons.phone),
                            ),
                          ),
                        ],
                      ),
                    ),
                    DrawerItem(
                      name: "Ayarlar",
                      icon: Icon(Icons.settings, size: 22),
                      onTapRoute: () {
                        Navigator.pushNamed(context, "/setting");
                      },
                    ),
                    Divider(
                      color: Color.fromARGB(136, 155, 155, 155),
                    ),
                    DrawerItem(
                      name: "Oturumu kapat",
                      icon: Icon(Icons.logout_outlined, size: 22),
                      onTapRoute: () {
                        if (kIsWeb) {
                          logoutMaterial();
                        } 
                        else {
                          if (Platform.isIOS || Platform.isMacOS) {
                            logoutIOS();
                          } 
                          else {
                            logoutMaterial();
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
              Text(
                "Version 1.0.0",
                style: TextStyle(color: Colors.grey, fontSize: 11),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Upside(),
            Expanded(
              child: Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              width: 150,
                              height: 40,
                              decoration: BoxDecoration(
                                color: switchChange
                                    ? Color.fromARGB(255, 240, 135, 64)
                                    : Colors.black87,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 12,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "FOLLOW",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              width: 150,
                              height: 40,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color.fromARGB(221, 212, 212, 212),
                                ),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "MESSAGE",
                                    style: TextStyle(
                                      color: switchChange
                                          ? Colors.white
                                          : Colors.black87,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 45,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.only(bottom: 2),
                            decoration: BoxDecoration(
                                border: Border(
                              bottom: BorderSide(
                                  color: Colors.transparent, width: 3),
                            )),
                            child: Text(
                              "Portföy",
                              style: TextStyle(
                                color: Color.fromARGB(255, 176, 176, 176),
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.only(bottom: 2),
                            decoration: BoxDecoration(
                                border: Border(
                              bottom: BorderSide(
                                  color: switchChange
                                      ? Color.fromARGB(255, 240, 135, 64)
                                      : Colors.black87,
                                  width: 3),
                            )),
                            child: Text(
                              "Playlist",
                              style: TextStyle(
                                color: switchChange
                                    ? Color.fromARGB(255, 225, 224, 223)
                                    : Colors.black87,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          playlistItem("assets/images/playlistImage1.jpg",
                              "Karişik", "16 Şarki", () {}),
                          playlistItem("assets/images/playlistImage3.jpg",
                              "Rock", "13 Şarki", () {}),
                          playlistItem("assets/images/playlistImage4.jpg",
                              "Jazz", "9 Şarki", () {}),
                          playlistItem("assets/images/playlistImage2.jpg",
                              "Türkçe", "17 Şarki", () {}),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Divider(
                            color: switchChange
                                ? Color.fromARGB(41, 255, 255, 255)
                                : Colors.grey.shade300,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.favorite_border,
                                  color: switchChange
                                      ? Color.fromARGB(255, 240, 135, 64)
                                      : Colors.black87,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "120",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: switchChange
                                        ? Color.fromARGB(255, 225, 224, 223)
                                        : Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.chat_bubble_outline,
                                  color: switchChange
                                      ? Color.fromARGB(255, 240, 135, 64)
                                      : Colors.black87,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Yorum",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: switchChange
                                        ? Color.fromARGB(255, 225, 224, 223)
                                        : Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.share,
                                  color: switchChange
                                      ? Color.fromARGB(255, 240, 135, 64)
                                      : Colors.black87,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Paylaş",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: switchChange
                                        ? Color.fromARGB(255, 225, 224, 223)
                                        : Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            BottomMenu(),
          ],
        ),
      ),
    );
  }

  Widget playlistItem(
      String photo, String title, String count, final Function()? onTap) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: 150,
          height: 200,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 3),
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(photo),
                    fit: BoxFit.fill,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Expanded(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  style: TextStyle(
                    color: switchChange
                        ? Color.fromARGB(255, 225, 224, 223)
                        : Colors.black87,
                    fontSize: 16,
                  ),
                ),
              ),
              Text(
                count,
                style: TextStyle(
                  color: Color.fromARGB(255, 176, 176, 176),
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget BottomMenu() {
    return Container(
      color: switchChange ? Color.fromARGB(255, 35, 28, 21) : Colors.white,
      width: double.infinity,
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: () => Navigator.pushNamed(context, '/home'),
            child: BottomMenuItems(
                "Ana Sayfa", Icons.home_outlined, Icons.home, true),
          ),
          InkWell(
            onTap: () => Navigator.pushNamed(context, '/search'),
            child: BottomMenuItems(
                "Ara", Icons.search_outlined, Icons.saved_search, false),
          ),
          InkWell(
            onTap: () => Navigator.pushNamed(context, '/library'),
            child: BottomMenuItems("Kitapliğin", Icons.library_music_outlined,
                Icons.library_music, false),
          ),
          InkWell(
            onTap: () {
              //Navigator.pushNamed(context, '/profile'); // Zaten profil sayfasında olduğumuzdan burası kapalı
            },
            child: BottomMenuItems(
                "Profil", Icons.person_outline, Icons.person, false),
          ),
        ],
      ),
    );
  }

  Widget BottomMenuItems(String iconName, IconData iconActive,
      IconData iconDeactive, bool active) {
    IconData changeIcon = active ? iconDeactive : iconActive;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            changeIcon,
            size: 26,
            color: switchChange
                ? Color.fromARGB(255, 225, 224, 223)
                : Colors.black87,
          ),
          SizedBox(height: 2),
          Text(
            iconName,
            style: TextStyle(
              fontSize: 10,
              color: switchChange
                  ? Color.fromARGB(255, 225, 224, 223)
                  : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget Upside() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              InkWell(
                onTap: () {},
                child: profileSection("153K", "Takipçi"),
              ),
              SizedBox(
                height: 12,
              ),
              InkWell(
                onTap: () {},
                child: profileSection("100K", "Takip"),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(1.5),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      stops: [0.0, 0.3, 0.0, 0.0, 1],
                      colors: switchChange
                          ? [
                              Color.fromARGB(255, 40, 32, 25),
                              Color.fromARGB(255, 40, 32, 25),
                              Color.fromARGB(255, 202, 111, 47),
                              Color.fromARGB(255, 202, 111, 47),
                              Color.fromARGB(255, 202, 111, 47),
                            ]
                          : [
                              Color.fromARGB(255, 251, 251, 251),
                              Color.fromARGB(255, 251, 251, 251),
                              Color.fromARGB(255, 132, 132, 132),
                              Color.fromARGB(255, 132, 132, 132),
                              Color.fromARGB(255, 132, 132, 132),
                            ],
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Container(
                    padding: EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      color: switchChange
                          ? Color.fromARGB(255, 40, 32, 25)
                          : Color.fromARGB(255, 251, 251, 251),
                      shape: BoxShape.circle,
                    ),
                    child: CircleAvatar(
                      backgroundImage: AssetImage("assets/images/profil1.jpg"),
                      radius: 38,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: 250,
                  child: Text(
                    "Berkay T",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: switchChange
                          ? Color.fromARGB(255, 225, 224, 223)
                          : Colors.black87,
                      fontSize: 18,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 18,
                      color: Color.fromARGB(255, 185, 185, 185),
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Text(
                      "Los Angeles",
                      style: TextStyle(
                        color: Color.fromARGB(255, 185, 185, 185),
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          profileSection("4", "PLAYLİST"),
        ],
      ),
    );
  }

  Widget profileSection(String number, String name) {
    return Column(
      children: [
        Text(
          number,
          style: TextStyle(
            color: switchChange
                ? Color.fromARGB(255, 225, 224, 223)
                : Colors.black87,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          name,
          style: TextStyle(
            color: Color.fromARGB(255, 185, 185, 185),
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}
