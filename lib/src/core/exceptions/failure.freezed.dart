// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Failure {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Failure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Failure()';
}


}

/// @nodoc
class $FailureCopyWith<$Res>  {
$FailureCopyWith(Failure _, $Res Function(Failure) __);
}


/// Adds pattern-matching-related methods to [Failure].
extension FailurePatterns on Failure {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( NetworkFailure value)?  network,TResult Function( TimeoutFailure value)?  timeout,TResult Function( ServerFailure value)?  server,TResult Function( ClientFailure value)?  client,TResult Function( AuthFailure value)?  auth,TResult Function( LocalStorageFailure value)?  localStorage,TResult Function( CacheFailure value)?  cache,TResult Function( DatabaseFailure value)?  database,TResult Function( ValidationFailure value)?  validation,TResult Function( UnknownFailure value)?  unknown,TResult Function( NetworkNoInternetFailure value)?  networkNoInternet,TResult Function( NetworkBadCertificateFailure value)?  networkBadCertificate,TResult Function( NetworkCancelledFailure value)?  networkCancelled,TResult Function( ServerBadRequestFailure value)?  serverBadRequest,TResult Function( ServerNotFoundFailure value)?  serverNotFound,TResult Function( ServerValidationFailure value)?  serverValidationError,TResult Function( ServerTooManyRequestsFailure value)?  serverTooManyRequests,TResult Function( ServerInternalErrorFailure value)?  serverInternalError,TResult Function( ClientBadRequestFailure value)?  clientBadRequest,TResult Function( ClientUnauthorizedFailure value)?  clientUnauthorized,TResult Function( ClientForbiddenFailure value)?  clientForbidden,TResult Function( ClientNotFoundFailure value)?  clientNotFound,TResult Function( ClientValidationFailure value)?  clientValidationError,TResult Function( AuthUnauthorizedFailure value)?  authUnauthorized,TResult Function( AuthForbiddenFailure value)?  authForbidden,TResult Function( AuthExpiredFailure value)?  authExpired,required TResult orElse(),}){
final _that = this;
switch (_that) {
case NetworkFailure() when network != null:
return network(_that);case TimeoutFailure() when timeout != null:
return timeout(_that);case ServerFailure() when server != null:
return server(_that);case ClientFailure() when client != null:
return client(_that);case AuthFailure() when auth != null:
return auth(_that);case LocalStorageFailure() when localStorage != null:
return localStorage(_that);case CacheFailure() when cache != null:
return cache(_that);case DatabaseFailure() when database != null:
return database(_that);case ValidationFailure() when validation != null:
return validation(_that);case UnknownFailure() when unknown != null:
return unknown(_that);case NetworkNoInternetFailure() when networkNoInternet != null:
return networkNoInternet(_that);case NetworkBadCertificateFailure() when networkBadCertificate != null:
return networkBadCertificate(_that);case NetworkCancelledFailure() when networkCancelled != null:
return networkCancelled(_that);case ServerBadRequestFailure() when serverBadRequest != null:
return serverBadRequest(_that);case ServerNotFoundFailure() when serverNotFound != null:
return serverNotFound(_that);case ServerValidationFailure() when serverValidationError != null:
return serverValidationError(_that);case ServerTooManyRequestsFailure() when serverTooManyRequests != null:
return serverTooManyRequests(_that);case ServerInternalErrorFailure() when serverInternalError != null:
return serverInternalError(_that);case ClientBadRequestFailure() when clientBadRequest != null:
return clientBadRequest(_that);case ClientUnauthorizedFailure() when clientUnauthorized != null:
return clientUnauthorized(_that);case ClientForbiddenFailure() when clientForbidden != null:
return clientForbidden(_that);case ClientNotFoundFailure() when clientNotFound != null:
return clientNotFound(_that);case ClientValidationFailure() when clientValidationError != null:
return clientValidationError(_that);case AuthUnauthorizedFailure() when authUnauthorized != null:
return authUnauthorized(_that);case AuthForbiddenFailure() when authForbidden != null:
return authForbidden(_that);case AuthExpiredFailure() when authExpired != null:
return authExpired(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( NetworkFailure value)  network,required TResult Function( TimeoutFailure value)  timeout,required TResult Function( ServerFailure value)  server,required TResult Function( ClientFailure value)  client,required TResult Function( AuthFailure value)  auth,required TResult Function( LocalStorageFailure value)  localStorage,required TResult Function( CacheFailure value)  cache,required TResult Function( DatabaseFailure value)  database,required TResult Function( ValidationFailure value)  validation,required TResult Function( UnknownFailure value)  unknown,required TResult Function( NetworkNoInternetFailure value)  networkNoInternet,required TResult Function( NetworkBadCertificateFailure value)  networkBadCertificate,required TResult Function( NetworkCancelledFailure value)  networkCancelled,required TResult Function( ServerBadRequestFailure value)  serverBadRequest,required TResult Function( ServerNotFoundFailure value)  serverNotFound,required TResult Function( ServerValidationFailure value)  serverValidationError,required TResult Function( ServerTooManyRequestsFailure value)  serverTooManyRequests,required TResult Function( ServerInternalErrorFailure value)  serverInternalError,required TResult Function( ClientBadRequestFailure value)  clientBadRequest,required TResult Function( ClientUnauthorizedFailure value)  clientUnauthorized,required TResult Function( ClientForbiddenFailure value)  clientForbidden,required TResult Function( ClientNotFoundFailure value)  clientNotFound,required TResult Function( ClientValidationFailure value)  clientValidationError,required TResult Function( AuthUnauthorizedFailure value)  authUnauthorized,required TResult Function( AuthForbiddenFailure value)  authForbidden,required TResult Function( AuthExpiredFailure value)  authExpired,}){
final _that = this;
switch (_that) {
case NetworkFailure():
return network(_that);case TimeoutFailure():
return timeout(_that);case ServerFailure():
return server(_that);case ClientFailure():
return client(_that);case AuthFailure():
return auth(_that);case LocalStorageFailure():
return localStorage(_that);case CacheFailure():
return cache(_that);case DatabaseFailure():
return database(_that);case ValidationFailure():
return validation(_that);case UnknownFailure():
return unknown(_that);case NetworkNoInternetFailure():
return networkNoInternet(_that);case NetworkBadCertificateFailure():
return networkBadCertificate(_that);case NetworkCancelledFailure():
return networkCancelled(_that);case ServerBadRequestFailure():
return serverBadRequest(_that);case ServerNotFoundFailure():
return serverNotFound(_that);case ServerValidationFailure():
return serverValidationError(_that);case ServerTooManyRequestsFailure():
return serverTooManyRequests(_that);case ServerInternalErrorFailure():
return serverInternalError(_that);case ClientBadRequestFailure():
return clientBadRequest(_that);case ClientUnauthorizedFailure():
return clientUnauthorized(_that);case ClientForbiddenFailure():
return clientForbidden(_that);case ClientNotFoundFailure():
return clientNotFound(_that);case ClientValidationFailure():
return clientValidationError(_that);case AuthUnauthorizedFailure():
return authUnauthorized(_that);case AuthForbiddenFailure():
return authForbidden(_that);case AuthExpiredFailure():
return authExpired(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( NetworkFailure value)?  network,TResult? Function( TimeoutFailure value)?  timeout,TResult? Function( ServerFailure value)?  server,TResult? Function( ClientFailure value)?  client,TResult? Function( AuthFailure value)?  auth,TResult? Function( LocalStorageFailure value)?  localStorage,TResult? Function( CacheFailure value)?  cache,TResult? Function( DatabaseFailure value)?  database,TResult? Function( ValidationFailure value)?  validation,TResult? Function( UnknownFailure value)?  unknown,TResult? Function( NetworkNoInternetFailure value)?  networkNoInternet,TResult? Function( NetworkBadCertificateFailure value)?  networkBadCertificate,TResult? Function( NetworkCancelledFailure value)?  networkCancelled,TResult? Function( ServerBadRequestFailure value)?  serverBadRequest,TResult? Function( ServerNotFoundFailure value)?  serverNotFound,TResult? Function( ServerValidationFailure value)?  serverValidationError,TResult? Function( ServerTooManyRequestsFailure value)?  serverTooManyRequests,TResult? Function( ServerInternalErrorFailure value)?  serverInternalError,TResult? Function( ClientBadRequestFailure value)?  clientBadRequest,TResult? Function( ClientUnauthorizedFailure value)?  clientUnauthorized,TResult? Function( ClientForbiddenFailure value)?  clientForbidden,TResult? Function( ClientNotFoundFailure value)?  clientNotFound,TResult? Function( ClientValidationFailure value)?  clientValidationError,TResult? Function( AuthUnauthorizedFailure value)?  authUnauthorized,TResult? Function( AuthForbiddenFailure value)?  authForbidden,TResult? Function( AuthExpiredFailure value)?  authExpired,}){
final _that = this;
switch (_that) {
case NetworkFailure() when network != null:
return network(_that);case TimeoutFailure() when timeout != null:
return timeout(_that);case ServerFailure() when server != null:
return server(_that);case ClientFailure() when client != null:
return client(_that);case AuthFailure() when auth != null:
return auth(_that);case LocalStorageFailure() when localStorage != null:
return localStorage(_that);case CacheFailure() when cache != null:
return cache(_that);case DatabaseFailure() when database != null:
return database(_that);case ValidationFailure() when validation != null:
return validation(_that);case UnknownFailure() when unknown != null:
return unknown(_that);case NetworkNoInternetFailure() when networkNoInternet != null:
return networkNoInternet(_that);case NetworkBadCertificateFailure() when networkBadCertificate != null:
return networkBadCertificate(_that);case NetworkCancelledFailure() when networkCancelled != null:
return networkCancelled(_that);case ServerBadRequestFailure() when serverBadRequest != null:
return serverBadRequest(_that);case ServerNotFoundFailure() when serverNotFound != null:
return serverNotFound(_that);case ServerValidationFailure() when serverValidationError != null:
return serverValidationError(_that);case ServerTooManyRequestsFailure() when serverTooManyRequests != null:
return serverTooManyRequests(_that);case ServerInternalErrorFailure() when serverInternalError != null:
return serverInternalError(_that);case ClientBadRequestFailure() when clientBadRequest != null:
return clientBadRequest(_that);case ClientUnauthorizedFailure() when clientUnauthorized != null:
return clientUnauthorized(_that);case ClientForbiddenFailure() when clientForbidden != null:
return clientForbidden(_that);case ClientNotFoundFailure() when clientNotFound != null:
return clientNotFound(_that);case ClientValidationFailure() when clientValidationError != null:
return clientValidationError(_that);case AuthUnauthorizedFailure() when authUnauthorized != null:
return authUnauthorized(_that);case AuthForbiddenFailure() when authForbidden != null:
return authForbidden(_that);case AuthExpiredFailure() when authExpired != null:
return authExpired(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String message,  String code)?  network,TResult Function( String message,  String code)?  timeout,TResult Function( String message,  String code,  int? statusCode)?  server,TResult Function( String message,  String code,  int? statusCode)?  client,TResult Function( String message,  String code)?  auth,TResult Function( String message,  String code)?  localStorage,TResult Function( String message,  String code)?  cache,TResult Function( String message,  String code)?  database,TResult Function( String message,  String code)?  validation,TResult Function( String message,  String code)?  unknown,TResult Function()?  networkNoInternet,TResult Function()?  networkBadCertificate,TResult Function()?  networkCancelled,TResult Function( String? message)?  serverBadRequest,TResult Function( String? message)?  serverNotFound,TResult Function( String? message,  Map<String, List<String>>? errors)?  serverValidationError,TResult Function()?  serverTooManyRequests,TResult Function( String? message,  int statusCode)?  serverInternalError,TResult Function( String? message)?  clientBadRequest,TResult Function()?  clientUnauthorized,TResult Function()?  clientForbidden,TResult Function( String? message)?  clientNotFound,TResult Function( String? message,  Map<String, List<String>>? errors)?  clientValidationError,TResult Function()?  authUnauthorized,TResult Function()?  authForbidden,TResult Function()?  authExpired,required TResult orElse(),}) {final _that = this;
switch (_that) {
case NetworkFailure() when network != null:
return network(_that.message,_that.code);case TimeoutFailure() when timeout != null:
return timeout(_that.message,_that.code);case ServerFailure() when server != null:
return server(_that.message,_that.code,_that.statusCode);case ClientFailure() when client != null:
return client(_that.message,_that.code,_that.statusCode);case AuthFailure() when auth != null:
return auth(_that.message,_that.code);case LocalStorageFailure() when localStorage != null:
return localStorage(_that.message,_that.code);case CacheFailure() when cache != null:
return cache(_that.message,_that.code);case DatabaseFailure() when database != null:
return database(_that.message,_that.code);case ValidationFailure() when validation != null:
return validation(_that.message,_that.code);case UnknownFailure() when unknown != null:
return unknown(_that.message,_that.code);case NetworkNoInternetFailure() when networkNoInternet != null:
return networkNoInternet();case NetworkBadCertificateFailure() when networkBadCertificate != null:
return networkBadCertificate();case NetworkCancelledFailure() when networkCancelled != null:
return networkCancelled();case ServerBadRequestFailure() when serverBadRequest != null:
return serverBadRequest(_that.message);case ServerNotFoundFailure() when serverNotFound != null:
return serverNotFound(_that.message);case ServerValidationFailure() when serverValidationError != null:
return serverValidationError(_that.message,_that.errors);case ServerTooManyRequestsFailure() when serverTooManyRequests != null:
return serverTooManyRequests();case ServerInternalErrorFailure() when serverInternalError != null:
return serverInternalError(_that.message,_that.statusCode);case ClientBadRequestFailure() when clientBadRequest != null:
return clientBadRequest(_that.message);case ClientUnauthorizedFailure() when clientUnauthorized != null:
return clientUnauthorized();case ClientForbiddenFailure() when clientForbidden != null:
return clientForbidden();case ClientNotFoundFailure() when clientNotFound != null:
return clientNotFound(_that.message);case ClientValidationFailure() when clientValidationError != null:
return clientValidationError(_that.message,_that.errors);case AuthUnauthorizedFailure() when authUnauthorized != null:
return authUnauthorized();case AuthForbiddenFailure() when authForbidden != null:
return authForbidden();case AuthExpiredFailure() when authExpired != null:
return authExpired();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String message,  String code)  network,required TResult Function( String message,  String code)  timeout,required TResult Function( String message,  String code,  int? statusCode)  server,required TResult Function( String message,  String code,  int? statusCode)  client,required TResult Function( String message,  String code)  auth,required TResult Function( String message,  String code)  localStorage,required TResult Function( String message,  String code)  cache,required TResult Function( String message,  String code)  database,required TResult Function( String message,  String code)  validation,required TResult Function( String message,  String code)  unknown,required TResult Function()  networkNoInternet,required TResult Function()  networkBadCertificate,required TResult Function()  networkCancelled,required TResult Function( String? message)  serverBadRequest,required TResult Function( String? message)  serverNotFound,required TResult Function( String? message,  Map<String, List<String>>? errors)  serverValidationError,required TResult Function()  serverTooManyRequests,required TResult Function( String? message,  int statusCode)  serverInternalError,required TResult Function( String? message)  clientBadRequest,required TResult Function()  clientUnauthorized,required TResult Function()  clientForbidden,required TResult Function( String? message)  clientNotFound,required TResult Function( String? message,  Map<String, List<String>>? errors)  clientValidationError,required TResult Function()  authUnauthorized,required TResult Function()  authForbidden,required TResult Function()  authExpired,}) {final _that = this;
switch (_that) {
case NetworkFailure():
return network(_that.message,_that.code);case TimeoutFailure():
return timeout(_that.message,_that.code);case ServerFailure():
return server(_that.message,_that.code,_that.statusCode);case ClientFailure():
return client(_that.message,_that.code,_that.statusCode);case AuthFailure():
return auth(_that.message,_that.code);case LocalStorageFailure():
return localStorage(_that.message,_that.code);case CacheFailure():
return cache(_that.message,_that.code);case DatabaseFailure():
return database(_that.message,_that.code);case ValidationFailure():
return validation(_that.message,_that.code);case UnknownFailure():
return unknown(_that.message,_that.code);case NetworkNoInternetFailure():
return networkNoInternet();case NetworkBadCertificateFailure():
return networkBadCertificate();case NetworkCancelledFailure():
return networkCancelled();case ServerBadRequestFailure():
return serverBadRequest(_that.message);case ServerNotFoundFailure():
return serverNotFound(_that.message);case ServerValidationFailure():
return serverValidationError(_that.message,_that.errors);case ServerTooManyRequestsFailure():
return serverTooManyRequests();case ServerInternalErrorFailure():
return serverInternalError(_that.message,_that.statusCode);case ClientBadRequestFailure():
return clientBadRequest(_that.message);case ClientUnauthorizedFailure():
return clientUnauthorized();case ClientForbiddenFailure():
return clientForbidden();case ClientNotFoundFailure():
return clientNotFound(_that.message);case ClientValidationFailure():
return clientValidationError(_that.message,_that.errors);case AuthUnauthorizedFailure():
return authUnauthorized();case AuthForbiddenFailure():
return authForbidden();case AuthExpiredFailure():
return authExpired();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String message,  String code)?  network,TResult? Function( String message,  String code)?  timeout,TResult? Function( String message,  String code,  int? statusCode)?  server,TResult? Function( String message,  String code,  int? statusCode)?  client,TResult? Function( String message,  String code)?  auth,TResult? Function( String message,  String code)?  localStorage,TResult? Function( String message,  String code)?  cache,TResult? Function( String message,  String code)?  database,TResult? Function( String message,  String code)?  validation,TResult? Function( String message,  String code)?  unknown,TResult? Function()?  networkNoInternet,TResult? Function()?  networkBadCertificate,TResult? Function()?  networkCancelled,TResult? Function( String? message)?  serverBadRequest,TResult? Function( String? message)?  serverNotFound,TResult? Function( String? message,  Map<String, List<String>>? errors)?  serverValidationError,TResult? Function()?  serverTooManyRequests,TResult? Function( String? message,  int statusCode)?  serverInternalError,TResult? Function( String? message)?  clientBadRequest,TResult? Function()?  clientUnauthorized,TResult? Function()?  clientForbidden,TResult? Function( String? message)?  clientNotFound,TResult? Function( String? message,  Map<String, List<String>>? errors)?  clientValidationError,TResult? Function()?  authUnauthorized,TResult? Function()?  authForbidden,TResult? Function()?  authExpired,}) {final _that = this;
switch (_that) {
case NetworkFailure() when network != null:
return network(_that.message,_that.code);case TimeoutFailure() when timeout != null:
return timeout(_that.message,_that.code);case ServerFailure() when server != null:
return server(_that.message,_that.code,_that.statusCode);case ClientFailure() when client != null:
return client(_that.message,_that.code,_that.statusCode);case AuthFailure() when auth != null:
return auth(_that.message,_that.code);case LocalStorageFailure() when localStorage != null:
return localStorage(_that.message,_that.code);case CacheFailure() when cache != null:
return cache(_that.message,_that.code);case DatabaseFailure() when database != null:
return database(_that.message,_that.code);case ValidationFailure() when validation != null:
return validation(_that.message,_that.code);case UnknownFailure() when unknown != null:
return unknown(_that.message,_that.code);case NetworkNoInternetFailure() when networkNoInternet != null:
return networkNoInternet();case NetworkBadCertificateFailure() when networkBadCertificate != null:
return networkBadCertificate();case NetworkCancelledFailure() when networkCancelled != null:
return networkCancelled();case ServerBadRequestFailure() when serverBadRequest != null:
return serverBadRequest(_that.message);case ServerNotFoundFailure() when serverNotFound != null:
return serverNotFound(_that.message);case ServerValidationFailure() when serverValidationError != null:
return serverValidationError(_that.message,_that.errors);case ServerTooManyRequestsFailure() when serverTooManyRequests != null:
return serverTooManyRequests();case ServerInternalErrorFailure() when serverInternalError != null:
return serverInternalError(_that.message,_that.statusCode);case ClientBadRequestFailure() when clientBadRequest != null:
return clientBadRequest(_that.message);case ClientUnauthorizedFailure() when clientUnauthorized != null:
return clientUnauthorized();case ClientForbiddenFailure() when clientForbidden != null:
return clientForbidden();case ClientNotFoundFailure() when clientNotFound != null:
return clientNotFound(_that.message);case ClientValidationFailure() when clientValidationError != null:
return clientValidationError(_that.message,_that.errors);case AuthUnauthorizedFailure() when authUnauthorized != null:
return authUnauthorized();case AuthForbiddenFailure() when authForbidden != null:
return authForbidden();case AuthExpiredFailure() when authExpired != null:
return authExpired();case _:
  return null;

}
}

}

