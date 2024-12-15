import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/hotel_model.dart';

abstract class HotelRemoteDataSource {
  Future<List<HotelModel>> getHotels();
}

class HotelRemoteDataSourceImpl implements HotelRemoteDataSource {
  final http.Client client;

  HotelRemoteDataSourceImpl(this.client);

  @override
  Future<List<HotelModel>> getHotels() async {
    // Query parameters
    final Map<String, String> parameters = {
      "engine": "google_hotels",
      "q": "Bali Resorts",
      "check_in_date": "2024-12-16",
      "check_out_date": "2024-12-17",
      "adults": "2",
      "currency": "USD",
      "gl": "us",
      "hl": "es",
      "api_key": "4fe05815942694184c2bc31f0ec93a49d2ed4ffb5ffede8d7582932f610f2132"
    };

    // Base URL
    final Uri url = Uri.https('serpapi.com', '/search.json', parameters);

    try {
      final response = await client.get(url);

      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> properties = data['properties'] ?? [];

        return properties.map((json) => HotelModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch hotels: ${response.reasonPhrase}');
      }
    } catch (e, stackTrace) {
      print('Error in HotelRemoteDataSourceImpl: $e');
      print(stackTrace);
      rethrow;
    }
  }
}
