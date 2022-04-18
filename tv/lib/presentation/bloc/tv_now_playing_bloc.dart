import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/tv_get_now_playing.dart';

part 'tv_now_playing_event.dart';
part 'tv_now_playing_state.dart';

class TvNowPlayingBloc extends Bloc<TvNowPlayingEvent, TvNowPlayingState> {
  final GetNowPlayingTv _getNowPlayingTvs;

  TvNowPlayingBloc(this._getNowPlayingTvs) : super(TvNowPlayingEmpty()) {
    on<TvNowPlayingEvent>((event, emit) async {
      emit(TvNowPlayingLoading());
      final result = await _getNowPlayingTvs.execute();

      result.fold(
        (failure) {
          emit(TvNowPlayingError(failure.message));
        },
        (data) {
          emit(TvNowPlayingHasData(data));
        },
      );
    });
  }
}
