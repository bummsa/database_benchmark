// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fruit_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FruitDto _$FruitDtoFromJson(Map<String, dynamic> json) => FruitDto(
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
      ..userId = (json['userId'] as num?)?.toInt();

Map<String, dynamic> _$FruitDtoToJson(FruitDto instance) => <String, dynamic>{
      'containerId': instance.containerId,
      'noI': instance.noI,
      'entityTag': instance.entityTag,
      'userId': instance.userId,
      'name': instance.name,
      'shape': instance.shape,
      'color': instance.color,
      'description': instance.description,
      'amount': instance.amount,
      'available': instance.available,
    };
