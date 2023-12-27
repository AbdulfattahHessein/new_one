import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:new_one/src/models/Account.dart';
import 'package:new_one/src/models/ApiResponse.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "https://10.0.2.2:7060/api";
  Future<ApiResponse<Account>> getAllAccounts() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/Accounts'));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return ApiResponse.fromJson(jsonData, (json) => Account.fromJson(json));
      } else {
        throw HttpException(
            'API request failed with status code: ${response.statusCode}');
      }
    } on HttpException catch (error) {
      log('HTTP error: $error');
      rethrow;
    } on FormatException catch (error) {
      log('JSON parsing error: $error');
      rethrow;
    } catch (error) {
      log('Unexpected error: $error');
      rethrow;
    }
  }
}
