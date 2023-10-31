import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:oneid_mobile_app/util/constants.dart' as constants;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final int _timeout = 60;
  String _authCookie = "";

  Future<http.Response?> getData(String endpoint, bool isAuthorized) async {
    Uri uri = Uri.parse(constants.baseUrl + endpoint);

    try {
      http.Response response = await http
          .get(uri,
              headers:
                  isAuthorized ? await _setHeadersWithAuth() : _setHeaders())
          .timeout(Duration(seconds: _timeout));
      if (kDebugMode) {
        print(response.body);
      }
      // checkTokenExpiryAndForceLogout(response);
      return response;
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }

  Future<http.Response?> postData(
      data, String endpoint, bool isAuthorized) async {
    Uri uri = Uri.parse(constants.baseUrl + endpoint);
    try {
      http.Response response = await http
          .post(uri,
              body: data,
              headers:
                  isAuthorized ? await _setHeadersWithAuth() : _setHeaders())
          .timeout(Duration(seconds: _timeout));
      // if (endpoint == constants.loginEndpoint) updateCookie(response);
      if (kDebugMode) {
        print(data);
        print(response.body);
      }
      // checkTokenExpiryAndForceLogout(response);
      return response;
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }

  // void checkTokenExpiryAndForceLogout(http.Response response){
  //   if(response.statusCode == 401){
  //     print("Token expired !!!");
  //     Navigator.of(context, rootNavigator: true).push(
  //       MaterialPageRoute(
  //         builder: (context) => const SubmitTestimonialScreen(),
  //       ),
  //     );
  //     ExitAppDialog();
  //   }
  // }

  Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? "";
  }

  void updateCookie(http.Response response) {
    String? rawCookie = response.headers['set-cookie'];
    if (rawCookie != null) {
      _authCookie = rawCookie;
    }
  }

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };

  _setHeadersWithAuth() async => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${await getToken()}',
        'Cookie': _authCookie,
      };
}
