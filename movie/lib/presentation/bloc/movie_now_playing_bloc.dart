import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/movie_get_now_playing.dart';

part 'movie_now_playing_event.dart';
part 'movie_now_playing_state.dart';

class MovieNowPlayingBloc
    extends Bloc<MovieNowPlayingEvent, MovieNowPlayingState> {
  final GetNowPlayingMovies _getNowPlayingMovies;

  MovieNowPlayingBloc(this._getNowPlayingMovies)
      : super(MovieNowPlayingEmpty()) {
    on<MovieNowPlayingEvent>((event, emit) async {
      emit(MovieNowPlayingLoading());
      final result = await _getNowPlayingMovies.execute();

      result.fold(
        (failure) {
          emit(MovieNowPlayingError(failure.message));
        },
        (data) {
          emit(MovieNowPlayingHasData(data));
        },
      );
    });
  }
}
