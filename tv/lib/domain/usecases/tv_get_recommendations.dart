import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/repositories/tv_repository.dart';

class GetTvRecommendations {
  final TvRepository tvRepository;

  GetTvRecommendations(this.tvRepository);

  Future<Either<Failure, List<Tv>>> execute(id) {
    return tvRepository.getTvRecommendations(id);
  }
}
