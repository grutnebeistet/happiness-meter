import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:happiness_meter/data/database_helpers.dart';
import 'package:happiness_meter/global_translations.dart';
import 'package:happiness_meter/main.dart';
import 'package:happiness_meter/screens/record_details.dart';
import 'package:happiness_meter/theme/app_colors.dart';
import 'package:happiness_meter/theme/happ_meter_icons.dart';
import 'package:happiness_meter/utils/date_utils.dart';
import 'package:happiness_meter/utils/record_drawing.dart';

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
                padding: EdgeInsets.only(bottom: 10, top: 10),
                children: snapshot.data
                    .map(
                      (record) => GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    RecordDetailsPage(record)),
                          );
                        },
                        child: Container(
                          margin: new EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5.0),
                          // height: 208,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 5,
                                child: Card(
                                  elevation: 8.0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xfff0f5fb),
                                      border: Border.all(
                                        width: 8,
                                        color: AppColors.colorLightThemeBlue,
                                      ),
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                    padding: EdgeInsets.all(8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          DateUtils.getPrettyDate(record.date),
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: 1.3,
                                              color: Color(0xff5b6990)),
                                        ),
                                        Container(
                                          width: 200,
                                          child: buildListResultGraph(record),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  child: Column(
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: () {
                                          onEditPressed(record);
                                        },
                                        child: Container(
                                            height: 90,
                                            width: 90,
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
                                                        BorderRadius.circular(
                                                            3)),
                                                child: Icon(
                                                  HappMeter.pencil,
                                                  size: 26,
                                                ),
                                              ),
                                            )),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(
                                            () {
                                              DatabaseHelper.instance
                                                  .deleteRecord(record.id);
                                            },
                                          );
                                          // Show a snackbar. This snackbar could also contain "Undo" actions.
                                          Scaffold.of(context).showSnackBar(
                                              SnackBar(
                                                  duration:
                                                      Duration(seconds: 1),
                                                  content: Text(allTranslations
                                                      .text("home.removed"))));
                                        },
                                        child: Container(
                                          height: 90,
                                          width: 90,
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
                                              child: Icon(
                                                HappMeter.trash,
                                                size: 26,
                                              ),
                                            ),
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
            },
          )),
    );
  }
}
