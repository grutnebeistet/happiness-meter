import 'package:flutter/material.dart';
import 'package:happiness_meter/components/record_cylinder.dart';
import 'package:happiness_meter/data/database_helpers.dart';
import 'package:happiness_meter/theme/app_colors.dart';

class GraphPainter extends CustomPainter {
  final double value;
  final Color primaryColor;
  final Color inactiveColor;
  final double strokeWidth;

  GraphPainter(
      this.value, this.primaryColor, this.inactiveColor, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    // foreground
    Paint trackBarPaint = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;

    //background
    Paint trackPaint = Paint()
      ..color = inactiveColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;

    Path trackBarPath = Path();
    Path trackPath = Path();

    trackPath.moveTo(0, 0);
    trackPath.lineTo(0, size.height);

    trackBarPath.moveTo(0, size.height);
    if (value > 0) {
      trackBarPath.lineTo(0, size.height - (size.height * value / 10));
    }
    // origin = origin + size.width * 2.26;

    canvas.drawPath(trackPath, trackPaint);
    canvas.drawPath(trackBarPath, trackBarPaint);
  }

  @override
  bool shouldRepaint(GraphPainter oldDelegate) => oldDelegate.value != value;
}

Container buildResultGraph(HappinessRecord record, BuildContext context) {
  return Container(
    child: Column(children: <Widget>[
      Container(
        width: double.infinity,
        child: Row(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * 0.82,
              margin: EdgeInsets.only(right: 6),
              child: Column(children: <Widget>[
                Container(
                  height: 25,
                  width: double.infinity,
                  margin: EdgeInsets.fromLTRB(20, 20, 4, 0),
                  padding: EdgeInsets.only(top: 4.5, bottom: 1),
                  child: LinearProgressIndicator(
                    backgroundColor: AppColors.colorOrangeInactive,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(AppColors.colorOrange),
                    value: record.totalHQ / 10,
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 25,
                  padding: EdgeInsets.fromLTRB(20, 2, 0, 0),
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      "0       3       2       3       4       5       6       7       8       9       10",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ]),
            ),
            Text(
              record.totalHQ.toString(),
              style: TextStyle(fontSize: 27,
              fontWeight: FontWeight.bold,
                color: AppColors.colorOrange,
              ),
            ),
          ],
        ),
      ),
      SizedBox(
        height: 6,
      ),
      _buildCylinderContainer(
          record, HappinessCylinder.detailsCylindeHeight, 12),
    ]),
  );
}

class Context {}

Container buildListResultGraph(HappinessRecord record) {
  return Container(
    child: Column(children: <Widget>[
      Container(
        height: 12,
        margin: EdgeInsets.fromLTRB(8, 10, 8, 0),
        width: double.infinity,
        child: LinearProgressIndicator(
          backgroundColor: AppColors.colorOrangeInactive,
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.colorOrange),
          value: record.totalHQ / 10,
        ),
      ),
      _buildCylinderContainer(record, HappinessCylinder.listCylindeHeight, 5),
    ]),
  );
}

Container _buildCylinderContainer(
    HappinessRecord record, double height, double margin) {
  return Container(
    child: Align(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(margin),
            child: HappinessCylinder("PERCEPTIE", AppColors.colorBlue,
                AppColors.colorBlueInactive, record.blueValue, height),
          ),
          Container(
            margin: EdgeInsets.all(margin),
            child: HappinessCylinder("ACCEPTATIE", AppColors.colorGreen,
                AppColors.colorGreenInactive, record.greenValue, height),
          ),
          Container(
            margin: EdgeInsets.all(margin),
            child: HappinessCylinder("VISIE", AppColors.colorYellow,
                AppColors.colorYellowInactive, record.yellowValue, height),
          ),
          Container(
            margin: EdgeInsets.all(margin),
            child: HappinessCylinder("ACTIE", AppColors.colorRed,
                AppColors.colorRedInactive, record.redValue, height),
          ),
        ],
      ),
    ),
  );
}
