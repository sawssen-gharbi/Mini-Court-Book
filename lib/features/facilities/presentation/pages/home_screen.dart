import 'package:flutter/material.dart';
import 'package:mini_court_book/core/theme/app_palette.dart';
import 'package:mini_court_book/features/bookings/presentation/pages/my_bookings_screen.dart';
import 'package:mini_court_book/features/facilities/presentation/pages/facilities_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //var
  int _selectedIndex = 0;
  //func

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const List<Widget> _pages = [FacilitiesScreen(), MyBookingsScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: IndexedStack(index: _selectedIndex, children: _pages),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppPalette.backgroundColor,
        elevation: 0,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_score),
            label: 'Facilities',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book_online),
            label: 'My Bookings',
          ),
        ],
        selectedItemColor: AppPalette.primaryColor,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
