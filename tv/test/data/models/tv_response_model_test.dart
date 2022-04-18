import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tv/data/models/tv_model.dart';
import 'package:tv/data/models/tv_response.dart';

import '../../json_reader.dart';


void main() {
  final tTvModel = TvModel(
    backdropPath: "/path.jpg",
    firstAirDate: "firstAirDate",
    genreIds: [1, 2],
    id: 1,
    name: "name",
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1.0,
    posterPath: '/path.jpg',
    voteAverage: 1,
    voteCount: 1,
  );

  final tTvResponseModel = TvResponse(tvList: <TvModel>[tTvModel]);

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/tv_now_playing.json'));
      // act
      final result = TvResponse.fromJson(jsonMap);
      // assert
      expect(result, tTvResponseModel);
    });
  });

  group('toJson', () {
    test('should return JSON map containing poper data', () async {
      // arrange
      final result = tTvResponseModel.toJson();
      // act
      final expectedJsonMap = {
        "result": [
          {
            'backdropPath': "/path.jpg",
            'firstAirDate': "firstAirDate",
            'genreIds': [1, 2],
            'id': 1,
            'name': "name",
            'originalName': 'originalName',
            'overview': 'overview',
            'popularity': 1.0,
            'posterPath': '/path.jpg',
            'voteAverage': 1,
            'voteCount': 1,
          }
        ],
      };
      // assert
      expect(result, expectedJsonMap);
    });
  });
}
