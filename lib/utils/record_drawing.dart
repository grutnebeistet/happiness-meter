import 'package:flutter/material.dart';
import 'package:happiness_meter/data/database_helpers.dart';
import 'package:happiness_meter/model/record.dart';
import 'package:happiness_meter/theme/app_colors.dart';

// const double COL_HEIGHT = 110.0;
// const double COL_WIDTH = 35.0;

// class ResultCylinder extends StatelessWidget {
//   final color;
//   final bgColor;
//   final value;

//   ResultCylinder(this.color, this.bgColor, this.value);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       // width: COL_HEIGHT,
//       // height: COL_WIDTH,
//       child: LinearProgressIndicator(
//         backgroundColor: bgColor,
//         value: value / 10,
//         valueColor: AlwaysStoppedAnimation(color),
// //
//       ),
//     );
//   }
// }

class GraphPainter extends CustomPainter {
  final HappinessRecord dbRecord;

  GraphPainter(this.dbRecord) {
    //  debugPrint('GraphPainter id ${dbRecord.id} - B: ${dbRecord.blueValue} - G: ${dbRecord.greenValue} - Y: ${dbRecord.yellowValue}');
  }

  @override
  void paint(Canvas canvas, Size size) {
    List sliderVals = [
      Record(size.height * dbRecord.blueValue / 10, AppColors.colorBlue,
          AppColors.colorBlueInactive),
      Record(size.height / 10 * dbRecord.greenValue,
          AppColors.colorGreen, AppColors.colorGreenInactive),
      Record(size.height / 10 * dbRecord.yellowValue, AppColors.colorYellow,
          AppColors.colorYellowInactive),
      Record(size.height / 10 * dbRecord.redValue, AppColors.colorRed,
          AppColors.colorRedInactive),
    ];
    double origin = 22;

    for (int i = 0; i < sliderVals.length; i++) {
      Record record = sliderVals[i];

      // foreground
      Paint trackBarPaint = Paint()
        ..color = record.color
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeWidth = 12;

      //background
      Paint trackPaint = Paint()
        ..color = Color(0xffdee6f1)
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeWidth = 12;

      Path trackBarPath = Path();
      Path trackPath = Path();

      trackPath.moveTo(origin, 0);
      trackPath.lineTo(origin, size.height);

      trackBarPath.moveTo(origin, size.height);
      if (record.value > 0) {
        trackBarPath.lineTo(origin, size.height - record.value);
      }
      origin = origin + size.width * 0.16;

      canvas.drawPath(trackPath, trackPaint);
      canvas.drawPath(trackBarPath, trackBarPaint);
    }

    // Total HQ
    Path trackBarHQ = Path();
    Path trackHQ = Path();
    var originHQ = origin + 14;
    // foreground
    Paint trackBarPaintHQ = Paint()
      ..color = AppColors.colorOrange
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 18;

    //background
    Paint trackPaintHQ = Paint()
      ..color = Color(0xffdee6f1)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 18;

    trackHQ.moveTo(originHQ, 0);
    trackHQ.lineTo(originHQ, size.height);
    trackBarHQ.moveTo(originHQ, size.height);
    if (dbRecord.totalHQ > 0)
      trackBarHQ.lineTo(
          originHQ, size.height - size.height * dbRecord.totalHQ / 10);

    debugPrint(
        "GraphPaint: totalHQ: ${dbRecord.totalHQ}  blue: ${dbRecord.blueValue}");
    canvas.drawPath(trackHQ, trackPaintHQ);
    canvas.drawPath(trackBarHQ, trackBarPaintHQ);

// Total HQ
  }

  @override
  bool shouldRepaint(GraphPainter oldDelegate) =>
      oldDelegate.dbRecord != dbRecord;
}
