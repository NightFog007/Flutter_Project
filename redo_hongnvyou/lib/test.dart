import 'package:dio/dio.dart';

String get_day (String theday) {
  
  // theday = "20170124";
  var year = theday.substring(0,4);
  var month = theday.substring(4,6);
  var day = theday.substring(6,8);

  // print(year);
  // print(month);
  // print(day);
   

    var d1 = new DateTime(int.parse(year),int.parse(month), int.parse(day));
var d2 = new DateTime(2019, 10, 10);

d2 =new DateTime.now();



var difference = d2.difference(d1);
var res = difference.inDays;
print(res);
  
 
 var fianl = "这是我们在一起的第"+res.toString()+"天.";

return  fianl;

}



void getHttp() async {
  try {
    // Response response = await Dio().get("https://api.lovelive.tools/api/SweetNothings/1/Serialization/Json");
    Response response = await Dio().get("https://www.mxnzp.com/api/weather/current/长沙市");
    // var tmp = response.data.toString();
    var tmp = response.data["data"];

    print("-------------");
    print(tmp);

    var tianqi = tmp["weather"];
    var wendu = tmp["temp"];
    var feng = tmp["windDirection"];
    var fengli = tmp["windPower"];
    var address = tmp["address"];
    var shidu = tmp["humidity"];
    var time = "";
    time =  tmp["reportTime"];
    time = time.substring(0,10);

    var final_text = time + "  " + address + "  " +  tianqi + "  " + feng+"风" + fengli + "  " + "当前温度:"+ wendu + "  " + "空气湿度:"+ shidu ;

    print(final_text);


  } catch (e) {
    print(e);
  }
}


void get_english() async {
try {
    Response response = await Dio().get("https://api.ooopn.com/ciba/api.php");
     var tmp = response.data["ciba"];
    var english = response.data["ciba-en"];

  } catch (e) {
    print(e);
  }
}



void main(){
  // getHttp();
//   var day = get_day("20191105");
  

// var jjd = new Test();
// jjd.tt = "3";

get_english();

}


class Test {
  var tt = "";
}



