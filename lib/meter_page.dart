import 'package:flutter/material.dart';
import 'package:happiness_meter/custom_slider_thumb.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/services.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'happiness_slider.dart';
import 'database_helpers.dart';
import 'app_colors.dart';

class MeterPage extends StatefulWidget {
  final HappinessRecord happinessRecord;
  MeterPage(this.happinessRecord);
  @override
  _MeterPageState createState() => _MeterPageState(this.happinessRecord);
}

class _MeterPageState extends State<MeterPage> {
   HappinessRecord happinessRecord;
     var average = 0.0;
  var blueValue = 0.0;
  var greenValue = 0.0;
  var yellowValue = 0.0;
  var redValue = 0.0;
  static var situationDescription = '';

  _MeterPageState(this.happinessRecord){
    if (happinessRecord != null) {
      blueValue = happinessRecord.blueValue;
      greenValue = happinessRecord.greenValue;
      yellowValue = happinessRecord.yellowValue;
      redValue = happinessRecord.redValue;
      average = happinessRecord.totalHQ;
      situationDescription = happinessRecord.situation;
    }
  }

  final textController = TextEditingController(text: situationDescription);

  var saveLabel = 'Save';

  // bool updatingRecord;

  // _initMeter() {
  //   if (happinessRecord != null) {
  //     updatingRecord = true;
  //     blueValue = happinessRecord.blueValue;
  //       // _updateBlueValue(happinessRecord.blueValue);
  //       // _updateGreenValue(happinessRecord.greenValue);
  //       // _updateYellowValue(happinessRecord.yellowValue);
  //       // _updateRedValue(happinessRecord.redValue);
  //   }
  //   updatingRecord = false;
  // }

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
                  var isNewRecord = happinessRecord == null;

                  happinessRecord = HappinessRecord(
                    isNewRecord ? DateTime.now().millisecondsSinceEpoch : happinessRecord.date,
                      blueValue,
                      greenValue,
                      yellowValue,
                      redValue,
                      average,
                      textController.text);

                  if (!isNewRecord) {
                    DatabaseHelper.instance.update(happinessRecord);
                  } else {
                    DatabaseHelper.instance.insert(happinessRecord);

                    Navigator.pop(context);
                  }
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
      body: SingleChildScrollView(
        child: Container(
          color: Color(0xffE5E5E5),
          child: Column(
            children: <Widget>[
              Container(
                height: 22,
                width: double.infinity,
                margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
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
                  valueColor:
                      AlwaysStoppedAnimation<Color>(AppColors.colorPurple),
                  value: average / 10,
                ),
              ),
              Container(
                width: double.infinity,
                height: 25,
                padding: EdgeInsets.fromLTRB(20, 2, 16, 0),
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    "0       1       2       3       4       5       6       7       8       9       10",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Container(
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
                                  _updateBlueValue, blueValue),
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
                                  _updateGreenValue, greenValue)),
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
                                  _updateYellowValue, yellowValue)),
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
                                  _updateRedValue, redValue)),
                        ),
//                      alignment: FractionalOffset.bottomRight,
                      ),
                    ],
                  ),
                  alignment: Alignment.topCenter,
                ),
              ),
              // text input 'subject'
              Container(
                color: Colors.white,
                alignment: Alignment.topCenter,
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: textController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintStyle: TextStyle(fontSize: 26),
                    hintText: 'Enter notes here',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
}
