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
          title: Container(
            alignment: Alignment.center,
            child: _appBarTitle(),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.share),
              color: Colors.white,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
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
              child: buildResultGraph(record, context),
              margin: EdgeInsets.only(bottom: 20),
            ),
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
                  style: TextStyle(fontSize: 32),
                  minFontSize: 8,
                  stepGranularity: 1,
                  maxLines: 40,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // TODO show logo if capturingScreen
  _appBarTitle() {
    return Column(
      children: <Widget>[
        Text(
          DateUtils.getPrettyDate(record.date),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: capturingScreen ? Colors.black : Colors.white,
          ),
        ),
        Text(
          DateUtils.getPrettyTime(record.date),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            color: capturingScreen ? Colors.black : Colors.white,
          ),
        ),
      ],
    );
  }

  _captureAndShare() {
    String fileName =
        "Bewaarde gegenvens ${DateUtils.getPrettyDateAndTime(record.date)}";
    screenshotController.capture(pixelRatio: 1.5).then((File image) async {
      Uint8List bytes = image.readAsBytesSync();
      await Share.file(
          "Bewaarde gegenvens", "$fileName.jpg", bytes, 'image/jpg',
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
