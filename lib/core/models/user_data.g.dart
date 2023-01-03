// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserData _$$_UserDataFromJson(Map<String, dynamic> json) => _$_UserData(
      customerId: json['customerId'] as String,
      accessToken: json['accessToken'] as String,
      expiresIn: json['expiresIn'] as String,
      tokenType: json['tokenType'] as String,
      scope: json['scope'] as String,
      timezone: json['timezone'] as String,
      cc: json['cc'] as bool,
      community: json['community'] as bool,
      beta: json['beta'] as bool,
      latestVersion: json['latestVersion'] as String?,
      urlLink: json['urlLink'] as String?,
    );

Map<String, dynamic> _$$_UserDataToJson(_$_UserData instance) =>
    <String, dynamic>{
      'customerId': instance.customerId,
      'accessToken': instance.accessToken,
      'expiresIn': instance.expiresIn,
      'tokenType': instance.tokenType,
      'scope': instance.scope,
      'timezone': instance.timezone,
      'cc': instance.cc,
      'community': instance.community,
      'beta': instance.beta,
      'latestVersion': instance.latestVersion,
      'urlLink': instance.urlLink,
    };
