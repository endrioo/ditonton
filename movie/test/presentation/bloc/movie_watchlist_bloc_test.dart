import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';

import 'movie_watchlist_bloc_test.mocks.dart';

@GenerateMocks([
  GetWatchlistMovies,
])
void main() {
  late MovieWatchlistPageBloc movieWatchlistPageBloc;
  late MockGetWatchlistMovies mockGetWatchlistMovies;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    movieWatchlistPageBloc = MovieWatchlistPageBloc(mockGetWatchlistMovies);
  });

  final tMovieWatchlist = Movie.watchlist(
    id: 1,
    overview: 'overview',
    posterPath: 'posterPath',
    title: 'title',
  );

  group('Movie Watchlist Page Bloc Test', () {
    blocTest<MovieWatchlistPageBloc, MovieWatchlistPageState>(
      'should return emit [loading, hasData] when data is loaded successfully',
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => Right([tMovieWatchlist]));
        return movieWatchlistPageBloc;
      },
      act: (bloc) => bloc.add(MovieWatchlistpageEvent()),
      expect: () => [
        MovieWatchlistPageLoading(),
        MovieWatchlistPageHasData([tMovieWatchlist])
      ],
    );

    blocTest<MovieWatchlistPageBloc, MovieWatchlistPageState>(
      'should return emit [loading, error] when data is loaded unsuccessfully',
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => Left(DatabaseFailure("Can't get data")));
        return movieWatchlistPageBloc;
      },
      act: (bloc) => bloc.add(MovieWatchlistpageEvent()),
      expect: () => [
        MovieWatchlistPageLoading(),
        MovieWatchlistPageError("Can't get data"),
      ],
    );
  });
}
