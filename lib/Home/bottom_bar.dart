import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:naptah/Home/homePage.dart';
import 'package:naptah/Scanning/resultScreen.dart';
import 'package:naptah/socialCommunity/Experts/premiumPage.dart';
import 'package:naptah/My_Plant/schedule.dart';
import 'package:naptah/socialCommunity/homePage.dart';

class BottomBar extends StatefulWidget {
  // const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _currentIndex = 0;
  List<Widget> tabs = [
    const HomePage(),
    const schedule(),
    const HomePageCommunity(),
    const premiumPage()
  ];

  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    return File(pickedFile!.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          File? image = await getImage();
          if (image != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => resultScreen(image: image)),
            );
          }
        },
        backgroundColor: Color(0xff184A2C),
        child: Image.asset(
          'assets/bottomIcon/camera_Icon.png',
          width: 40,
          height: 40,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        notchMargin: 8,
        elevation: 60.0,
        clipBehavior: Clip.antiAlias,
        shape: const CircularNotchedRectangle(),
        child: Container(
          height: 70.0,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.0),
              topRight: Radius.circular(25.0),
            ),
            color: Colors.white,
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            selectedItemColor: Color(0xff184A2C),
            unselectedItemColor: Color(0xff707070),
            iconSize: 40,
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              _currentIndex = index;
              setState(() {});
            },
            items: [
              const BottomNavigationBarItem(
                icon: ImageIcon(AssetImage("assets/home_Icon.png")),
                label: '',
              ),
              const BottomNavigationBarItem(
                icon: ImageIcon(AssetImage("assets/icons8-plant-100.png")),
                label: '',
              ),
              const BottomNavigationBarItem(
                icon: ImageIcon(AssetImage("assets/group-users.png")),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Stack(
                  children: const [
                    ImageIcon(AssetImage("assets/user (3).png")),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Icon(
                        Icons.star,
                        color: Color(0xffFFC107),
                        size: 26,
                      ),
                    ),
                  ],
                ),
                label: '',
              ),
            ],
          ),
        ),
      ),
      body: tabs[_currentIndex],
    );
  }
}
