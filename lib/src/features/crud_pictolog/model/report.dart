import 'package:hive/hive.dart';

part 'report.g.dart';

@HiveType(typeId: 0)
class Report extends HiveObject {
  @HiveField(0)
  String imagePath; // Store the path, not the blob

  @HiveField(1)
  String? description;

  Report({
    required this.imagePath,
    this.description,
  });
}
