import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';

import 'movie_now_playing_bloc_test.mocks.dart';

@GenerateMocks([
  GetNowPlayingMovies,
])
void main() {
  late MovieNowPlayingBloc movieNowPlayingBloc;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    movieNowPlayingBloc = MovieNowPlayingBloc(mockGetNowPlayingMovies);
  });

  final tMovieList = <Movie>[];

  group('Movie Now Playing Bloc Test', () {
    blocTest<MovieNowPlayingBloc, MovieNowPlayingState>(
      'should emit [loading, hasData] when data is loaded succesfully',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return movieNowPlayingBloc;
      },
      act: (bloc) => bloc.add(MovieNowPlayingEvent()),
      expect: () =>
          [MovieNowPlayingLoading(), MovieNowPlayingHasData(tMovieList)],
      verify: (bloc) {
        verify(mockGetNowPlayingMovies.execute());
      },
    );

    blocTest<MovieNowPlayingBloc, MovieNowPlayingState>(
      'should emit [loading,error] when data is loaded unsuccesfully',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return movieNowPlayingBloc;
      },
      act: (bloc) => bloc.add(MovieNowPlayingEvent()),
      expect: () => [MovieNowPlayingLoading(), MovieNowPlayingError('Server Failure')],
      verify: (bloc) {
        verify(mockGetNowPlayingMovies.execute());
      }
    );
  });
}
