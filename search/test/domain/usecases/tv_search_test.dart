import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:search/domain/usecases/tv_search.dart';
import 'package:tv/domain/entities/tv.dart';
import '../../../../tv/test/helpers/tv_test_helper.mocks.dart';

void main() {
  late SearchTv usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = SearchTv(mockTvRepository);
  });

  final tTvs = <Tv>[];
  final tQuery = 'Spiderman';

  test('should get list of Tvs from the repository', () async {
    // arrange
    when(mockTvRepository.searchTv(tQuery))
        .thenAnswer((_) async => Right(tTvs));
    // act
    final result = await usecase.execute(tQuery);
    // assert
    expect(result, Right(tTvs));
  });
}
