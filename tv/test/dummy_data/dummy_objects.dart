import 'package:tv/data/models/tv_table.dart';
import 'package:tv/domain/entities/genre.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/entities/tv_detail.dart';


final testTv = Tv(
  backdropPath: '/1qpUk27LVI9UoTS7S0EixUBj5aR.jpg',
  firstAirDate: "2022-03-24",
  genreIds: [10759, 10765],
  id: 52814,
  name: "Halo",
  overview:
      "Depicting an epic 26th-century conflict between humanity and an alien threat known as the Covenant, the series weaves deeply drawn personal stories with action, adventure and a richly imagined vision of the future.",
  posterPath: "/nJUHX3XL1jMkk8honUZnUmudFb9.jpg",
  voteAverage: 8.9,
  voteCount: 289,
);

final testTvList = [testTv];

final testTvDetail = TvDetail(
  adult: false,
  backdroppath: "backdropPath",
  firstAirDate: "firstAirDate",
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  name: "name",
  numberOfEpisodes: 1,
  numberOfSeasons: 1,
  overview: "overview",
  voteAverage: 1,
  voteCount: 1,
  posterPath: "posterPath",
);

final testWatchlistTv = Tv.watchlist(
  id: 1,
  name: "name",
  posterPath: "posterPath",
  overview: "overview",
);


final testTvTable = TvTable(
  id: 1,
  name: "name",
  posterPath: "posterPath",
  overview: "overview",
);

final testTvMap = {
  "id": 1,
  'name': "name",
  'posterPath': "posterPath",
  'overview': "overview",
};
