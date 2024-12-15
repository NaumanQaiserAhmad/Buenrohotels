import 'dart:convert';
import '../models/hotel_model.dart';
import '../../domain/entities/hotel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesRepository {
  static const _favoritesKey = 'favorites';

  Future<void> saveFavoriteHotel(Hotel hotel) async {
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
    favorites.add(hotelModel);

    final encoded = jsonEncode(favorites.map((e) => e.toJson()).toList());
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
      return jsonList.map((e) => HotelModel.fromJson(e)).toList();
    }

    return [];
  }
}
