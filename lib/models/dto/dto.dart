import 'package:database_benchmark/models/dto/entity_tag.dart';

abstract class Dto {

  /// The local storage ID for this DTO. May be `null` for new DTOs.
  late int? containerId;

  /// The ID of the instance on the server side
  late int? noI;

  /// The entity tag reflects the entity tag in the AMOS server side.
  EntityTag? entityTag;

  /// Field used to have a perimeter by user for the table data in the local storage,
  /// userId is set when the table.put method is called with the logged-in userId
  int? userId;

  // evtl. als mixin damit es nicht für alle DTOs sind 
  int? version;

  Dto({this.containerId, this.noI, this.entityTag});

  Map<String, dynamic> toJson() {
    throw Exception('toJson() not implemented for DTO abstract class');
  }

  static Dto fromJson(Map<String, dynamic> json) {
    throw Exception('fromJson() not implemented for DTO abstract class');
  }

  @override
  String toString() {
    return 'containerId=$containerId, noI=$noI, entityTag=$entityTag, userId=$userId';
  }

}