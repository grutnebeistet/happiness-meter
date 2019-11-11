import 'package:flutter/material.dart';
import 'package:happiness_meter/custom_slider_thumb.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/services.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'happiness_slider.dart';
import 'database_helpers.dart';
import 'app_colors.dart';

class MeterPage extends StatefulWidget {
  @override
  _MeterPageState createState() => _MeterPageState();
}

class _MeterPageState extends State<MeterPage> {
  final double sliderHeight = 420.0;
  final double sliderWidth = 70.0;
  var average = 0.0;
  var blueValue = 0.0;
  var greenValue = 0.0;
  var yellowValue = 0.0;
  var redValue = 0.0;

  var saveLabel = 'Save';

  _updateBlueValue(double newValue) {
    setState(() {
      blueValue = newValue;
      updateAverage();
    });
  }

  _updateGreenValue(double newValue) {
    setState(() {
      greenValue = newValue;
      updateAverage();
    });
  }

  _updateYellowValue(double newValue) {
    setState(() {
      yellowValue = newValue;
      updateAverage();
    });
  }

  _updateRedValue(double newValue) {
    setState(() {
      redValue = newValue;
      updateAverage();
    });
  }

  void updateSaveLabel(bool saved) {
    setState(() {
      if (saved)
        saveLabel = "Saved";
      else
        saveLabel = "Save";
    });
  }

  void updateAverage() {
    average = (blueValue + greenValue + yellowValue + redValue) / 4;
    updateSaveLabel(false);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return new Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
              //
            }),
        title: Text("Happiness Meter"),
        actions: <Widget>[
//          IconButton(icon: Icon(FontAwesomeIcons.dyalog), onPressed: () {}),
          Container(
            child: GestureDetector(
              onTap: () {
                if (saveLabel == 'Save') {
                  updateSaveLabel(true);
                  HappinessRecord record = HappinessRecord(DateTime.now().millisecondsSinceEpoch,
                      blueValue, greenValue, yellowValue, redValue);
                  DatabaseHelper.instance.insert(record);

                  Navigator.pop(context);
                }
//              Navigator.pushNamed(context, "myRoute");
              },
              child: new Text(
                saveLabel,
                style: TextStyle(fontSize: 16),
              ),
            ),
            alignment: Alignment.center,
            padding: const EdgeInsets.all(16.0),
          ),
        ],
      ),
      body: Container(
          color: Color(0xffE5E5E5),
          child: Column(
            children: <Widget>[
              Container(
                height: 55,
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(20, 45, 20, 0),
//                child: LinearPercentIndicator(
////                  width: MediaQuery.of(context).size.width - 50,
//                  animation: false,
//                  lineHeight: 20.0,
////                  animationDuration: 500,
//                  percent: average / 10,
//                  linearStrokeCap: LinearStrokeCap.roundAll,
//                  progressColor: Color(0xff7300a8),
//                ),
                child: LinearProgressIndicator(
                  backgroundColor: AppColors.colorPurpleInactive,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.colorPurple),
                  value: average / 10,
                ),
              ),
              Container(
                width: double.infinity,
                height: 30,
                padding: EdgeInsets.fromLTRB(20, 5, 18, 0),
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    "0       1       2       3       4       5       6       7       8       9       10",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Material(
                            color: Color(0xffE5E5E5),
//                        elevation: 14.0,
                            borderRadius: BorderRadius.circular(24.0),
                            shadowColor: Color(0x802196F3),
                            child: Container(
                              child: HappinessSlider(
                                  "PERCEPTIE",
                                  AppColors.colorBlue,
                                  AppColors.colorBlueInactive,
                                  _updateBlueValue),
                            )),
                        margin: EdgeInsets.all(10),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Material(
                          color: Color(0xffE5E5E5),
//                        elevation: 14.0,
                          borderRadius: BorderRadius.circular(24.0),
                          shadowColor: Color(0xFFA5D6A7),
                          child: Container(
                              child: HappinessSlider(
                                  "ACCEPTATIE",
                                  AppColors.colorGreen,
                                  AppColors.colorGreenInactive,
                                  _updateGreenValue)),
                        ),
//                      alignment: FractionalOffset.bottomRight,
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Material(
                          color: Color(0xffE5E5E5),
//                        elevation: 14.0,
                          borderRadius: BorderRadius.circular(24.0),
                          shadowColor: Color(0xFFFFCC80),
                          child: Container(
                              child: HappinessSlider(
                                  "VISIE",
                                  AppColors.colorYellow,
                                  AppColors.colorYellowInactive,
                                  _updateYellowValue)),
                        ),
//                      alignment: FractionalOffset.bottomRight,
                      ),
//                    HappinessSlider("ARTIE", Colors.red, Color(0xFFEF9A9A))
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Material(
                          color: Color(0xffE5E5E5),
//                        elevation: 14.0,
                          borderRadius: BorderRadius.circular(24.0),
                          shadowColor: Color(0xFFEF9A9A),
                          child: Container(
                              child: HappinessSlider(
                                  "ACTIE",
                                  AppColors.colorRed,
                                  AppColors.colorRedInactive,
                                  _updateRedValue)),
                        ),
//                      alignment: FractionalOffset.bottomRight,
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                ),
              ),
            ],
          )),
    );
  }
}
