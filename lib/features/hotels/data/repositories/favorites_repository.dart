import 'dart:convert';
import '../models/hotel_model.dart';
import '../../domain/entities/hotel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesRepository {
  static const _favoritesKey = 'favorites';

  Future<void> saveFavoriteHotel(Hotel hotel) async {
    final hotelModel = HotelModel(
      name: hotel.name,
      price: hotel.price,
      rating: hotel.rating,
      image: hotel.image,
      link: hotel.link,
      description: hotel.description,
    );

    final prefs = await SharedPreferences.getInstance();
    final favorites = await getFavoriteHotels();

    // Check if the hotel already exists in favorites
    final existingIndex = favorites.indexWhere((element) => element.name == hotelModel.name);
    if (existingIndex != -1) {
      // Update the existing hotel entry
      favorites[existingIndex] = hotelModel;
    } else {
      // Add new hotel to favorites
      favorites.add(hotelModel);
    }

    final encoded = jsonEncode(favorites.map((e) => e.toJson()).toList());
    print('Encoded favorites to save: $encoded'); // Debug log

    await prefs.setString(_favoritesKey, encoded);
  }


  Future<void> removeFavoriteHotel(Hotel hotel) async {
    // Convert Hotel to HotelModel
    final hotelModel = HotelModel(
      name: hotel.name,
      price: hotel.price,
      rating: hotel.rating,
      image: hotel.image,
      link: hotel.link,
    );

    final prefs = await SharedPreferences.getInstance();
    final favorites = await getFavoriteHotels();
    favorites.removeWhere((element) => element.name == hotelModel.name);

    final encoded = jsonEncode(favorites.map((e) => e.toJson()).toList());
    await prefs.setString(_favoritesKey, encoded);
  }

  Future<List<HotelModel>> getFavoriteHotels() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_favoritesKey);

    if (jsonString != null) {
      final List<dynamic> jsonList = jsonDecode(jsonString);
      // Log the JSON before mapping
      print('Decoded JSON list: $jsonList');
      return jsonList.map((e) {
        print('Mapping JSON to HotelModel: $e'); // Log each item
        return HotelModel.fromJson(e);
      }).toList();
    }

    return [];
  }


}
