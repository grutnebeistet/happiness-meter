import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:happiness_meter/data/database_helpers.dart';
import 'package:happiness_meter/global_translations.dart';
import 'package:happiness_meter/main.dart';
import 'package:happiness_meter/theme/app_colors.dart';
import 'package:happiness_meter/theme/happ_meter_icons.dart';
import 'package:happiness_meter/utils/record_drawing.dart';
import 'package:intl/intl.dart';

class RecordListPage extends StatefulWidget {
  const RecordListPage({this.onEditPressed});
  final RecordDetailCallback onEditPressed;

  _StateRecordsPage createState() => _StateRecordsPage(onEditPressed);
}

class _StateRecordsPage extends State<RecordListPage> {
  _StateRecordsPage(this.onEditPressed);
  final RecordDetailCallback onEditPressed;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Colors.white70, //AppColors.colorThemeBlue,
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
                          // TODO Details page
                          // onEditPressed(null);
                        },
                        child: Container(
                          margin: new EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5.0),
                          // height: 208,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 7,
                                child: Card(
                                  elevation: 8.0,
                                  // margin: new EdgeInsets.symmetric(
                                  //     horizontal: 10.0, vertical: 10.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xfff0f5fb),
                                      border: Border.all(
                                        width: 8,
                                        color: AppColors.colorLightThemeBlue,
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
                                              // .add_jm()
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
                                          // child: Text("id ${record.id} - B: ${record.blueValue} - G: ${record.greenValue} - Y: ${record.yellowValue}"),
                                          child: CustomPaint(
                                            foregroundPainter:
                                                GraphPainter(record),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  // color: Colors.pink,
                                  // width: 80,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Container(
                                        height: 100,
                                        child: Card(
                                            elevation: 8.0,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Color(0xfff0f5fb),
                                                  border: Border.all(
                                                    width: 8,
                                                    color: AppColors
                                                        .colorLightThemeBlue,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(3)),
                                              padding: EdgeInsets.all(15),
                                              child: GestureDetector(
                                                onTap: (){
                                                  onEditPressed(record);
                                                },
                                                child: Icon(
                                                  HappMeter.pencil,
                                                  size: 22,
                                                ),
                                              ),
                                            )),
                                      ),
                                      Container(
                                        height: 100,
                                        child: Card(
                                          elevation: 8.0,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Color(0xfff0f5fb),
                                              border: Border.all(
                                                width: 8,
                                                color: AppColors
                                                    .colorLightThemeBlue,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(3),
                                            ),
                                            padding: EdgeInsets.all(15),
                                            child: GestureDetector(
                                              onTap: () {
                                                setState(
                                                  () {
                                                    DatabaseHelper.instance
                                                        .deleteRecord(
                                                            record.id);
                                                  },
                                                );
                                                // Show a snackbar. This snackbar could also contain "Undo" actions.
                                                Scaffold.of(context)
                                                    .showSnackBar(SnackBar(
                                                        duration: Duration(
                                                            seconds: 1),
                                                        content: Text(
                                                            allTranslations.text(
                                                                "home.removed"))));
                                              },
                                              child: Icon(
                                                HappMeter.trash,
                                                size: 22,
                                              ),
                                            ),

                                            // padding: EdgeInsets.all(15),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              );
              // return RecordList(
              //   onEditPressed: onEditPressed,
              //   data: snapshot,
              // );
            },
          )),
    );
  }
}