/// @nodoc


class NetworkFailure extends Failure {
  const NetworkFailure({this.message = 'Ошибка сети', this.code = 'NETWORK_ERROR'}): super._();
  

@JsonKey() final  String message;
@JsonKey() final  String code;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NetworkFailureCopyWith<NetworkFailure> get copyWith => _$NetworkFailureCopyWithImpl<NetworkFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NetworkFailure&&(identical(other.message, message) || other.message == message)&&(identical(other.code, code) || other.code == code));
}


@override
int get hashCode => Object.hash(runtimeType,message,code);

@override
String toString() {
  return 'Failure.network(message: $message, code: $code)';
}


}

/// @nodoc
abstract mixin class $NetworkFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $NetworkFailureCopyWith(NetworkFailure value, $Res Function(NetworkFailure) _then) = _$NetworkFailureCopyWithImpl;
@useResult
$Res call({
 String message, String code
});




}
/// @nodoc
class _$NetworkFailureCopyWithImpl<$Res>
    implements $NetworkFailureCopyWith<$Res> {
  _$NetworkFailureCopyWithImpl(this._self, this._then);

  final NetworkFailure _self;
  final $Res Function(NetworkFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,Object? code = null,}) {
  return _then(NetworkFailure(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class TimeoutFailure extends Failure {
  const TimeoutFailure({this.message = 'Превышено время ожидания', this.code = 'TIMEOUT_ERROR'}): super._();
  

@JsonKey() final  String message;
@JsonKey() final  String code;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TimeoutFailureCopyWith<TimeoutFailure> get copyWith => _$TimeoutFailureCopyWithImpl<TimeoutFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimeoutFailure&&(identical(other.message, message) || other.message == message)&&(identical(other.code, code) || other.code == code));
}


@override
int get hashCode => Object.hash(runtimeType,message,code);

@override
String toString() {
  return 'Failure.timeout(message: $message, code: $code)';
}


}

/// @nodoc
abstract mixin class $TimeoutFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $TimeoutFailureCopyWith(TimeoutFailure value, $Res Function(TimeoutFailure) _then) = _$TimeoutFailureCopyWithImpl;
@useResult
$Res call({
 String message, String code
});




}
/// @nodoc
class _$TimeoutFailureCopyWithImpl<$Res>
    implements $TimeoutFailureCopyWith<$Res> {
  _$TimeoutFailureCopyWithImpl(this._self, this._then);

  final TimeoutFailure _self;
  final $Res Function(TimeoutFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,Object? code = null,}) {
  return _then(TimeoutFailure(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ServerFailure extends Failure {
  const ServerFailure({this.message = 'Ошибка сервера', this.code = 'SERVER_ERROR', this.statusCode}): super._();
  

@JsonKey() final  String message;
@JsonKey() final  String code;
 final  int? statusCode;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServerFailureCopyWith<ServerFailure> get copyWith => _$ServerFailureCopyWithImpl<ServerFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServerFailure&&(identical(other.message, message) || other.message == message)&&(identical(other.code, code) || other.code == code)&&(identical(other.statusCode, statusCode) || other.statusCode == statusCode));
}


@override
int get hashCode => Object.hash(runtimeType,message,code,statusCode);

@override
String toString() {
  return 'Failure.server(message: $message, code: $code, statusCode: $statusCode)';
}


}

/// @nodoc
abstract mixin class $ServerFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $ServerFailureCopyWith(ServerFailure value, $Res Function(ServerFailure) _then) = _$ServerFailureCopyWithImpl;
@useResult
$Res call({
 String message, String code, int? statusCode
});




}
/// @nodoc
class _$ServerFailureCopyWithImpl<$Res>
    implements $ServerFailureCopyWith<$Res> {
  _$ServerFailureCopyWithImpl(this._self, this._then);

  final ServerFailure _self;
  final $Res Function(ServerFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,Object? code = null,Object? statusCode = freezed,}) {
  return _then(ServerFailure(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,statusCode: freezed == statusCode ? _self.statusCode : statusCode // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc


class ClientFailure extends Failure {
  const ClientFailure({this.message = 'Ошибка клиента', this.code = 'CLIENT_ERROR', this.statusCode}): super._();
  

@JsonKey() final  String message;
@JsonKey() final  String code;
 final  int? statusCode;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClientFailureCopyWith<ClientFailure> get copyWith => _$ClientFailureCopyWithImpl<ClientFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClientFailure&&(identical(other.message, message) || other.message == message)&&(identical(other.code, code) || other.code == code)&&(identical(other.statusCode, statusCode) || other.statusCode == statusCode));
}


@override
int get hashCode => Object.hash(runtimeType,message,code,statusCode);

@override
String toString() {
  return 'Failure.client(message: $message, code: $code, statusCode: $statusCode)';
}


}

/// @nodoc
abstract mixin class $ClientFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $ClientFailureCopyWith(ClientFailure value, $Res Function(ClientFailure) _then) = _$ClientFailureCopyWithImpl;
@useResult
$Res call({
 String message, String code, int? statusCode
});




}
/// @nodoc
class _$ClientFailureCopyWithImpl<$Res>
    implements $ClientFailureCopyWith<$Res> {
  _$ClientFailureCopyWithImpl(this._self, this._then);

  final ClientFailure _self;
  final $Res Function(ClientFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,Object? code = null,Object? statusCode = freezed,}) {
  return _then(ClientFailure(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,statusCode: freezed == statusCode ? _self.statusCode : statusCode // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc


class AuthFailure extends Failure {
  const AuthFailure({this.message = 'Ошибка доступа', this.code = 'AUTH_ERROR'}): super._();
  

@JsonKey() final  String message;
@JsonKey() final  String code;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthFailureCopyWith<AuthFailure> get copyWith => _$AuthFailureCopyWithImpl<AuthFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthFailure&&(identical(other.message, message) || other.message == message)&&(identical(other.code, code) || other.code == code));
}


@override
int get hashCode => Object.hash(runtimeType,message,code);

@override
String toString() {
  return 'Failure.auth(message: $message, code: $code)';
}


}

/// @nodoc
abstract mixin class $AuthFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $AuthFailureCopyWith(AuthFailure value, $Res Function(AuthFailure) _then) = _$AuthFailureCopyWithImpl;
@useResult
$Res call({
 String message, String code
});




}
/// @nodoc
class _$AuthFailureCopyWithImpl<$Res>
    implements $AuthFailureCopyWith<$Res> {
  _$AuthFailureCopyWithImpl(this._self, this._then);

  final AuthFailure _self;
  final $Res Function(AuthFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,Object? code = null,}) {
  return _then(AuthFailure(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class LocalStorageFailure extends Failure {
  const LocalStorageFailure({this.message = 'Ошибка локального хранилища', this.code = 'LOCAL_STORAGE_ERROR'}): super._();
  

@JsonKey() final  String message;
@JsonKey() final  String code;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LocalStorageFailureCopyWith<LocalStorageFailure> get copyWith => _$LocalStorageFailureCopyWithImpl<LocalStorageFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocalStorageFailure&&(identical(other.message, message) || other.message == message)&&(identical(other.code, code) || other.code == code));
}


@override
int get hashCode => Object.hash(runtimeType,message,code);

@override
String toString() {
  return 'Failure.localStorage(message: $message, code: $code)';
}


}

/// @nodoc
abstract mixin class $LocalStorageFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $LocalStorageFailureCopyWith(LocalStorageFailure value, $Res Function(LocalStorageFailure) _then) = _$LocalStorageFailureCopyWithImpl;
@useResult
$Res call({
 String message, String code
});




}
/// @nodoc
class _$LocalStorageFailureCopyWithImpl<$Res>
    implements $LocalStorageFailureCopyWith<$Res> {
  _$LocalStorageFailureCopyWithImpl(this._self, this._then);

  final LocalStorageFailure _self;
  final $Res Function(LocalStorageFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,Object? code = null,}) {
  return _then(LocalStorageFailure(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class CacheFailure extends Failure {
  const CacheFailure({this.message = 'Ошибка кэша', this.code = 'CACHE_ERROR'}): super._();
  

@JsonKey() final  String message;
@JsonKey() final  String code;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CacheFailureCopyWith<CacheFailure> get copyWith => _$CacheFailureCopyWithImpl<CacheFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CacheFailure&&(identical(other.message, message) || other.message == message)&&(identical(other.code, code) || other.code == code));
}


@override
int get hashCode => Object.hash(runtimeType,message,code);

@override
String toString() {
  return 'Failure.cache(message: $message, code: $code)';
}


}

/// @nodoc
abstract mixin class $CacheFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $CacheFailureCopyWith(CacheFailure value, $Res Function(CacheFailure) _then) = _$CacheFailureCopyWithImpl;
@useResult
$Res call({
 String message, String code
});




}
/// @nodoc
class _$CacheFailureCopyWithImpl<$Res>
    implements $CacheFailureCopyWith<$Res> {
  _$CacheFailureCopyWithImpl(this._self, this._then);

  final CacheFailure _self;
  final $Res Function(CacheFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,Object? code = null,}) {
  return _then(CacheFailure(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class DatabaseFailure extends Failure {
  const DatabaseFailure({this.message = 'Ошибка базы данных', this.code = 'DATABASE_ERROR'}): super._();
  

@JsonKey() final  String message;
@JsonKey() final  String code;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DatabaseFailureCopyWith<DatabaseFailure> get copyWith => _$DatabaseFailureCopyWithImpl<DatabaseFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DatabaseFailure&&(identical(other.message, message) || other.message == message)&&(identical(other.code, code) || other.code == code));
}


@override
int get hashCode => Object.hash(runtimeType,message,code);

@override
String toString() {
  return 'Failure.database(message: $message, code: $code)';
}


}

/// @nodoc
abstract mixin class $DatabaseFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $DatabaseFailureCopyWith(DatabaseFailure value, $Res Function(DatabaseFailure) _then) = _$DatabaseFailureCopyWithImpl;
@useResult
$Res call({
 String message, String code
});




}
/// @nodoc
class _$DatabaseFailureCopyWithImpl<$Res>
    implements $DatabaseFailureCopyWith<$Res> {
  _$DatabaseFailureCopyWithImpl(this._self, this._then);

  final DatabaseFailure _self;
  final $Res Function(DatabaseFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,Object? code = null,}) {
  return _then(DatabaseFailure(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ValidationFailure extends Failure {
  const ValidationFailure({this.message = 'Ошибка валидации', this.code = 'VALIDATION_ERROR'}): super._();
  

@JsonKey() final  String message;
@JsonKey() final  String code;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ValidationFailureCopyWith<ValidationFailure> get copyWith => _$ValidationFailureCopyWithImpl<ValidationFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ValidationFailure&&(identical(other.message, message) || other.message == message)&&(identical(other.code, code) || other.code == code));
}


@override
int get hashCode => Object.hash(runtimeType,message,code);

@override
String toString() {
  return 'Failure.validation(message: $message, code: $code)';
}


}

/// @nodoc
abstract mixin class $ValidationFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $ValidationFailureCopyWith(ValidationFailure value, $Res Function(ValidationFailure) _then) = _$ValidationFailureCopyWithImpl;
@useResult
$Res call({
 String message, String code
});




}
/// @nodoc
class _$ValidationFailureCopyWithImpl<$Res>
    implements $ValidationFailureCopyWith<$Res> {
  _$ValidationFailureCopyWithImpl(this._self, this._then);

  final ValidationFailure _self;
  final $Res Function(ValidationFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,Object? code = null,}) {
  return _then(ValidationFailure(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class UnknownFailure extends Failure {
  const UnknownFailure({this.message = 'Неизвестная ошибка', this.code = 'UNKNOWN_ERROR'}): super._();
  

@JsonKey() final  String message;
@JsonKey() final  String code;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UnknownFailureCopyWith<UnknownFailure> get copyWith => _$UnknownFailureCopyWithImpl<UnknownFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnknownFailure&&(identical(other.message, message) || other.message == message)&&(identical(other.code, code) || other.code == code));
}


@override
int get hashCode => Object.hash(runtimeType,message,code);

@override
String toString() {
  return 'Failure.unknown(message: $message, code: $code)';
}


}

/// @nodoc
abstract mixin class $UnknownFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $UnknownFailureCopyWith(UnknownFailure value, $Res Function(UnknownFailure) _then) = _$UnknownFailureCopyWithImpl;
@useResult
$Res call({
 String message, String code
});




}
/// @nodoc
class _$UnknownFailureCopyWithImpl<$Res>
    implements $UnknownFailureCopyWith<$Res> {
  _$UnknownFailureCopyWithImpl(this._self, this._then);

  final UnknownFailure _self;
  final $Res Function(UnknownFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,Object? code = null,}) {
  return _then(UnknownFailure(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class NetworkNoInternetFailure extends Failure {
  const NetworkNoInternetFailure(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NetworkNoInternetFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Failure.networkNoInternet()';
}


}




/// @nodoc


class NetworkBadCertificateFailure extends Failure {
  const NetworkBadCertificateFailure(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NetworkBadCertificateFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Failure.networkBadCertificate()';
}


}




/// @nodoc


class NetworkCancelledFailure extends Failure {
  const NetworkCancelledFailure(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NetworkCancelledFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Failure.networkCancelled()';
}


}




/// @nodoc


class ServerBadRequestFailure extends Failure {
  const ServerBadRequestFailure({this.message}): super._();
  

 final  String? message;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServerBadRequestFailureCopyWith<ServerBadRequestFailure> get copyWith => _$ServerBadRequestFailureCopyWithImpl<ServerBadRequestFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServerBadRequestFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'Failure.serverBadRequest(message: $message)';
}


}

/// @nodoc
abstract mixin class $ServerBadRequestFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $ServerBadRequestFailureCopyWith(ServerBadRequestFailure value, $Res Function(ServerBadRequestFailure) _then) = _$ServerBadRequestFailureCopyWithImpl;
@useResult
$Res call({
 String? message
});




}
/// @nodoc
class _$ServerBadRequestFailureCopyWithImpl<$Res>
    implements $ServerBadRequestFailureCopyWith<$Res> {
  _$ServerBadRequestFailureCopyWithImpl(this._self, this._then);

  final ServerBadRequestFailure _self;
  final $Res Function(ServerBadRequestFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = freezed,}) {
  return _then(ServerBadRequestFailure(
message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class ServerNotFoundFailure extends Failure {
  const ServerNotFoundFailure({this.message}): super._();
  

 final  String? message;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServerNotFoundFailureCopyWith<ServerNotFoundFailure> get copyWith => _$ServerNotFoundFailureCopyWithImpl<ServerNotFoundFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServerNotFoundFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'Failure.serverNotFound(message: $message)';
}


}

/// @nodoc
abstract mixin class $ServerNotFoundFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $ServerNotFoundFailureCopyWith(ServerNotFoundFailure value, $Res Function(ServerNotFoundFailure) _then) = _$ServerNotFoundFailureCopyWithImpl;
@useResult
$Res call({
 String? message
});




}
/// @nodoc
class _$ServerNotFoundFailureCopyWithImpl<$Res>
    implements $ServerNotFoundFailureCopyWith<$Res> {
  _$ServerNotFoundFailureCopyWithImpl(this._self, this._then);

  final ServerNotFoundFailure _self;
  final $Res Function(ServerNotFoundFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = freezed,}) {
  return _then(ServerNotFoundFailure(
message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class ServerValidationFailure extends Failure {
  const ServerValidationFailure({this.message, final  Map<String, List<String>>? errors}): _errors = errors,super._();
  

 final  String? message;
 final  Map<String, List<String>>? _errors;
 Map<String, List<String>>? get errors {
  final value = _errors;
  if (value == null) return null;
  if (_errors is EqualUnmodifiableMapView) return _errors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServerValidationFailureCopyWith<ServerValidationFailure> get copyWith => _$ServerValidationFailureCopyWithImpl<ServerValidationFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServerValidationFailure&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other._errors, _errors));
}


@override
int get hashCode => Object.hash(runtimeType,message,const DeepCollectionEquality().hash(_errors));

@override
String toString() {
  return 'Failure.serverValidationError(message: $message, errors: $errors)';
}


}

/// @nodoc
abstract mixin class $ServerValidationFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $ServerValidationFailureCopyWith(ServerValidationFailure value, $Res Function(ServerValidationFailure) _then) = _$ServerValidationFailureCopyWithImpl;
@useResult
$Res call({
 String? message, Map<String, List<String>>? errors
});




}
/// @nodoc
class _$ServerValidationFailureCopyWithImpl<$Res>
    implements $ServerValidationFailureCopyWith<$Res> {
  _$ServerValidationFailureCopyWithImpl(this._self, this._then);

  final ServerValidationFailure _self;
  final $Res Function(ServerValidationFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = freezed,Object? errors = freezed,}) {
  return _then(ServerValidationFailure(
message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,errors: freezed == errors ? _self._errors : errors // ignore: cast_nullable_to_non_nullable
as Map<String, List<String>>?,
  ));
}


}

/// @nodoc


class ServerTooManyRequestsFailure extends Failure {
  const ServerTooManyRequestsFailure(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServerTooManyRequestsFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Failure.serverTooManyRequests()';
}


}




/// @nodoc


class ServerInternalErrorFailure extends Failure {
  const ServerInternalErrorFailure({this.message, required this.statusCode}): super._();
  

 final  String? message;
 final  int statusCode;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServerInternalErrorFailureCopyWith<ServerInternalErrorFailure> get copyWith => _$ServerInternalErrorFailureCopyWithImpl<ServerInternalErrorFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServerInternalErrorFailure&&(identical(other.message, message) || other.message == message)&&(identical(other.statusCode, statusCode) || other.statusCode == statusCode));
}


