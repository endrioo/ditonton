import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/movie_get_recommendations.dart';

part  "movie_recommendation_state.dart";
part  "movie_recommendation_event.dart";

class MovieRecommendationBloc extends Bloc<MovieRecommendationEvent, MovieRecommendationState> {
  final GetMovieRecommendations _getMovieRecommendation;

  MovieRecommendationBloc(this._getMovieRecommendation) : super(MovieRecommendationEmpty()) {
    on<OnFetchMovieRecommendation>((event, emit) async {
      final id = event.id;

      emit(MovieRecommendationLoading());
      final result = await _getMovieRecommendation.execute(id);

      result.fold(
        (failure) {
          emit(MovieRecommendationError(failure.message));
        },
        (data) {
          emit(MovieRecommendationHasData(data));
        },
      );
    });
  }
}
