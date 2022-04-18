import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';

import 'movie_recommendation_bloc_test.mocks.dart';

@GenerateMocks([
  GetMovieRecommendations,
])
void main() {
  late MovieRecommendationBloc movieRecommendationBloc;
  late MockGetMovieRecommendations mockGetMovieRecommendations;

  setUp(() {
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    movieRecommendationBloc =
        MovieRecommendationBloc(mockGetMovieRecommendations);
  });

  final tId = 1;

  final tMovie = Movie(
    adult: false,
    backdropPath: '/backdropPath.jpg',
    genreIds: [14, 28],
    id: 557,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: '/posterPath.jpg',
    releaseDate: '2002-05-01',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );

  final tMovies = <Movie>[tMovie];

  group('Movie Recommendation Bloc test', () {
    blocTest<MovieRecommendationBloc, MovieRecommendationState>(
      'should emit [loading, hasData] when data is loaded successfully',
      build: () {
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => Right(tMovies));
        return movieRecommendationBloc;
      },
      act: (bloc) => bloc.add(OnFetchMovieRecommendation(tId)),
      expect: () =>
          [MovieRecommendationLoading(), MovieRecommendationHasData(tMovies)],
    );

    blocTest<MovieRecommendationBloc, MovieRecommendationState>(
      'should emit [loading, error] when data is loaded unsuccessfully',
      build: () {
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return movieRecommendationBloc;
      },
      act: (bloc) => bloc.add(OnFetchMovieRecommendation(tId)),
      expect: () => [
        MovieRecommendationLoading(),
        MovieRecommendationError('Server Failure')
      ],
    );
  });
}
