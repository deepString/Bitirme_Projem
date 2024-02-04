import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io' show Platform;

import '../engine/storage.dart';
import '../widgets/drawerItem.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

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

    var size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 30, 30, 30),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          toolbarHeight: 70,
          iconTheme: IconThemeData(
            color: Color.fromARGB(255, 234, 234, 234),
          ),
          actions: [
            InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: SvgPicture.asset(
                  "assets/icons/podcasts.svg",
                  height: 21,
                  colorFilter: ColorFilter.mode(
                      Color.fromARGB(255, 234, 234, 234), BlendMode.srcIn),
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: SvgPicture.asset(
                  "assets/icons/notification.svg",
                  height: 21,
                  colorFilter: ColorFilter.mode(
                      Color.fromARGB(255, 234, 234, 234), BlendMode.srcIn),
                ),
              ),
            ),
            SizedBox(width: 10,),
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
            Expanded(
              child: Container(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            YourStoryItem("assets/images/profil1.jpg", "${userInfo["Name"]}"),
                            StoryItem("assets/images/profile3.jpg", "Profil 1"),
                            StoryItem("assets/images/profile4.jpg", "Profil 2"),
                            StoryItem("assets/images/profile2.jpg", "Profil 3"),
                            StoryItem("assets/images/profile6.jpg", "Profil 4"),
                            StoryItem("assets/images/profile5.webp", "Profil 5"),
                            StoryItem("assets/images/profile3.jpg", "Profil 6"),
                            StoryItem("assets/images/profile4.jpg", "Profil 7"),
                            StoryItem("assets/images/profile2.jpg", "Profil 8"),
                            StoryItem("assets/images/profile5.webp", "Profil 9"),
                          ],
                        ),
                      ),
                      SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        child: Text(
                          "Hoşgeldin ${userInfo["Name"]}",
                          style: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 240, 240, 240),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: Container(
                              width: size.width / 2 - 25,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 50, 50, 50),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 60,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          bottomLeft: Radius.circular(10)),
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Color.fromARGB(255, 97, 60, 233),
                                          Color.fromARGB(255, 173, 205, 205),
                                        ],
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.favorite,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: Text(
                                      "Beğenilen Şarkilar Playlistiiiii",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: true,
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 225, 225, 225),
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: Container(
                              width: size.width / 2 - 25,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 50, 50, 50),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 60,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          bottomLeft: Radius.circular(10)),
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "assets/images/chrismasImage.jpg"),
                                          fit: BoxFit.fill),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: Text(
                                      "Yilbaşi",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: true,
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 225, 225, 225),
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: Container(
                              width: size.width / 2 - 25,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 50, 50, 50),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 60,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          bottomLeft: Radius.circular(10)),
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "assets/images/playlistImage4.jpg"),
                                          fit: BoxFit.fill),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: Text(
                                      "Yabanci",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: true,
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 225, 225, 225),
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: Container(
                              width: size.width / 2 - 25,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 50, 50, 50),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 60,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          bottomLeft: Radius.circular(10)),
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "assets/images/playlistImage2.jpg"),
                                          fit: BoxFit.fill),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: Text(
                                      "Türkçe",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: true,
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 225, 225, 225),
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: Container(
                              width: size.width / 2 - 25,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 50, 50, 50),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 60,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          bottomLeft: Radius.circular(10)),
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "assets/images/playlistImage5.jpg"),
                                          fit: BoxFit.fill),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: Text(
                                      "Modun Kötüyse",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: true,
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 225, 225, 225),
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: Container(
                              width: size.width / 2 - 25,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 50, 50, 50),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 60,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          bottomLeft: Radius.circular(10)),
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "assets/images/playlistImage6.webp"),
                                          fit: BoxFit.fill),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: Text(
                                      "Slow",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: true,
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 225, 225, 225),
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20,),
                      SoloTitleItem("Yeniden dinleyin"),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            SizedBox(width: 2,),
                            ListenAgainFrame("assets/images/musicIgnite.jpg", "Ignite (feat. Alan Walker, Julie Bergan ve SEUNGRI)"),
                            ListenAgainPlaylistFrame("assets/images/playlistImage2.jpg", "Türkçe"),
                            ListenAgainFrame("assets/images/musicImgood.jpg", "I'm good (Blue) - David Guetta & Bebe Rexha"),
                            ListenAgainFrame("assets/images/musicImparator.jpg", "IMPARATOR - Sefo"),
                            ListenAgainFrame("assets/images/musicKor.jpg", "Kor - Emir Can İğrek"),
                            ListenAgainFrame("assets/images/musicSeninugruna.jpg", "SENIN UGRUNA - UZI"),
                            ListenAgainPlaylistFrame("assets/images/playlistImage6.webp", "Slow"),
                          ],
                        ),
                      ),
                      TitleItem("Sizin için derlenenler", "Diğer"),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            SizedBox(width: 2,),
                            PlaylistFrame("assets/images/playlistImage7.jpg", "Supermix'im", "David Guetta, INNA ve J Balvin"),
                            PlaylistFrame("assets/images/playlistImage8.jpg", "Karişik Listem 1", "Sean Paul, Pitbull ve Marron 5"),
                            PlaylistFrame("assets/images/playlistImage9.jpg", "Karişik Listem 2", "Sefo, UZI, Çakal, ate ve Lvbel C5"),
                            PlaylistFrame("assets/images/playlistImage7.jpg", "Supermix'im", "David Guetta, INNA ve J Balvin"),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          "BİR ŞARKIDAN RADYO BAŞLATIN",
                          style: TextStyle(
                            color: Color.fromARGB(255, 150, 150, 150),
                            fontSize: 11,
                          ),
                        ),
                      ),
                      TitleItem("Hizli seçimler", "Tümünü oynat"),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Column(
                              children: [
                                QuickPicksMusic(size, "assets/images/musicKor.jpg", "Kor", "Emir Can İğrek"),
                                QuickPicksMusic(size, "assets/images/musicIgnite.jpg", "Ignite", "K-391 & Alan Walker"),
                                QuickPicksMusic(size, "assets/images/musicImgood.jpg", "I'm Good (blue)", "David Guetta & Bebe Rexha"),
                                QuickPicksMusic(size, "assets/images/musicImparator.jpg", "IMPARATOR", "Sefo"),
                              ],
                            ),
                            Column(
                              children: [
                                QuickPicksMusic(size, "assets/images/musicSeninugruna.jpg", "SENIN UGRUNA", "UZI"),
                                QuickPicksMusic(size, "assets/images/musicImparator.jpg", "IMPARATOR", "Sefo"),
                                QuickPicksMusic(size, "assets/images/musicKor.jpg", "Kor", "Emir Can İğrek"),
                                QuickPicksMusic(size, "assets/images/musicIgnite.jpg", "Ignite", "K-391 & Alan Walker"),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SoloTitleItem("Topluluktan"),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            PlaylistFrame("assets/images/playlistImage10.png", "Arabada Yabanci", "Profil x • 2,7 B görüntülenme"),
                            PlaylistFrame("assets/images/playlistImage12.jpg", "Sakin Türkçe", "Profil xx • 268 B görüntülenme"),
                            PlaylistFrame("assets/images/playlistImage11.jpg", "Yabanci Hit", "Profil 8 • 2,8 B görüntülenme"),
                            PlaylistFrame("assets/images/playlistImage2.jpg", "Karişik", "Profil 11 • 1,6 B görüntülenme"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 40, 40, 40),
                border: Border(
                  bottom: BorderSide(
                    color: Color.fromARGB(255, 70, 70, 70),
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(width: 10,),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 3),
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/musicImgood.jpg"),
                              fit: BoxFit.fill,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "I'm Good (blue)",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                            ),
                          ),
                          Text(
                            "David Guetta & Bebe Rexha",
                            style: TextStyle(
                              color: Color.fromARGB(255, 150, 150, 150),
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Icon(Icons.cast, color: Colors.white),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Icon(Icons.play_circle, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            BottomMenu(),
          ],
        ),
      ),
    );
  }

  Widget QuickPicksMusic(Size size, String photo, String title, String artist) {
    return Container(
      margin: EdgeInsets.only(left: 15),
      width: size.width - 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 3),
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(photo),
                    fit: BoxFit.fill,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    artist,
                    style: TextStyle(
                      color: Color.fromARGB(255, 150, 150, 150),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Icon(Icons.more_vert, color: Colors.white),
        ],
      ),
    );
  }

  Widget ListenAgainFrame(String photo, String musicName) {
    return Container(
      margin: const EdgeInsets.only(left: 10),
      width: 100,
      height: 145,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 3),
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(photo),
                fit: BoxFit.fill,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          SizedBox(
            height: 2,
          ),
          Expanded(
            child: Text(
              musicName,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget ListenAgainPlaylistFrame(String photo, String playlistName) {
    return Container(
      margin: const EdgeInsets.only(left: 10),
      width: 100,
      height: 145,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 3),
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(photo),
                fit: BoxFit.fill,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          SizedBox(
            height: 2,
          ),
          Expanded(
            child: Text(
              playlistName,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget PlaylistFrame(String photo, String playlistName, String artists) {
    return Container(
      margin: const EdgeInsets.only(left: 10),
      width: 130,
      height: 210,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 3),
            height: 130,
            width: 130,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(photo),
                fit: BoxFit.fill,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          SizedBox(
            height: 2,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  playlistName,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Text(
              artists,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
              style: TextStyle(
                color: Color.fromARGB(255, 150, 150, 150),
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget SoloTitleItem(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          color: Color.fromARGB(255, 240, 240, 240),
        ),
      ),
    );
  }

  Widget TitleItem(String title, String link) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              color: Color.fromARGB(255, 240, 240, 240),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              border: Border.all(
                color: Color.fromARGB(70, 240, 240, 240),
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              child: Text(
                link,
                style: TextStyle(
                  fontSize: 12,
                  color: Color.fromARGB(255, 240, 240, 240),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget StoryItem(String photo, String name) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 10),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromARGB(255, 240, 135, 64),
            ),
            child: Container(
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 30, 30, 30),
                shape: BoxShape.circle,
              ),
              child: CircleAvatar(
                backgroundImage: AssetImage(photo),
                backgroundColor: Colors.white,
                radius: 25,
              ),
            ),
          ),
          SizedBox(
            height: 6,
          ),
          Container(
            width: 60,
            child: Text(
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color.fromARGB(255, 225, 225, 225),
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget YourStoryItem(String photo, String name) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 10),
      child: Column(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(photo),
            backgroundColor: Colors.white,
            radius: 28,
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: 60,
            child: Text(
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color.fromARGB(255, 225, 225, 225),
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget BottomMenu() {
    return Container(
      color: Color.fromARGB(255, 40, 40, 40),
      width: double.infinity,
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: () {}, // Zaten ana sayfada olduğumuzdan Navigator eklemedim
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
            onTap: () => Navigator.pushNamed(context, '/profile'),
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
            color: Color.fromARGB(255, 234, 234, 234),
          ),
          SizedBox(height: 2),
          Text(
            iconName,
            style: TextStyle(
              fontSize: 10,
              color: Color.fromARGB(255, 234, 234, 234),
            ),
          ),
        ],
      ),
    );
  }
}
