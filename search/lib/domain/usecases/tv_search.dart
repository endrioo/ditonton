import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:tv/tv.dart';

class SearchTv {
  final TvRepository tvRepository;

  SearchTv(this.tvRepository);

  Future<Either<Failure, List<Tv>>> execute(String query) {
    return tvRepository.searchTv(query);
  }
}
