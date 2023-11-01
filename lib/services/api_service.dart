import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oneid_mobile_app/theme/colors.dart';
import 'package:oneid_mobile_app/util/constants.dart';

import 'auth_service.dart';

class ApiService extends GetConnect {
  final AuthService _authService =
      Get.find(); // Get a reference to the AuthService

  @override
  void onInit() {
    super.onInit();
    httpClient.baseUrl = baseUrl;
    httpClient.timeout = const Duration(seconds: 10);
  }

  // Function to send a GET request
  Future<Response<T>> sendGetRequest<T>(
    bool isAuthRequired,
    String endpoint, {
    Map<String, String>? headers = const {
      'Content-Type': 'application/json',
    },
    Map<String, dynamic>? query = const {},
    T Function(dynamic)? decoder,
  }) async {
    try {
      final response = await get(
        baseUrl + endpoint,
        headers: {
          ...headers ?? {},
          // Keep any existing headers
          if (isAuthRequired)
            'Authorization': 'Bearer ${_authService.getBearerToken()}',
          // Add the bearer token header
        },
        query: query,
        decoder: decoder,
      );

      if (kDebugMode) {
        print(response);
      }

      if (response.statusCode == 401) {
        throw ForceLogoutException("Error: 401 Unauthorized");
      }

      return response;
    } catch (error) {
      _handleError(error);
      rethrow;
    }
  }

  // Function to send a POST request
  Future<Response<T>?> sendPostRequest<T>(
    bool isAuthRequired,
    String endpoint, {
    dynamic data,
    Map<String, String>? headers = const {
      'Content-Type': 'application/json',
    },
    Map<String, dynamic>? query = const {},
    T Function(dynamic)? decoder,
  }) async {
    try {
      final response = await post(
        baseUrl + endpoint,
        data,
        headers: {
          ...headers ?? {},
          // Keep any existing headers
          if (isAuthRequired)
            'Authorization': 'Bearer ${_authService.getBearerToken()}',
          // Add the bearer token header
        },
        query: query,
        decoder: decoder,
      );

      if (kDebugMode) {
        print(response.statusCode);
      }

      if (response.statusCode == null) {
        throw Exception("No response, check your internet connection");
      }
      //
      // if (response.statusCode == 400) {
      //   throw Exception("Please check your inputs");
      // }

      if (response.statusCode == 401) {
        throw ForceLogoutException("Unauthorized");
      }

      return response;
    } catch (error) {
      _handleError(error);
      // rethrow;
      return null;
    }
  }

  void _handleError(dynamic error) {
    if (error is SocketException) {
      // Handle network/socket errors
      Get.snackbar(
        'Error',
        'Network error occurred',
        colorText: OneIDColor.white,
      );
    } else if (error is TimeoutException) {
      // Handle timeout errors
      Get.snackbar(
        'Error',
        'Request timed out',
        colorText: OneIDColor.white,
      );
    } else {
      if (kDebugMode) {
        print(error);
      }
      // Handle other errors

      Get.snackbar(
        'Error',
        error.toString().replaceAll('Exception: ', ''),
        backgroundColor: Colors.black.withOpacity(0.7),
        colorText: OneIDColor.white,
      );

      // Check if the error indicates a need for force logout
      if (error is ForceLogoutException) {
        _authService.forceLogout();
      }
    }
  }
}

class ForceLogoutException implements Exception {
  final String message;

  ForceLogoutException(this.message);

  @override
  String toString() {
    return 'ForceLogoutException: $message';
  }
}
