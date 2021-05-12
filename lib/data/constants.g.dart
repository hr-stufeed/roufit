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
        return WorkoutType.setOnly;
      case 1:
        return WorkoutType.durationOnly;
      case 2:
        return WorkoutType.setWeight;
      case 3:
        return WorkoutType.durationWeight;
      default:
        return WorkoutType.setOnly;
    }
  }

  @override
  void write(BinaryWriter writer, WorkoutType obj) {
    switch (obj) {
      case WorkoutType.setOnly:
        writer.writeByte(0);
        break;
      case WorkoutType.durationOnly:
        writer.writeByte(1);
        break;
      case WorkoutType.setWeight:
        writer.writeByte(2);
        break;
      case WorkoutType.durationWeight:
        writer.writeByte(3);
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
