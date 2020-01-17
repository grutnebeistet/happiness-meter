import 'package:flutter/material.dart';
import 'package:happiness_meter/data/database_helpers.dart';
import 'package:happiness_meter/model/record.dart';
import 'package:happiness_meter/theme/app_colors.dart';

const double COL_HEIGHT = 110.0;
const double COL_WIDTH = 35.0;

class ResultCylinder extends StatelessWidget {
  final color;
  final bgColor;
  final value;

  ResultCylinder(this.color, this.bgColor, this.value);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: COL_HEIGHT,
      height: COL_WIDTH,
      child: LinearProgressIndicator(
        backgroundColor: bgColor,
        value: value / 10,
        valueColor: AlwaysStoppedAnimation(color),
//
      ),
    );
  }
}

class GraphPainter extends CustomPainter {
  final HappinessRecord dbRecord;

  GraphPainter(this.dbRecord){
     debugPrint('GraphPainter id ${dbRecord.id} - B: ${dbRecord.blueValue} - G: ${dbRecord.greenValue} - Y: ${dbRecord.yellowValue}');
  }

  // foreground
  Paint trackBarPaint = Paint()
    ..color = Color(0xff818aab)
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round
    ..strokeWidth = 12;

  //background
  Paint trackPaint = Paint()
    ..color = Color(0xffdee6f1)
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round
    ..strokeWidth = 12;

  @override
  void paint(Canvas canvas, Size size) {
    List val = [
      Record(size.height * dbRecord.blueValue / 10, AppColors.colorBlue,
          AppColors.colorBlueInactive),
      Record(size.height / 10 * dbRecord.greenValue,
          AppColors.colorGreenInactive, AppColors.colorGreenInactive),
      Record(size.height / 10 * dbRecord.yellowValue, AppColors.colorGreen,
          AppColors.colorGreenInactive),
      Record(size.height / 10 * dbRecord.redValue, AppColors.colorRed,
          AppColors.colorRedInactive),
    ];
    double origin = 8;

    Path trackBarPath = Path();
    Path trackPath = Path();

    for (int i = 0; i < val.length; i++) {
      Record record = val[i];

      trackPath.moveTo(origin, 0);
      trackPath.lineTo(origin, size.height);

      trackBarPath.moveTo(origin, size.height);
      if (record.value > 0) {
        trackBarPath.lineTo(origin, 120 - record.value);
      }
      origin = origin + size.width * 0.18;
    }

    canvas.drawPath(trackPath, trackPaint);
    canvas.drawPath(trackBarPath, trackBarPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
