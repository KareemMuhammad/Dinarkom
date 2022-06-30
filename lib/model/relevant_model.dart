class RelevantModel {
  bool? status;
  String? errorNumber;
  String? message;
  List<Relatives>? relatives;

  RelevantModel({this.status, this.errorNumber, this.message, this.relatives});

  RelevantModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errorNumber = json['errorNumber'];
    message = json['message'];
    if (json['relatives'] != null) {
      relatives = <Relatives>[];
      json['relatives'].forEach((v) {
        relatives!.add( Relatives.fromJson(v));
      });
    }else{
      relatives = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['status'] = this.status;
    data['errorNumber'] = this.errorNumber;
    data['message'] = this.message;
    if (this.relatives != null) {
      data['relatives'] = this.relatives!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Relatives {
  int? id;
  int? userID;
  String? relativeRelation;
  String? relativeName;
  String? relativeCivilID;
  String? createdAt;
  String? updatedAt;

  Relatives(
      {this.id,
        this.userID,
        this.relativeRelation,
        this.relativeName,
        this.relativeCivilID,
        this.createdAt,
        this.updatedAt});

  Relatives.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userID = json['userID'];
    relativeRelation = json['relativeRelation'];
    relativeName = json['relativeName'];
    relativeCivilID = json['relativeCivilID'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = this.id;
    data['userID'] = this.userID;
    data['relativeRelation'] = this.relativeRelation;
    data['relativeName'] = this.relativeName;
    data['relativeCivilID'] = this.relativeCivilID;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}