import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController querycontroller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PdfChest"),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: 80.0),
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 10.0,
                    ),
                    padding: EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: Colors.red,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "hello sdjhdsjhfdjklfv fd jhbfd blfdibdifjbdf fddfnifdnfdj",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Container(
                          height: 40.0,
                          width: 100.0,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Container(
              alignment: Alignment.topCenter,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: TextField(
                          controller: querycontroller,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter a topic",
                            hintStyle: TextStyle(
                              color: Colors.white.withOpacity(0.6),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: Container(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Icon(
                          Icons.search_outlined,
                          size: 36.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
