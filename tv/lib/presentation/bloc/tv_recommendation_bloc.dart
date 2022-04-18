import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/tv_get_recommendations.dart';

part 'tv_recommendation_event.dart';
part 'tv_recommendation_state.dart';


class TvRecommendationBloc extends Bloc<TvRecommendationEvent, TvRecommendationState> {
  final GetTvRecommendations _getTvRecommendation;

  TvRecommendationBloc(this._getTvRecommendation) : super(TvRecommendationEmpty()) {
    on<OnFetchTvRecommendation>((event, emit) async {
      final id = event.id;

      emit(TvRecommendationLoading());
      final result = await _getTvRecommendation.execute(id);

      result.fold(
        (failure) {
          emit(TvRecommendationError(failure.message));
        },
        (data) {
          emit(TvRecommendationHasData(data));
        },
      );
    });
  }
}