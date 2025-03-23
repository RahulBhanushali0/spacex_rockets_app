import 'dart:convert';
import 'package:http/http.dart' as http;

class SpaceXApiService {
  final String baseUrl = 'https://api.spacexdata.com/v4';

  Future<List<dynamic>> getRockets({int page = 1, int limit = 10}) async {
    // final response = await http.get(Uri.parse('$baseUrl/rockets?page=$page&limit=$limit'));
    final response = await http.get(Uri.parse('$baseUrl/rockets'));
    if (response.statusCode == 200) {
      print("getRockets API res   ${response.body}");
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load rockets');
    }
  }

  Future<dynamic> getRocketDetails(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/rockets/$id'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load rocket details');
    }
  }
}