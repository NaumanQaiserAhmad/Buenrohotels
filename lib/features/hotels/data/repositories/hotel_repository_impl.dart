import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/hotel.dart';
import '../../domain/repositories/hotel_repository.dart';
import '../datasources/hotel_remote_datasource.dart';

class HotelRepositoryImpl implements HotelRepository {
  final HotelRemoteDataSource remoteDataSource;

  HotelRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<Hotel>>> getHotels() async {
    try {
      final hotels = await remoteDataSource.getHotels();
      return Right(hotels);
    } catch (e) {
      return Left(ServerFailure('Failed to fetch hotels'));
    }
  }
}
