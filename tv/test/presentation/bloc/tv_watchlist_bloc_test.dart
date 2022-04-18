import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import 'tv_watchlist_bloc_test.mocks.dart';

@GenerateMocks([
  GetWatchlistTv,
])
void main() {
  late TvWatchlistPageBloc tvWatchlistPageBloc;
  late MockGetWatchlistTv mockGetWatchlistTvs;

  setUp(() {
    mockGetWatchlistTvs = MockGetWatchlistTv();
    tvWatchlistPageBloc = TvWatchlistPageBloc(mockGetWatchlistTvs);
  });

  final tTvWatchlist = Tv.watchlist(
    id: 1,
    name: "name",
    posterPath: "posterPath",
    overview: "overview",
  );

  group('Tv Watchlist Page Bloc Test', () {
    blocTest<TvWatchlistPageBloc, TvWatchlistPageState>(
      'should return emit [loading, hasData] when data is loaded successfully',
      build: () {
        when(mockGetWatchlistTvs.execute())
            .thenAnswer((_) async => Right([tTvWatchlist]));
        return tvWatchlistPageBloc;
      },
      act: (bloc) => bloc.add(TvWatchlistpageEvent()),
      expect: () => [
        TvWatchlistPageLoading(),
        TvWatchlistPageHasData([tTvWatchlist])
      ],
    );

    blocTest<TvWatchlistPageBloc, TvWatchlistPageState>(
      'should return emit [loading, error] when data is loaded unsuccessfully',
      build: () {
        when(mockGetWatchlistTvs.execute())
            .thenAnswer((_) async => Left(DatabaseFailure("Can't get data")));
        return tvWatchlistPageBloc;
      },
      act: (bloc) => bloc.add(TvWatchlistpageEvent()),
      expect: () => [
        TvWatchlistPageLoading(),
        TvWatchlistPageError("Can't get data"),
      ],
    );
  });
}
