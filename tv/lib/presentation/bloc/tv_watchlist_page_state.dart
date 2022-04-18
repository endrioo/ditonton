part of 'tv_watchlist_page_bloc.dart';

abstract class TvWatchlistPageState extends Equatable {
  const TvWatchlistPageState();

  @override 
  List<Object> get props => [];
}

class TvWatchlistPageEmpty extends TvWatchlistPageState {}

class TvWatchlistPageLoading extends TvWatchlistPageState {}

class TvWatchlistPageError extends TvWatchlistPageState {
  final String message;

  TvWatchlistPageError(this.message);

  @override 
  List<Object> get props => [];
}

class TvWatchlistPageHasData extends TvWatchlistPageState {
  final List<Tv> result;

  TvWatchlistPageHasData(this.result);

  @override 
  List<Object> get props => [result];
}