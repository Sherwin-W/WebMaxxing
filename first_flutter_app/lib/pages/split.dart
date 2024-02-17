import 'package:flutter/material.dart';
import 'package:first_flutter_app/widgets/quotes.dart';
import 'package:first_flutter_app/widgets/edge.dart';
import 'package:first_flutter_app/widgets/looks_maxxing.dart';
import 'package:first_flutter_app/widgets/nav_item.dart';

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
          QuotesWidget(),
          EdgeWidget(),
          LooksMaxxingWidget(),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            NavItem(
              icon: Icons.library_books,
              label: 'Quote of The Day',
              index: 0,
              isSelected: _selectedIndex == 0,
              onTap: _onItemTapped,
            ),
            NavItem(
              icon: Icons.airline_seat_recline_extra,
              label: 'Edging',
              index: 1,
              isSelected: _selectedIndex == 1,
              onTap: _onItemTapped,
            ),
            NavItem(
              icon: Icons.camera_alt,
              label: 'LooksMaxxing',
              index: 2,
              isSelected: _selectedIndex == 2,
              onTap: _onItemTapped,
            ),
          ],
        ),
      ),
    );
  }
}
