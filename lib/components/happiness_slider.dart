import 'package:flutter/material.dart';
import 'package:happiness_meter/components/custom_slider_thumb.dart';
import 'package:happiness_meter/components/custom_slider_track.dart';
import 'package:happiness_meter/utils/record_drawing.dart';

class HappinessSlider extends StatefulWidget {
  final primaryColor;
  final inactiveColor;
  final sliderTitle;
  final startValue;

  final ValueChanged<double> parentAction;

  HappinessSlider(this.sliderTitle, this.primaryColor, this.inactiveColor,
      this.startValue, this.parentAction);

  @override
  State<StatefulWidget> createState() {
    return _HappinessSliderState(
        sliderTitle, primaryColor, inactiveColor, startValue);
  }
}

class _HappinessSliderState extends State<HappinessSlider> {
  final sliderHeight = 400.0;
  var primaryColor;
  var inactiveColor;
  var sliderTitle;
  var value;

  _HappinessSliderState(
      this.sliderTitle, this.primaryColor, this.inactiveColor, this.value);

  void updateValue(double newValue) {
    setState(() {
      value = newValue;
      widget.parentAction(newValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10.0),
        shadowColor: inactiveColor,
        child: Container(
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
                      ),
                    ),
                  ),
                  _thumbSlider(),
                  // widget.parentAction == null ? _graphSlider() : _thumbSlider()
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Container _graphSlider() {
  //   return Container(
  //     height: height,
  //     child: CustomPaint(
  //       foregroundPainter:
  //           GraphPainterDetails(value, primaryColor, inactiveColor),
  //     ),
  //   );
  // }

  Expanded _thumbSlider() {
    return Expanded(
      child: Container(
        color: Colors.transparent,
        child: SliderTheme(
          data: SliderTheme.of(context).copyWith(
            overlayColor: Colors.transparent,
            activeTrackColor: primaryColor,
            inactiveTrackColor: inactiveColor,
            trackHeight: 10.0,
            inactiveTickMarkColor: inactiveColor,
            activeTickMarkColor: inactiveColor,
            // trackShape: CustomSliderTrack(),
            thumbShape: CustomSliderThumb(),
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
          ),
        ),
      ),
    );
  }
}
