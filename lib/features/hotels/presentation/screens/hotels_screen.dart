import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/hotel_bloc.dart';
import '../bloc/hotel_state.dart';
import '../widgets/hotel_card.dart';

class HotelsScreen extends StatelessWidget {
  const HotelsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HotelBloc, HotelState>(
      builder: (context, state) {
        if (state is HotelLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is HotelLoaded) {
          return ListView.builder(
            itemCount: state.hotels.length,
            itemBuilder: (context, index) {
              final hotel = state.hotels[index];
              return HotelCard(
                hotel: hotel,
                isFavorite: false, // Pass favorite status
              );
            },
          );
        } else if (state is HotelError) {
          return Center(child: Text(state.message));
        } else {
          return const Center(child: Text('No data available.'));
        }
      },
    );
  }
}
