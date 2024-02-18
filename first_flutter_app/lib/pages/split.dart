import 'package:first_flutter_app/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:first_flutter_app/widgets/quotes.dart';
import 'package:first_flutter_app/widgets/edge.dart';
import 'package:first_flutter_app/widgets/looks_maxxing.dart';
import 'package:first_flutter_app/widgets/settings.dart';

class SplitPage extends StatefulWidget {
  const SplitPage({super.key});

  @override
  _SplitPageState createState() => _SplitPageState();
}

class _SplitPageState extends State<SplitPage> with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _selectedIndex = 0;
  late final AnimationController _iconAnimationController;

   @override
  void initState() {
    super.initState();
    _iconAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _iconAnimationController.dispose();
    super.dispose();
  }

  void _onSettingsIconTap() {
    _iconAnimationController.forward(from: 0.0);
    showSettingsPanel(context, _iconAnimationController);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF3EDF6),
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: AnimatedBuilder(
              animation: _iconAnimationController,
              builder: (_, child) {
                return Transform.rotate(
                  angle: _iconAnimationController.value * 2 * 3.141592653589793238,
                  child: child,
                );
              },
              child: Icon(Icons.settings),
            ),
            onPressed: _onSettingsIconTap,
          ),
        ],
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: <Widget>[
          const QuotesWidget(),
          const EdgeWidget(),
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
