import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/entities/movie_detail.dart';
import 'package:movie/domain/usecases/movie_get_watchlist_status.dart';
import 'package:movie/domain/usecases/movie_remove_watchlist.dart';
import 'package:movie/domain/usecases/movie_save_watchlist.dart';

part 'movie_watchlist_event.dart';
part 'movie_watchlist_state.dart';

class MovieWatchlistBloc
    extends Bloc<MovieWatchlistEvent, MovieWatchlistState> {
  final GetWatchListStatus _getWatchListStatus;
  final SaveWatchlist _saveWatchlist;
  final RemoveWatchlist _removeWatchlist;

  MovieWatchlistBloc(
      this._getWatchListStatus, this._removeWatchlist, this._saveWatchlist)
      : super(MovieWatchlistEmpty()) {
    on<AddWatchList>((event, emit) async {
      final MovieDetail movie = event.movie;

      emit(MovieWatchlistLoading());
      final result = await _saveWatchlist.execute(movie);

      result.fold(
        (failure) {
          emit(MovieWatchlistError(failure.message));
        },
        (data) {
          emit(MovieWatchlistStatus(true));
        },
      );
    });
    on<RemoveWatchList>((event, emit) async {
      final MovieDetail movie = event.movie;

      emit(MovieWatchlistLoading());
      final result = await _removeWatchlist.execute(movie);

      result.fold(
        (failure) {
          emit(MovieWatchlistError(failure.message));
        },
        (data) {
          emit(MovieWatchlistStatus(false));
        },
      );
    });
    on<LoadWatchListStatus>((event, emit) async {
      final int id = event.id;

      emit(MovieWatchlistLoading());
      final result = await _getWatchListStatus.execute(id);

      emit(MovieWatchlistStatus(result));
    });
  }
}
