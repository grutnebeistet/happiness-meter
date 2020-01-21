import 'package:flutter/material.dart';
import 'package:happiness_meter/components/happiness_slider.dart';
import 'package:happiness_meter/components/record_cylinder.dart';
import 'package:happiness_meter/data/database_helpers.dart';
import 'package:happiness_meter/model/record.dart';
import 'package:happiness_meter/theme/app_colors.dart';

class GraphPainter extends CustomPainter {
  // final HappinessRecord dbRecord;
  final double value;
  final Color primaryColor;
  final Color inactiveColor;
  final double strokeWidth;


  GraphPainter(
      this.value, this.primaryColor, this.inactiveColor, this.strokeWidth) {
    //  debugPrint('GraphPainter id ${dbRecord.id} - B: ${dbRecord.blueValue} - G: ${dbRecord.greenValue} - Y: ${dbRecord.yellowValue}');
  }

  @override
  void paint(Canvas canvas, Size size) {
    // double origin = 0;

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
  bool shouldRepaint(GraphPainter oldDelegate) =>
      oldDelegate.value != value;
}

Container buildResultGraph(HappinessRecord record) {
  return Container(
    child: Column(children: <Widget>[
      Container(
        height: 22,
        width: double.infinity,
        margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: LinearProgressIndicator(
          backgroundColor: AppColors.colorOrangeInactive,
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.colorOrange),
          value: record.totalHQ / 10,
        ),
      ),
      Container(
        width: double.infinity,
        height: 25,
        padding: EdgeInsets.fromLTRB(20, 2, 16, 0),
        child: FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(
            "0       1       2       3       4       5       6       7       8       9       10",
            textAlign: TextAlign.center,
          ),
        ),
      ),
      SizedBox(
        height: 16,
      ),
      // _buildGraphContainer(record, false),
      Container(
        child: Align(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                // TODO try set height and use fromHeight in
                margin: EdgeInsets.all(10),
                child: HappinessCylinder("PERCEPTIE", AppColors.colorBlue,
                    AppColors.colorBlueInactive, record.blueValue,HappinessCylinder.detailsCylindeHeight),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: HappinessCylinder("ACCEPTATIE", AppColors.colorGreen,
                    AppColors.colorGreenInactive, record.greenValue, HappinessCylinder.detailsCylindeHeight),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: HappinessCylinder("VISIE", AppColors.colorYellow,
                    AppColors.colorYellowInactive, record.yellowValue, HappinessCylinder.detailsCylindeHeight),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: HappinessCylinder("ACTIE", AppColors.colorRed,
                    AppColors.colorRedInactive, record.redValue, HappinessCylinder.detailsCylindeHeight),
              ),
            ],
          ),
          // alignment: Alignment.topCenter,
        ),
      ),
    ]),
  );
}

Container buildListResultGraph(HappinessRecord record, double height) {
  return Container(
    // color: Colors.blue,
    child: Column(children: <Widget>[
      Container(
        // color: Colors.blue,
        height: 12,
        // alignment: Alignment.center,
        margin: EdgeInsets.fromLTRB(8, 10, 8, 8),
        width: double.infinity,
        child: LinearProgressIndicator(
          backgroundColor: AppColors.colorOrangeInactive,
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.colorOrange),
          value: record.totalHQ / 10,
        ),
      ),

      // _buildGraphContainer(record, true),
      Container(
        child: Align(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(5),
                child: HappinessCylinder("PERCEPTIE", AppColors.colorBlue,
                    AppColors.colorBlueInactive, record.blueValue, height),
              ),
              Container(
                margin: EdgeInsets.all(5),
                child: HappinessCylinder("ACCEPTATIE", AppColors.colorGreen,
                    AppColors.colorGreenInactive, record.greenValue, height),
              ),
              Container(
                margin: EdgeInsets.all(5),
                child: HappinessCylinder("VISIE", AppColors.colorYellow,
                    AppColors.colorYellowInactive, record.yellowValue, height),
              ),
              Container(
                margin: EdgeInsets.all(5),
                child: HappinessCylinder("ACTIE", AppColors.colorRed,
                    AppColors.colorRedInactive, record.redValue, height),
              ),
            ],
          ),
          // alignment: Alignment.topCenter,
        ),
      ),
      // if (record.situation.isNotEmpty)
      //   Container(
      //     // padding: EdgeInsets.all(20),
      //     margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
      //     alignment: Alignment.topLeft,
      //     decoration: BoxDecoration(
      //       border: Border.all(color: Colors.blueGrey, width: 3),
      //     ),
      //     child: Text(
      //       record.situation,
      //       style: TextStyle(
      //         fontSize: 24,
      //       ),
      //     ),
      //   ),
    ]),
  );
}

// Container _buildGraphContainer(HappinessRecord record, double height){
//     return Container(
//           child: Align(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 Container(
//                   margin: EdgeInsets.all(10),
//                   child: HappinessCylinder("PERCEPTIE", AppColors.colorBlue,
//                       AppColors.colorBlueInactive, record.blueValue, height),
//                 ),
//                 Container(
//                   margin: EdgeInsets.all(10),
//                   child: HappinessCylinder("ACCEPTATIE", AppColors.colorGreen,
//                       AppColors.colorGreenInactive, record.greenValue, height),
//                 ),
//                 Container(
//                   margin: EdgeInsets.all(10),
//                   child: HappinessCylinder("VISIE", AppColors.colorYellow,
//                       AppColors.colorYellowInactive, record.yellowValue, height),
//                 ),
//                 Container(
//                   margin: EdgeInsets.all(10),
//                   child: HappinessCylinder("ACTIE", AppColors.colorRed,
//                       AppColors.colorRedInactive, record.redValue, height),
//                 ),
//               ],
//             ),
//             // alignment: Alignment.topCenter,
//           ),
//         );
// }
