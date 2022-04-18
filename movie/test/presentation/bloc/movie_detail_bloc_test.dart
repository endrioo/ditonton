import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';

import 'movie_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetMovieDetail,
])
void main() {
  late MovieDetailBloc movieDetailBloc;
  late MockGetMovieDetail mockGetMovieDetail;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    movieDetailBloc = MovieDetailBloc(mockGetMovieDetail);
  });

  final tId = 1;

  final tMovieDetail = MovieDetail(
    adult: false,
    backdropPath: 'backdropPath',
    genres: [],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    runtime: 1,
    title: 'title',
    voteAverage: 1.0,
    voteCount: 1,
  );

  group('Movie Detail Bloc test', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
        'should emit [loading, hasData] when data is loaded succesfully',
        build: () {
          when(mockGetMovieDetail.execute(tId))
              .thenAnswer((_) async => Right(tMovieDetail));
          return movieDetailBloc;
        },
        act: (bloc) => bloc.add(OnFetchMovieDetail(tId)),
        expect: () {
          return [MovieDetailLoading(), MovieDetailHasData(tMovieDetail)];
        });

    blocTest<MovieDetailBloc, MovieDetailState>(
      'should emit [loading, error] when data is loaded unsuccesfully',
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(OnFetchMovieDetail(tId)),
      expect: () {
        return [MovieDetailLoading(), MovieDetailError('Server Failure')];
      }
    );
  });
}
