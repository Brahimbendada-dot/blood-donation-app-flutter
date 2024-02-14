
import 'package:intl/intl.dart';

String formattedDate(timeStamp){
  var dateFromTimeStamp = DateTime.fromMicrosecondsSinceEpoch(timeStamp.seconds * 1000);
  return DateFormat('dd-MM-yyyy').format(dateFromTimeStamp);
}