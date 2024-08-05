class ChangefavoritesModel{
  bool? status;
  String? message;


  ChangefavoritesModel.fromjson(Map<String,dynamic> json){

    status=json['status'];
    message=json['message'];

  }
  }


