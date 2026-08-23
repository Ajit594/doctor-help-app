// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'appointment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Appointment _$AppointmentFromJson(Map<String, dynamic> json) {
  return _Appointment.fromJson(json);
}

/// @nodoc
mixin _$Appointment {
  @JsonKey(name: '_id')
  String get id => throw _privateConstructorUsedError;
  String get patientId => throw _privateConstructorUsedError;
  AppointmentDoctor get doctorId => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  AppointmentTimeSlot get timeSlot => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String? get symptoms => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  String? get prescription => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  String get paymentStatus => throw _privateConstructorUsedError;
  String? get meetingLink => throw _privateConstructorUsedError;
  AppointmentPatientProfile? get patientProfile =>
      throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AppointmentCopyWith<Appointment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppointmentCopyWith<$Res> {
  factory $AppointmentCopyWith(
          Appointment value, $Res Function(Appointment) then) =
      _$AppointmentCopyWithImpl<$Res, Appointment>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      String patientId,
      AppointmentDoctor doctorId,
      DateTime date,
      AppointmentTimeSlot timeSlot,
      String type,
      String status,
      String? symptoms,
      String? notes,
      String? prescription,
      double amount,
      String paymentStatus,
      String? meetingLink,
      AppointmentPatientProfile? patientProfile,
      DateTime? createdAt});

  $AppointmentDoctorCopyWith<$Res> get doctorId;
  $AppointmentTimeSlotCopyWith<$Res> get timeSlot;
  $AppointmentPatientProfileCopyWith<$Res>? get patientProfile;
}

