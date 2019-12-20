import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:happiness_meter/database_helpers.dart';
import 'package:happiness_meter/meter_page.dart';
import 'package:happiness_meter/record_details.dart';
import 'database_helpers.dart';
import 'app_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

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
          title: Text('Happiness Meter'),
          actions: <Widget>[
//          IconButton(icon: Icon(FontAwesomeIcons.dyalog), onPressed: () {}),
            Container(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    DatabaseHelper.instance.deleteAll();
                  });
                },
                child: new Text(
                  "Delete all",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              alignment: Alignment.center,
              padding: const EdgeInsets.all(16.0),
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
                    "No Happiness Recorded!",
                    style: TextStyle(fontSize: 22),
                  ));
//                  return Center(child: CircularProgressIndicator());

                return ListView(
                  children: snapshot.data
                      .map(
                        (record) => GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RecordDetails(record.id)));
                          },
                          child: Card(
                            elevation: 8.0,
                            margin: new EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10.0),
                            child: Container(
                              height: 200,
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(64, 75, 96, .9)),
                              child: Dismissible(
                                key: Key(record.id.toString()),
                                onDismissed: (direction) {
                                  setState(() {
                                    snapshot.data.remove(record);
                                    DatabaseHelper.instance
                                        .deleteRecord(record.id);
                                  });
                                  // Show a snackbar. This snackbar could also contain "Undo" actions.
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                      duration: Duration(seconds: 1),
                                      content:
                                          Text("Happiness Record removed")));
                                },
                                child: ListTile(
                                  title: Text(
                                    DateFormat("E dd LLL yyy H:m")
                                        .format(
                                            DateTime.fromMillisecondsSinceEpoch(
                                                record.date))
                                        .toString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Container(
                                    alignment: Alignment.center,
                                    child: RotatedBox(
                                      quarterTurns: 3,
                                      child: Column(
                                        children: <Widget>[
                                          ResultCylinder(AppColors.colorBlue,AppColors.colorBlueInactive,
                                              record.blueValue),
                                          SizedBox(height: 20),
                                          ResultCylinder(AppColors.colorGreen, AppColors.colorGreenInactive,
                                              record.greenValue),
                                          SizedBox(height: 20),
                                          ResultCylinder(AppColors.colorYellow, AppColors.colorYellowInactive,
                                              record.yellowValue),
                                          SizedBox(height: 20),
                                          ResultCylinder(AppColors.colorRed,AppColors.colorRedInactive,
                                              record.redValue),
                                          SizedBox(height: 20),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
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
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MeterPage()));
          },
          label: Text('Add record'),
        ));
  }
}

class ResultCylinder extends StatelessWidget {
  final color;
  final bgColor;
  final value;

  ResultCylinder(this.color,this.bgColor, this.value);

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
