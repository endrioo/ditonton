import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/repositories/tv_repository.dart';


class GetTopRatedTv {
  final TvRepository tvRepository;

  GetTopRatedTv(this.tvRepository);

  Future<Either<Failure, List<Tv>>> execute() {
    return tvRepository.getTopRatedTv();
  }
}
