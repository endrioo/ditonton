import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:search/search.dart';
import 'package:tv/domain/entities/tv.dart';

import 'tv_search_bloc_test.mocks.dart';


@GenerateMocks([SearchTv])
void main() {
  late TvSearchBloc searchBloc;
  late MockSearchTv mockSearchTv;

  setUp(() {
    mockSearchTv = MockSearchTv();
    searchBloc = TvSearchBloc(mockSearchTv);
  });

  test('initial state should be empty', () {
    expect(searchBloc.state, TvSearchEmpty());
  });

  final tTvModel = Tv(
    backdropPath: '/15iVN0AydCNNmETAdIIQD1e6Oow.jpg',
    firstAirDate: "2017-04-05",
    genreIds: [10759, 16],
    id: 70881,
    name: "Boruto: Naruto Next Generations",
    overview:
        "The life of the shinobi is beginning to change. Boruto Uzumaki, son of Seventh Hokage Naruto Uzumaki, has enrolled in the Ninja Academy to learn the ways of the ninja. Now, as a series of mysterious events unfolds, Boruto’s story is about to begin!",
    posterPath: '/e0B6i48kxdRkMcK4tR4YNfXGWOc.jpg',
    voteAverage: 8,
    voteCount: 2030,
  );
  final tTvList = <Tv>[tTvModel];
  final tQuery = 'boruto';

  blocTest<TvSearchBloc, TvSearchState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockSearchTv.execute(tQuery))
          .thenAnswer((_) async => Right(tTvList));
      return searchBloc;
    },
    act: (bloc) => bloc.add(OnTvQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      TvSearchLoading(),
      TvSearchHasData(tTvList),
    ],
    verify: (bloc) {
      verify(mockSearchTv.execute(tQuery));
    },
  );

  blocTest<TvSearchBloc, TvSearchState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockSearchTv.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return searchBloc;
    },
    act: (bloc) => bloc.add(OnTvQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      TvSearchLoading(),
      TvSearchError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSearchTv.execute(tQuery));
    },
  );
}
