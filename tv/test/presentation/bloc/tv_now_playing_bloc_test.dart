import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import 'tv_now_playing_bloc_test.mocks.dart';

@GenerateMocks([
  GetNowPlayingTv,
])
void main() {
  late TvNowPlayingBloc tvNowPlayingBloc;
  late MockGetNowPlayingTv mockGetNowPlayingTvs;

  setUp(() {
    mockGetNowPlayingTvs = MockGetNowPlayingTv();
    tvNowPlayingBloc = TvNowPlayingBloc(mockGetNowPlayingTvs);
  });

  final tTvList = <Tv>[];

  group('Tv Now Playing Bloc Test', () {
    blocTest<TvNowPlayingBloc, TvNowPlayingState>(
      'should emit [loading, hasData] when data is loaded succesfully',
      build: () {
        when(mockGetNowPlayingTvs.execute())
            .thenAnswer((_) async => Right(tTvList));
        return tvNowPlayingBloc;
      },
      act: (bloc) => bloc.add(TvNowPlayingEvent()),
      expect: () => [TvNowPlayingLoading(), TvNowPlayingHasData(tTvList)],
      verify: (bloc) {
        verify(mockGetNowPlayingTvs.execute());
      },
    );

    blocTest<TvNowPlayingBloc, TvNowPlayingState>(
        'should emit [loading,error] when data is loaded unsuccesfully',
        build: () {
          when(mockGetNowPlayingTvs.execute())
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          return tvNowPlayingBloc;
        },
        act: (bloc) => bloc.add(TvNowPlayingEvent()),
        expect: () =>
            [TvNowPlayingLoading(), TvNowPlayingError('Server Failure')],
        verify: (bloc) {
          verify(mockGetNowPlayingTvs.execute());
        });
  });
}
