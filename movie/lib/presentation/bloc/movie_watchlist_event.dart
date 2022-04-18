part of 'movie_watchlist_bloc.dart';

abstract class MovieWatchlistEvent extends Equatable {
  const MovieWatchlistEvent();

  @override
  List<Object> get props => [];
}

class FetchWatchlistMovie extends MovieWatchlistEvent {}

class AddWatchList extends MovieWatchlistEvent {
  final MovieDetail movie;

  AddWatchList(this.movie);

  @override
  List<Object> get props => [Movie];
}

class RemoveWatchList extends MovieWatchlistEvent {
  final MovieDetail movie;

  RemoveWatchList(this.movie);

  @override
  List<Object> get props => [Movie];
}

class LoadWatchListStatus extends MovieWatchlistEvent {
  final int id;

  LoadWatchListStatus(this.id);

  @override
  List<Object> get props => [id];
}