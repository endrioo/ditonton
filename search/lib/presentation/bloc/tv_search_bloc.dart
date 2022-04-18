import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search/domain/usecases/tv_search.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:rxdart/rxdart.dart';

part 'tv_search_event.dart';
part 'tv_search_state.dart';

class TvSearchBloc extends Bloc<TvSearchEvent, TvSearchState> {
  final SearchTv _searchTv;

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }

  TvSearchBloc(this._searchTv) : super(TvSearchEmpty()) {
    on<OnTvQueryChanged>((event, emit) async {
      final query = event.query;

      emit(TvSearchLoading());
      final result = await _searchTv.execute(query);

      result.fold(
        (failure) {
          emit(TvSearchError(failure.message));
        },
        (data) {
          emit(TvSearchHasData(data));
        },
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}
