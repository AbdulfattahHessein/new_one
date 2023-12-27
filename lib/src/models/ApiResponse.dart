import 'package:new_one/main.dart';

class ApiResponse<T extends JsonSerializable> {
  List<T>? data;
  bool? succeeded;
  int? statusCode;
  dynamic meta;
  String? message;
  Map<String, List<String>>? errors;

  ApiResponse({
    this.data,
    this.succeeded,
    this.statusCode,
    this.meta,
    this.message,
    this.errors,
  });

  ApiResponse.fromJson(
      Map<String, dynamic> json, T Function(dynamic) fromJsonT) {
    if (json['data'] != null) {
      var dataList = json['data'] as List;
      data = dataList.map((item) => fromJsonT(item)).toList();
    }
    succeeded = json['succeeded'];
    statusCode = json['statusCode'];
    meta = json['meta'];
    message = json['message'];
    errors = json['errors'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['succeeded'] = succeeded;
    data['statusCode'] = statusCode;
    data['meta'] = meta;
    data['message'] = message;
    data['errors'] = errors;
    return data;
  }
}
