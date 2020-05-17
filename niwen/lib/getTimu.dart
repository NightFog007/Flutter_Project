import 'package:dio/dio.dart';


class GetTimu {


void getHttp() async {
  try {
    Response response = await Dio().get("http://api.tianapi.com/txapi/baiketiku/index?key=ca4f25b93495f1001c3a81dd9972b89c");
    print(response);
  } catch (e) {
    print(e);
  }
}
}

