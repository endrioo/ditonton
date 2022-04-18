import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import 'tv_popular_bloc_test.mocks.dart';

@GenerateMocks([
  GetPopularTv,
])
void main() {
  late TvPopularBloc tvPopularBloc;
  late MockGetPopularTv mockGetPopularTvs;

  setUp(() {
    mockGetPopularTvs = MockGetPopularTv();
    tvPopularBloc = TvPopularBloc(mockGetPopularTvs);
  });

  final tTvList = <Tv>[];

  group('Tv Popular BLoc Test', () {
    blocTest<TvPopularBloc, TvPopularState>(
        'should emit [loading, hasData] when data is loaded successfully',
        build: () {
          when(mockGetPopularTvs.execute())
              .thenAnswer((_) async => Right(tTvList));
          return tvPopularBloc;
        },
        act: (bloc) => bloc.add(TvPopularEvent()),
        expect: () => [TvPopularLoading(), TvPopularHasData(tTvList)],
        verify: (bloc) {
          verify(mockGetPopularTvs.execute());
        });

    blocTest<TvPopularBloc, TvPopularState>(
        'should emit [loading, error] when data is loaded unsuccessfully',
        build: () {
          when(mockGetPopularTvs.execute())
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          return tvPopularBloc;
        },
        act: (bloc) => bloc.add(TvPopularEvent()),
        expect: () => [TvPopularLoading(), TvPopularError('Server Failure')],
        verify: (bloc) {
          verify(mockGetPopularTvs.execute());
        });
  });
}
