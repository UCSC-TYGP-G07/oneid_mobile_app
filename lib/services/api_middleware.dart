import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:oneid_mobile_app/services/snackbar_service.dart';

import 'api_service.dart';

enum RequestType { get, post }

class ApiMiddleware {
  final BuildContext context;
  final ApiService apiService = ApiService();

  ApiMiddleware(this.context);

  Future<http.Response?> sendRequest(
      {required RequestType requestType,
      required String endpoint,
      dynamic data}) async {
    const bool isAuthorized = false;
    http.Response? response;

    SnackBarService snackBarService = SnackBarService(context);

    switch (requestType) {
      case RequestType.get:
        response = await apiService.getData(endpoint, isAuthorized);
        break;
      case RequestType.post:
        response = await apiService.postData(data, endpoint, isAuthorized);
        break;
    }

    if (response != null) {
      return response;
    } else {
      snackBarService.showNoInternetMessage();
    }
    return null;
  }

  Future<http.Response?> sendRequestWithAuthorization(
      {required RequestType requestType,
      required String endpoint,
      dynamic data}) async {
    const bool isAuthorized = true;
    http.Response? response;

    switch (requestType) {
      case RequestType.get:
        response = await apiService.getData(endpoint, isAuthorized);
        break;
      case RequestType.post:
        response = await apiService.postData(data, endpoint, isAuthorized);
        break;
    }

    SnackBarService snackBarService = SnackBarService(context);

    if (response != null) {
      if (response.statusCode == 400) {
        snackBarService.showErrorMessage(
            content: "User authorization invalid, please login again");
      } else if (response.statusCode == 401) {
        snackBarService.showErrorMessage(
            content: "User authorization not found, please login again");
      }
      return response;
    } else {
      snackBarService.showNoInternetMessage();
    }
    return null;
  }
}
