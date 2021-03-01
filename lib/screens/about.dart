import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100.0),
              child: Image.asset(
                'images/profile.jpg',
                height: 100.0,
                width: 100.0,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              "Hola , I am Niloy Sikdar , currenty an undergrad student in CSE. I try to build creative and interactive mobile and web aplications. Pdf Chest is an application where you can search for a topic and you will get the list of available pdfs related to that topic. You can download them as well for free. Enjoy and don't forget to rate the app :)",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 30.0),
            Text(
              "Contact me at : niloysikdar30@gmail.com",
              style: TextStyle(
                color: Colors.red,
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
