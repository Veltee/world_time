import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart'; //for formatting date

class WorldTime {
  String location; //location name for the UI
  String time; //the time in that location
  String flag; //url to an asset flag icon
  var url; //location url for API endpoint
  bool isDayTime; //true if its daytime

  WorldTime({
    this.location,
    this.flag,
    this.url
  });

  Future<void> getTime() async{
    try{
      var urlr = "http://worldtimeapi.org/api/timezone/$url";
      var response = await http.get(Uri.parse(urlr));

      Map data = json.decode(response.body);
      //print(data);

      //get properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3);
      // print(datetime);
      // print(offset);

      //create DateTime Obejct
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));
      print(now);

      isDayTime = now.hour > 6 && now.hour < 18 ? true : false;
      time = DateFormat.jm().format(now);

      //time = now.toString(); //set the time property
    }
    catch(e){
      print('caught error: $e');
      time = 'could not get time data';
    }

  }

}

