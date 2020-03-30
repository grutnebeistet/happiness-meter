import 'package:flutter/material.dart';
import 'package:happiness_meter/components/happiness_slider.dart';

import 'package:flutter/services.dart';
import 'package:happiness_meter/data/database_helpers.dart';
import 'package:happiness_meter/global_translations.dart';
import 'package:happiness_meter/theme/app_colors.dart';

class MeterPage extends StatefulWidget {
  final HappinessRecord happinessRecord;
  MeterPage([this.happinessRecord]);
  @override
  _MeterPageState createState() => _MeterPageState(this.happinessRecord);
}

class _MeterPageState extends State<MeterPage> {
  HappinessRecord happinessRecord;
  final textController = TextEditingController();

  int recordId;
  var average = 0.0;
  var blueValue = 0.0;
  var greenValue = 0.0;
  var yellowValue = 0.0;
  var redValue = 0.0;
  var situationDescription = '';

  var saveLabel;

  var shouldDisableFab = false;

  _MeterPageState([this.happinessRecord]) {
    // TODO two constructors
    if (happinessRecord != null) {
      recordId = happinessRecord.id;
      blueValue = happinessRecord.blueValue;
      greenValue = happinessRecord.greenValue;
      yellowValue = happinessRecord.yellowValue;
      redValue = happinessRecord.redValue;
      average = happinessRecord.totalHQ;
      situationDescription = happinessRecord.situation;
      textController.text = situationDescription;
      saveLabel = '';
    } else {
      saveLabel = allTranslations.text("meter.save");
      situationDescription = '';
    }
  }

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

  _updateSaveLabel(bool saved) {
    setState(() {
      if (saved)
        saveLabel = allTranslations.text("meter.saved");
      else
        saveLabel = allTranslations.text("meter.save");
    });
  }

  void updateAverage() {
    average = (blueValue + greenValue + yellowValue + redValue) / 4;
    _updateSaveLabel(false);
    shouldDisableFab = false;
    // FocusScope.of(context).requestFocus(new FocusNode());
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return new Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              // if (happinessRecord != null) // TODO hidden for demo
              //   Container(
              //     padding: EdgeInsets.only(top: 15),
              //     child: Text(
              //       "Record added ${DateUtils.getPrettyDate(happinessRecord.date)}",
              //       style: TextStyle(fontSize: 16),
              //     ),
              //   ),
              Container(
                width: double.infinity,
                child: Row(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width * 0.82,
                      margin: EdgeInsets.only(right: 6),
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 25,
                            width: double.infinity,
                            margin: EdgeInsets.fromLTRB(20, 20, 4, 0),
                            padding: EdgeInsets.only(top: 4.5, bottom: 1),
                            child: LinearProgressIndicator(
                              backgroundColor: AppColors.colorOrangeInactive,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  AppColors.colorOrange),
                              value: average / 10,
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            height: 25,
                            padding: EdgeInsets.fromLTRB(20, 2, 0, 0),
                            child: FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text(
                                "0       1       2       3       4       5       6       7       8       9       10",
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // color: Colors.blueGrey,
                      // alignment: Alignment.center,
                      child: Text(
                        average.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 27,
                          color: AppColors.colorOrange,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                child: Align(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(10),
                        child: HappinessSlider(
                          "PERCEPTIE",
                          // "",
                          AppColors.colorBlue,
                          AppColors.colorBlueInactive,
                          // AppColors.colorBlue,
                          blueValue,
                          _updateBlueValue,
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.all(10),
                          child: HappinessSlider(
                            "ACCEPTATIE",
                            // "",
                            AppColors.colorGreen,
                            AppColors.colorGreenInactive,
                            // AppColors.colorGreen,
                            greenValue,
                            _updateGreenValue,
                          )),
                      Container(
                          margin: EdgeInsets.all(10),
                          child: HappinessSlider(
                            "VISIE",
                            // "",
                            AppColors.colorYellow,
                            // AppColors.colorYellow,
                            AppColors.colorYellowInactive,
                            yellowValue,
                            _updateYellowValue,
                          )),
                      Container(
                          margin: EdgeInsets.all(10),
                          child: HappinessSlider(
                            "ACTIE",
                            // "",
                            AppColors.colorRed,
                            AppColors.colorRedInactive,
                            //  AppColors.colorRed,
                            redValue,
                            _updateRedValue,
                          )),
                    ],
                  ),
                  alignment: Alignment.topCenter,
                ),
              ),
              // text input 'subject'
              Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
                child: TextField(
                  // onSubmitted: (value) {},
                  onChanged: (value) {
                    setState(() {
                      shouldDisableFab = false;
                    });
                  },
                  textCapitalization: TextCapitalization.sentences,
                  keyboardType: TextInputType.multiline,
                  maxLength: 350,
                  maxLines: null,
                  controller: textController,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                  decoration: InputDecoration(
                    labelText:
                        allTranslations.text("meter.situation_description"),
                    labelStyle: (TextStyle(fontSize: 24)),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.blueGrey, width: 3.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.blueGrey, width: 3.0),
                    ),
                    // border: InputBorder.none,
                    hintStyle: TextStyle(fontSize: 18),
                    hintText: allTranslations.text("meter.enter_notes_hint"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: shouldDisableFab ? Colors.grey : Colors.blueGrey,
        onPressed: shouldDisableFab
            ? null
            : () {
                FocusScope.of(context).unfocus();
                setState(() {
                  var isNewRecord = happinessRecord == null;
                  happinessRecord = HappinessRecord(
                      isNewRecord
                          ? DateTime.now().millisecondsSinceEpoch
                          : happinessRecord.date,
                      blueValue,
                      greenValue,
                      yellowValue,
                      redValue,
                      average,
                      textController.text);

                  if (!isNewRecord) {
                    _updateRecord();

                    _showSnackBar(
                        context, allTranslations.text("meter.updated"));
                  } else {
                    _insertRecord();

                    _showSnackBar(
                        context, allTranslations.text("meter.recorded"));
                  }
                  shouldDisableFab = true;
                });
              },
        icon: Icon(Icons.save),
        label: Text(''),
      ),
    );
  }

  void _insertRecord() async {
    recordId = await DatabaseHelper.instance.insert(happinessRecord);
  }

  void _updateRecord() async {
    setState(() {
      DatabaseHelper.instance.update(happinessRecord, recordId);
    });
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
}

void _showSnackBar(dynamic context, String msg) {
  Scaffold.of(context).showSnackBar(
      SnackBar(duration: Duration(seconds: 1), content: Text(msg)));
}
