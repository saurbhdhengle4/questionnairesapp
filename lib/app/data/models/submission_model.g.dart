part of 'submission_model.dart';

class SubmissionModelAdapter extends TypeAdapter<SubmissionModel> {
  @override
  final int typeId = 0;

  @override
  SubmissionModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SubmissionModel(
      questionnaireId: fields[0] as String,
      questionnaireName: fields[1] as String,
      answers: (fields[2] as Map).cast<String, String>(),
      submissionDate: fields[3] as DateTime,
      latitude: fields[4] as double,
      longitude: fields[5] as double,
    );
  }

  @override
  void write(BinaryWriter writer, SubmissionModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.questionnaireId)
      ..writeByte(1)
      ..write(obj.questionnaireName)
      ..writeByte(2)
      ..write(obj.answers)
      ..writeByte(3)
      ..write(obj.submissionDate)
      ..writeByte(4)
      ..write(obj.latitude)
      ..writeByte(5)
      ..write(obj.longitude);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubmissionModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
