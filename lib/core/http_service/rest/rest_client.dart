import 'dart:async';

import 'package:dio/dio.dart';
import 'package:intertoons/screen/home/home_model.dart';

import 'package:retrofit/retrofit.dart';

part 'rest_client.g.dart';


@RestApi(baseUrl:"http://omanphone.smsoman.com/api/")
abstract class RestClient {
  factory RestClient(Dio dio, {required String baseUrl}) = _RestClient;

  @GET('homepage')
  Future<List<HomeModel>> getHome();
}