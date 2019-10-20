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

  var colorBlue = Color(0xff005093);
  var colorGreen = Color(0xff009351);
  var colorYellow = Color(0xffF4C223);
  var colorRed = Color(0xffD8222A);

  var saveLabel = 'Save';

  void updateBlueValue(double newValue) {
    setState(() {
      blueValue = newValue;
      updateAverage();
    });
  }

  void updateGreenValue(double newValue) {
    setState(() {
      greenValue = newValue;
      updateAverage();
    });
  }

  void updateYellowValue(double newValue) {
    setState(() {
      yellowValue = newValue;
      updateAverage();
    });
  }

  void updateRedValue(double newValue) {
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
                child:  LinearPercentIndicator(
//                  width: MediaQuery.of(context).size.width - 50,
                  animation: false,
                  lineHeight: 20.0,
//                  animationDuration: 500,
                  percent: average/10,
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
                    "1       2       3       4       5       6       7       8       9       10",textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              RaisedButton(
                color: Colors.blueGrey,
                onPressed: () {
                  updateSaveLabel(saveLabel == "Save");
                },
//                child: const Text(saveLabel, style: TextStyle(fontSize: 20)),
                child: Text(saveLabel, style: TextStyle(fontSize: 20),),
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
                            width: sliderWidth,
                            height: sliderHeight,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: 1,
                                  child: Text(
                                    "PERCEPTIE",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xff005093),
                                      fontSize: 24,
                                    ),
                                  ),
                                ),
                                Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Container(
                                          alignment: Alignment.center,
                                          width: 32,
                                          child: Text(
                                            blueValue.toInt().toString(),
                                            style: TextStyle(
                                                color: Color(0xff005093),
                                                fontSize: 24.0),
                                          )),
                                    ),
                                    Expanded(
                                      child: SliderTheme(
                                          data: SliderTheme.of(context)
                                              .copyWith(
//                                                      trackShape:
//                                                          CustomSliderTrack(),
                                              activeTrackColor:
                                              Color(0xff005093),
                                              inactiveTrackColor:
                                              Color(0xffffffff),
                                              trackHeight: 10.0,
                                              thumbColor: Color(0xff005093),
                                              inactiveTickMarkColor:
                                              Color(0xff005093),
                                              activeTickMarkColor:
                                              Color(0xff005093),
                                              thumbShape:
                                              CustomSliderThumb()
//                                            thumbShape: RoundSliderThumbShape(
//                                                enabledThumbRadius: 24.0),
                                          ),
                                          child: RotatedBox(
                                            quarterTurns: 3,
                                            child: Slider(
                                              min: 0.0,
                                              max: 10.0,
                                              divisions: 10,
                                              value: blueValue,
                                              onChanged: (newValue) {
                                                updateBlueValue(newValue);
                                              },
                                            ),
                                          )),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
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
                            width: sliderWidth,
                            height: sliderHeight,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: 1,
                                  child: Text(
                                    "ACCEPTATIE",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: colorGreen,
                                      fontSize: 24,
                                    ),
                                  ),
                                ),
                                Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Container(
                                          alignment: Alignment.center,
                                          width: 32,
                                          child: Text(
                                            greenValue.toInt().toString(),
                                            style: TextStyle(
                                                color: colorGreen,
                                                fontSize: 24.0),
                                          )),
                                    ),
                                    Expanded(
                                      child: SliderTheme(
                                          data:
                                          SliderTheme.of(context).copyWith(
                                            activeTrackColor: colorGreen,
                                            inactiveTrackColor:
                                            Color(0xFFC8E6C9),
                                            trackHeight: 10.0,
                                            thumbColor: colorGreen,
                                            inactiveTickMarkColor:
                                            Color(0xFFC8E6C9),
                                            activeTickMarkColor: colorGreen,
                                            thumbShape: CustomSliderThumb(),
//                                            thumbShape: RoundSliderThumbShape(
//                                                enabledThumbRadius: 24.0),
//                                            overlayColor:
//                                                Colors.purple.withAlpha(32),
//                                            overlayShape:
//                                                RoundSliderOverlayShape(
//                                                    overlayRadius: 14.0),
                                          ),
                                          child: RotatedBox(
                                            quarterTurns: 3,
                                            child: Slider(
                                              min: 0.0,
                                              max: 10.0,
                                              divisions: 10,
                                              value: greenValue,
                                              onChanged: (newValue) {
                                                updateGreenValue(newValue);
                                              },
                                            ),
                                          )),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
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
                            width: sliderWidth,
                            height: sliderHeight,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: 1,
                                  child: Text(
                                    "VISIE",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: colorYellow,
                                      fontSize: 24,
                                    ),
                                  ),
                                ),
                                Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Container(
                                          alignment: Alignment.center,
                                          width: 32,
                                          child: Text(
                                            yellowValue.toInt().toString(),
                                            style: TextStyle(
                                                color: colorYellow,
                                                fontSize: 24.0),
                                          )),
                                    ),
                                    Expanded(
                                      child: SliderTheme(
                                          data:
                                          SliderTheme.of(context).copyWith(
                                            activeTrackColor: colorYellow,
                                            inactiveTrackColor:
                                            Color(0xFFFFFFFF),
                                            trackHeight: 10.0,
                                            thumbColor: colorYellow,
                                            inactiveTickMarkColor:
                                            Color(0xFFFFFFFF),
                                            activeTickMarkColor: colorYellow,
                                            thumbShape: CustomSliderThumb(),
//                                            thumbShape: RoundSliderThumbShape(
//                                                enabledThumbRadius: 24.0),
//                                            overlayColor:
//                                                Colors.purple.withAlpha(32),
//                                            overlayShape:
//                                                RoundSliderOverlayShape(
//                                                    overlayRadius: 14.0),
                                          ),
                                          child: RotatedBox(
                                            quarterTurns: 3,
                                            child: Slider(
                                              min: 0.0,
                                              max: 10.0,
                                              divisions: 10,
                                              value: yellowValue,
                                              onChanged: (newValue) {
                                                updateYellowValue(newValue);
                                              },
                                            ),
                                          )),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
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
                            width: sliderWidth,
                            height: sliderHeight,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: 1,
                                  child: Text(
                                    "ACTIE",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: colorRed,
                                      fontSize: 24,
                                    ),
                                  ),
                                ),
                                Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Container(
                                          alignment: Alignment.center,
                                          width: 32,
                                          child: Text(
                                            redValue.toInt().toString(),
                                            style: TextStyle(
                                                color: colorRed,
                                                fontSize: 24.0),
                                          )),
                                    ),
                                    Expanded(
                                      child: SliderTheme(
                                          data:
                                          SliderTheme.of(context).copyWith(
                                            activeTrackColor: colorRed,
                                            inactiveTrackColor:
                                            Color(0xFFFFCDD2),
                                            trackHeight: 10.0,
                                            thumbColor: colorRed,
                                            inactiveTickMarkColor:
                                            Color(0xFFFFCDD2),
                                            activeTickMarkColor: colorRed,
                                            thumbShape: CustomSliderThumb(),
//                                            thumbShape: RoundSliderThumbShape(
//                                                enabledThumbRadius: 24.0),
//                                            overlayColor:
//                                                Colors.purple.withAlpha(32),
//                                            overlayShape:
//                                                RoundSliderOverlayShape(
//                                                    overlayRadius: 14.0),
                                          ),
                                          child: RotatedBox(
                                            quarterTurns: 3,
                                            child: Slider(
                                              min: 0.0,
                                              max: 10.0,
                                              divisions: 10,
                                              value: redValue,
                                              onChanged: (newValue) {
                                                updateRedValue(newValue);
                                              },
                                            ),
                                          )),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
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
