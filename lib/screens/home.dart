import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final querycontroller = TextEditingController();
  int _itemcount = 0;
  int searchCode = 0;
  var jsonResponse;

  Future<void> getJsondata(String query) async {
    String url = "https://bookapi.pythonanywhere.com/api/" + query.trim();
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      _itemcount = jsonResponse.length;
      searchCode = 2;
      setState(() {});
    } else {
      print("error is happening");
      searchCode = 3;
      setState(() {});
    }
  }

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
            (searchCode == 0)
                ? Center(
                    child: Text("Search for something"),
                  )
                : (_itemcount != 0)
                    ? Container(
                        margin: EdgeInsets.only(top: 80.0),
                        child: ListView.builder(
                          itemCount: _itemcount,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: 20.0,
                                vertical: 13.0,
                              ),
                              padding: EdgeInsets.all(20.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey[350],
                                    blurRadius: 5.0,
                                    spreadRadius: 5.0,
                                    offset: Offset(
                                      3.0,
                                      5.0,
                                    ),
                                  )
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    jsonResponse[index]["title"],
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                  SizedBox(height: 15.0),
                                  Container(
                                    height: 40.0,
                                    width: 100.0,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Download",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      )
                    : (searchCode == 1)
                        ? Center(child: Text("Searching...."))
                        : Center(
                            child: Text("Something is wrong ..."),
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
                    GestureDetector(
                      onTap: () {
                        if (querycontroller.text.trim() != "") {
                          String query = querycontroller.text;
                          querycontroller.text = "";
                          setState(() {
                            _itemcount = 0;
                            searchCode = 1;
                          });
                          getJsondata(query).then(
                            (value) => {
                              print("Completed"),
                            },
                          );
                        }
                      },
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
