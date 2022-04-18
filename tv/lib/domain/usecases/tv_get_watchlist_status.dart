

import 'package:tv/domain/repositories/tv_repository.dart';

class GetWatchListTvStatus {
  final TvRepository tvRepository;

  GetWatchListTvStatus(this.tvRepository);

  Future<bool> execute(int id) async {
    return tvRepository.isAddedToTvWatchlist(id);
  }
}
