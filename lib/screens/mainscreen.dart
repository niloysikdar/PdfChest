import 'package:PdfChest/screens/about.dart';
import 'package:PdfChest/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int index = 0;
  List<Widget> list = [
    HomeScreen(),
    AboutPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        toolbarHeight: 60.0,
        title: Text(
          "Pdf Chest",
          style: TextStyle(fontSize: 23.0),
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () {
              Share.share(
                "Want to get pdfs for free ? I am enjoying the application Pdf Chest. You can also download and use it from here : https://pub.dev/packages/share",
                subject: "Download the application here",
              );
            },
            child: Container(
              color: Colors.red,
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Icon(
                Icons.share,
                size: 30.0,
              ),
            ),
          ),
        ],
      ),
      body: list[index],
      drawer: SizedBox(
        width: MediaQuery.of(context).size.width * 0.7,
        child: Drawer(
          child: Column(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: Colors.red),
                child: Container(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ClipRRect(
                        child: Image.asset(
                          'images/icon.png',
                          height: 80.0,
                        ),
                      ),
                      Text(
                        "Pdf Chest",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 23.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.home,
                  size: 30.0,
                ),
                title: Text(
                  "Home",
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                onTap: () {
                  setState(() {
                    index = 0;
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.info,
                  size: 30.0,
                ),
                title: Text(
                  "About",
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                onTap: () {
                  setState(() {
                    index = 1;
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                onTap: () {
                  Share.share(
                    "Want to get pdfs for free ? I am enjoying the application Pdf Chest. You can also download and use it from here : https://pub.dev/packages/share",
                    subject: "Download the application here",
                  );
                },
                leading: Icon(
                  Icons.share,
                  size: 30.0,
                ),
                title: Text(
                  "Share",
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.star_rate,
                  size: 30.0,
                ),
                title: Text(
                  "Rate the app",
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
