// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'second_dto_for_objectbox.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SecondDtoForObjectBox _$SecondDtoForObjectBoxFromJson(
        Map<String, dynamic> json) =>
    SecondDtoForObjectBox(
      id: (json['id'] as num?)?.toInt() ?? 0,
      entityTag: json['entityTag'] == null
          ? null
          : EntityTag.fromJson(json['entityTag'] as Map<String, dynamic>),
      name: json['name'] as String,
      shape: json['shape'] as String,
      description: (json['description'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      amount: (json['amount'] as num).toInt(),
      available: json['available'] as bool,
      color: json['color'] as String? ?? '',
    )
      ..containerId = (json['containerId'] as num?)?.toInt()
      ..noI = (json['noI'] as num?)?.toInt()
      ..userId = (json['userId'] as num?)?.toInt()
      ..version = (json['version'] as num?)?.toInt();

Map<String, dynamic> _$SecondDtoForObjectBoxToJson(
        SecondDtoForObjectBox instance) =>
    <String, dynamic>{
      'containerId': instance.containerId,
      'noI': instance.noI,
      'entityTag': instance.entityTag,
      'userId': instance.userId,
      'version': instance.version,
      'id': instance.id,
      'name': instance.name,
      'shape': instance.shape,
      'color': instance.color,
      'description': instance.description,
      'amount': instance.amount,
      'available': instance.available,
    };
