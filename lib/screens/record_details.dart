import 'package:flutter/material.dart';
import 'package:happiness_meter/data/database_helpers.dart';

import 'meter_page.dart';
// class MeterPage extends StatefulWidget {
//   @override
//   _MeterPageState createState() => _MeterPageState();
// }

class RecordDetailsPage extends StatefulWidget {
  final recordId;
  RecordDetailsPage(this.recordId);
  @override
  _RecordDetailsPageState createState() => _RecordDetailsPageState(recordId);
}

class _RecordDetailsPageState extends State<RecordDetailsPage> {
  final recordId;
  _RecordDetailsPageState(this.recordId);
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: FutureBuilder<HappinessRecord>(
        future: DatabaseHelper.instance.queryHappinessRecord(recordId),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: Text(
                "Error retrieving data!",
                style: TextStyle(fontSize: 22),
              ),
            );
            return MeterPage(snapshot.data);
          // return Center(
          //   child: Text(snapshot.data.situation),
          // );
        },
      ),
    );
  }
}
