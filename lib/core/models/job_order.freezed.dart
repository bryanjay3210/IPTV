// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'job_order.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

JobOrder _$JobOrderFromJson(Map<String, dynamic> json) {
  return _JobOrder.fromJson(json);
}

/// @nodoc
mixin _$JobOrder {
  String get jobOrderId => throw _privateConstructorUsedError;
  ServiceRequestType get serviceRequestType =>
      throw _privateConstructorUsedError;
  String get clientId => throw _privateConstructorUsedError;
  String get clientName => throw _privateConstructorUsedError;
  String get clientEmail => throw _privateConstructorUsedError;
  UnitType get unitType => throw _privateConstructorUsedError;
  String get technicianName => throw _privateConstructorUsedError;
  String get repairTechnicianName => throw _privateConstructorUsedError;
  JobOrderCurrentProgressType get joCurrentProgress =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'prefferedDate')
  DateTime? get preferredDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'prefferedTime')
  String? get preferredTime => throw _privateConstructorUsedError;
  String get technicianId => throw _privateConstructorUsedError;
  int get joProgressId => throw _privateConstructorUsedError;
  String? get subProgress => throw _privateConstructorUsedError;
  num? get estimatedRepairPrice => throw _privateConstructorUsedError;
  num? get estimatedRepairDays => throw _privateConstructorUsedError;
  bool? get isRepairable => throw _privateConstructorUsedError;
  String? get offerId => throw _privateConstructorUsedError;
  String? get repairTechnicianId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $JobOrderCopyWith<JobOrder> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JobOrderCopyWith<$Res> {
  factory $JobOrderCopyWith(JobOrder value, $Res Function(JobOrder) then) =
      _$JobOrderCopyWithImpl<$Res>;
  $Res call(
      {String jobOrderId,
      ServiceRequestType serviceRequestType,
      String clientId,
      String clientName,
      String clientEmail,
      UnitType unitType,
      String technicianName,
      String repairTechnicianName,
      JobOrderCurrentProgressType joCurrentProgress,
      @JsonKey(name: 'prefferedDate') DateTime? preferredDate,
      @JsonKey(name: 'prefferedTime') String? preferredTime,
      String technicianId,
      int joProgressId,
      String? subProgress,
      num? estimatedRepairPrice,
      num? estimatedRepairDays,
      bool? isRepairable,
      String? offerId,
      String? repairTechnicianId});
}

/// @nodoc
class _$JobOrderCopyWithImpl<$Res> implements $JobOrderCopyWith<$Res> {
  _$JobOrderCopyWithImpl(this._value, this._then);

  final JobOrder _value;
  // ignore: unused_field
  final $Res Function(JobOrder) _then;

