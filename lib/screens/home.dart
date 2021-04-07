import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:whether_app/screens/daily_report.dart';

class HomePage extends StatelessWidget {
  final String url =
      "https://weatherapi-com.p.rapidapi.com/forecast.json?q=Sunyani&days=7";

  Future<Map<dynamic, dynamic>> getWhether() async {
    http.Response response = await http.get(Uri.parse(url), headers: {
      "x-rapidapi-key": "a8890b68a7msh7b34d53324cfd55p1422b6jsnfd27f4ef5760",
      "x-rapidapi-host": "weatherapi-com.p.rapidapi.com",
      "useQueryString": "true"
    });
    return jsonDecode(response.body);
  }

  Widget _currentReport(AsyncSnapshot snapshot) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                snapshot.data['current']['temp_c'].toString() + "\u00B0",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 60),
              ),
              Text(
                snapshot.data['current']['condition']['text'].toString(),
                style: TextStyle(
                    color: Colors.white54,
                    fontWeight: FontWeight.w800,
                    fontSize: 20),
              ),
              Text(
                snapshot.data['location']['name'].toString() +
                    ", " +
                    snapshot.data['location']['country'].toString(),
                style: TextStyle(
                    color: Colors.white54,
                    fontWeight: FontWeight.w800,
                    fontSize: 18),
              )
            ],
          ),
          Container(
              width: 150,
              height: 150,
              child: Image.network(
                "https:" + snapshot.data['current']['condition']['icon'],
                fit: BoxFit.cover,
              ))
          // Stack(
          //   children: [
          //     Icon(
          //       Icons.wb_sunny,
          //       color: Colors.yellow,
          //       size: 85,
          //     ),
          //     Positioned(
          //       bottom: -5,
          //       child: Icon(
          //         Icons.cloud,
          //         color: Colors.white,
          //         size: 50,
          //       ),
          //     )
          //   ],
          // )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // print("start" + snapshot);
    var media = MediaQuery.of(context).size;
    return FutureBuilder<Map<dynamic, dynamic>>(
        future: this.getWhether(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                Stack(
                  children: [
                    Positioned(
                      child: Container(
                        width: media.width,
                        height: media.height / 1.5,
                        color: Colors.blue,
                      ),
                    ),
                    Positioned.fill(
                      top: 0,
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Colors.black, Colors.transparent])),
                      ),
                    ),
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(top: 40),
                        child: Text(
                          "Today",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(top: 100, left: 10),
                        child: Text(
                          "Sunyani Weather Forecast App",
                          style: TextStyle(
                              fontSize: 28,
                              color: Colors.white,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                    ),
                    Positioned.fill(child: _currentReport(snapshot)),
                    SizedBox(
                      height: 20,
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 65),
                        width: media.width,
                        height: media.height * .15,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Ionicons.ios_water,
                                  color: Colors.blue,
                                ),
                                Text(snapshot.data['current']['humidity']
                                        .toString() +
                                    " %")
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Feather.wind,
                                  color: Colors.blue,
                                ),
                                Text(snapshot.data['current']['wind_kph']
                                        .toString() +
                                    " km/h")
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Ionicons.md_speedometer,
                                  color: Colors.blue,
                                ),
                                Text(snapshot.data['current']['pressure_mb']
                                    .toString())
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  MaterialIcons.visibility,
                                  color: Colors.blue,
                                ),
                                Text(snapshot.data['current']['vis_km']
                                        .toString() +
                                    " km")
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Transform.translate(
                    offset: Offset(0, -10),
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          )),
                      child: DailyReport(snapshot),
                    ),
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            print("Error received ...........");
          } else {
            Container(
              child: Center(child: Text("Loading...................")),
            );
          }
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
