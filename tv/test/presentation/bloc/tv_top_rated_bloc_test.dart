import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import 'tv_top_rated_bloc_test.mocks.dart';

@GenerateMocks([
  GetTopRatedTv,
])
void main() {
  late TvTopRatedBloc tvTopRatedBloc;
  late MockGetTopRatedTv mockGetTopRatedTvs;

  setUp(() {
    mockGetTopRatedTvs = MockGetTopRatedTv();
    tvTopRatedBloc = TvTopRatedBloc(mockGetTopRatedTvs);
  });

  final tTvList = <Tv>[];

  group('Tv Top Rated Bloc test', () {
    blocTest<TvTopRatedBloc, TvTopRatedState>(
      'should emit [loading, hasData] when data is loaded successfully',
      build: () {
        when(mockGetTopRatedTvs.execute())
            .thenAnswer((_) async => Right(tTvList));
        return tvTopRatedBloc;
      },
      act: (bloc) => bloc.add(TvTopRatedEvent()),
      expect: () => [TvTopRatedLoading(), TvTopRatedHasData(tTvList)],
      verify: (bloc) {
        verify(mockGetTopRatedTvs.execute());
      },
    );

    blocTest<TvTopRatedBloc, TvTopRatedState>(
      'should emit [loading, error] when data is loaded unsuccessfully',
      build: () {
        when(mockGetTopRatedTvs.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return tvTopRatedBloc;
      },
      act: (bloc) => bloc.add(TvTopRatedEvent()),
      expect: () => [TvTopRatedLoading(), TvTopRatedError('Server Failure')],
      verify: (bloc) {
        verify(mockGetTopRatedTvs.execute());
      },
    );
  });
}
