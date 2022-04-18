part of 'tv_watchlist_bloc.dart';

abstract class TvWatchlistEvent extends Equatable {
  const TvWatchlistEvent();

  @override
  List<Object> get props => [];
}

class FetchWatchlistTv extends TvWatchlistEvent {}

class AddWatchList extends TvWatchlistEvent {
  final TvDetail tv;

  AddWatchList(this.tv);

  @override
  List<Object> get props => [Tv];
}

class RemoveWatchList extends TvWatchlistEvent {
  final TvDetail tv;

  RemoveWatchList(this.tv);

  @override
  List<Object> get props => [Tv];
}

class LoadWatchListStatus extends TvWatchlistEvent {
  final int id;

  LoadWatchListStatus(this.id);

  @override
  List<Object> get props => [id];
}