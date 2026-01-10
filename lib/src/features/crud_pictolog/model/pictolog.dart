import 'package:hive/hive.dart';
import 'report.dart';

part 'pictolog.g.dart';

@HiveType(typeId: 1)
class Pictolog extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String overviewDescription;

  @HiveField(2)
  List<Report> reports;

  @HiveField(3)
  DateTime createdAt;

  @HiveField(4)
  DateTime? updatedAt;

  Pictolog({
    required this.name,
    required this.overviewDescription,
    this.reports = const [],
    required this.createdAt,
    this.updatedAt,
  });
}
