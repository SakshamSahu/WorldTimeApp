import 'dart:convert';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class WorldTime{

  late String location; // location name for the ui
  late String time; // the time in that ui
  late String url; // location url for api endpoint
  late String flag;// url for an asset flag icon
  late bool isdaytime;//true or false if daytime or not

  WorldTime({required this.location,required this.flag,required this.url});

  Future<void> getTime() async {

    try {
      //make the request
      Response response = await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);
      //print(data);

      //get properties from data
      String datetime = data['datetime'].toString();
      String offset = data['utc_offset'].substring(1,3).toString();
      //print(datetime);
      //print(offset);

      //create datetime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      // set the time property
      isdaytime = now.hour >6 && now.hour<19 ? true : false;
      time =DateFormat.jm().format(now);
    }
    catch(e){
      print('caught error $e');
      time='Could not get time data';
    }

  }
}
