import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/tv_get_watchlist.dart';

part 'tv_watchlist_page_event.dart';
part 'tv_watchlist_page_state.dart';

class TvWatchlistPageBloc
    extends Bloc<TvWatchlistpageEvent, TvWatchlistPageState> {
  final GetWatchlistTv _getWatchlistTvs;

  TvWatchlistPageBloc(this._getWatchlistTvs) : super(TvWatchlistPageEmpty()) {
    on<TvWatchlistpageEvent>((event, emit) async {
      emit(TvWatchlistPageLoading());
      final result = await _getWatchlistTvs.execute();

      result.fold(
        (failure) {
          emit(TvWatchlistPageError(failure.message));
        },
        (data) {
          emit(TvWatchlistPageHasData(data));
        },
      );
    });
  }
}
