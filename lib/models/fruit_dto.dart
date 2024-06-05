import 'package:database_benchmark/models/dto/dto.dart';
import 'package:database_benchmark/models/dto/entity_tag.dart';
import 'package:json_annotation/json_annotation.dart';

part 'fruit_dto.g.dart';

@JsonSerializable()
class FruitDto extends Dto {
  final String name;
  final String shape;
  final String color;
  final List<String> description;
  final int amount;
  final bool available;

  FruitDto({
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

  static FruitDto fromJson(Map<String, dynamic> json) =>
      _$FruitDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$FruitDtoToJson(this);

  static List<FruitDto> generateDtos(int count) {
    final result = <FruitDto>[];

    final listSize = count == 1 ? 1 : (count / 2).round();
    final descriptions = generateDescriptions(listSize);

    for (int i = 0; i < count; i++) {
      final dto = FruitDto(
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
