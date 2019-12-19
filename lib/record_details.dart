import 'package:flutter/material.dart';
import 'package:happiness_meter/database_helpers.dart';
// class MeterPage extends StatefulWidget {
//   @override
//   _MeterPageState createState() => _MeterPageState();
// }

class RecordDetails extends StatefulWidget {
  final recordId;
  RecordDetails(this.recordId);
  @override
  _RecordDetailsState createState() => _RecordDetailsState(recordId);
}

class _RecordDetailsState extends State<RecordDetails> {
  final recordId;
  _RecordDetailsState(this.recordId);
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
          return Center(
            child: Text(snapshot.data.situation),
          );
        },
      ),
    );
  }
}
