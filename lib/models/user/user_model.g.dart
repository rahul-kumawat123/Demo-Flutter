// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      dob: DateTime.parse(json['dob'] as String),
      gender: json['gender'] as String,
      profileImagePath: json['profileImagePath'] as String?,
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
      'dob': instance.dob.toIso8601String(),
      'gender': instance.gender,
      'profileImagePath': instance.profileImagePath,
    };
