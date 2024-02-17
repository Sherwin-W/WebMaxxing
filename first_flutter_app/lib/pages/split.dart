import 'package:first_flutter_app/widgets/bottom_bar.dart';
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
  final PageController _pageController = PageController();
  int _selectedIndex = 0;


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
      bottomNavigationBar: SplitBottomBar(
        selectedIndex: _selectedIndex,
        onTabChange: (index) {
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 800),
            curve: Curves.ease,
          );
        },
      )
    );
  }
}
