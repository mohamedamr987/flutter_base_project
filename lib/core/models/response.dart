import 'package:freezed_annotation/freezed_annotation.dart';

part 'response.freezed.dart';

@freezed
class ResponseModel<T> with _$ResponseModel<T> {
  const factory ResponseModel.initial() = Initial<T>;
  const factory ResponseModel.loading() = Loading<T>;
  const factory ResponseModel.loaded(T data) = Loaded<T>;
  const factory ResponseModel.error({String? message}) = Error<T>;
  const factory ResponseModel.paginationLoading(T data) = PaginationLoading<T>;
}
