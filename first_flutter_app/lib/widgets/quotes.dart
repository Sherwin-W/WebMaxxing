import 'dart:async';
import 'package:flutter/material.dart';

class QuotesWidget extends StatefulWidget {
  const QuotesWidget({super.key});

  @override
  _QuotesWidgetState createState() => _QuotesWidgetState();
}

class _QuotesWidgetState extends State<QuotesWidget> {
  int _currentIndex = 0;
  Timer? _timer;

  // Array of quotes
  final List<String> _quotes = [
  "Life's edge sharpens the goon within us all.",
  "On the edge of reason, goons find their wisdom.",
  "Only a true goon can dance on the edge gracefully.",
  "Wisdom often lurks at the edge of folly.",
  "Goon or sage, we all teeter on the edge.",
  "The edge is thin; tread like a seasoned goon.",
  "Edgy minds cut deeper, revealing the goon's wisdom.",
  "In the realm of goons, the edge is king.",
  "To live on the edge, one must embrace their inner goon.",
  "A goon at the edge is closer to truth than a sage in the center.",
  "Leap from the edge and let your inner goon fly.",
  "The edge is where goonish wisdom shines brightest.",
  "Goonish antics at the edge often lead to profound insights.",
  "Every goon has its edge; every sage, a moment of folly.",
  "At the edge, even a goon can glimpse infinity.",
  "The sharpest edge is the divide between wisdom and goonery.",
  "An edgy spirit keeps the goon's mind sharp.",
  "Embrace the edge; it's where the goon's heart beats loudest.",
  "A goon's edge is the wit that slices through ignorance.",
  "To find the edge, a goon must first wander.",
  "Edge or no edge, a goon's path is always circular.",
  "The edge is just a step away for the daring goon.",
  "A wise goon knows the edge is just the beginning.",
  "Goon logic: if the edge is near, jump and learn to fly.",
  "On the edge of tomorrow, goons ponder yesterday's wisdom.",
  "Edgy today, goon tomorrow; such is the cycle of wisdom.",
  "To sharpen the mind, a goon walks the edge.",
  "A goon's courage is found on the edge of reason.",
  "Edge walking is a goon's guide to enlightenment.",
  "Where wisdom ends, the goon's edge begins.",
  "A true goon knows the edge is a friend, not a foe.",
  "In every goon, there's an edge that cuts through darkness.",
  "The wise goon jumps, knowing the edge is just an illusion.",
  "Beware the goon who's found his edge; wisdom follows.",
  "The edge isn't the end; it's where the goon's journey starts.",
  "At the world's edge, goons and sages dine together.",
  "The finest edge doesn't cut; it enlightens the goon.",
  "Edge your bets, but never bet against a goon's intuition.",
  "In the garden of wisdom, the goon's edge is the spade.",
  "A goon without an edge is like a song without notes.",
  "To walk the edge, a goon must first learn to balance.",
  "The edge calls to the goon's spirit, promising adventure.",
  "A goon's tale often ends at the edge of wisdom.",
  "Only at the edge can a goon truly see.",
  "A goon lives by the edge, a sage learns from it.",
  "The edge is where goons flirt with destiny and wisdom."
];

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % _quotes.length;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedSwitcher(
        duration: const Duration(seconds: 1),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(opacity: animation, child: child);
        },
        child: Text(
          _quotes[_currentIndex],
          key: ValueKey<int>(_currentIndex), // Important for changing animation
          style: const TextStyle(
            fontFamily: 'Tusj',
            fontWeight: FontWeight.w600,
            fontSize: 30,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

