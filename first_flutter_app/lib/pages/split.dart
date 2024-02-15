import 'package:flutter/material.dart';
import 'package:first_flutter_app/widgets/quotes.dart';
import 'package:first_flutter_app/widgets/edge.dart';
import 'package:first_flutter_app/widgets/looks_maxxing.dart';

class SplitPage extends StatefulWidget {
  const SplitPage({super.key});

  @override
  _SplitPageState createState() => _SplitPageState();
}

class _SplitPageState extends State<SplitPage> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(index,
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: const <Widget>[
          QuotesWidget(), // Use QuotesWidget here
          EdgeWidget(),
          LooksMaxxingWidget(), //Center(child: Text('Page 3')),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            label: 'Quote of The Day',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.airline_seat_recline_extra),
            label: 'Edging',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt),
            label: 'LooksMaxxing',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

