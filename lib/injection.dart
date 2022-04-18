import 'package:core/database/database_helper.dart';
import 'package:ditonton/utils/ssl_pinning.dart';
import 'package:movie/movie.dart';
import 'package:tv/tv.dart';
import 'package:search/search.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {



  // bloc
  locator.registerFactory(
    () => MovieSearchBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => TvSearchBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => MovieDetailBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => MovieNowPlayingBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => MoviePopularBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => MovieRecommendationBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => MovieTopRatedBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => MovieWatchlistBloc(
      locator(),
      locator(),
      locator(),
    ),
  );

  locator.registerFactory(
    () => MovieWatchlistPageBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => TvDetailBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => TvNowPlayingBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => TvPopularBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => TvRecommendationBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => TvTopRatedBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => TvWatchlistBloc(
      locator(),
      locator(),
      locator(),
    ),
  );

  locator.registerFactory(
    () => TvWatchlistPageBloc(
      locator(),
    ),
  );

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));
  locator.registerLazySingleton(() => GetNowPlayingTv(locator()));
  locator.registerLazySingleton(() => GetPopularTv(locator()));
  locator.registerLazySingleton(() => GetTopRatedTv(locator()));
  locator.registerLazySingleton(() => GetTvDetail(locator()));
  locator.registerLazySingleton(() => GetTvRecommendations(locator()));
  locator.registerLazySingleton(() => GetWatchlistTv(locator()));
  locator.registerLazySingleton(() => GetWatchListTvStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTv(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTv(locator()));
  locator.registerLazySingleton(() => SearchTv(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  locator.registerLazySingleton<TvRepository>(
    () => TvRepositoryimpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));
  locator.registerLazySingleton<TvRemoteDataSource>(
      () => TvRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvLocalDataSource>(
      () => TvLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => HttpSSLPinning.client);
}
