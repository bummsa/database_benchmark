import 'package:database_benchmark/models/dto/dto.dart';
import 'package:database_benchmark/models/dto/entity_tag.dart';
import 'package:objectbox/objectbox.dart';
import 'package:json_annotation/json_annotation.dart';

part 'fruit_dto_for_objectbox.g.dart';

@Entity()
@JsonSerializable()
class FruitDtoForObjectBox extends Dto {
  @Id(assignable: true)
  int id;

  final String name;
  final String shape;
  final String color;
  final List<String> description;
  final int amount;
  final bool available;

  FruitDtoForObjectBox({
    this.id = 0,
    int? noi,
    super.entityTag,
    required this.name,
    required this.shape,
    required this.description,
    required this.amount,
    required this.available,
    this.color = '',
  }) : super(containerId: id, noI: noi);

  factory FruitDtoForObjectBox.fromJson(Map<String, dynamic> json) =>
      _$FruitDtoForObjectBoxFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$FruitDtoForObjectBoxToJson(this);
}