  @override
  $Res call({
    Object? jobOrderId = freezed,
    Object? serviceRequestType = freezed,
    Object? clientId = freezed,
    Object? clientName = freezed,
    Object? clientEmail = freezed,
    Object? unitType = freezed,
    Object? technicianName = freezed,
    Object? repairTechnicianName = freezed,
    Object? joCurrentProgress = freezed,
    Object? preferredDate = freezed,
    Object? preferredTime = freezed,
    Object? technicianId = freezed,
    Object? joProgressId = freezed,
    Object? subProgress = freezed,
    Object? estimatedRepairPrice = freezed,
    Object? estimatedRepairDays = freezed,
    Object? isRepairable = freezed,
    Object? offerId = freezed,
    Object? repairTechnicianId = freezed,
  }) {
    return _then(_value.copyWith(
      jobOrderId: jobOrderId == freezed
          ? _value.jobOrderId
          : jobOrderId // ignore: cast_nullable_to_non_nullable
              as String,
      serviceRequestType: serviceRequestType == freezed
          ? _value.serviceRequestType
          : serviceRequestType // ignore: cast_nullable_to_non_nullable
              as ServiceRequestType,
      clientId: clientId == freezed
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      clientName: clientName == freezed
          ? _value.clientName
          : clientName // ignore: cast_nullable_to_non_nullable
              as String,
      clientEmail: clientEmail == freezed
          ? _value.clientEmail
          : clientEmail // ignore: cast_nullable_to_non_nullable
              as String,
      unitType: unitType == freezed
          ? _value.unitType
          : unitType // ignore: cast_nullable_to_non_nullable
              as UnitType,
      technicianName: technicianName == freezed
          ? _value.technicianName
          : technicianName // ignore: cast_nullable_to_non_nullable
              as String,
      repairTechnicianName: repairTechnicianName == freezed
          ? _value.repairTechnicianName
          : repairTechnicianName // ignore: cast_nullable_to_non_nullable
              as String,
      joCurrentProgress: joCurrentProgress == freezed
          ? _value.joCurrentProgress
          : joCurrentProgress // ignore: cast_nullable_to_non_nullable
              as JobOrderCurrentProgressType,
      preferredDate: preferredDate == freezed
          ? _value.preferredDate
          : preferredDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      preferredTime: preferredTime == freezed
          ? _value.preferredTime
          : preferredTime // ignore: cast_nullable_to_non_nullable
              as String?,
      technicianId: technicianId == freezed
          ? _value.technicianId
          : technicianId // ignore: cast_nullable_to_non_nullable
              as String,
      joProgressId: joProgressId == freezed
          ? _value.joProgressId
          : joProgressId // ignore: cast_nullable_to_non_nullable
              as int,
      subProgress: subProgress == freezed
          ? _value.subProgress
          : subProgress // ignore: cast_nullable_to_non_nullable
              as String?,
      estimatedRepairPrice: estimatedRepairPrice == freezed
          ? _value.estimatedRepairPrice
          : estimatedRepairPrice // ignore: cast_nullable_to_non_nullable
              as num?,
      estimatedRepairDays: estimatedRepairDays == freezed
          ? _value.estimatedRepairDays
          : estimatedRepairDays // ignore: cast_nullable_to_non_nullable
              as num?,
      isRepairable: isRepairable == freezed
          ? _value.isRepairable
          : isRepairable // ignore: cast_nullable_to_non_nullable
              as bool?,
      offerId: offerId == freezed
          ? _value.offerId
          : offerId // ignore: cast_nullable_to_non_nullable
              as String?,
      repairTechnicianId: repairTechnicianId == freezed
          ? _value.repairTechnicianId
          : repairTechnicianId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$$_JobOrderCopyWith<$Res> implements $JobOrderCopyWith<$Res> {
  factory _$$_JobOrderCopyWith(
          _$_JobOrder value, $Res Function(_$_JobOrder) then) =
      __$$_JobOrderCopyWithImpl<$Res>;
  @override
  $Res call(
      {String jobOrderId,
      ServiceRequestType serviceRequestType,
      String clientId,
      String clientName,
      String clientEmail,
      UnitType unitType,
      String technicianName,
      String repairTechnicianName,
      JobOrderCurrentProgressType joCurrentProgress,
      @JsonKey(name: 'prefferedDate') DateTime? preferredDate,
      @JsonKey(name: 'prefferedTime') String? preferredTime,
      String technicianId,
      int joProgressId,
      String? subProgress,
      num? estimatedRepairPrice,
      num? estimatedRepairDays,
      bool? isRepairable,
      String? offerId,
      String? repairTechnicianId});
}

/// @nodoc
class __$$_JobOrderCopyWithImpl<$Res> extends _$JobOrderCopyWithImpl<$Res>
    implements _$$_JobOrderCopyWith<$Res> {
  __$$_JobOrderCopyWithImpl(
      _$_JobOrder _value, $Res Function(_$_JobOrder) _then)
      : super(_value, (v) => _then(v as _$_JobOrder));

  @override
  _$_JobOrder get _value => super._value as _$_JobOrder;

  @override
  $Res call({
    Object? jobOrderId = freezed,
    Object? serviceRequestType = freezed,
    Object? clientId = freezed,
    Object? clientName = freezed,
    Object? clientEmail = freezed,
    Object? unitType = freezed,
    Object? technicianName = freezed,
    Object? repairTechnicianName = freezed,
    Object? joCurrentProgress = freezed,
    Object? preferredDate = freezed,
    Object? preferredTime = freezed,
    Object? technicianId = freezed,
    Object? joProgressId = freezed,
    Object? subProgress = freezed,
    Object? estimatedRepairPrice = freezed,
    Object? estimatedRepairDays = freezed,
    Object? isRepairable = freezed,
    Object? offerId = freezed,
    Object? repairTechnicianId = freezed,
  }) {
    return _then(_$_JobOrder(
      jobOrderId: jobOrderId == freezed
          ? _value.jobOrderId
          : jobOrderId // ignore: cast_nullable_to_non_nullable
              as String,
      serviceRequestType: serviceRequestType == freezed
          ? _value.serviceRequestType
          : serviceRequestType // ignore: cast_nullable_to_non_nullable
              as ServiceRequestType,
      clientId: clientId == freezed
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      clientName: clientName == freezed
          ? _value.clientName
          : clientName // ignore: cast_nullable_to_non_nullable
              as String,
      clientEmail: clientEmail == freezed
          ? _value.clientEmail
          : clientEmail // ignore: cast_nullable_to_non_nullable
              as String,
      unitType: unitType == freezed
          ? _value.unitType
          : unitType // ignore: cast_nullable_to_non_nullable
              as UnitType,
      technicianName: technicianName == freezed
          ? _value.technicianName
          : technicianName // ignore: cast_nullable_to_non_nullable
              as String,
      repairTechnicianName: repairTechnicianName == freezed
          ? _value.repairTechnicianName
          : repairTechnicianName // ignore: cast_nullable_to_non_nullable
              as String,
      joCurrentProgress: joCurrentProgress == freezed
          ? _value.joCurrentProgress
          : joCurrentProgress // ignore: cast_nullable_to_non_nullable
              as JobOrderCurrentProgressType,
      preferredDate: preferredDate == freezed
          ? _value.preferredDate
          : preferredDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      preferredTime: preferredTime == freezed
          ? _value.preferredTime
          : preferredTime // ignore: cast_nullable_to_non_nullable
              as String?,
      technicianId: technicianId == freezed
          ? _value.technicianId
          : technicianId // ignore: cast_nullable_to_non_nullable
              as String,
      joProgressId: joProgressId == freezed
          ? _value.joProgressId
          : joProgressId // ignore: cast_nullable_to_non_nullable
              as int,
      subProgress: subProgress == freezed
          ? _value.subProgress
          : subProgress // ignore: cast_nullable_to_non_nullable
              as String?,
      estimatedRepairPrice: estimatedRepairPrice == freezed
          ? _value.estimatedRepairPrice
          : estimatedRepairPrice // ignore: cast_nullable_to_non_nullable
              as num?,
      estimatedRepairDays: estimatedRepairDays == freezed
          ? _value.estimatedRepairDays
          : estimatedRepairDays // ignore: cast_nullable_to_non_nullable
              as num?,
      isRepairable: isRepairable == freezed
          ? _value.isRepairable
          : isRepairable // ignore: cast_nullable_to_non_nullable
              as bool?,
      offerId: offerId == freezed
          ? _value.offerId
          : offerId // ignore: cast_nullable_to_non_nullable
              as String?,
      repairTechnicianId: repairTechnicianId == freezed
          ? _value.repairTechnicianId
          : repairTechnicianId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_JobOrder implements _JobOrder {
  const _$_JobOrder(
      {required this.jobOrderId,
      required this.serviceRequestType,
      required this.clientId,
      required this.clientName,
      required this.clientEmail,
      required this.unitType,
      required this.technicianName,
      required this.repairTechnicianName,
      required this.joCurrentProgress,
      @JsonKey(name: 'prefferedDate') required this.preferredDate,
      @JsonKey(name: 'prefferedTime') required this.preferredTime,
      required this.technicianId,
      required this.joProgressId,
      required this.subProgress,
      required this.estimatedRepairPrice,
      required this.estimatedRepairDays,
      required this.isRepairable,
      required this.offerId,
      required this.repairTechnicianId});

  factory _$_JobOrder.fromJson(Map<String, dynamic> json) =>
      _$$_JobOrderFromJson(json);

  @override
  final String jobOrderId;
  @override
  final ServiceRequestType serviceRequestType;
  @override
  final String clientId;
  @override
  final String clientName;
  @override
  final String clientEmail;
  @override
  final UnitType unitType;
  @override
  final String technicianName;
  @override
  final String repairTechnicianName;
  @override
  final JobOrderCurrentProgressType joCurrentProgress;
  @override
  @JsonKey(name: 'prefferedDate')
  final DateTime? preferredDate;
  @override
  @JsonKey(name: 'prefferedTime')
  final String? preferredTime;
  @override
  final String technicianId;
  @override
  final int joProgressId;
  @override
  final String? subProgress;
  @override
  final num? estimatedRepairPrice;
  @override
  final num? estimatedRepairDays;
  @override
  final bool? isRepairable;
  @override
  final String? offerId;
  @override
  final String? repairTechnicianId;

  @override
  String toString() {
    return 'JobOrder(jobOrderId: $jobOrderId, serviceRequestType: $serviceRequestType, clientId: $clientId, clientName: $clientName, clientEmail: $clientEmail, unitType: $unitType, technicianName: $technicianName, repairTechnicianName: $repairTechnicianName, joCurrentProgress: $joCurrentProgress, preferredDate: $preferredDate, preferredTime: $preferredTime, technicianId: $technicianId, joProgressId: $joProgressId, subProgress: $subProgress, estimatedRepairPrice: $estimatedRepairPrice, estimatedRepairDays: $estimatedRepairDays, isRepairable: $isRepairable, offerId: $offerId, repairTechnicianId: $repairTechnicianId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_JobOrder &&
            const DeepCollectionEquality()
                .equals(other.jobOrderId, jobOrderId) &&
            const DeepCollectionEquality()
                .equals(other.serviceRequestType, serviceRequestType) &&
            const DeepCollectionEquality().equals(other.clientId, clientId) &&
            const DeepCollectionEquality()
                .equals(other.clientName, clientName) &&
            const DeepCollectionEquality()
                .equals(other.clientEmail, clientEmail) &&
            const DeepCollectionEquality().equals(other.unitType, unitType) &&
            const DeepCollectionEquality()
                .equals(other.technicianName, technicianName) &&
            const DeepCollectionEquality()
                .equals(other.repairTechnicianName, repairTechnicianName) &&
            const DeepCollectionEquality()
                .equals(other.joCurrentProgress, joCurrentProgress) &&
            const DeepCollectionEquality()
                .equals(other.preferredDate, preferredDate) &&
            const DeepCollectionEquality()
                .equals(other.preferredTime, preferredTime) &&
            const DeepCollectionEquality()
                .equals(other.technicianId, technicianId) &&
            const DeepCollectionEquality()
                .equals(other.joProgressId, joProgressId) &&
            const DeepCollectionEquality()
                .equals(other.subProgress, subProgress) &&
            const DeepCollectionEquality()
                .equals(other.estimatedRepairPrice, estimatedRepairPrice) &&
            const DeepCollectionEquality()
                .equals(other.estimatedRepairDays, estimatedRepairDays) &&
            const DeepCollectionEquality()
                .equals(other.isRepairable, isRepairable) &&
            const DeepCollectionEquality().equals(other.offerId, offerId) &&
            const DeepCollectionEquality()
                .equals(other.repairTechnicianId, repairTechnicianId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        const DeepCollectionEquality().hash(jobOrderId),
        const DeepCollectionEquality().hash(serviceRequestType),
        const DeepCollectionEquality().hash(clientId),
        const DeepCollectionEquality().hash(clientName),
        const DeepCollectionEquality().hash(clientEmail),
        const DeepCollectionEquality().hash(unitType),
        const DeepCollectionEquality().hash(technicianName),
        const DeepCollectionEquality().hash(repairTechnicianName),
        const DeepCollectionEquality().hash(joCurrentProgress),
        const DeepCollectionEquality().hash(preferredDate),
        const DeepCollectionEquality().hash(preferredTime),
        const DeepCollectionEquality().hash(technicianId),
        const DeepCollectionEquality().hash(joProgressId),
        const DeepCollectionEquality().hash(subProgress),
        const DeepCollectionEquality().hash(estimatedRepairPrice),
        const DeepCollectionEquality().hash(estimatedRepairDays),
        const DeepCollectionEquality().hash(isRepairable),
        const DeepCollectionEquality().hash(offerId),
        const DeepCollectionEquality().hash(repairTechnicianId)
      ]);

  @JsonKey(ignore: true)
  @override
  _$$_JobOrderCopyWith<_$_JobOrder> get copyWith =>
      __$$_JobOrderCopyWithImpl<_$_JobOrder>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_JobOrderToJson(
      this,
    );
  }
}

abstract class _JobOrder implements JobOrder {
  const factory _JobOrder(
      {required final String jobOrderId,
      required final ServiceRequestType serviceRequestType,
      required final String clientId,
      required final String clientName,
      required final String clientEmail,
      required final UnitType unitType,
      required final String technicianName,
      required final String repairTechnicianName,
      required final JobOrderCurrentProgressType joCurrentProgress,
      @JsonKey(name: 'prefferedDate') required final DateTime? preferredDate,
      @JsonKey(name: 'prefferedTime') required final String? preferredTime,
      required final String technicianId,
      required final int joProgressId,
      required final String? subProgress,
      required final num? estimatedRepairPrice,
      required final num? estimatedRepairDays,
      required final bool? isRepairable,
      required final String? offerId,
      required final String? repairTechnicianId}) = _$_JobOrder;

  factory _JobOrder.fromJson(Map<String, dynamic> json) = _$_JobOrder.fromJson;

  @override
  String get jobOrderId;
  @override
  ServiceRequestType get serviceRequestType;
  @override
  String get clientId;
  @override
  String get clientName;
  @override
  String get clientEmail;
  @override
  UnitType get unitType;
  @override
  String get technicianName;
  @override
  String get repairTechnicianName;
  @override
  JobOrderCurrentProgressType get joCurrentProgress;
  @override
  @JsonKey(name: 'prefferedDate')
  DateTime? get preferredDate;
  @override
  @JsonKey(name: 'prefferedTime')
  String? get preferredTime;
  @override
  String get technicianId;
  @override
  int get joProgressId;
  @override
  String? get subProgress;
  @override
  num? get estimatedRepairPrice;
  @override
  num? get estimatedRepairDays;
  @override
  bool? get isRepairable;
  @override
  String? get offerId;
  @override
  String? get repairTechnicianId;
  @override
  @JsonKey(ignore: true)
  _$$_JobOrderCopyWith<_$_JobOrder> get copyWith =>
      throw _privateConstructorUsedError;
}
