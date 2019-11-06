import 'package:flutter/material.dart';
import 'package:happiness_meter/custom_slider_thumb.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/services.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'happinessslider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final double sliderHeight = 420.0;
  final double sliderWidth = 70.0;
  var average = 0.0;
  var blueValue = 0.0;
  var greenValue = 0.0;
  var yellowValue = 0.0;
  var redValue = 0.0;

//   var blueSlider = HappinessSlider("Blue", colorBlue, colorBlue, _updateBlueValue);

  var colorBlue = Color(0xff005093);
  var colorGreen = Color(0xff009351);
  var colorYellow = Color(0xffF4C223);
  var colorRed = Color(0xffD8222A);

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
              //
            }),
        title: Text("Happiness Meter"),
        actions: <Widget>[
          IconButton(icon: Icon(FontAwesomeIcons.dyalog), onPressed: () {}),
        ],
      ),
      body: Container(
          color: Color(0xffE5E5E5),
          child: Column(
            children: <Widget>[
              Container(
                height: 55,
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: LinearPercentIndicator(
//                  width: MediaQuery.of(context).size.width - 50,
                  animation: false,
                  lineHeight: 20.0,
//                  animationDuration: 500,
                  percent: average / 10,
                  linearStrokeCap: LinearStrokeCap.roundAll,
                  progressColor: Colors.purple,
                ),
//                  child: LinearProgressIndicator(
//                    backgroundColor: Colors.white,
//                    valueColor: AlwaysStoppedAnimation<Color>(Colors.purple),
//                    value: average / 10,
//                  )
              ),
              Container(
                width: double.infinity,
                height: 30,
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    "1       2       3       4       5       6       7       8       9       10",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              RaisedButton(
                color: Colors.blueGrey,
                onPressed: () {
                  updateSaveLabel(saveLabel == "Save");
                },
                child: Text(
                  saveLabel,
                  style: TextStyle(fontSize: 20),
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
                              child:  HappinessSlider("PERCEPTIE", colorBlue,
                                  colorBlue, _updateBlueValue),
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
                              child: new HappinessSlider("ACCEPTATIE",
                                  colorGreen, colorGreen, _updateGreenValue)),
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
                              child: new HappinessSlider("VISIE", colorYellow,
                                  colorYellow, _updateYellowValue)),
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
                              child: new HappinessSlider("ACTIE", colorRed,
                                  colorRed, _updateRedValue)),
                        ),
//                      alignment: FractionalOffset.bottomRight,
                      ),
                    ],
                  ),
                  alignment: Alignment.bottomCenter,
                ),
              ),
            ],
          )),
    );
  }
}
