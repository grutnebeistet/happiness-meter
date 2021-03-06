import 'package:happiness_meter/global_translations.dart';
import 'package:intl/intl.dart';

class DateUtils{
 static String getPrettyDate(int date){
  //  return DateFormat.yMMMMEEEEd(allTranslations.locale.toString())
   return DateFormat.yMMMEd(allTranslations.locale.toString())
                                              .format(DateTime.fromMillisecondsSinceEpoch(date))
                                              .toString();
  }
   static String getPrettyDateAndTime(int date){
   return DateFormat.yMMMEd(allTranslations.locale.toString())
                                              .add_jm()
                                              .format(DateTime.fromMillisecondsSinceEpoch(date))
                                              .toString();
  }
  static String getPrettyTime(int date){
    return DateFormat.Hm(allTranslations.locale.toString())
    .format(DateTime.fromMillisecondsSinceEpoch(date))
    .toString();
  }
}