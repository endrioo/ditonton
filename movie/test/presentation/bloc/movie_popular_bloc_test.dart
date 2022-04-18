import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';

import 'movie_popular_bloc_test.mocks.dart';

@GenerateMocks([
  GetPopularMovies,
])
void main() {
  late MoviePopularBloc moviePopularBloc;
  late MockGetPopularMovies mockGetPopularMovies;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    moviePopularBloc = MoviePopularBloc(mockGetPopularMovies);
  });

  final tMovieList = <Movie>[];

  group('Movie Popular BLoc Test', () {
    blocTest<MoviePopularBloc, MoviePopularState>(
      'should emit [loading, hasData] when data is loaded successfully',
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return moviePopularBloc;
      },
      act: (bloc) => bloc.add(MoviePopularEvent()),
      expect: () => [MoviePopularLoading(), MoviePopularHasData(tMovieList)],
      verify: (bloc) {
        verify(mockGetPopularMovies.execute());
      }
    );

    blocTest<MoviePopularBloc, MoviePopularState>(
      'should emit [loading, error] when data is loaded unsuccessfully',
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return moviePopularBloc;
      },
      act: (bloc) => bloc.add(MoviePopularEvent()),
      expect: () => [MoviePopularLoading(), MoviePopularError('Server Failure')],
      verify: (bloc) {
        verify(mockGetPopularMovies.execute());
      }
    );
  });
}
