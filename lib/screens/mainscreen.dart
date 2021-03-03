import 'package:PdfChest/screens/about.dart';
import 'package:PdfChest/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String appurl = "https://play.google.com/store/apps/details?id=com.deepstash";
  int index = 0;
  List<Widget> list = [
    HomeScreen(),
    AboutPage(),
  ];

  RateMyApp _rateMyApp = RateMyApp(
    preferencesPrefix: 'rateMyApp_',
    minDays: 0,
    minLaunches: 3,
    remindDays: 2,
    remindLaunches: 3,
  );

  @override
  void initState() {
    super.initState();
    _rateMyApp.init().then((_) {
      if (_rateMyApp.shouldOpenDialog) {
        _rateMyApp.showStarRateDialog(
          context,
          title: "Enjoying Pdf Chest !",
          message: "Please leave a rating :)",
          actionsBuilder: (context, stars) {
            return [
              FlatButton(
                child: Text("Ok"),
                onPressed: () async {
                  if (stars >= 3.0) {
                    _rateMyApp.save();
                    await _rateMyApp
                        .callEvent(RateMyAppEventType.rateButtonPressed);
                    Navigator.pop<RateMyAppDialogButton>(
                        context, RateMyAppDialogButton.rate);
                    _launchPlayStore();
                  } else {
                    Navigator.pop(context);
                  }
                },
              )
            ];
          },
          ignoreNativeDialog: true,
          dialogStyle: DialogStyle(
            titleAlign: TextAlign.center,
            messageAlign: TextAlign.center,
            messagePadding: EdgeInsets.only(bottom: 20.0),
          ),
          starRatingOptions: StarRatingOptions(),
        );
      }
    });
  }

  _launchPlayStore() async {
    if (await canLaunch(appurl)) {
      final bool launchSeccess = await launch(
        appurl,
        forceSafariVC: false,
        universalLinksOnly: true,
      );
      if (!launchSeccess) {
        await launch(appurl, forceSafariVC: true);
      }
    }
  }

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
                "Want to get pdfs for free ? I am enjoying the application Pdf Chest. You can also download and use it from here : $appurl",
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
        width: MediaQuery.of(context).size.width * 0.75,
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
                    "Want to get pdfs for free ? I am enjoying the application Pdf Chest. You can also download and use it from here : $appurl",
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
                onTap: () {
                  _launchPlayStore();
                },
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
