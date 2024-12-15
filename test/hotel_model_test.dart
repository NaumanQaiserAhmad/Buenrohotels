import 'package:flutter_test/flutter_test.dart';
import 'package:hotel_booking_app/features/hotels/data/models/hotel_model.dart';


void main() {
  group('HotelModel', () {
    test('fromJson creates a valid HotelModel from valid JSON', () {
      const json = {
        'name': 'Test Hotel',
        'rate_per_night': {'extracted_lowest': 120.0},
        'overall_rating': 4.5,
        'images': [
          {'thumbnail': 'http://example.com/image.jpg'}
        ],
        'link': 'http://example.com',
        'description': 'A test hotel description',
      };

      final hotelModel = HotelModel.fromJson(json);

      expect(hotelModel.name, 'Test Hotel');
      expect(hotelModel.price, 120.0);
      expect(hotelModel.rating, 4.5);
      expect(hotelModel.image, 'http://example.com/image.jpg');
      expect(hotelModel.link, 'http://example.com');
      expect(hotelModel.description, 'A test hotel description');
    });

    test('fromJson handles missing optional fields gracefully', () {
      const json = {
        'name': 'Test Hotel',
        'rate_per_night': {'extracted_lowest': 150.0},
      };

      final hotelModel = HotelModel.fromJson(json);

      expect(hotelModel.name, 'Test Hotel');
      expect(hotelModel.price, 150.0);
      expect(hotelModel.rating, 0.0); // Default value
      expect(hotelModel.image, isNull);
      expect(hotelModel.link, '');
      expect(hotelModel.description, 'No description available'); // Default value
    });

    test('toJson generates valid JSON from HotelModel', () {
      const hotelModel = HotelModel(
        name: 'Test Hotel',
        price: 120.0,
        rating: 4.5,
        image: 'http://example.com/image.jpg',
        link: 'http://example.com',
        description: 'A test hotel description',
      );

      final json = hotelModel.toJson();

      expect(json['name'], 'Test Hotel');
      expect(json['rate_per_night']['extracted_lowest'], 120.0);
      expect(json['overall_rating'], 4.5);
      expect(json['images'][0]['thumbnail'], 'http://example.com/image.jpg');
      expect(json['link'], 'http://example.com');
      expect(json['description'], 'A test hotel description');
    });

    test('toJson serializes to correct JSON', () {
      const hotelModel = HotelModel(
        name: 'Test Hotel',
        price: 0.0, // Edge case for price
        rating: 4.5,
        image: 'http://example.com/image.jpg',
        link: 'http://example.com',
        description: 'A test hotel description',
      );

      final json = hotelModel.toJson();

      expect(json, {
        'name': 'Test Hotel',
        'rate_per_night': {'extracted_lowest': 0.0},
        'overall_rating': 4.5,
        'images': [
          {'thumbnail': 'http://example.com/image.jpg'}
        ],
        'link': 'http://example.com',
        'description': 'A test hotel description',
      });
    });
  });
}