@override
int get hashCode => Object.hash(runtimeType,message,statusCode);

@override
String toString() {
  return 'Failure.serverInternalError(message: $message, statusCode: $statusCode)';
}


}

/// @nodoc
abstract mixin class $ServerInternalErrorFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $ServerInternalErrorFailureCopyWith(ServerInternalErrorFailure value, $Res Function(ServerInternalErrorFailure) _then) = _$ServerInternalErrorFailureCopyWithImpl;
@useResult
$Res call({
 String? message, int statusCode
});




}
/// @nodoc
class _$ServerInternalErrorFailureCopyWithImpl<$Res>
    implements $ServerInternalErrorFailureCopyWith<$Res> {
  _$ServerInternalErrorFailureCopyWithImpl(this._self, this._then);

  final ServerInternalErrorFailure _self;
  final $Res Function(ServerInternalErrorFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = freezed,Object? statusCode = null,}) {
  return _then(ServerInternalErrorFailure(
message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,statusCode: null == statusCode ? _self.statusCode : statusCode // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class ClientBadRequestFailure extends Failure {
  const ClientBadRequestFailure({this.message}): super._();
  

 final  String? message;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClientBadRequestFailureCopyWith<ClientBadRequestFailure> get copyWith => _$ClientBadRequestFailureCopyWithImpl<ClientBadRequestFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClientBadRequestFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'Failure.clientBadRequest(message: $message)';
}


}

/// @nodoc
abstract mixin class $ClientBadRequestFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $ClientBadRequestFailureCopyWith(ClientBadRequestFailure value, $Res Function(ClientBadRequestFailure) _then) = _$ClientBadRequestFailureCopyWithImpl;
@useResult
$Res call({
 String? message
});




}
/// @nodoc
class _$ClientBadRequestFailureCopyWithImpl<$Res>
    implements $ClientBadRequestFailureCopyWith<$Res> {
  _$ClientBadRequestFailureCopyWithImpl(this._self, this._then);

  final ClientBadRequestFailure _self;
  final $Res Function(ClientBadRequestFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = freezed,}) {
  return _then(ClientBadRequestFailure(
message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class ClientUnauthorizedFailure extends Failure {
  const ClientUnauthorizedFailure(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClientUnauthorizedFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Failure.clientUnauthorized()';
}


}




/// @nodoc


class ClientForbiddenFailure extends Failure {
  const ClientForbiddenFailure(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClientForbiddenFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Failure.clientForbidden()';
}


}




/// @nodoc


class ClientNotFoundFailure extends Failure {
  const ClientNotFoundFailure({this.message}): super._();
  

 final  String? message;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClientNotFoundFailureCopyWith<ClientNotFoundFailure> get copyWith => _$ClientNotFoundFailureCopyWithImpl<ClientNotFoundFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClientNotFoundFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'Failure.clientNotFound(message: $message)';
}


}

/// @nodoc
abstract mixin class $ClientNotFoundFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $ClientNotFoundFailureCopyWith(ClientNotFoundFailure value, $Res Function(ClientNotFoundFailure) _then) = _$ClientNotFoundFailureCopyWithImpl;
@useResult
$Res call({
 String? message
});




}
/// @nodoc
class _$ClientNotFoundFailureCopyWithImpl<$Res>
    implements $ClientNotFoundFailureCopyWith<$Res> {
  _$ClientNotFoundFailureCopyWithImpl(this._self, this._then);

  final ClientNotFoundFailure _self;
  final $Res Function(ClientNotFoundFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = freezed,}) {
  return _then(ClientNotFoundFailure(
message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class ClientValidationFailure extends Failure {
  const ClientValidationFailure({this.message, final  Map<String, List<String>>? errors}): _errors = errors,super._();
  

 final  String? message;
 final  Map<String, List<String>>? _errors;
 Map<String, List<String>>? get errors {
  final value = _errors;
  if (value == null) return null;
  if (_errors is EqualUnmodifiableMapView) return _errors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClientValidationFailureCopyWith<ClientValidationFailure> get copyWith => _$ClientValidationFailureCopyWithImpl<ClientValidationFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClientValidationFailure&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other._errors, _errors));
}


@override
int get hashCode => Object.hash(runtimeType,message,const DeepCollectionEquality().hash(_errors));

@override
String toString() {
  return 'Failure.clientValidationError(message: $message, errors: $errors)';
}


}

/// @nodoc
abstract mixin class $ClientValidationFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $ClientValidationFailureCopyWith(ClientValidationFailure value, $Res Function(ClientValidationFailure) _then) = _$ClientValidationFailureCopyWithImpl;
@useResult
$Res call({
 String? message, Map<String, List<String>>? errors
});




}
/// @nodoc
class _$ClientValidationFailureCopyWithImpl<$Res>
    implements $ClientValidationFailureCopyWith<$Res> {
  _$ClientValidationFailureCopyWithImpl(this._self, this._then);

  final ClientValidationFailure _self;
  final $Res Function(ClientValidationFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = freezed,Object? errors = freezed,}) {
  return _then(ClientValidationFailure(
message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,errors: freezed == errors ? _self._errors : errors // ignore: cast_nullable_to_non_nullable
as Map<String, List<String>>?,
  ));
}


}

/// @nodoc


class AuthUnauthorizedFailure extends Failure {
  const AuthUnauthorizedFailure(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthUnauthorizedFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Failure.authUnauthorized()';
}


}




/// @nodoc


class AuthForbiddenFailure extends Failure {
  const AuthForbiddenFailure(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthForbiddenFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Failure.authForbidden()';
}


}




/// @nodoc


class AuthExpiredFailure extends Failure {
  const AuthExpiredFailure(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthExpiredFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Failure.authExpired()';
}


}




// dart format on
