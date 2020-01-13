import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:happiness_meter/data/database_helpers.dart';

import 'package:happiness_meter/global_translations.dart';
import 'package:flutter/foundation.dart';
import 'package:happiness_meter/model/record.dart';
import 'package:happiness_meter/screens/record_details.dart';
import 'package:happiness_meter/screens/settings_page.dart';
import 'package:happiness_meter/theme/app_colors.dart';
import 'package:intl/intl.dart';

import 'meter_page.dart';
import 'dart:developer' as developer;

class HomePage extends StatefulWidget {
  _StateHomePage createState() => _StateHomePage();
}

const double COL_HEIGHT = 110.0;
const double COL_WIDTH = 35.0;

class _StateHomePage extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(allTranslations.text("main.page_title")),
          actions: <Widget>[
//          IconButton(icon: Icon(FontAwesomeIcons.dyalog), onPressed: () {}),
            Container(
              child: IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {
                  setState(() {
                    DatabaseHelper.instance.deleteAll();
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => SettingsPage()));
                  });
                },
              ),
              alignment: Alignment.center,
              // padding: const EdgeInsets.all(16.0),
            ),
          ],
        ),
        body: Container(
            color: Colors.blueGrey,
            child: FutureBuilder<List<HappinessRecord>>(
              future: DatabaseHelper.instance.getAllHappinessRecords(),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Center(
                      child: Text(
                    allTranslations.text("home.empty_db_msg"),
                    style: TextStyle(fontSize: 22),
                  ));
                return ListView(
                  children: snapshot.data
                      .map(
                        (record) => GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        RecordDetailsPage(record.id)));
                          },
                          child: Container(
                            margin: new EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 5.0),
                            height: 208,
                            child: Row(
                              children: <Widget>[
                                Card(
                                  elevation: 8.0,
                                  // margin: new EdgeInsets.symmetric(
                                  //     horizontal: 10.0, vertical: 10.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xfff0f5fb),
                                      border: Border.all(
                                        width: 8,
                                        color: Color(0xffd3e1ed),
                                      ),
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                    padding: EdgeInsets.all(15),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          DateFormat.yMMMMEEEEd(allTranslations
                                                  .locale
                                                  .toString())
                                              .add_jm()
                                              .format(DateTime
                                                  .fromMillisecondsSinceEpoch(
                                                      record.date))
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: 1.3,
                                              color: Color(0xff5b6990)),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Container(
                                          height: 120,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          width: 200,
                                          child: CustomPaint(
                                            foregroundPainter:
                                                GraphPainter(record),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(
                                          child: Card(
                                              elevation: 8.0,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: Color(0xfff0f5fb),
                                                    border: Border.all(
                                                      width: 8,
                                                      color: Color(0xffd3e1ed),
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3)),
                                                padding: EdgeInsets.all(15),
                                                child: Image(
                                                  image: NetworkImage(
                                                      'https://banner2.cleanpng.com/20180920/gof/kisspng-computer-icons-editing-portable-network-graphics-i-edit-profile-svg-png-icon-free-download-194863-5ba34579aa7087.1111242415374268096981.jpg'),
                                                ),
                                              )),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          child: Card(
                                            elevation: 8.0,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Color(0xfff0f5fb),
                                                border: Border.all(
                                                  width: 8,
                                                  color: Color(0xffd3e1ed),
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(3),
                                              ),
                                              child: GestureDetector(
                                                onTap: (){
                                                  setState(() {
                                                    DatabaseHelper.instance.deleteRecord(record.id);
                                                  });
                                                },
                                                child: Image(
                                                  image: NetworkImage(
                                                      'https://toppng.com/uploads/preview/delete-button-clipart-volume-icon-hapus-11563950527luvjbpuej2.png'),
                                                ),
                                              ),

                                              // padding: EdgeInsets.all(15),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList(),
                );
              },
            )),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: AppColors.colorPurple,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MeterPage(null)));
          },
          label: Text(allTranslations.text("home.add_record")),
        ));
  }
}

class ResultCylinder extends StatelessWidget {
  final color;
  final bgColor;
  final value;

  ResultCylinder(this.color, this.bgColor, this.value);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: COL_HEIGHT,
        height: COL_WIDTH,
        child: LinearProgressIndicator(
          backgroundColor: bgColor,
          value: value / 10,
          valueColor: AlwaysStoppedAnimation(color),
//
        ));
  }
}

class GraphPainter extends CustomPainter {
  final HappinessRecord dbRecord;

  GraphPainter(this.dbRecord);

  // foreground
  Paint trackBarPaint = Paint()
    ..color = Color(0xff818aab)
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round
    ..strokeWidth = 12;

  //background
  Paint trackPaint = Paint()
    ..color = Color(0xffdee6f1)
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round
    ..strokeWidth = 12;

  @override
  void paint(Canvas canvas, Size size) {
    List val = [
      Record(size.height * dbRecord.blueValue / 10, AppColors.colorBlue,
          AppColors.colorBlueInactive),
      Record(size.height / 10 * dbRecord.greenValue,
          AppColors.colorGreenInactive, AppColors.colorGreenInactive),
      Record(size.height / 10 * dbRecord.yellowValue, AppColors.colorGreen,
          AppColors.colorGreenInactive),
      Record(size.height / 10 * dbRecord.redValue, AppColors.colorRed,
          AppColors.colorRedInactive),
    ];
    double origin = 8;

    Path trackBarPath = Path();
    Path trackPath = Path();

    for (int i = 0; i < val.length; i++) {
      Record record = val[i];

      trackPath.moveTo(origin, 0);
      trackPath.lineTo(origin, size.height);

      trackBarPath.moveTo(origin, size.height);
      if (record.value > 0) {
        trackBarPath.lineTo(origin, 120 - record.value);
      }
      origin = origin + size.width * 0.18;
    }

    canvas.drawPath(trackPath, trackPaint);
    canvas.drawPath(trackBarPath, trackBarPaint);
  }

  // @override
  // void paint(Canvas canvas, Size size) {
  //   List val = [
  //     Record(size.height * dbRecord.blueValue/10, AppColors.colorBlue,
  //         AppColors.colorBlueInactive),
  //     Record(size.height / 10 * dbRecord.greenValue, AppColors.colorGreenInactive,
  //         AppColors.colorGreenInactive),
  //     Record(size.height / 10 * dbRecord.yellowValue, AppColors.colorGreen,
  //         AppColors.colorGreenInactive),
  //     Record(size.height / 10 * dbRecord.redValue, AppColors.colorRed,
  //         AppColors.colorRedInactive),
  //   ];
  //   double origin = 8;

  //   Path trackBarPath = Path();
  //   Path trackPath = Path();

  //   for (int i = 0; i < val.length; i++) {
  //      Record record = val[i];

  // debugPrint('recValue: ${record.value}');
  //     // trackPaint.color = record.inactiveColor;
  //     // trackBarPaint.color = record.color;

  //     trackPath.moveTo(origin, size.height);
  //     trackPath.lineTo(origin, 0);

  //     trackBarPath.moveTo(origin, size.height);
  //     trackBarPath.lineTo(origin, record.value);

  //     origin = origin + size.width * 0.18;
  //   }

  //   canvas.drawPath(trackBarPath, trackBarPaint);
  //   canvas.drawPath(trackPath, trackPaint);
  // }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}
