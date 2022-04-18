import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/tv_get_top_rated.dart';

part 'tv_top_rated_event.dart';
part 'tv_top_rated_state.dart';

class TvTopRatedBloc extends Bloc<TvTopRatedEvent, TvTopRatedState> {
  final GetTopRatedTv _getTopRatedTvs;

  TvTopRatedBloc(this._getTopRatedTvs) : super(TvTopRatedEmpty()) {
    on<TvTopRatedEvent>((event, emit) async {
      emit(TvTopRatedLoading());
      final result = await _getTopRatedTvs.execute();

      result.fold(
        (failure) {
          emit(TvTopRatedError(failure.message));
        },
        (data) {
          emit(TvTopRatedHasData(data));
        },
      );
    });
  }
}
