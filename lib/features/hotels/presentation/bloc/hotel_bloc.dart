import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_hotels.dart';
import 'hotel_event.dart';
import 'hotel_state.dart';
import '../../../../core/usecases/usecase.dart';


class HotelBloc extends Bloc<HotelEvent, HotelState> {
  final GetHotels getHotels;

  HotelBloc({required this.getHotels}) : super(HotelInitial()) {
    on<LoadHotelsEvent>((event, emit) async {
      emit(HotelLoading());
      final result = await getHotels(NoParams());
      result.fold(
            (failure) => emit(HotelError(failure.message)),
            (hotels) => emit(HotelLoaded(hotels)),
      );
    });
  }
}
