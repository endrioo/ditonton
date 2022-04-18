part of 'movie_watchlist_page_bloc.dart';

abstract class MovieWatchlistPageState extends Equatable {
  const MovieWatchlistPageState();

  @override 
  List<Object> get props => [];
}

class MovieWatchlistPageEmpty extends MovieWatchlistPageState {}

class MovieWatchlistPageLoading extends MovieWatchlistPageState {}

class MovieWatchlistPageError extends MovieWatchlistPageState {
  final String message;

  MovieWatchlistPageError(this.message);

  @override 
  List<Object> get props => [];
}

class MovieWatchlistPageHasData extends MovieWatchlistPageState {
  final List<Movie> result;

  MovieWatchlistPageHasData(this.result);

  @override 
  List<Object> get props => [result];
}