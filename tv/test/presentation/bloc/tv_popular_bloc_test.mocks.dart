// Mocks generated by Mockito 5.1.0 from annotations
// in tv/test/presentation/bloc/tv_popular_bloc_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;

import 'package:core/core.dart' as _i6;
import 'package:dartz/dartz.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;
import 'package:tv/domain/entities/tv.dart' as _i7;
import 'package:tv/domain/repositories/tv_repository.dart' as _i2;
import 'package:tv/domain/usecases/tv_get_popular.dart' as _i4;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeTvRepository_0 extends _i1.Fake implements _i2.TvRepository {}

class _FakeEither_1<L, R> extends _i1.Fake implements _i3.Either<L, R> {}

/// A class which mocks [GetPopularTv].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetPopularTv extends _i1.Mock implements _i4.GetPopularTv {
  MockGetPopularTv() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TvRepository get tvRepository =>
      (super.noSuchMethod(Invocation.getter(#tvRepository),
          returnValue: _FakeTvRepository_0()) as _i2.TvRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i7.Tv>>> execute() =>
      (super.noSuchMethod(Invocation.method(#execute, []),
              returnValue: Future<_i3.Either<_i6.Failure, List<_i7.Tv>>>.value(
                  _FakeEither_1<_i6.Failure, List<_i7.Tv>>()))
          as _i5.Future<_i3.Either<_i6.Failure, List<_i7.Tv>>>);
}
