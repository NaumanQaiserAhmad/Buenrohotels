import 'package:flutter/material.dart';
import 'hotels_screen.dart';
import 'favorites_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 1; // Default to Hotels tab

  final List<Widget> _screens = [
    const Center(child: Text('Overview')), // Overview placeholder
    const HotelsScreen(), // Hotels Tab
    const FavoritesScreen(), // Favorites Tab
    const Center(child: Text('Account')), // Account placeholder
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hotel Booking App'),
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey, // Set background color to grey
        selectedItemColor: Colors.blue, // Set selected item color
        unselectedItemColor: Colors.black, // Set unselected item color
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Overview'),
          BottomNavigationBarItem(icon: Icon(Icons.hotel), label: 'Hotels'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: 'Account'),
        ],
      ),
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      title: 'Hotel Booking App',
      theme: ThemeData(
        useMaterial3: true, // For Material Design 3
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.grey, // Explicitly set the background color
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.black,
        ),
      ),
      home: const HomeScreen(),
    ),
  );
}
