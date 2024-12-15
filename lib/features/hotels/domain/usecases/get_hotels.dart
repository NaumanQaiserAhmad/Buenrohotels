import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/hotel.dart';
import '../repositories/hotel_repository.dart';

class GetHotels extends UseCase<List<Hotel>, NoParams> {
  final HotelRepository repository;

  GetHotels(this.repository);

  @override
  Future<Either<Failure, List<Hotel>>> call(NoParams params) async {
    return await repository.getHotels();
  }
}
