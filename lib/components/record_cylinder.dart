import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:happiness_meter/utils/record_drawing.dart';

class HappinessCylinder extends StatelessWidget {
  static const double detailsCylindeHeight = 320.0;
  static const double listCylindeHeight = 135.0;
  final primaryColor;
  final inactiveColor;
  final value;
  final cylinderTitle;
  final double cylinderHeight;

  double _fontSize;
  EdgeInsets _cylinderPadding;

  HappinessCylinder(this.cylinderTitle, this.primaryColor, this.inactiveColor,
      this.value, this.cylinderHeight) {
    _fontSize = cylinderHeight == detailsCylindeHeight
        ? 16
        : 10; // TODO Refactor fontsize mess
    _cylinderPadding = cylinderHeight == detailsCylindeHeight
        ? EdgeInsets.only(right: 16, left: 16, bottom: 24)
        : EdgeInsets.only(bottom: 11, right: 2);
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
                    fontSize: cylinderHeight == detailsCylindeHeight
                        ? _fontSize * 1.4
                        : _fontSize,
                  ),
                ),
              ),
              Column(
                children: <Widget>[
                  Container(
                    margin: _cylinderPadding,
                    alignment: Alignment.center,
                    width: 32,
                    // child: AutoSizeText(
                    //   (value / 2).toString(),
                    //   style: TextStyle(fontSize: _fontSize),
                    //   minFontSize: 8,
                    //   stepGranularity: 1,
                    //   maxLines: 1,
                    // ),
                    child: Text(
                      // (value / 2).toString(),
                      (value).toInt().toString(),
                      maxLines: 1,
                      style:
                          TextStyle(color: primaryColor, fontSize: _fontSize),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: CustomPaint(
                        foregroundPainter: GraphPainter(
                            value,
                            primaryColor,
                            inactiveColor,
                            cylinderHeight == detailsCylindeHeight ? 30 : 14),
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
