// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routine_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RoutineModelAdapter extends TypeAdapter<RoutineModel> {
  @override
  final int typeId = 1;

  @override
  RoutineModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RoutineModel(
      key: fields[0] as String,
      name: fields[1] as String,
      color: fields[2] as int,
      isListUp: fields[3] as bool,
      workoutModelList: (fields[4] as List)?.cast<WorkoutModel>(),
      days: (fields[5] as List)?.cast<String>(),
      restTime: fields[6] as int,
      finishedTime: fields[7] as int,
    );
  }

  @override
  void write(BinaryWriter writer, RoutineModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.key)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.color)
      ..writeByte(3)
      ..write(obj.isListUp)
      ..writeByte(4)
      ..write(obj.workoutModelList)
      ..writeByte(5)
      ..write(obj.days)
      ..writeByte(6)
      ..write(obj.restTime)
      ..writeByte(7)
      ..write(obj.finishedTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RoutineModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
