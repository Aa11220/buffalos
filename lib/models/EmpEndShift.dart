// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class EmpEndShift {
  final String EmpName;
  final int PK_Shift_ID;
  final int FK_EmpID;
  final int FK_JobCategoryID;
  final String job_category;
  EmpEndShift({
    required this.EmpName,
    required this.PK_Shift_ID,
    required this.FK_EmpID,
    required this.FK_JobCategoryID,
    required this.job_category,
  });

  EmpEndShift copyWith({
    String? EmpName,
    int? PK_Shift_ID,
    int? FK_EmpID,
    int? FK_JobCategoryID,
    String? job_category,
  }) {
    return EmpEndShift(
      EmpName: EmpName ?? this.EmpName,
      PK_Shift_ID: PK_Shift_ID ?? this.PK_Shift_ID,
      FK_EmpID: FK_EmpID ?? this.FK_EmpID,
      FK_JobCategoryID: FK_JobCategoryID ?? this.FK_JobCategoryID,
      job_category: job_category ?? this.job_category,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'EmpName': EmpName,
      'PK_Shift_ID': PK_Shift_ID,
      'FK_EmpID': FK_EmpID,
      'FK_JobCategoryID': FK_JobCategoryID,
      'job_category': job_category,
    };
  }

  factory EmpEndShift.fromMap(Map<String, dynamic> map) {
    return EmpEndShift(
      EmpName: map['EmpName'] as String,
      PK_Shift_ID: map['PK_Shift_ID'] as int,
      FK_EmpID: map['FK_EmpID'] as int,
      FK_JobCategoryID: map['FK_JobCategoryID'] as int,
      job_category: map['job_category'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory EmpEndShift.fromJson(String source) =>
      EmpEndShift.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'EmpEndShift(EmpName: $EmpName, PK_Shift_ID: $PK_Shift_ID, FK_EmpID: $FK_EmpID, FK_JobCategoryID: $FK_JobCategoryID, job_category: $job_category)';
  }

  @override
  bool operator ==(covariant EmpEndShift other) {
    if (identical(this, other)) return true;

    return other.EmpName == EmpName &&
        other.PK_Shift_ID == PK_Shift_ID &&
        other.FK_EmpID == FK_EmpID &&
        other.FK_JobCategoryID == FK_JobCategoryID &&
        other.job_category == job_category;
  }

  @override
  int get hashCode {
    return EmpName.hashCode ^
        PK_Shift_ID.hashCode ^
        FK_EmpID.hashCode ^
        FK_JobCategoryID.hashCode ^
        job_category.hashCode;
  }
}
