import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  HistoryPage({Key key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: SafeArea(
          child: Container(
            height: double.infinity,
            width: double.infinity,
            padding: EdgeInsets.only(top: 30),
            color: Colors.pink[100],
            child: Row(
              children: [
                // IconButton(
                //   icon: Icon(Icons.arrow_back_ios),
                //   color: Colors.black,
                //   onPressed: () {
                //     Navigator.of(context).pop();
                //   },
                // ),
                SizedBox(
                  width: 30,
                ),
                Expanded(
                  child: Text(
                    "PAST ORDERS".toUpperCase(),
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.pink[100],
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    height: 100,
                    width: double.infinity,
                    child: Card(
                      elevation: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: double.infinity,
                              width: 250,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Yomie's Rice Sri Petaling",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                      "The Red Tropical,Haw purple Rice Yogurt"),
                                  Text("2020-10-10 22:55"),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "RM 72.29",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    height: 30,
                                    width: double.infinity,
                                    margin: EdgeInsets.only(right: 3),
                                    child: RaisedButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(0)),
                                      onPressed: () {},
                                      child: Text(
                                        "Details",
                                        style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
