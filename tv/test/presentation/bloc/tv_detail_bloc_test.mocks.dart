// Mocks generated by Mockito 5.1.0 from annotations
// in tv/test/presentation/bloc/tv_detail_bloc_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;

import 'package:core/core.dart' as _i6;
import 'package:dartz/dartz.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;
import 'package:tv/domain/entities/tv_detail.dart' as _i7;
import 'package:tv/domain/repositories/tv_repository.dart' as _i2;
import 'package:tv/domain/usecases/tv_get_detail.dart' as _i4;

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

/// A class which mocks [GetTvDetail].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetTvDetail extends _i1.Mock implements _i4.GetTvDetail {
  MockGetTvDetail() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TvRepository get tvRepository =>
      (super.noSuchMethod(Invocation.getter(#tvRepository),
          returnValue: _FakeTvRepository_0()) as _i2.TvRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, _i7.TvDetail>> execute(int? id) =>
      (super.noSuchMethod(Invocation.method(#execute, [id]),
              returnValue: Future<_i3.Either<_i6.Failure, _i7.TvDetail>>.value(
                  _FakeEither_1<_i6.Failure, _i7.TvDetail>()))
          as _i5.Future<_i3.Either<_i6.Failure, _i7.TvDetail>>);
}
