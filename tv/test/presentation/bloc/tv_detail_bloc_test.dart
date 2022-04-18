import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import 'tv_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetTvDetail,
])
void main() {
  late TvDetailBloc tvDetailBloc;
  late MockGetTvDetail mockGetTvDetail;

  setUp(() {
    mockGetTvDetail = MockGetTvDetail();
    tvDetailBloc = TvDetailBloc(mockGetTvDetail);
  });

  final tId = 1;

  final tTvDetail = TvDetail(
    adult: false,
    backdroppath: "backdropPath",
    firstAirDate: "firstAirDate",
    genres: [Genre(id: 1, name: 'Action')],
    id: 1,
    name: "name",
    numberOfEpisodes: 1,
    numberOfSeasons: 1,
    overview: "overview",
    voteAverage: 1,
    voteCount: 1,
    posterPath: "posterPath",
  );

  group('Tv Detail Bloc test', () {
    blocTest<TvDetailBloc, TvDetailState>(
        'should emit [loading, hasData] when data is loaded succesfully',
        build: () {
          when(mockGetTvDetail.execute(tId))
              .thenAnswer((_) async => Right(tTvDetail));
          return tvDetailBloc;
        },
        act: (bloc) => bloc.add(OnFetchTvDetail(tId)),
        expect: () {
          return [TvDetailLoading(), TvDetailHasData(tTvDetail)];
        });

    blocTest<TvDetailBloc, TvDetailState>(
      'should emit [loading, error] when data is loaded unsuccesfully',
      build: () {
        when(mockGetTvDetail.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return tvDetailBloc;
      },
      act: (bloc) => bloc.add(OnFetchTvDetail(tId)),
      expect: () {
        return [TvDetailLoading(), TvDetailError('Server Failure')];
      },
    );
  });
}
