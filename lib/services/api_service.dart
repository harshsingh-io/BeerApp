import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/beer_model.dart';
import '../utils/constants.dart';

class ApiService {
  Future<List<BeerModel>> fetchBeers() async {
    try {
      final response =
          await http.get(Uri.parse('${Constants.apiBaseUrl}beers'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final List<BeerModel> beers =
            data.map((json) => BeerModel.fromJson(json)).toList();
        return beers;
      } else {
        print('Failed to load beers. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to load beers');
      }
    } catch (e) {
      print('Error during API request: $e');
      throw Exception('Failed to load beers');
    }
  }

  Future<BeerModel> fetchBeerDetails(int beerId) async {
    try {
      final response =
          await http.get(Uri.parse('${Constants.apiBaseUrl}beers/$beerId'));

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body)[0];
        BeerModel beer = BeerModel.fromJson(data);
        return beer;
      } else {
        print(
            'Failed to load beer details. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to load beer details');
      }
    } catch (e) {
      print('Error during API request: $e');
      throw Exception('Failed to load beer details');
    }
  }
}
