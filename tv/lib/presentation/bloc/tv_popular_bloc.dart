import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/tv_get_popular.dart';

part 'tv_popular_state.dart';
part 'tv_popular_event.dart';

class TvPopularBloc extends Bloc<TvPopularEvent, TvPopularState> {
  final GetPopularTv _getPopularTvs;

  TvPopularBloc(this._getPopularTvs) : super(TvPopularEmpty()) {
    on<TvPopularEvent>((event, emit) async {
      emit(TvPopularLoading());
      final result = await _getPopularTvs.execute();

      result.fold(
        (failure) {
          emit(TvPopularError(failure.message));
        },
        (data) {
          emit(TvPopularHasData(data));
        },
      );
    });
  }
}
