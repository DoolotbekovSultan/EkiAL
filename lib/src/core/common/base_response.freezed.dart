// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'base_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BaseResponse<T> {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BaseResponse<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BaseResponse<$T>()';
}


}

/// @nodoc
class $BaseResponseCopyWith<T,$Res>  {
$BaseResponseCopyWith(BaseResponse<T> _, $Res Function(BaseResponse<T>) __);
}


/// Adds pattern-matching-related methods to [BaseResponse].
extension BaseResponsePatterns<T> on BaseResponse<T> {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Success<T> value)?  success,TResult Function( _Error<T> value)?  error,TResult Function( _Loading<T> value)?  loading,TResult Function( _Empty<T> value)?  empty,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Success() when success != null:
return success(_that);case _Error() when error != null:
return error(_that);case _Loading() when loading != null:
return loading(_that);case _Empty() when empty != null:
return empty(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Success<T> value)  success,required TResult Function( _Error<T> value)  error,required TResult Function( _Loading<T> value)  loading,required TResult Function( _Empty<T> value)  empty,}){
final _that = this;
switch (_that) {
case _Success():
return success(_that);case _Error():
return error(_that);case _Loading():
return loading(_that);case _Empty():
return empty(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Success<T> value)?  success,TResult? Function( _Error<T> value)?  error,TResult? Function( _Loading<T> value)?  loading,TResult? Function( _Empty<T> value)?  empty,}){
final _that = this;
switch (_that) {
case _Success() when success != null:
return success(_that);case _Error() when error != null:
return error(_that);case _Loading() when loading != null:
return loading(_that);case _Empty() when empty != null:
return empty(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( T data,  String? message,  int statusCode)?  success,TResult Function( String message,  int statusCode,  dynamic errorData)?  error,TResult Function()?  loading,TResult Function()?  empty,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Success() when success != null:
return success(_that.data,_that.message,_that.statusCode);case _Error() when error != null:
return error(_that.message,_that.statusCode,_that.errorData);case _Loading() when loading != null:
return loading();case _Empty() when empty != null:
return empty();case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( T data,  String? message,  int statusCode)  success,required TResult Function( String message,  int statusCode,  dynamic errorData)  error,required TResult Function()  loading,required TResult Function()  empty,}) {final _that = this;
switch (_that) {
case _Success():
return success(_that.data,_that.message,_that.statusCode);case _Error():
return error(_that.message,_that.statusCode,_that.errorData);case _Loading():
return loading();case _Empty():
return empty();case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( T data,  String? message,  int statusCode)?  success,TResult? Function( String message,  int statusCode,  dynamic errorData)?  error,TResult? Function()?  loading,TResult? Function()?  empty,}) {final _that = this;
switch (_that) {
case _Success() when success != null:
return success(_that.data,_that.message,_that.statusCode);case _Error() when error != null:
return error(_that.message,_that.statusCode,_that.errorData);case _Loading() when loading != null:
return loading();case _Empty() when empty != null:
return empty();case _:
  return null;

}
}

}

/// @nodoc


class _Success<T> extends BaseResponse<T> {
  const _Success({required this.data, this.message, this.statusCode = 200}): super._();
  

 final  T data;
 final  String? message;
@JsonKey() final  int statusCode;

/// Create a copy of BaseResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SuccessCopyWith<T, _Success<T>> get copyWith => __$SuccessCopyWithImpl<T, _Success<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Success<T>&&const DeepCollectionEquality().equals(other.data, data)&&(identical(other.message, message) || other.message == message)&&(identical(other.statusCode, statusCode) || other.statusCode == statusCode));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(data),message,statusCode);

@override
String toString() {
  return 'BaseResponse<$T>.success(data: $data, message: $message, statusCode: $statusCode)';
}


}

/// @nodoc
abstract mixin class _$SuccessCopyWith<T,$Res> implements $BaseResponseCopyWith<T, $Res> {
  factory _$SuccessCopyWith(_Success<T> value, $Res Function(_Success<T>) _then) = __$SuccessCopyWithImpl;
@useResult
$Res call({
 T data, String? message, int statusCode
});




}
/// @nodoc
class __$SuccessCopyWithImpl<T,$Res>
    implements _$SuccessCopyWith<T, $Res> {
  __$SuccessCopyWithImpl(this._self, this._then);

  final _Success<T> _self;
  final $Res Function(_Success<T>) _then;

/// Create a copy of BaseResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = freezed,Object? message = freezed,Object? statusCode = null,}) {
  return _then(_Success<T>(
data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as T,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,statusCode: null == statusCode ? _self.statusCode : statusCode // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _Error<T> extends BaseResponse<T> {
  const _Error({required this.message, this.statusCode = 500, this.errorData}): super._();
  

 final  String message;
@JsonKey() final  int statusCode;
 final  dynamic errorData;

/// Create a copy of BaseResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ErrorCopyWith<T, _Error<T>> get copyWith => __$ErrorCopyWithImpl<T, _Error<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Error<T>&&(identical(other.message, message) || other.message == message)&&(identical(other.statusCode, statusCode) || other.statusCode == statusCode)&&const DeepCollectionEquality().equals(other.errorData, errorData));
}


@override
int get hashCode => Object.hash(runtimeType,message,statusCode,const DeepCollectionEquality().hash(errorData));

@override
String toString() {
  return 'BaseResponse<$T>.error(message: $message, statusCode: $statusCode, errorData: $errorData)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<T,$Res> implements $BaseResponseCopyWith<T, $Res> {
  factory _$ErrorCopyWith(_Error<T> value, $Res Function(_Error<T>) _then) = __$ErrorCopyWithImpl;
@useResult
$Res call({
 String message, int statusCode, dynamic errorData
});




}
/// @nodoc
class __$ErrorCopyWithImpl<T,$Res>
    implements _$ErrorCopyWith<T, $Res> {
  __$ErrorCopyWithImpl(this._self, this._then);

  final _Error<T> _self;
  final $Res Function(_Error<T>) _then;

/// Create a copy of BaseResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,Object? statusCode = null,Object? errorData = freezed,}) {
  return _then(_Error<T>(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,statusCode: null == statusCode ? _self.statusCode : statusCode // ignore: cast_nullable_to_non_nullable
as int,errorData: freezed == errorData ? _self.errorData : errorData // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}


}

/// @nodoc


class _Loading<T> extends BaseResponse<T> {
  const _Loading(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BaseResponse<$T>.loading()';
}


}




/// @nodoc


class _Empty<T> extends BaseResponse<T> {
  const _Empty(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Empty<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BaseResponse<$T>.empty()';
}


}




// dart format on
