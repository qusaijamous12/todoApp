import 'package:dio/dio.dart';

class DioHelper{
  static Dio ?dio;
  static init(){
    dio=Dio(
      BaseOptions(
        baseUrl:'https://student.valuxapps.com/api/' ,
        receiveDataWhenStatusError: true,
        // headers: {
        //   "lang":'ar',
        //   "Content-Type":'application/json'
        // }

      )
    );
  }
  static Future<Response> getData({
     Map<String,dynamic> ?query,
    required String path,
    String ?token,
    String lang='ar'
})async{
    dio!.options.headers={
      'Authorization':token??'',
      'lang':lang,
      "Content-Type":'application/json'

    };

    return await  dio!.get(
      path,
      queryParameters:query

    );
  }

  static Future<Response> PostData({
    required String path,
    Map<String,dynamic> ?query,
    required dynamic data,
    String ?token,
    String ?lang
})async{
    dio!.options.headers={
      'Authorization':token??'',
      'lang':lang,
      "Content-Type":'application/json'

    };
    return await dio!.post(
      path,
      queryParameters: query,
      data: data


    );
  }

}
//https://newsapi.org/
// v2/top-headlines?
// country=us&category=business&apiKey=7857d908aca74a29ac0f3d7059d58e25