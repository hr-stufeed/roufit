// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'constants.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WorkoutTypeAdapter extends TypeAdapter<WorkoutType> {
  @override
  final int typeId = 3;

  @override
  WorkoutType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return WorkoutType.none;
      case 1:
        return WorkoutType.durationWeight;
      case 2:
        return WorkoutType.setWeight;
      default:
        return WorkoutType.none;
    }
  }

  @override
  void write(BinaryWriter writer, WorkoutType obj) {
    switch (obj) {
      case WorkoutType.none:
        writer.writeByte(0);
        break;
      case WorkoutType.durationWeight:
        writer.writeByte(1);
        break;
      case WorkoutType.setWeight:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkoutTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
