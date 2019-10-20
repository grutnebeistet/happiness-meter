import 'package:flutter/material.dart';

class HappinessSlider extends StatefulWidget {
  var primaryColor;
  var inactiveColor;
  var sliderTitle;
  var value = 0.0;

  HappinessSlider(this.sliderTitle, this.primaryColor, this.inactiveColor);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HappinessSliderState(
        sliderTitle, primaryColor, inactiveColor, value);
  }
}

class _HappinessSliderState extends State<HappinessSlider> {
  final double sliderHeight = 420.0;
  final double sliderWidth = 70.0;
  var primaryColor;
  var inactiveColor;
  var sliderTitle;
  var value = 0.0;

  _HappinessSliderState(
      this.sliderTitle, this.primaryColor, this.inactiveColor, this.value);

  void updateValue(double newValue) {
    setState(() {
      value = newValue;

    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        color: Color(0xffE5E5E5),
        borderRadius: BorderRadius.circular(24.0),
        shadowColor: inactiveColor,
        child: Container(
          width: sliderWidth,
          height: sliderHeight,
          child: Row(
            children: <Widget>[
              Container(
                width: 1,
                child: Text(
                  sliderTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: primaryColor,
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
                          value.toInt().toString(),
                          style: TextStyle(color: primaryColor, fontSize: 24.0),
                        )),
                  ),
                  Expanded(
                    child: SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          activeTrackColor: primaryColor,
                          inactiveTrackColor: inactiveColor,
                          trackHeight: 10.0,
                          thumbColor: primaryColor,
                          inactiveTickMarkColor: inactiveColor,
                          activeTickMarkColor: primaryColor,
                          thumbShape:
                              RoundSliderThumbShape(enabledThumbRadius: 16.0),
                          overlayColor: Colors.purple.withAlpha(32),
                          overlayShape:
                              RoundSliderOverlayShape(overlayRadius: 14.0),
                        ),
                        child: RotatedBox(
                          quarterTurns: 3,
                          child: Slider(
                            min: 0.0,
                            max: 10.0,
                            divisions: 10,
                            value: value,
                            onChanged: (newValue) {
                              updateValue(newValue);
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
    );
  }
}
