import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class SplitBottomBar extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onTabChange;
  const SplitBottomBar({super.key,
    required this.selectedIndex,
    required this.onTabChange
  });

  @override
  _SplitBottomBarState createState() => _SplitBottomBarState();
}

class _SplitBottomBarState extends State<SplitBottomBar> {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF3EDF6),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
        child: GNav(
          gap: 8,
          color: Colors.black,
          activeColor: Colors.black,
          iconSize: 24,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          duration: const Duration(milliseconds: 800),
            tabBackgroundColor: Colors.purple[100]!,
          tabs: const [
            GButton(
              icon: Icons.library_books,
              text: 'Quotes',
            ),
            GButton(
              icon: Icons.airline_seat_recline_extra,
              text: 'Edge',
            ),
            GButton(
              icon: Icons.camera_alt,
              text: 'Maxxing',
            ),
          ],
          selectedIndex: widget.selectedIndex,
          onTabChange: (index) {
            widget.onTabChange(index);
          },
        )
      )
    );
  }
}