import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:riverpod/riverpod.dart';
import 'rest/rest_client.dart';


final dioProvider = Provider<Dio>(
      (ref) => Dio(
    BaseOptions(
      baseUrl: "http://omanphone.smsoman.com/api/",
      connectTimeout: 60000,
      receiveTimeout: 60000,
    ),
  )..interceptors.add(PrettyDioLogger()),
);
final restClientProvider = Provider<RestClient>(
      (ref) => RestClient(
    Dio(
      BaseOptions(
        baseUrl: "http://omanphone.smsoman.com/api/",
        connectTimeout: 60000,
        receiveTimeout: 60000,
      ),
    )
      ..interceptors.add(PrettyDioLogger()),
    baseUrl:"http://omanphone.smsoman.com/api/",
  ),
);