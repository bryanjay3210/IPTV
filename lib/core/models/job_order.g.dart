// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_JobOrder _$$_JobOrderFromJson(Map<String, dynamic> json) => _$_JobOrder(
      jobOrderId: json['jobOrderId'] as String,
      serviceRequestType:
          $enumDecode(_$ServiceRequestTypeEnumMap, json['serviceRequestType']),
      clientId: json['clientId'] as String,
      clientName: json['clientName'] as String,
      clientEmail: json['clientEmail'] as String,
      unitType: $enumDecode(_$UnitTypeEnumMap, json['unitType']),
      technicianName: json['technicianName'] as String,
      repairTechnicianName: json['repairTechnicianName'] as String,
      joCurrentProgress: $enumDecode(
          _$JobOrderCurrentProgressTypeEnumMap, json['joCurrentProgress']),
      preferredDate: json['prefferedDate'] == null
          ? null
          : DateTime.parse(json['prefferedDate'] as String),
      preferredTime: json['prefferedTime'] as String?,
      technicianId: json['technicianId'] as String,
      joProgressId: json['joProgressId'] as int,
      subProgress: json['subProgress'] as String?,
      estimatedRepairPrice: json['estimatedRepairPrice'] as num?,
      estimatedRepairDays: json['estimatedRepairDays'] as num?,
      isRepairable: json['isRepairable'] as bool?,
      offerId: json['offerId'] as String?,
      repairTechnicianId: json['repairTechnicianId'] as String?,
    );

Map<String, dynamic> _$$_JobOrderToJson(_$_JobOrder instance) =>
    <String, dynamic>{
      'jobOrderId': instance.jobOrderId,
      'serviceRequestType':
          _$ServiceRequestTypeEnumMap[instance.serviceRequestType]!,
      'clientId': instance.clientId,
      'clientName': instance.clientName,
      'clientEmail': instance.clientEmail,
      'unitType': _$UnitTypeEnumMap[instance.unitType]!,
      'technicianName': instance.technicianName,
      'repairTechnicianName': instance.repairTechnicianName,
      'joCurrentProgress':
          _$JobOrderCurrentProgressTypeEnumMap[instance.joCurrentProgress]!,
      'prefferedDate': instance.preferredDate?.toIso8601String(),
      'prefferedTime': instance.preferredTime,
      'technicianId': instance.technicianId,
      'joProgressId': instance.joProgressId,
      'subProgress': instance.subProgress,
      'estimatedRepairPrice': instance.estimatedRepairPrice,
      'estimatedRepairDays': instance.estimatedRepairDays,
      'isRepairable': instance.isRepairable,
      'offerId': instance.offerId,
      'repairTechnicianId': instance.repairTechnicianId,
    };

const _$ServiceRequestTypeEnumMap = {
  ServiceRequestType.service: 'service',
  ServiceRequestType.serviceWithMaterials: 'service_with_materials',
};

const _$UnitTypeEnumMap = {
  UnitType.laptop: '1',
  UnitType.mobile: '2',
  UnitType.tablet: '3',
  UnitType.spareParts: '4',
  UnitType.other: '5',
};

const _$JobOrderCurrentProgressTypeEnumMap = {
  JobOrderCurrentProgressType.offer: 'Offer',
  JobOrderCurrentProgressType.diagnostic: 'Diagnostic',
  JobOrderCurrentProgressType.serviceRequest: 'Service Request',
  JobOrderCurrentProgressType.repair: 'Repair',
  JobOrderCurrentProgressType.invoice: 'Invoice',
  JobOrderCurrentProgressType.payment: 'Payment',
  JobOrderCurrentProgressType.release: 'Release',
  JobOrderCurrentProgressType.feedback: 'Feedback',
};
