part of 'tv_recommendation_bloc.dart';

abstract class TvRecommendationState extends Equatable {
  const TvRecommendationState();

  @override 
  List<Object> get props => [];
}

class TvRecommendationEmpty extends TvRecommendationState {}

class TvRecommendationLoading extends TvRecommendationState {}

class TvRecommendationError extends TvRecommendationState {
  final String message;

  TvRecommendationError(this.message);

  @override 
  List<Object> get props => [];
}

class TvRecommendationHasData extends TvRecommendationState {
  final List<Tv> tv;

  TvRecommendationHasData(this.tv);

  @override 
  List<Object> get props => [tv];
}