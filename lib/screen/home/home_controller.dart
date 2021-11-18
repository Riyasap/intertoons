import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intertoons/core/http_service/http_services.dart';
import 'package:intertoons/screen/home/home_model.dart';
import 'package:intertoons/screen/product_details/product_response_model.dart';

import 'package:meta/meta.dart';

enum RequestStatus { initial, requesting, success, error }

@immutable
class HomeControllerState {
  final Exception? exception;
  final RequestStatus requestStatus;

  const HomeControllerState(this.requestStatus, this.exception);
}

class HomeState extends HomeControllerState {
  final List<HomeModel>? response;
  const HomeState(
    RequestStatus requestStatus, {
    this.response,
    Exception? exception,
  }) : super(requestStatus, exception);
}

class ProductState extends HomeControllerState {
  final ProductResponseModel? response;

  const ProductState(
    RequestStatus requestStatus, {
    this.response,
    Exception? exception,
  }) : super(requestStatus, exception);
}

List<ProductResponseModel> cartProducts = [];

final productCartProvider =
    Provider<List<ProductResponseModel>>((ref) => cartProducts);

double totalAmount = 0.0;

final amountProvider = Provider<double>((ref) => totalAmount);

final homeController =
    StateNotifierProvider<HomeController, HomeControllerState>(
        (ref) => HomeController(
              ref.read(dioProvider),
            ));

class HomeController extends StateNotifier<HomeControllerState> {
  final Dio _dio;

  HomeController(this._dio) : super(const HomeState(RequestStatus.initial));

  Future<void> getHome() async {
    state = const HomeState(RequestStatus.requesting);

    try {
      final response = await _dio.get('homepage');
      final data = json.decode(response.data);
      final test = (data as List).map((e) => HomeModel.fromJson(e)).toList();

      state = HomeState(RequestStatus.success, response: test);
    } on DioError catch (dioError) {
      print(dioError.error);
      print("dioError");
    } catch (e) {
      print('error ~~~~~: $e');
      state = HomeState(RequestStatus.error, exception: e as Exception);
    }
  }

  Future<void> getProductDetails(int id) async {
    state = const ProductState(RequestStatus.requesting);
    try {
      final response = await _dio.get("productdetails?id=$id");
      final test = json.decode(response.toString());
      final data = ProductResponseModel.fromJson(test);
      print(data.runtimeType);

      state = ProductState(RequestStatus.success, response: data);
    } on DioError catch (dioError) {
      print(dioError.error);
      print("dioError");
    } catch (e) {
      print('error ~~~~~: $e');
      state = HomeState(RequestStatus.error, exception: e as Exception);
    }
  }
}
