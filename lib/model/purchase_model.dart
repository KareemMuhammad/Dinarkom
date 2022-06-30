class PurchaseModel {
  bool? status;
  String? errorNumber;
  String? message;
  List<Purchase>? purchase;

  PurchaseModel({this.status, this.errorNumber, this.message, this.purchase});

  PurchaseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errorNumber = json['errorNumber'];
    message = json['message'];
    if (json['purches'] != null) {
      purchase = <Purchase>[];
      json['purches'].forEach((v) {
        purchase!.add( Purchase.fromJson(v));
      });
    }else{
      purchase = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['status'] = this.status;
    data['errorNumber'] = this.errorNumber;
    data['message'] = this.message;
    if (this.purchase != null) {
      data['purches'] = this.purchase!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Purchase {
  int? id;
  int? orderNum;
  int? incrimentNum;
  int? ym;
  int? imgID;
  int? userID;
  int? relativeID;
  String? orderDate;
  int? price;
  int? tasks;
  int? totalPrice;
  int? status;
  String? updatedAt;
  Null? paymentid;
  Null? result;
  Null? ref;
  Null? tranid;
  Null? postdate;
  Null? trackid;
  int? knetStatuse;
  Null? createdAt;

  Purchase(
      {this.id,
        this.orderNum,
        this.incrimentNum,
        this.ym,
        this.imgID,
        this.userID,
        this.relativeID,
        this.orderDate,
        this.price,
        this.tasks,
        this.totalPrice,
        this.status,
        this.updatedAt,
        this.paymentid,
        this.result,
        this.ref,
        this.tranid,
        this.postdate,
        this.trackid,
        this.knetStatuse,
        this.createdAt});

  Purchase.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderNum = json['orderNum'];
    incrimentNum = json['incrimentNum'];
    ym = json['ym'];
    imgID = json['imgID'];
    userID = json['userID'];
    relativeID = json['relativeID'];
    orderDate = json['orderDate'];
    price = json['price'];
    tasks = json['tasks'];
    totalPrice = json['totalPrice'];
    status = json['status'];
    updatedAt = json['updated_at'];
    paymentid = json['paymentid'];
    result = json['result'];
    ref = json['ref'];
    tranid = json['tranid'];
    postdate = json['postdate'];
    trackid = json['trackid'];
    knetStatuse = json['knetStatuse'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['orderNum'] = this.orderNum;
    data['incrimentNum'] = this.incrimentNum;
    data['ym'] = this.ym;
    data['imgID'] = this.imgID;
    data['userID'] = this.userID;
    data['relativeID'] = this.relativeID;
    data['orderDate'] = this.orderDate;
    data['price'] = this.price;
    data['tasks'] = this.tasks;
    data['totalPrice'] = this.totalPrice;
    data['status'] = this.status;
    data['updated_at'] = this.updatedAt;
    data['paymentid'] = this.paymentid;
    data['result'] = this.result;
    data['ref'] = this.ref;
    data['tranid'] = this.tranid;
    data['postdate'] = this.postdate;
    data['trackid'] = this.trackid;
    data['knetStatuse'] = this.knetStatuse;
    data['created_at'] = this.createdAt;
    return data;
  }
}