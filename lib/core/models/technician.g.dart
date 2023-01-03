// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'technician.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Technician _$$_TechnicianFromJson(Map<String, dynamic> json) =>
    _$_Technician(
      uid: json['uid'] as String,
      email: json['email'] as String,
      firstName: json['firstname'] as String,
      middleName: json['middlename'] as String? ?? '',
      lastName: json['lastname'] as String? ?? '',
      address: json['address'] as String? ?? '',
      city: json['city'] as String? ?? '',
      zip: json['zip'] as String?,
      phoneNumber: json['phone_number'] as String?,
      cellNumber: json['cellnumber'] as String?,
      photoUrl: json['photourl'] as String? ??
          'https://firebasestorage.googleapis.com/v0/b/moveup-304715.appspot.com/o/authoringtool%2Fdefault_user_placeholder.png?alt=media',
      dateOfBirth: json['date_of_birth'] == null
          ? null
          : DateTime.parse(json['date_of_birth'] as String),
      age: json['age'] as num? ?? 0,
      addressB: json['address_b'] as String?,
      gender: json['gender'] as String? ?? 'Unspecified',
      experience: json['experience'] as String? ?? '',
      specialty: json['specialty'] as String? ?? '',
      yearsExperience: json['years_experience'] as int? ?? 0,
    );

Map<String, dynamic> _$$_TechnicianToJson(_$_Technician instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'firstname': instance.firstName,
      'middlename': instance.middleName,
      'lastname': instance.lastName,
      'address': instance.address,
      'city': instance.city,
      'zip': instance.zip,
      'phone_number': instance.phoneNumber,
      'cellnumber': instance.cellNumber,
      'photourl': instance.photoUrl,
      'date_of_birth': instance.dateOfBirth?.toIso8601String(),
      'age': instance.age,
      'address_b': instance.addressB,
      'gender': instance.gender,
      'experience': instance.experience,
      'specialty': instance.specialty,
      'years_experience': instance.yearsExperience,
    };
