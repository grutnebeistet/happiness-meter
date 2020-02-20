import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:happiness_meter/data/database_helpers.dart';
import 'package:happiness_meter/utils/date_utils.dart';
import 'package:happiness_meter/utils/record_drawing.dart';
import 'package:screenshot/screenshot.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:auto_size_text/auto_size_text.dart';

class RecordDetailsPage extends StatefulWidget {
  final HappinessRecord record;
  RecordDetailsPage(this.record);
  @override
  _RecordDetailsPageState createState() => _RecordDetailsPageState(record);
}

class _RecordDetailsPageState extends State<RecordDetailsPage> {
  final HappinessRecord record;
  ScreenshotController screenshotController = ScreenshotController();
  bool capturingScreen = false;

  _RecordDetailsPageState(this.record);
  @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: screenshotController,
      child: new Scaffold(
        appBar: AppBar(
          backgroundColor: capturingScreen ? Colors.white : Colors.blueGrey,
          title: Text(
            DateUtils.getPrettyDateAndTime(record.date),
            style: TextStyle(
              fontSize: 16,
              color: capturingScreen ? Colors.black : Colors.white,
            ),
          ),
          // TODO logo if capturingScreen
          actions: <Widget>[
            if(!capturingScreen)
            IconButton(
              icon: Icon(Icons.share),
              // color: capturingScreen ? Colors.blueGrey : Colors.white,
              onPressed: () async {
                setState(() {
                  capturingScreen = true;
                });
                _captureAndShare();
              },
            ),
          ],
        ),
        body: Column(
          children: <Widget>[
            Container(
              child: buildResultGraph(record),
              margin: EdgeInsets.only(bottom: 20),
            ),
            // if (record.situation.isNotEmpty)
            Expanded(
              child: Container(
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
                alignment: Alignment.topLeft,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueGrey, width: 3),
                ),
                child: AutoSizeText(
                  record.situation,
                  style: TextStyle(fontSize: 40),
                  minFontSize: 8,
                  stepGranularity: 2,
                  maxLines: 40,
                  overflow: TextOverflow.ellipsis,
                ),
                // child: Text(
                //   record.situation,
                //   // style: TextStyle(backgroundColor: Colors.yellow
                //   //     // fontSize: 24,
                //   //     ),
                // ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _captureAndShare() {
    String fileName =
        "Bewaarde gegenvens ${DateUtils.getPrettyDateAndTime(record.date)}";
    screenshotController.capture().then((File image) async {
      Uint8List bytes = image.readAsBytesSync();
      await Share.file("HEHE", "$fileName.jpg", bytes, 'image/png',
          text:
              "Happiness recorded ${DateUtils.getPrettyDateAndTime(record.date)}");

      setState(() {
        capturingScreen = false;
      });
    }).catchError(
      (onError) {
        print(onError);
      },
    );
  }
}
