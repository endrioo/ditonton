import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';

import 'movie_top_rated_bloc_test.mocks.dart';

@GenerateMocks([
  GetTopRatedMovies,
])
void main() {
  late MovieTopRatedBloc movieTopRatedBloc;
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    movieTopRatedBloc = MovieTopRatedBloc(mockGetTopRatedMovies);
  });

  final tMovieList = <Movie>[];

  group('Movie Top Rated Bloc test', () {
    blocTest<MovieTopRatedBloc, MovieTopRatedState>(
      'should emit [loading, hasData] when data is loaded successfully',
      build: () {
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return movieTopRatedBloc;
      },
      act: (bloc) => bloc.add(MovieTopRatedEvent()),
      expect: () => [MovieTopRatedLoading(), MovieTopRatedHasData(tMovieList)],
      verify: (bloc) {
        verify(mockGetTopRatedMovies.execute());
      },
    );

    blocTest<MovieTopRatedBloc, MovieTopRatedState>(
      'should emit [loading, error] when data is loaded unsuccessfully',
      build: () {
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return movieTopRatedBloc;
      },
      act: (bloc) => bloc.add(MovieTopRatedEvent()),
      expect: () =>
          [MovieTopRatedLoading(), MovieTopRatedError('Server Failure')],
      verify: (bloc) {
        verify(mockGetTopRatedMovies.execute());
      },
    );
  });
}
