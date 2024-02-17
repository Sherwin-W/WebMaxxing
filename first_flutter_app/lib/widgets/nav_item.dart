import 'package:flutter/material.dart';

class NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final int index;
  final bool isSelected;
  final Function(int) onTap;

  const NavItem({
    Key? key,
    required this.icon,
    required this.label,
    required this.index,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(index),
        child: Container(
          height: 60, // Keeping a fixed height to prevent overflow
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: isSelected ? Color(0xFF28536B) : Color(0xFF7EA8BE), size: 24),
              SizedBox(height: 4), // Spacing between icon and text
              AnimatedOpacity(
                opacity: isSelected ? 1.0 : 0.0, // Fade in if selected, otherwise fade out
                duration: const Duration(milliseconds: 300),
                child: Text(label, style: TextStyle(color: Color(0xFF28536B), fontSize: 12)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}




