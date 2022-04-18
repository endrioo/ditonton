import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:tv/domain/entities/tv_detail.dart';
import 'package:tv/domain/repositories/tv_repository.dart';

class RemoveWatchlistTv {
  final TvRepository tvRepository;

  RemoveWatchlistTv(this.tvRepository);

  Future<Either<Failure, String>> execute(TvDetail tv) {
    return tvRepository.removeTvWatchlist(tv);
  }
}
