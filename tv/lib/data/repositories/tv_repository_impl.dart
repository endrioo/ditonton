import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:core/utils/exception.dart';
import 'package:core/utils/failure.dart';
import 'package:tv/data/datasources/tv_local_data_source.dart';
import 'package:tv/data/datasources/tv_remote_data_source.dart';
import 'package:tv/data/models/tv_table.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/entities/tv_detail.dart';
import 'package:tv/domain/repositories/tv_repository.dart';

class TvRepositoryimpl implements TvRepository {
  final TvRemoteDataSource remoteDataSource;
  final TvLocalDataSource localDataSource;

  TvRepositoryimpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<Tv>>> getNowPlayingTv() async {
    try {
      final result = await remoteDataSource.getNowPlayingTv();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return left(ServerFailure(''));
    } on TlsException catch (e) {
      return Left(ConnectionFailure('Certificated not valid\n${e.message}'));
    } on SocketException {
      return left(ConnectionFailure('failed to connect to network'));
    }
  }

  @override
  Future<Either<Failure, TvDetail>> getTvDetail(int id) async {
    try {
      final result = await remoteDataSource.getTvDetail(id);
      return Right(result.toEntity());
    } on ServerException {
      return Left(ServerFailure(''));
    } on TlsException catch (e) {
      return Left(ConnectionFailure('Certificated not valid\n${e.message}'));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> getTvRecommendations(int id) async {
    try {
      final result = await remoteDataSource.getTvRecommendations(id);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on TlsException catch (e) {
      return Left(ConnectionFailure('Certificated not valid\n${e.message}'));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> getPopularTv() async {
    try {
      final result = await remoteDataSource.getPopularTv();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on TlsException catch (e) {
      return Left(ConnectionFailure('Certificated not valid\n${e.message}'));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> getTopRatedTv() async {
    try {
      final result = await remoteDataSource.getTopRatedTv();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on TlsException catch (e) {
      return Left(ConnectionFailure('Certificated not valid\n${e.message}'));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> searchTv(String query) async {
    try {
      final result = await remoteDataSource.searchTv(query);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on TlsException catch (e) {
      return Left(ConnectionFailure('Certificated not valid\n${e.message}'));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, String>> saveTvWatchlist(TvDetail movie) async {
    try {
      final result =
          await localDataSource.insertTvWatchlist(TvTable.fromEntity(movie));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<Either<Failure, String>> removeTvWatchlist(TvDetail movie) async {
    try {
      final result =
          await localDataSource.removeTvWatchlist(TvTable.fromEntity(movie));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<bool> isAddedToTvWatchlist(int id) async {
    final result = await localDataSource.getTvById(id);
    return result != null;
  }

  @override
  Future<Either<Failure, List<Tv>>> getWatchlistTv() async {
    final result = await localDataSource.getWatchlistTv();
    return Right(result.map((data) => data.toEntity()).toList());
  }
}
