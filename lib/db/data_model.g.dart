// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserNameModelAdapter extends TypeAdapter<UserNameModel> {
  @override
  final int typeId = 0;

  @override
  UserNameModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserNameModel(
      fields[0] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UserNameModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.userName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserNameModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
