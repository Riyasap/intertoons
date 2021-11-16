import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intertoons/core/http_service/http_services.dart';
import 'package:intertoons/core/http_service/rest/rest_client.dart';
import 'package:intertoons/screen/home/home_model.dart';

import 'package:meta/meta.dart';
import 'home_response_model.dart';


enum RequestStatus { initial, requesting, success, error }

@immutable
class HomeControllerState {
  final Exception? exception;
  final RequestStatus requestStatus;

  const HomeControllerState(this.requestStatus, this.exception);
}
class HomeState extends HomeControllerState {
  final List<HomeModel>? response;
  //final List<HomeModel>? productList;
  const HomeState(
      RequestStatus requestStatus, {
        this.response,
       // this.productList,
        Exception? exception,
      }) : super(requestStatus, exception);
}

//List<Data> productList = [];

//final productProvider = Provider<List<Data>>((ref) => productList);

final homeController =StateNotifierProvider<HomeController,HomeControllerState>((ref) => HomeController(
  ref.read(dioProvider),));

class HomeController extends StateNotifier<HomeControllerState>{


  final Dio _dio;
  //final StateNotifierProviderRef ref;

  HomeController(this._dio): super(const HomeState(RequestStatus.initial));

  Future<void> getHome() async {
    state = HomeState(RequestStatus.requesting);


    try {
      final response = await _dio.get('homepage');
      final data= json.decode(response.data);
      final test = (data as List).map((e) => HomeModel.fromJson(e)).toList();

      state = HomeState(RequestStatus.success,response:test);

    }
    on DioError catch(dioError) {
      print(dioError.error);
      print("dioError");
    }

    catch (e){
      print('error ~~~~~: $e');
      state = HomeState(RequestStatus.error,exception: e as Exception);
    }
  }
}