/// @nodoc
class _$AppointmentCopyWithImpl<$Res, $Val extends Appointment>
    implements $AppointmentCopyWith<$Res> {
  _$AppointmentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? patientId = null,
    Object? doctorId = null,
    Object? date = null,
    Object? timeSlot = null,
    Object? type = null,
    Object? status = null,
    Object? symptoms = freezed,
    Object? notes = freezed,
    Object? prescription = freezed,
    Object? amount = null,
    Object? paymentStatus = null,
    Object? meetingLink = freezed,
    Object? patientProfile = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      patientId: null == patientId
          ? _value.patientId
          : patientId // ignore: cast_nullable_to_non_nullable
              as String,
      doctorId: null == doctorId
          ? _value.doctorId
          : doctorId // ignore: cast_nullable_to_non_nullable
              as AppointmentDoctor,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      timeSlot: null == timeSlot
          ? _value.timeSlot
          : timeSlot // ignore: cast_nullable_to_non_nullable
              as AppointmentTimeSlot,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      symptoms: freezed == symptoms
          ? _value.symptoms
          : symptoms // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      prescription: freezed == prescription
          ? _value.prescription
          : prescription // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      paymentStatus: null == paymentStatus
          ? _value.paymentStatus
          : paymentStatus // ignore: cast_nullable_to_non_nullable
              as String,
      meetingLink: freezed == meetingLink
          ? _value.meetingLink
          : meetingLink // ignore: cast_nullable_to_non_nullable
              as String?,
      patientProfile: freezed == patientProfile
          ? _value.patientProfile
          : patientProfile // ignore: cast_nullable_to_non_nullable
              as AppointmentPatientProfile?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AppointmentDoctorCopyWith<$Res> get doctorId {
    return $AppointmentDoctorCopyWith<$Res>(_value.doctorId, (value) {
      return _then(_value.copyWith(doctorId: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $AppointmentTimeSlotCopyWith<$Res> get timeSlot {
    return $AppointmentTimeSlotCopyWith<$Res>(_value.timeSlot, (value) {
      return _then(_value.copyWith(timeSlot: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $AppointmentPatientProfileCopyWith<$Res>? get patientProfile {
    if (_value.patientProfile == null) {
      return null;
    }

    return $AppointmentPatientProfileCopyWith<$Res>(_value.patientProfile!,
        (value) {
      return _then(_value.copyWith(patientProfile: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AppointmentImplCopyWith<$Res>
    implements $AppointmentCopyWith<$Res> {
  factory _$$AppointmentImplCopyWith(
          _$AppointmentImpl value, $Res Function(_$AppointmentImpl) then) =
      __$$AppointmentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      String patientId,
      AppointmentDoctor doctorId,
      DateTime date,
      AppointmentTimeSlot timeSlot,
      String type,
      String status,
      String? symptoms,
      String? notes,
      String? prescription,
      double amount,
      String paymentStatus,
      String? meetingLink,
      AppointmentPatientProfile? patientProfile,
      DateTime? createdAt});

  @override
  $AppointmentDoctorCopyWith<$Res> get doctorId;
  @override
  $AppointmentTimeSlotCopyWith<$Res> get timeSlot;
  @override
  $AppointmentPatientProfileCopyWith<$Res>? get patientProfile;
}

/// @nodoc
class __$$AppointmentImplCopyWithImpl<$Res>
    extends _$AppointmentCopyWithImpl<$Res, _$AppointmentImpl>
    implements _$$AppointmentImplCopyWith<$Res> {
  __$$AppointmentImplCopyWithImpl(
      _$AppointmentImpl _value, $Res Function(_$AppointmentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? patientId = null,
    Object? doctorId = null,
    Object? date = null,
    Object? timeSlot = null,
    Object? type = null,
    Object? status = null,
    Object? symptoms = freezed,
    Object? notes = freezed,
    Object? prescription = freezed,
    Object? amount = null,
    Object? paymentStatus = null,
    Object? meetingLink = freezed,
    Object? patientProfile = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$AppointmentImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      patientId: null == patientId
          ? _value.patientId
          : patientId // ignore: cast_nullable_to_non_nullable
              as String,
      doctorId: null == doctorId
          ? _value.doctorId
          : doctorId // ignore: cast_nullable_to_non_nullable
              as AppointmentDoctor,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      timeSlot: null == timeSlot
          ? _value.timeSlot
          : timeSlot // ignore: cast_nullable_to_non_nullable
              as AppointmentTimeSlot,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      symptoms: freezed == symptoms
          ? _value.symptoms
          : symptoms // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      prescription: freezed == prescription
          ? _value.prescription
          : prescription // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      paymentStatus: null == paymentStatus
          ? _value.paymentStatus
          : paymentStatus // ignore: cast_nullable_to_non_nullable
              as String,
      meetingLink: freezed == meetingLink
          ? _value.meetingLink
          : meetingLink // ignore: cast_nullable_to_non_nullable
              as String?,
      patientProfile: freezed == patientProfile
          ? _value.patientProfile
          : patientProfile // ignore: cast_nullable_to_non_nullable
              as AppointmentPatientProfile?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AppointmentImpl implements _Appointment {
  const _$AppointmentImpl(
      {@JsonKey(name: '_id') required this.id,
      required this.patientId,
      required this.doctorId,
      required this.date,
      required this.timeSlot,
      required this.type,
      this.status = 'pending',
      this.symptoms,
      this.notes,
      this.prescription,
      this.amount = 0.0,
      this.paymentStatus = 'pending',
      this.meetingLink,
      this.patientProfile,
      this.createdAt});

  factory _$AppointmentImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppointmentImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String id;
  @override
  final String patientId;
  @override
  final AppointmentDoctor doctorId;
  @override
  final DateTime date;
  @override
  final AppointmentTimeSlot timeSlot;
  @override
  final String type;
  @override
  @JsonKey()
  final String status;
  @override
  final String? symptoms;
  @override
  final String? notes;
  @override
  final String? prescription;
  @override
  @JsonKey()
  final double amount;
  @override
  @JsonKey()
  final String paymentStatus;
  @override
  final String? meetingLink;
  @override
  final AppointmentPatientProfile? patientProfile;
  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'Appointment(id: $id, patientId: $patientId, doctorId: $doctorId, date: $date, timeSlot: $timeSlot, type: $type, status: $status, symptoms: $symptoms, notes: $notes, prescription: $prescription, amount: $amount, paymentStatus: $paymentStatus, meetingLink: $meetingLink, patientProfile: $patientProfile, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppointmentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.patientId, patientId) ||
                other.patientId == patientId) &&
            (identical(other.doctorId, doctorId) ||
                other.doctorId == doctorId) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.timeSlot, timeSlot) ||
                other.timeSlot == timeSlot) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.symptoms, symptoms) ||
                other.symptoms == symptoms) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.prescription, prescription) ||
                other.prescription == prescription) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.paymentStatus, paymentStatus) ||
                other.paymentStatus == paymentStatus) &&
            (identical(other.meetingLink, meetingLink) ||
                other.meetingLink == meetingLink) &&
            (identical(other.patientProfile, patientProfile) ||
                other.patientProfile == patientProfile) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      patientId,
      doctorId,
      date,
      timeSlot,
      type,
      status,
      symptoms,
      notes,
      prescription,
      amount,
      paymentStatus,
      meetingLink,
      patientProfile,
      createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppointmentImplCopyWith<_$AppointmentImpl> get copyWith =>
      __$$AppointmentImplCopyWithImpl<_$AppointmentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppointmentImplToJson(
      this,
    );
  }
}

abstract class _Appointment implements Appointment {
  const factory _Appointment(
      {@JsonKey(name: '_id') required final String id,
      required final String patientId,
      required final AppointmentDoctor doctorId,
      required final DateTime date,
      required final AppointmentTimeSlot timeSlot,
      required final String type,
      final String status,
      final String? symptoms,
      final String? notes,
      final String? prescription,
      final double amount,
      final String paymentStatus,
      final String? meetingLink,
      final AppointmentPatientProfile? patientProfile,
      final DateTime? createdAt}) = _$AppointmentImpl;

  factory _Appointment.fromJson(Map<String, dynamic> json) =
      _$AppointmentImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String get id;
  @override
  String get patientId;
  @override
  AppointmentDoctor get doctorId;
  @override
  DateTime get date;
  @override
  AppointmentTimeSlot get timeSlot;
  @override
  String get type;
  @override
  String get status;
  @override
  String? get symptoms;
  @override
  String? get notes;
  @override
  String? get prescription;
  @override
  double get amount;
  @override
  String get paymentStatus;
  @override
  String? get meetingLink;
  @override
  AppointmentPatientProfile? get patientProfile;
  @override
  DateTime? get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$AppointmentImplCopyWith<_$AppointmentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AppointmentPatientProfile _$AppointmentPatientProfileFromJson(
    Map<String, dynamic> json) {
  return _AppointmentPatientProfile.fromJson(json);
}

/// @nodoc
mixin _$AppointmentPatientProfile {
  String get name => throw _privateConstructorUsedError;
  int get age => throw _privateConstructorUsedError;
  String get gender => throw _privateConstructorUsedError;
  String? get relationship => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AppointmentPatientProfileCopyWith<AppointmentPatientProfile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppointmentPatientProfileCopyWith<$Res> {
  factory $AppointmentPatientProfileCopyWith(AppointmentPatientProfile value,
          $Res Function(AppointmentPatientProfile) then) =
      _$AppointmentPatientProfileCopyWithImpl<$Res, AppointmentPatientProfile>;
  @useResult
  $Res call({String name, int age, String gender, String? relationship});
}

/// @nodoc
class _$AppointmentPatientProfileCopyWithImpl<$Res,
        $Val extends AppointmentPatientProfile>
    implements $AppointmentPatientProfileCopyWith<$Res> {
  _$AppointmentPatientProfileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? age = null,
    Object? gender = null,
    Object? relationship = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      age: null == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int,
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
      relationship: freezed == relationship
          ? _value.relationship
          : relationship // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppointmentPatientProfileImplCopyWith<$Res>
    implements $AppointmentPatientProfileCopyWith<$Res> {
  factory _$$AppointmentPatientProfileImplCopyWith(
          _$AppointmentPatientProfileImpl value,
          $Res Function(_$AppointmentPatientProfileImpl) then) =
      __$$AppointmentPatientProfileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, int age, String gender, String? relationship});
}

/// @nodoc
class __$$AppointmentPatientProfileImplCopyWithImpl<$Res>
    extends _$AppointmentPatientProfileCopyWithImpl<$Res,
        _$AppointmentPatientProfileImpl>
    implements _$$AppointmentPatientProfileImplCopyWith<$Res> {
  __$$AppointmentPatientProfileImplCopyWithImpl(
      _$AppointmentPatientProfileImpl _value,
      $Res Function(_$AppointmentPatientProfileImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? age = null,
    Object? gender = null,
    Object? relationship = freezed,
  }) {
    return _then(_$AppointmentPatientProfileImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      age: null == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int,
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
      relationship: freezed == relationship
          ? _value.relationship
          : relationship // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AppointmentPatientProfileImpl implements _AppointmentPatientProfile {
  const _$AppointmentPatientProfileImpl(
      {required this.name,
      required this.age,
      required this.gender,
      this.relationship});

  factory _$AppointmentPatientProfileImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppointmentPatientProfileImplFromJson(json);

  @override
  final String name;
  @override
  final int age;
  @override
  final String gender;
  @override
  final String? relationship;

  @override
  String toString() {
    return 'AppointmentPatientProfile(name: $name, age: $age, gender: $gender, relationship: $relationship)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppointmentPatientProfileImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.age, age) || other.age == age) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.relationship, relationship) ||
                other.relationship == relationship));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, age, gender, relationship);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppointmentPatientProfileImplCopyWith<_$AppointmentPatientProfileImpl>
      get copyWith => __$$AppointmentPatientProfileImplCopyWithImpl<
          _$AppointmentPatientProfileImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppointmentPatientProfileImplToJson(
      this,
    );
  }
}

abstract class _AppointmentPatientProfile implements AppointmentPatientProfile {
  const factory _AppointmentPatientProfile(
      {required final String name,
      required final int age,
      required final String gender,
      final String? relationship}) = _$AppointmentPatientProfileImpl;

  factory _AppointmentPatientProfile.fromJson(Map<String, dynamic> json) =
      _$AppointmentPatientProfileImpl.fromJson;

  @override
  String get name;
  @override
  int get age;
  @override
  String get gender;
  @override
  String? get relationship;
  @override
  @JsonKey(ignore: true)
  _$$AppointmentPatientProfileImplCopyWith<_$AppointmentPatientProfileImpl>
      get copyWith => throw _privateConstructorUsedError;
}

AppointmentDoctor _$AppointmentDoctorFromJson(Map<String, dynamic> json) {
  return _AppointmentDoctor.fromJson(json);
}

/// @nodoc
mixin _$AppointmentDoctor {
  @JsonKey(name: '_id')
  String get id => throw _privateConstructorUsedError;
  AppointmentDoctorUser? get userId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AppointmentDoctorCopyWith<AppointmentDoctor> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppointmentDoctorCopyWith<$Res> {
  factory $AppointmentDoctorCopyWith(
          AppointmentDoctor value, $Res Function(AppointmentDoctor) then) =
      _$AppointmentDoctorCopyWithImpl<$Res, AppointmentDoctor>;
  @useResult
  $Res call({@JsonKey(name: '_id') String id, AppointmentDoctorUser? userId});

  $AppointmentDoctorUserCopyWith<$Res>? get userId;
}

/// @nodoc
class _$AppointmentDoctorCopyWithImpl<$Res, $Val extends AppointmentDoctor>
    implements $AppointmentDoctorCopyWith<$Res> {
  _$AppointmentDoctorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as AppointmentDoctorUser?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AppointmentDoctorUserCopyWith<$Res>? get userId {
    if (_value.userId == null) {
      return null;
    }

    return $AppointmentDoctorUserCopyWith<$Res>(_value.userId!, (value) {
      return _then(_value.copyWith(userId: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AppointmentDoctorImplCopyWith<$Res>
    implements $AppointmentDoctorCopyWith<$Res> {
  factory _$$AppointmentDoctorImplCopyWith(_$AppointmentDoctorImpl value,
          $Res Function(_$AppointmentDoctorImpl) then) =
      __$$AppointmentDoctorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: '_id') String id, AppointmentDoctorUser? userId});

  @override
  $AppointmentDoctorUserCopyWith<$Res>? get userId;
}

/// @nodoc
class __$$AppointmentDoctorImplCopyWithImpl<$Res>
    extends _$AppointmentDoctorCopyWithImpl<$Res, _$AppointmentDoctorImpl>
    implements _$$AppointmentDoctorImplCopyWith<$Res> {
  __$$AppointmentDoctorImplCopyWithImpl(_$AppointmentDoctorImpl _value,
      $Res Function(_$AppointmentDoctorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = freezed,
  }) {
    return _then(_$AppointmentDoctorImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as AppointmentDoctorUser?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AppointmentDoctorImpl implements _AppointmentDoctor {
  const _$AppointmentDoctorImpl(
      {@JsonKey(name: '_id') required this.id, this.userId});

  factory _$AppointmentDoctorImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppointmentDoctorImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String id;
  @override
  final AppointmentDoctorUser? userId;

  @override
  String toString() {
    return 'AppointmentDoctor(id: $id, userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppointmentDoctorImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, userId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppointmentDoctorImplCopyWith<_$AppointmentDoctorImpl> get copyWith =>
      __$$AppointmentDoctorImplCopyWithImpl<_$AppointmentDoctorImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppointmentDoctorImplToJson(
      this,
    );
  }
}

abstract class _AppointmentDoctor implements AppointmentDoctor {
  const factory _AppointmentDoctor(
      {@JsonKey(name: '_id') required final String id,
      final AppointmentDoctorUser? userId}) = _$AppointmentDoctorImpl;

  factory _AppointmentDoctor.fromJson(Map<String, dynamic> json) =
      _$AppointmentDoctorImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String get id;
  @override
  AppointmentDoctorUser? get userId;
  @override
  @JsonKey(ignore: true)
  _$$AppointmentDoctorImplCopyWith<_$AppointmentDoctorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AppointmentDoctorUser _$AppointmentDoctorUserFromJson(
    Map<String, dynamic> json) {
  return _AppointmentDoctorUser.fromJson(json);
}

/// @nodoc
mixin _$AppointmentDoctorUser {
  @JsonKey(name: '_id')
  String? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AppointmentDoctorUserCopyWith<AppointmentDoctorUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppointmentDoctorUserCopyWith<$Res> {
  factory $AppointmentDoctorUserCopyWith(AppointmentDoctorUser value,
          $Res Function(AppointmentDoctorUser) then) =
      _$AppointmentDoctorUserCopyWithImpl<$Res, AppointmentDoctorUser>;
  @useResult
  $Res call({@JsonKey(name: '_id') String? id, String? name, String? phone});
}

/// @nodoc
class _$AppointmentDoctorUserCopyWithImpl<$Res,
        $Val extends AppointmentDoctorUser>
    implements $AppointmentDoctorUserCopyWith<$Res> {
  _$AppointmentDoctorUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? phone = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppointmentDoctorUserImplCopyWith<$Res>
    implements $AppointmentDoctorUserCopyWith<$Res> {
  factory _$$AppointmentDoctorUserImplCopyWith(
          _$AppointmentDoctorUserImpl value,
          $Res Function(_$AppointmentDoctorUserImpl) then) =
      __$$AppointmentDoctorUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: '_id') String? id, String? name, String? phone});
}

/// @nodoc
class __$$AppointmentDoctorUserImplCopyWithImpl<$Res>
    extends _$AppointmentDoctorUserCopyWithImpl<$Res,
        _$AppointmentDoctorUserImpl>
    implements _$$AppointmentDoctorUserImplCopyWith<$Res> {
  __$$AppointmentDoctorUserImplCopyWithImpl(_$AppointmentDoctorUserImpl _value,
      $Res Function(_$AppointmentDoctorUserImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? phone = freezed,
  }) {
    return _then(_$AppointmentDoctorUserImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AppointmentDoctorUserImpl implements _AppointmentDoctorUser {
  const _$AppointmentDoctorUserImpl(
      {@JsonKey(name: '_id') this.id, this.name, this.phone});

  factory _$AppointmentDoctorUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppointmentDoctorUserImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String? id;
  @override
  final String? name;
  @override
  final String? phone;

  @override
  String toString() {
    return 'AppointmentDoctorUser(id: $id, name: $name, phone: $phone)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppointmentDoctorUserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phone, phone) || other.phone == phone));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, phone);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppointmentDoctorUserImplCopyWith<_$AppointmentDoctorUserImpl>
      get copyWith => __$$AppointmentDoctorUserImplCopyWithImpl<
          _$AppointmentDoctorUserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppointmentDoctorUserImplToJson(
      this,
    );
  }
}

abstract class _AppointmentDoctorUser implements AppointmentDoctorUser {
  const factory _AppointmentDoctorUser(
      {@JsonKey(name: '_id') final String? id,
      final String? name,
      final String? phone}) = _$AppointmentDoctorUserImpl;

  factory _AppointmentDoctorUser.fromJson(Map<String, dynamic> json) =
      _$AppointmentDoctorUserImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String? get id;
  @override
  String? get name;
  @override
  String? get phone;
  @override
  @JsonKey(ignore: true)
  _$$AppointmentDoctorUserImplCopyWith<_$AppointmentDoctorUserImpl>
      get copyWith => throw _privateConstructorUsedError;
}

AppointmentTimeSlot _$AppointmentTimeSlotFromJson(Map<String, dynamic> json) {
  return _AppointmentTimeSlot.fromJson(json);
}

/// @nodoc
mixin _$AppointmentTimeSlot {
  String get start => throw _privateConstructorUsedError;
  String get end => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AppointmentTimeSlotCopyWith<AppointmentTimeSlot> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppointmentTimeSlotCopyWith<$Res> {
  factory $AppointmentTimeSlotCopyWith(
          AppointmentTimeSlot value, $Res Function(AppointmentTimeSlot) then) =
      _$AppointmentTimeSlotCopyWithImpl<$Res, AppointmentTimeSlot>;
  @useResult
  $Res call({String start, String end});
}

/// @nodoc
class _$AppointmentTimeSlotCopyWithImpl<$Res, $Val extends AppointmentTimeSlot>
    implements $AppointmentTimeSlotCopyWith<$Res> {
  _$AppointmentTimeSlotCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? start = null,
    Object? end = null,
  }) {
    return _then(_value.copyWith(
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as String,
      end: null == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppointmentTimeSlotImplCopyWith<$Res>
    implements $AppointmentTimeSlotCopyWith<$Res> {
  factory _$$AppointmentTimeSlotImplCopyWith(_$AppointmentTimeSlotImpl value,
          $Res Function(_$AppointmentTimeSlotImpl) then) =
      __$$AppointmentTimeSlotImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String start, String end});
}

/// @nodoc
class __$$AppointmentTimeSlotImplCopyWithImpl<$Res>
    extends _$AppointmentTimeSlotCopyWithImpl<$Res, _$AppointmentTimeSlotImpl>
    implements _$$AppointmentTimeSlotImplCopyWith<$Res> {
  __$$AppointmentTimeSlotImplCopyWithImpl(_$AppointmentTimeSlotImpl _value,
      $Res Function(_$AppointmentTimeSlotImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? start = null,
    Object? end = null,
  }) {
    return _then(_$AppointmentTimeSlotImpl(
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as String,
      end: null == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AppointmentTimeSlotImpl implements _AppointmentTimeSlot {
  const _$AppointmentTimeSlotImpl({required this.start, required this.end});

  factory _$AppointmentTimeSlotImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppointmentTimeSlotImplFromJson(json);

  @override
  final String start;
  @override
  final String end;

  @override
  String toString() {
    return 'AppointmentTimeSlot(start: $start, end: $end)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppointmentTimeSlotImpl &&
            (identical(other.start, start) || other.start == start) &&
            (identical(other.end, end) || other.end == end));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, start, end);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppointmentTimeSlotImplCopyWith<_$AppointmentTimeSlotImpl> get copyWith =>
      __$$AppointmentTimeSlotImplCopyWithImpl<_$AppointmentTimeSlotImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppointmentTimeSlotImplToJson(
      this,
    );
  }
}

abstract class _AppointmentTimeSlot implements AppointmentTimeSlot {
  const factory _AppointmentTimeSlot(
      {required final String start,
      required final String end}) = _$AppointmentTimeSlotImpl;

  factory _AppointmentTimeSlot.fromJson(Map<String, dynamic> json) =
      _$AppointmentTimeSlotImpl.fromJson;

  @override
  String get start;
  @override
  String get end;
  @override
  @JsonKey(ignore: true)
  _$$AppointmentTimeSlotImplCopyWith<_$AppointmentTimeSlotImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DoctorAppointment _$DoctorAppointmentFromJson(Map<String, dynamic> json) {
  return _DoctorAppointment.fromJson(json);
}

/// @nodoc
mixin _$DoctorAppointment {
  @JsonKey(name: '_id')
  String get id => throw _privateConstructorUsedError;
  PatientInfo get patientId => throw _privateConstructorUsedError;
  String get doctorId => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  AppointmentTimeSlot get timeSlot => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String? get symptoms => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  String? get prescription => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  String get paymentStatus => throw _privateConstructorUsedError;
  AppointmentPatientProfile? get patientProfile =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DoctorAppointmentCopyWith<DoctorAppointment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DoctorAppointmentCopyWith<$Res> {
  factory $DoctorAppointmentCopyWith(
          DoctorAppointment value, $Res Function(DoctorAppointment) then) =
      _$DoctorAppointmentCopyWithImpl<$Res, DoctorAppointment>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      PatientInfo patientId,
      String doctorId,
      DateTime date,
      AppointmentTimeSlot timeSlot,
      String type,
      String status,
      String? symptoms,
      String? notes,
      String? prescription,
      double amount,
      String paymentStatus,
      AppointmentPatientProfile? patientProfile});

  $PatientInfoCopyWith<$Res> get patientId;
  $AppointmentTimeSlotCopyWith<$Res> get timeSlot;
  $AppointmentPatientProfileCopyWith<$Res>? get patientProfile;
}

/// @nodoc
class _$DoctorAppointmentCopyWithImpl<$Res, $Val extends DoctorAppointment>
    implements $DoctorAppointmentCopyWith<$Res> {
  _$DoctorAppointmentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? patientId = null,
    Object? doctorId = null,
    Object? date = null,
    Object? timeSlot = null,
    Object? type = null,
    Object? status = null,
    Object? symptoms = freezed,
    Object? notes = freezed,
    Object? prescription = freezed,
    Object? amount = null,
    Object? paymentStatus = null,
    Object? patientProfile = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      patientId: null == patientId
          ? _value.patientId
          : patientId // ignore: cast_nullable_to_non_nullable
              as PatientInfo,
      doctorId: null == doctorId
          ? _value.doctorId
          : doctorId // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      timeSlot: null == timeSlot
          ? _value.timeSlot
          : timeSlot // ignore: cast_nullable_to_non_nullable
              as AppointmentTimeSlot,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      symptoms: freezed == symptoms
          ? _value.symptoms
          : symptoms // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      prescription: freezed == prescription
          ? _value.prescription
          : prescription // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      paymentStatus: null == paymentStatus
          ? _value.paymentStatus
          : paymentStatus // ignore: cast_nullable_to_non_nullable
              as String,
      patientProfile: freezed == patientProfile
          ? _value.patientProfile
          : patientProfile // ignore: cast_nullable_to_non_nullable
              as AppointmentPatientProfile?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PatientInfoCopyWith<$Res> get patientId {
    return $PatientInfoCopyWith<$Res>(_value.patientId, (value) {
      return _then(_value.copyWith(patientId: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $AppointmentTimeSlotCopyWith<$Res> get timeSlot {
    return $AppointmentTimeSlotCopyWith<$Res>(_value.timeSlot, (value) {
      return _then(_value.copyWith(timeSlot: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $AppointmentPatientProfileCopyWith<$Res>? get patientProfile {
    if (_value.patientProfile == null) {
      return null;
    }

    return $AppointmentPatientProfileCopyWith<$Res>(_value.patientProfile!,
        (value) {
      return _then(_value.copyWith(patientProfile: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DoctorAppointmentImplCopyWith<$Res>
    implements $DoctorAppointmentCopyWith<$Res> {
  factory _$$DoctorAppointmentImplCopyWith(_$DoctorAppointmentImpl value,
          $Res Function(_$DoctorAppointmentImpl) then) =
      __$$DoctorAppointmentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      PatientInfo patientId,
      String doctorId,
      DateTime date,
      AppointmentTimeSlot timeSlot,
      String type,
      String status,
      String? symptoms,
      String? notes,
      String? prescription,
      double amount,
      String paymentStatus,
      AppointmentPatientProfile? patientProfile});

  @override
  $PatientInfoCopyWith<$Res> get patientId;
  @override
  $AppointmentTimeSlotCopyWith<$Res> get timeSlot;
  @override
  $AppointmentPatientProfileCopyWith<$Res>? get patientProfile;
}

/// @nodoc
class __$$DoctorAppointmentImplCopyWithImpl<$Res>
    extends _$DoctorAppointmentCopyWithImpl<$Res, _$DoctorAppointmentImpl>
    implements _$$DoctorAppointmentImplCopyWith<$Res> {
  __$$DoctorAppointmentImplCopyWithImpl(_$DoctorAppointmentImpl _value,
      $Res Function(_$DoctorAppointmentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? patientId = null,
    Object? doctorId = null,
    Object? date = null,
    Object? timeSlot = null,
    Object? type = null,
    Object? status = null,
    Object? symptoms = freezed,
    Object? notes = freezed,
    Object? prescription = freezed,
    Object? amount = null,
    Object? paymentStatus = null,
    Object? patientProfile = freezed,
  }) {
    return _then(_$DoctorAppointmentImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      patientId: null == patientId
          ? _value.patientId
          : patientId // ignore: cast_nullable_to_non_nullable
              as PatientInfo,
      doctorId: null == doctorId
          ? _value.doctorId
          : doctorId // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      timeSlot: null == timeSlot
          ? _value.timeSlot
          : timeSlot // ignore: cast_nullable_to_non_nullable
              as AppointmentTimeSlot,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      symptoms: freezed == symptoms
          ? _value.symptoms
          : symptoms // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      prescription: freezed == prescription
          ? _value.prescription
          : prescription // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      paymentStatus: null == paymentStatus
          ? _value.paymentStatus
          : paymentStatus // ignore: cast_nullable_to_non_nullable
              as String,
      patientProfile: freezed == patientProfile
          ? _value.patientProfile
          : patientProfile // ignore: cast_nullable_to_non_nullable
              as AppointmentPatientProfile?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DoctorAppointmentImpl implements _DoctorAppointment {
  const _$DoctorAppointmentImpl(
      {@JsonKey(name: '_id') required this.id,
      required this.patientId,
      required this.doctorId,
      required this.date,
      required this.timeSlot,
      required this.type,
      this.status = 'pending',
      this.symptoms,
      this.notes,
      this.prescription,
      this.amount = 0.0,
      this.paymentStatus = 'pending',
      this.patientProfile});

  factory _$DoctorAppointmentImpl.fromJson(Map<String, dynamic> json) =>
      _$$DoctorAppointmentImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String id;
  @override
  final PatientInfo patientId;
  @override
  final String doctorId;
  @override
  final DateTime date;
  @override
  final AppointmentTimeSlot timeSlot;
  @override
  final String type;
  @override
  @JsonKey()
  final String status;
  @override
  final String? symptoms;
  @override
  final String? notes;
  @override
  final String? prescription;
  @override
  @JsonKey()
  final double amount;
  @override
  @JsonKey()
  final String paymentStatus;
  @override
  final AppointmentPatientProfile? patientProfile;

  @override
  String toString() {
    return 'DoctorAppointment(id: $id, patientId: $patientId, doctorId: $doctorId, date: $date, timeSlot: $timeSlot, type: $type, status: $status, symptoms: $symptoms, notes: $notes, prescription: $prescription, amount: $amount, paymentStatus: $paymentStatus, patientProfile: $patientProfile)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DoctorAppointmentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.patientId, patientId) ||
                other.patientId == patientId) &&
            (identical(other.doctorId, doctorId) ||
                other.doctorId == doctorId) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.timeSlot, timeSlot) ||
                other.timeSlot == timeSlot) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.symptoms, symptoms) ||
                other.symptoms == symptoms) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.prescription, prescription) ||
                other.prescription == prescription) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.paymentStatus, paymentStatus) ||
                other.paymentStatus == paymentStatus) &&
            (identical(other.patientProfile, patientProfile) ||
                other.patientProfile == patientProfile));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      patientId,
      doctorId,
      date,
      timeSlot,
      type,
      status,
      symptoms,
      notes,
      prescription,
      amount,
      paymentStatus,
      patientProfile);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DoctorAppointmentImplCopyWith<_$DoctorAppointmentImpl> get copyWith =>
      __$$DoctorAppointmentImplCopyWithImpl<_$DoctorAppointmentImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DoctorAppointmentImplToJson(
      this,
    );
  }
}

abstract class _DoctorAppointment implements DoctorAppointment {
  const factory _DoctorAppointment(
          {@JsonKey(name: '_id') required final String id,
          required final PatientInfo patientId,
          required final String doctorId,
          required final DateTime date,
          required final AppointmentTimeSlot timeSlot,
          required final String type,
          final String status,
          final String? symptoms,
          final String? notes,
          final String? prescription,
          final double amount,
          final String paymentStatus,
          final AppointmentPatientProfile? patientProfile}) =
      _$DoctorAppointmentImpl;

  factory _DoctorAppointment.fromJson(Map<String, dynamic> json) =
      _$DoctorAppointmentImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String get id;
  @override
  PatientInfo get patientId;
  @override
  String get doctorId;
  @override
  DateTime get date;
  @override
  AppointmentTimeSlot get timeSlot;
  @override
  String get type;
  @override
  String get status;
  @override
  String? get symptoms;
  @override
  String? get notes;
  @override
  String? get prescription;
  @override
  double get amount;
  @override
  String get paymentStatus;
  @override
  AppointmentPatientProfile? get patientProfile;
  @override
  @JsonKey(ignore: true)
  _$$DoctorAppointmentImplCopyWith<_$DoctorAppointmentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PatientInfo _$PatientInfoFromJson(Map<String, dynamic> json) {
  return _PatientInfo.fromJson(json);
}

/// @nodoc
mixin _$PatientInfo {
  @JsonKey(name: '_id')
  String get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get avatar => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PatientInfoCopyWith<PatientInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PatientInfoCopyWith<$Res> {
  factory $PatientInfoCopyWith(
          PatientInfo value, $Res Function(PatientInfo) then) =
      _$PatientInfoCopyWithImpl<$Res, PatientInfo>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      String? name,
      String? phone,
      String? avatar});
}

/// @nodoc
class _$PatientInfoCopyWithImpl<$Res, $Val extends PatientInfo>
    implements $PatientInfoCopyWith<$Res> {
  _$PatientInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? phone = freezed,
    Object? avatar = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      avatar: freezed == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PatientInfoImplCopyWith<$Res>
    implements $PatientInfoCopyWith<$Res> {
  factory _$$PatientInfoImplCopyWith(
          _$PatientInfoImpl value, $Res Function(_$PatientInfoImpl) then) =
      __$$PatientInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      String? name,
      String? phone,
      String? avatar});
}

/// @nodoc
class __$$PatientInfoImplCopyWithImpl<$Res>
    extends _$PatientInfoCopyWithImpl<$Res, _$PatientInfoImpl>
    implements _$$PatientInfoImplCopyWith<$Res> {
  __$$PatientInfoImplCopyWithImpl(
      _$PatientInfoImpl _value, $Res Function(_$PatientInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? phone = freezed,
    Object? avatar = freezed,
  }) {
    return _then(_$PatientInfoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      avatar: freezed == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PatientInfoImpl implements _PatientInfo {
  const _$PatientInfoImpl(
      {@JsonKey(name: '_id') required this.id,
      this.name,
      this.phone,
      this.avatar});

  factory _$PatientInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$PatientInfoImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String id;
  @override
  final String? name;
  @override
  final String? phone;
  @override
  final String? avatar;

  @override
  String toString() {
    return 'PatientInfo(id: $id, name: $name, phone: $phone, avatar: $avatar)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PatientInfoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.avatar, avatar) || other.avatar == avatar));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, phone, avatar);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PatientInfoImplCopyWith<_$PatientInfoImpl> get copyWith =>
      __$$PatientInfoImplCopyWithImpl<_$PatientInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PatientInfoImplToJson(
      this,
    );
  }
}

abstract class _PatientInfo implements PatientInfo {
  const factory _PatientInfo(
      {@JsonKey(name: '_id') required final String id,
      final String? name,
      final String? phone,
      final String? avatar}) = _$PatientInfoImpl;

  factory _PatientInfo.fromJson(Map<String, dynamic> json) =
      _$PatientInfoImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String get id;
  @override
  String? get name;
  @override
  String? get phone;
  @override
  String? get avatar;
  @override
  @JsonKey(ignore: true)
  _$$PatientInfoImplCopyWith<_$PatientInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
