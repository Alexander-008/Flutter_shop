//对dio进行二次封装
import 'package:dio/dio.dart';
import 'package:hm_shop/constant/index.dart';

class DioRequest {
  final _dio = Dio(); //实例化dio
  //构造函数
  DioRequest() {
    _configDio();
  }
  //配置dio
  _configDio() {
    _dio.options
      ..baseUrl = GlobalConstants.BASE_URL
      ..connectTimeout = Duration(seconds: GlobalConstants.TIME_OUT)
      ..receiveTimeout = Duration(seconds: GlobalConstants.TIME_OUT);
    // ...sendTimeout=GlobalConstants.TIME_OUT,
    _interceptors();
  }

  //拦截器
  void _interceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        //请求拦截器
        onRequest: (options, handler) {
          return handler.next(options);
        },
        //响应拦截器
        onResponse: (response, handler) {
          //200到300之间的状态码表示请求成功
          if (response.statusCode! >= 200 && response.statusCode! < 300) {
            return handler.next(response);
          }
          //抛出异常
          handler.reject(DioException(requestOptions: response.requestOptions));
        },
        //错误拦截器
        onError: (error, handler) {
          return handler.reject(error); //抛出异常
        },
      ),
    );
  }

  //get请求
  Future<dynamic> get(String url, {Map<String, dynamic>? params}) async {
    return await _handleResponse(await _dio.get(url, queryParameters: params));
  }

  //进一步处理返回结果的函数
  Future<T> _handleResponse<T>(Response<T> response) async {
    try {
      Response<T> res = await response;
      final data = res.data as Map<String, dynamic>;
      if (data['code'] == GlobalConstants.SUCCESS_CODE) {
        //HTTP 状态和业务状态均正常，就可以正常的放行通过
        return data['result'];
      } else {
        // throw DioException(requestOptions: res.requestOptions);
        throw Exception(data['msg'] ?? '请求失败');
      }
    } catch (e) {
      rethrow;
    }
  }

  //post请求
  post(String url, {Map<String, dynamic>? params}) async {
    return await _dio.post(url, data: params);
  }

  //更新请求
  put(String url, {Map<String, dynamic>? params}) async {
    return await _dio.put(url, data: params);
  }

  //删除请求
  delete(String url, {Map<String, dynamic>? params}) async {
    return await _dio.delete(url, data: params);
  }
}

final dioRequest = DioRequest(); //实例化dioRequest
//Dio 请求工具发出请求，返回的数据是Response<dynamic>.data;
//把所有的接口 data 解放出来，拿到真正的数据。要判断业务状态码是不是等于 1
