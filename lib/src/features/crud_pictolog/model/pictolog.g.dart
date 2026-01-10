// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pictolog.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PictologAdapter extends TypeAdapter<Pictolog> {
  @override
  final int typeId = 1;

  @override
  Pictolog read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Pictolog(
      name: fields[0] as String,
      overviewDescription: fields[1] as String,
      reports: (fields[2] as List).cast<Report>(),
      createdAt: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Pictolog obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.overviewDescription)
      ..writeByte(2)
      ..write(obj.reports)
      ..writeByte(3)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PictologAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
