import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DailyReport extends StatelessWidget {
  DailyReport(this.snapshot);
  final snapshot;
  @override
  Widget build(BuildContext context) {
    print(DateTime.now());
    return ListView(
      children: [
        ListTile(
          leading: Image.network(
            "https:" + snapshot.data['current']['condition']['icon'],
            fit: BoxFit.cover,
          ),
          title: Center(
            child: Text(DateFormat('EEEE').format(DateTime.now()),
                style: TextStyle()),
          ),
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(snapshot.data['current']['temp_c'].toString() + "\u00B0 C",
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20)),
              Text(snapshot.data['current']['condition']['text'].toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.w800, color: Colors.black54))
            ],
          ),
        ),
        Divider(),
        ListTile(
          leading: Image.network(
            "https:" +
                snapshot.data['forecast']['forecastday'][1]['day']['condition']
                    ['icon'],
            fit: BoxFit.cover,
          ),
          title: Center(
            child: Text(
                DateFormat('EEEE').format(DateTime.parse(
                    snapshot.data['forecast']['forecastday'][1]['date'])),
                style: TextStyle()),
          ),
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  snapshot.data['forecast']['forecastday'][1]['day']
                              ['maxtemp_c']
                          .toString() +
                      "\u00B0 C",
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20)),
              Text(
                  snapshot.data['forecast']['forecastday'][1]['day']
                          ['condition']['text']
                      .toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.w800, color: Colors.black54))
            ],
          ),
        ),
        Divider(),
        ListTile(
          leading: Image.network(
            "https:" +
                snapshot.data['forecast']['forecastday'][2]['day']['condition']
                    ['icon'],
            fit: BoxFit.cover,
          ),
          title: Center(
            child: Text(
                DateFormat('EEEE').format(DateTime.parse(snapshot
                    .data['forecast']['forecastday'][2]['date']
                    .toString())),
                style: TextStyle()),
          ),
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  snapshot.data['forecast']['forecastday'][2]['day']
                              ['maxtemp_c']
                          .toString() +
                      "\u00B0 C",
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20)),
              Text(
                  snapshot.data['forecast']['forecastday'][2]['day']
                          ['condition']['text']
                      .toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.w800, color: Colors.black54)),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ],
    );
  }
}
