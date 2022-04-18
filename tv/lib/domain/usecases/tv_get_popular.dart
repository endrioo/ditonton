import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/repositories/tv_repository.dart';


class GetPopularTv {
  final TvRepository tvRepository;

  GetPopularTv(this.tvRepository);

  Future<Either<Failure, List<Tv>>> execute() {
    return tvRepository.getPopularTv();
  }
}
