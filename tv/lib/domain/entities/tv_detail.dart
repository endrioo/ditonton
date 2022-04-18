import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/genre.dart';

class TvDetail extends Equatable {
  TvDetail({
    required this.adult,
    required this.backdroppath,
    required this.firstAirDate,
    required this.genres,
    required this.id,
    required this.name,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.overview,
    required this.voteAverage,
    required this.voteCount,
    required this.posterPath,
  });

  final bool adult;
  final String? backdroppath;
  final String firstAirDate;
  final List<Genre> genres;
  final int id;
  final String name;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final String overview;
  final double voteAverage;
  final int voteCount;
  final String? posterPath;

  @override
  List<Object?> get props => [
        adult,
        backdroppath,
        firstAirDate,
        genres,
        id,
        name,
        numberOfEpisodes,
        numberOfSeasons,
        overview,
        voteAverage,
        voteCount,
        posterPath,
      ];
}
