import 'package:core/core.dart';
import 'package:ditonton/presentation/pages/watchlist_page.dart';
import 'package:flutter/material.dart';
import 'package:movie/movie.dart';
import 'package:tv/tv.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          HomeMoviePage(),
          HomeTvPage(),
          WatchlistPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: kRichBlack,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.movie_outlined),
            label: "Movie",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.tv_sharp),
            label: "Tv Series",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.bookmark_outline,
            ),
            label: "Watchlist",
          ),
        ],
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 13,
        unselectedFontSize: 13,
        currentIndex: _currentIndex,
        selectedItemColor: Colors.white,
        selectedIconTheme: IconThemeData(
          color: Colors.white,
        ),
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 200),
              curve: Curves.linear,
            );
          });
        },
      ),
    );
  }
}
