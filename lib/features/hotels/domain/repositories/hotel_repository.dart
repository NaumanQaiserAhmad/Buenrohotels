import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/hotel.dart';

abstract class HotelRepository {
  Future<Either<Failure, List<Hotel>>> getHotels();
}
