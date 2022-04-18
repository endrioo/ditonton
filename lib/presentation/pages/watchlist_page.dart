import 'package:about/about.dart';
import 'package:movie/movie.dart';
import 'package:tv/tv.dart';
import 'package:flutter/material.dart';

class WatchlistPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-movie';

  @override
  State<WatchlistPage> createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Watchlist"),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
              },
              icon: Icon(Icons.info_outline),
            )
          ],
          bottom: TabBar(
            indicatorColor: Colors.grey,
            tabs: [
              Tab(text: 'Movie Watchlist '),
              Tab(text: 'Tv Watchlist'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            WatchlistMoviesPage(),
            WatchlistTvpage(),
          ],
        ),
      ),
    );
  }
}
