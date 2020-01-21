import 'package:flutter/material.dart';
import 'package:happiness_meter/components/happiness_slider.dart';
import 'package:happiness_meter/components/record_cylinder.dart';
import 'package:happiness_meter/data/database_helpers.dart';
import 'package:happiness_meter/global_translations.dart';
import 'package:happiness_meter/theme/app_colors.dart';
import 'package:happiness_meter/utils/date_utils.dart';
import 'package:happiness_meter/utils/record_drawing.dart';
import 'package:screenshot_share_image/screenshot_share_image.dart';

import 'meter_page.dart';

class RecordDetailsPage extends StatefulWidget {
  final HappinessRecord record;
  RecordDetailsPage(this.record);
  @override
  _RecordDetailsPageState createState() => _RecordDetailsPageState(record);
}

class _RecordDetailsPageState extends State<RecordDetailsPage> {
  final HappinessRecord record;
  _RecordDetailsPageState(this.record);
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(
          DateUtils.getPrettyDateAndTime(record.date),
          style: TextStyle(fontSize: 16),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            color: Colors.pink,
            onPressed: () {
              ScreenshotShareImage.takeScreenshotShareImage();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            buildResultGraph(record),
            if (record.situation.isNotEmpty)
            Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.fromLTRB(20, 10, 20, 20),
              alignment: Alignment.topLeft,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blueGrey, width: 3),
              ),
              child: Text(record.situation,
                  style: TextStyle(
                    fontSize: 24,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
