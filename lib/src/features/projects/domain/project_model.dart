import 'package:hive/hive.dart';
import '../../reports/domain/report_model.dart';

part 'project_model.g.dart';

@HiveType(typeId: 1)
class ProjectModel extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String overviewDescription;

  @HiveField(2)
  List<ReportModel> reports;

  @HiveField(3)
  DateTime createdAt;

  @HiveField(4)
  DateTime? updatedAt;

  ProjectModel({
    required this.name,
    required this.overviewDescription,
    this.reports = const [],
    required this.createdAt,
    this.updatedAt,
  });
}
