import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final querycontroller = TextEditingController();
  int _itemcount = 0;
  int searchCode = 0;
  var jsonResponse;
  String downpercen = "0";
  bool isDownloading = false;

  Future<void> getJsondata(String query) async {
    String url = "https://bookapi.pythonanywhere.com/api/" + query.trim();
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        jsonResponse = json.decode(response.body);
        _itemcount = jsonResponse.length;
        searchCode = 2;
        setState(() {});
      } else {
        searchCode = 3;
        setState(() {});
      }
    } catch (e) {
      searchCode = 3;
      setState(() {});
    }
  }

  downloadPdf(String url, BuildContext context) async {
    await Permission.storage.request();
    String pdfname = url.split("/").last.toString();
    var downloadDir = await ExtStorage.getExternalStoragePublicDirectory(
        ExtStorage.DIRECTORY_DOWNLOADS);
    String savePath = downloadDir + "/" + pdfname;
    Dio dio = Dio();
    try {
      setState(() {
        isDownloading = true;
      });
      await dio.download(url, savePath, onReceiveProgress: (received, total) {
        setState(() {
          downpercen = ((received / total) * 100).toStringAsFixed(0);
        });
      });
      setState(() {
        downpercen = "0";
        isDownloading = false;
      });
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text("Download finished"),
          content: Text("Check your Downloads folder"),
          actions: [
            FlatButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: Text(
                "Okay",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.0,
                ),
              ),
            ),
          ],
        ),
      );
    } catch (e) {
      setState(() {
        downpercen = "0";
        isDownloading = false;
      });
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text("Unable to download file !"),
          actions: [
            FlatButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: Text("Okay"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Stack(
          children: [
            (searchCode == 0)
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Search for something ...",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                          ),
                        ),
                        Text(
                          "And get pdfs ...",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                          ),
                        ),
                      ],
                    ),
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
                                  GestureDetector(
                                    onTap: () {
                                      downloadPdf(
                                        jsonResponse[index]["url"],
                                        context,
                                      );
                                    },
                                    child: Container(
                                      height: 40.0,
                                      width: 100.0,
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(15.0),
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
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      )
                    : (searchCode == 1)
                        ? Center(
                            child: Text(
                              "Searching....",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                              ),
                            ),
                          )
                        : Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(40.0),
                                  child: Text(
                                    "Something is wrong ...\nCheck your internet connection or try after sometime",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                ),
                              ],
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
                    GestureDetector(
                      onTap: () {
                        if (querycontroller.text.trim() != "") {
                          String query = querycontroller.text;
                          setState(() {
                            _itemcount = 0;
                            searchCode = 1;
                          });
                          getJsondata(query);
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
            isDownloading
                ? Center(
                    child: Container(
                      height: 180.0,
                      width: MediaQuery.of(context).size.width / 1.5,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[350],
                            blurRadius: 3.0,
                            spreadRadius: 3.0,
                            offset: Offset(
                              2.0,
                              3.0,
                            ),
                          )
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: 50.0,
                            width: 50.0,
                            child: CircularProgressIndicator(
                              valueColor:
                                  new AlwaysStoppedAnimation<Color>(Colors.red),
                            ),
                          ),
                          Text(
                            "Downloading.... " + downpercen.toString() + "%",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 17.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
