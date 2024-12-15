import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/hotels/domain/usecases/get_hotels.dart';
import 'features/hotels/data/repositories/hotel_repository_impl.dart';
import 'features/hotels/data/datasources/hotel_remote_datasource.dart';
import 'features/hotels/presentation/bloc/hotel_bloc.dart';
import 'package:http/http.dart' as http;

import 'features/hotels/presentation/bloc/hotel_event.dart';
import 'features/hotels/presentation/screens/home_screen.dart';

void main() {
  final httpClient = http.Client();
  final remoteDataSource = HotelRemoteDataSourceImpl(httpClient);
  final hotelRepository = HotelRepositoryImpl(remoteDataSource);
  final getHotelsUseCase = GetHotels(hotelRepository);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HotelBloc(getHotels: getHotelsUseCase)..add(LoadHotelsEvent()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hotel Booking App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
        ),
      ),
      home: const HomeScreen(), // Updated HomeScreen
    );
  }
}
