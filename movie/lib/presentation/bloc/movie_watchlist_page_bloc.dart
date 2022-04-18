import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/movie.dart';

part 'movie_watchlist_page_event.dart';
part 'movie_watchlist_page_state.dart';

class MovieWatchlistPageBloc
    extends Bloc<MovieWatchlistpageEvent, MovieWatchlistPageState> {
  final GetWatchlistMovies _getWatchlistMovies;

  MovieWatchlistPageBloc(this._getWatchlistMovies)
      : super(MovieWatchlistPageEmpty()) {
    on<MovieWatchlistpageEvent>((event, emit) async {
      emit(MovieWatchlistPageLoading());
      final result = await _getWatchlistMovies.execute();

      result.fold(
        (failure) {
          emit(MovieWatchlistPageError(failure.message));
        },
        (data) {
          emit(MovieWatchlistPageHasData(data));
        },
      );
    });
  }
}
