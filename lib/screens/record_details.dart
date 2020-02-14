import 'dart:io';

import 'package:flutter/material.dart';
import 'package:happiness_meter/data/database_helpers.dart';
import 'package:happiness_meter/utils/date_utils.dart';
import 'package:happiness_meter/utils/record_drawing.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:flutter_share/flutter_share.dart';

class RecordDetailsPage extends StatefulWidget {
  final HappinessRecord record;
  RecordDetailsPage(this.record);
  @override
  _RecordDetailsPageState createState() => _RecordDetailsPageState(record);
}

class _RecordDetailsPageState extends State<RecordDetailsPage> {
  final HappinessRecord record;
  ScreenshotController screenshotController = ScreenshotController();

  _RecordDetailsPageState(this.record);
  @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: screenshotController,
      child: new Scaffold(
        appBar: AppBar(
          title: Text(
            DateUtils.getPrettyDateAndTime(record.date),
            style: TextStyle(fontSize: 16),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.share),
              color: Colors.white,
              onPressed: () async {
                debugPrint("takeScreenshotShareImage");
                final directory =
                    (await getApplicationDocumentsDirectory()).path;
                String fileName = DateTime.now().toIso8601String();
                String path = '$directory/$fileName.png';
                // capture image
                screenshotController
                    .capture(path: path, delay: Duration(milliseconds: 10))
                    .then((File image) async {
                  // save image
                  await ImageGallerySaver.saveImage(image.readAsBytesSync());

                  // share image
                  await FlutterShare.shareFile(
                    title: 'Example share',
                    text: 'Example share text',
                    filePath: path
                  );
                }).catchError((onError) {
                  print(onError);
                });
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                child: buildResultGraph(record),
                margin: EdgeInsets.only(bottom: 20),
              ),
              if (record.situation.isNotEmpty)
                Container(
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
                  alignment: Alignment.topLeft,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueGrey, width: 3),
                  ),
                  child: Text(
                    record.situation,
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
