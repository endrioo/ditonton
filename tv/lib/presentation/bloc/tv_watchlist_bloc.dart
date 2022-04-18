import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/entities/tv_detail.dart';
import 'package:tv/domain/usecases/tv_get_watchlist_status.dart';
import 'package:tv/domain/usecases/tv_remove_watchlist.dart';
import 'package:tv/domain/usecases/tv_save_watchlist.dart';

part 'tv_watchlist_event.dart';
part 'tv_watchlist_state.dart';

class TvWatchlistBloc extends Bloc<TvWatchlistEvent, TvWatchlistState> {
  final GetWatchListTvStatus _getWatchListStatus;
  final SaveWatchlistTv _saveWatchlist;
  final RemoveWatchlistTv _removeWatchlist;

  TvWatchlistBloc(
      this._getWatchListStatus, this._removeWatchlist, this._saveWatchlist)
      : super(TvWatchlistEmpty()) {
    on<AddWatchList>((event, emit) async {
      final TvDetail tv = event.tv;

      emit(TvWatchlistLoading());
      final result = await _saveWatchlist.execute(tv);

      result.fold(
        (failure) {
          emit(TvWatchlistError(failure.message));
        },
        (data) {
          emit(TvWatchlistStatus(true));
        },
      );
    });
    on<RemoveWatchList>((event, emit) async {
      final TvDetail tv = event.tv;

      emit(TvWatchlistLoading());
      final result = await _removeWatchlist.execute(tv);

      result.fold(
        (failure) {
          emit(TvWatchlistError(failure.message));
        },
        (data) {
          emit(TvWatchlistStatus(false));
        },
      );
    });
    on<LoadWatchListStatus>((event, emit) async {
      final int id = event.id;

      emit(TvWatchlistLoading());
      final result = await _getWatchListStatus.execute(id);

      emit(TvWatchlistStatus(result));
    });
  }
}
