import 'package:database_benchmark/models/dto/dto.dart';
import 'package:database_benchmark/models/dto/entity_tag.dart';
import 'package:json_annotation/json_annotation.dart';

part 'second_dto.g.dart';

@JsonSerializable()
class SecondDto extends Dto {
  final String name;
  final String shape;
  final String color;
  final List<String> description;
  final int amount;
  final bool available;

  SecondDto({
    int? id,
    int? noi,
    super.entityTag,
    required this.name,
    required this.shape,
    required this.description,
    required this.amount,
    required this.available,
    this.color = '',
  }) : super(containerId: id, noI: noi);

  static SecondDto fromJson(Map<String, dynamic> json) =>
      _$SecondDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SecondDtoToJson(this);

  static List<SecondDto> generateDtos(int count) {
    final result = <SecondDto>[];

    final listSize = count == 1 ? 1 : (count / 2).round();
    final descriptions = generateDescriptions(listSize);

    for (int i = 0; i < count; i++) {
      final dto = SecondDto(
        id: i,
        name: 'name$i',
        shape: "shape$i",
        description: descriptions,
        amount: i,
        available: true,
      );
      result.add(dto);
    }
    return result;
  }

  static List<String> generateDescriptions(int count) {
    final result = <String>[];
    for (int i = 0; i < count; i++) {}
    return result;
  }
}
