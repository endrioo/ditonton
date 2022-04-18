import 'package:about/about.dart';
import 'package:core/core.dart';
import 'package:ditonton/presentation/pages/home_page.dart';
import 'package:ditonton/presentation/pages/watchlist_page.dart';
import 'package:ditonton/utils/ssl_pinning.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/movie.dart';
import 'package:tv/tv.dart';
import 'package:search/search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ditonton/injection.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HttpSSLPinning.init();
  await Firebase.initializeApp();
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(
          create: (_) => di.locator<MovieSearchBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvSearchBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieNowPlayingBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MoviePopularBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieRecommendationBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieTopRatedBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieWatchlistBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieWatchlistPageBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvNowPlayingBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvPopularBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvRecommendationBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvTopRatedBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvWatchlistBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvWatchlistPageBloc>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: HomePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => HomePage());
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case PopularTvPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularTvPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case TopRatedTvPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedTvPage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case TvDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TvDetailPage(id: id),
                settings: settings,
              );
            case SearchPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            case TvSearchPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TvSearchPage());
            case WatchlistPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistPage());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
