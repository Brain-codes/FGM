import 'package:FGM/auth/controllers/auth_controller.dart';
import 'package:FGM/shared/services/local_database_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http_interceptor/http_interceptor.dart';

class AuthorizationInterceptor implements InterceptorContract {
  // We need to intercept request
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    try {
      // Fetching token from your local data
      var token =
          LocalDatabaseService().getData(DbKeyStrings.loginToken).toString();

      // Clear previous header and update it with updated token
      data.headers.clear();
      data.headers['authorization'] = 'Bearer $token';
      data.headers['content-type'] = 'application/json';
    } catch (e) {
      print(e);
    }

    return data;
  }

  // Currently we do not have any need to intercept response
  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    return data;
  }
}

class ExpiredTokenRetryPolicy extends RetryPolicy {
  final AuthController _authController = Get.put(AuthController());
  //final BuildContext context = BuildContext();

  //Number of retry
  @override
  int maxRetryAttempts = 1;

  @override
  Future<bool> shouldAttemptRetryOnResponse(ResponseData response) async {
    //This is where we need to update our token on 401/403 response
    if (response.statusCode == 401 || response.statusCode == 403) {
      //Refresh your token here. Make refresh token method where you get new token from
      //API and set it to your local data
      await _authController.refreshToken(Get.context!);
      return true;
    }
    return false;
  }
}
