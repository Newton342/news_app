import 'package:hive/hive.dart';

part 'source.g.dart';

@HiveType(typeId: 1)
class Source {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? name;

  Source({this.id, this.name});
}
