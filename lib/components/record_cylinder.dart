import 'package:flutter/material.dart';
import 'package:happiness_meter/utils/record_drawing.dart';

class HappinessCylinder extends StatelessWidget {
    static const double detailsCylindeHeight = 320.0;
  static const double listCylindeHeight = 120.0;
  final primaryColor;
  final inactiveColor;
  final value;
  final cylinderTitle;
  final double cylinderHeight;
  // final bool isListItem;

  double fontSize;
  // double cylinderWidth;
  EdgeInsets cylinderPadding;

  HappinessCylinder(this.cylinderTitle, this.primaryColor, this.inactiveColor,
      this.value, this.cylinderHeight) {
    fontSize = cylinderHeight == detailsCylindeHeight ? 24 : 10;
    cylinderPadding =
        cylinderHeight == detailsCylindeHeight  ?   EdgeInsets.only(right: 16, left: 16, bottom: 24):EdgeInsets.only(bottom: 8);
        // cylinderWidth = cylinderHeight == 400  ? 32 : 32;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: cylinderHeight,
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10.0),
        shadowColor: inactiveColor,
        child: Container(
          child: Row(
            children: <Widget>[
              Container(
                width: 1,
                child: Text(
                  cylinderTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: fontSize, //cylinderHeight / 16.6, //24,
                  ),
                ),
              ),
              Column(
                children: <Widget>[
                  Padding(
                    padding: cylinderPadding, //16.0),
                    child: Container(

                      alignment: Alignment.center,
                      width: 32,
                      child: Text(
                        value.toInt().toString(),
                        style: TextStyle(
                            color: primaryColor, fontSize: fontSize), //24.0),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      // height: 45,
                      child: CustomPaint(
                        foregroundPainter: GraphPainter(value,
                            primaryColor, inactiveColor, fontSize),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
