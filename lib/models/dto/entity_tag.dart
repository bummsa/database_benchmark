import 'package:json_annotation/json_annotation.dart';

part 'entity_tag.g.dart';

///  Stores information about the revision / "point in time" of a resource object.
///  This tag is then used for optimistic concurrency control.
///
///  Uses the "Memento" design pattern to store the resource revision.

@JsonSerializable()
class EntityTag {
  String? tag;

  EntityTag({this.tag}) : super();

  static EntityTag fromJson(Map<String, dynamic> json) =>
      _$EntityTagFromJson(json);
  Map<String, dynamic> toJson() => _$EntityTagToJson(this);
}
