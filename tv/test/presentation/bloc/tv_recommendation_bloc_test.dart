import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import 'tv_recommendation_bloc_test.mocks.dart';

@GenerateMocks([
  GetTvRecommendations,
])
void main() {
  late TvRecommendationBloc tvRecommendationBloc;
  late MockGetTvRecommendations mockGetTvRecommendations;

  setUp(() {
    mockGetTvRecommendations = MockGetTvRecommendations();
    tvRecommendationBloc = TvRecommendationBloc(mockGetTvRecommendations);
  });

  final tId = 1;

  final tTv = Tv(
    backdropPath: '/1qpUk27LVI9UoTS7S0EixUBj5aR.jpg',
    firstAirDate: "2022-03-24",
    genreIds: [10759, 10765],
    id: 52814,
    name: "Halo",
    overview:
        "Depicting an epic 26th-century conflict between humanity and an alien threat known as the Covenant, the series weaves deeply drawn personal stories with action, adventure and a richly imagined vision of the future.",
    posterPath: "/nJUHX3XL1jMkk8honUZnUmudFb9.jpg",
    voteAverage: 8.9,
    voteCount: 289,
  );

  final tTvs = <Tv>[tTv];

  group('Tv Recommendation Bloc test', () {
    blocTest<TvRecommendationBloc, TvRecommendationState>(
      'should emit [loading, hasData] when data is loaded successfully',
      build: () {
        when(mockGetTvRecommendations.execute(tId))
            .thenAnswer((_) async => Right(tTvs));
        return tvRecommendationBloc;
      },
      act: (bloc) => bloc.add(OnFetchTvRecommendation(tId)),
      expect: () => [TvRecommendationLoading(), TvRecommendationHasData(tTvs)],
    );

    blocTest<TvRecommendationBloc, TvRecommendationState>(
      'should emit [loading, error] when data is loaded unsuccessfully',
      build: () {
        when(mockGetTvRecommendations.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return tvRecommendationBloc;
      },
      act: (bloc) => bloc.add(OnFetchTvRecommendation(tId)),
      expect: () =>
          [TvRecommendationLoading(), TvRecommendationError('Server Failure')],
    );
  });
}
