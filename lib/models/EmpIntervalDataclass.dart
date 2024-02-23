// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

/* {
            "PK_Shift_ID": 1,
            "FK_EmpID": 2,
            "StartTime": "2023-10-25T13:27:04.49",
            "Endtime": "2023-11-01T14:48:43.29",
            "SafeStartValue": 0.00,
            "SafeEndValue": -138193021.38,
            "Running": false,
            "FK_EmpTo": 5
        }, */

class EmpIntervalDataclass {
  final int? PK_Shift_ID;
  final int? FK_EmpID;
  final String? StartTime;
  final String? Endtime;
  final double? SafeStartValue;
  final double? SafeEndValue;
  final bool? Running;
  final int? FK_EmpTo;
  EmpIntervalDataclass({
    this.PK_Shift_ID,
    this.FK_EmpID,
    this.StartTime,
    this.Endtime,
    this.SafeStartValue,
    this.SafeEndValue,
    this.Running,
    this.FK_EmpTo,
  });

  EmpIntervalDataclass copyWith({
    int? PK_Shift_ID,
    int? FK_EmpID,
    String? StartTime,
    String? Endtime,
    double? SafeStartValue,
    double? SafeEndValue,
    bool? Running,
    int? FK_EmpTo,
  }) {
    return EmpIntervalDataclass(
      PK_Shift_ID: PK_Shift_ID ?? this.PK_Shift_ID,
      FK_EmpID: FK_EmpID ?? this.FK_EmpID,
      StartTime: StartTime ?? this.StartTime,
      Endtime: Endtime ?? this.Endtime,
      SafeStartValue: SafeStartValue ?? this.SafeStartValue,
      SafeEndValue: SafeEndValue ?? this.SafeEndValue,
      Running: Running ?? this.Running,
      FK_EmpTo: FK_EmpTo ?? this.FK_EmpTo,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'PK_Shift_ID': PK_Shift_ID,
      'FK_EmpID': FK_EmpID,
      'StartTime': StartTime,
      'Endtime': Endtime,
      'SafeStartValue': SafeStartValue,
      'SafeEndValue': SafeEndValue,
      'Running': Running,
      'FK_EmpTo': FK_EmpTo,
    };
  }

  factory EmpIntervalDataclass.fromMap(Map<String, dynamic> map) {
    return EmpIntervalDataclass(
      PK_Shift_ID:
          map['PK_Shift_ID'] != null ? map['PK_Shift_ID'] as int : null,
      FK_EmpID: map['FK_EmpID'] != null ? map['FK_EmpID'] as int : null,
      StartTime: map['StartTime'] != null ? map['StartTime'] as String : null,
      Endtime: map['Endtime'] != null ? map['Endtime'] as String : null,
      SafeStartValue: map['SafeStartValue'] != null
          ? map['SafeStartValue'] as double
          : null,
      SafeEndValue:
          map['SafeEndValue'] != null ? map['SafeEndValue'] as double : null,
      Running: map['Running'] != null ? map['Running'] as bool : null,
      FK_EmpTo: map['FK_EmpTo'] != null ? map['FK_EmpTo'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory EmpIntervalDataclass.fromJson(String source) =>
      EmpIntervalDataclass.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'EmpIntervalDataclass(PK_Shift_ID: $PK_Shift_ID, FK_EmpID: $FK_EmpID, StartTime: $StartTime, Endtime: $Endtime, SafeStartValue: $SafeStartValue, SafeEndValue: $SafeEndValue, Running: $Running, FK_EmpTo: $FK_EmpTo)';
  }

  @override
  bool operator ==(covariant EmpIntervalDataclass other) {
    if (identical(this, other)) return true;

    return other.PK_Shift_ID == PK_Shift_ID &&
        other.FK_EmpID == FK_EmpID &&
        other.StartTime == StartTime &&
        other.Endtime == Endtime &&
        other.SafeStartValue == SafeStartValue &&
        other.SafeEndValue == SafeEndValue &&
        other.Running == Running &&
        other.FK_EmpTo == FK_EmpTo;
  }

  @override
  int get hashCode {
    return PK_Shift_ID.hashCode ^
        FK_EmpID.hashCode ^
        StartTime.hashCode ^
        Endtime.hashCode ^
        SafeStartValue.hashCode ^
        SafeEndValue.hashCode ^
        Running.hashCode ^
        FK_EmpTo.hashCode;
  }
}
