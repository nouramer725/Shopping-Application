import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapplication/cubit_login/states.dart';
import 'package:shopapplication/models/login_model.dart';
import 'package:shopapplication/network/end_points.dart';
import 'package:shopapplication/network/remote/dio_helper.dart';


class ShopLoginCubit extends Cubit<ShopLoginStates> {

  ShopLoginCubit() : super(ShopLoginIntialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);


  void UserLogin({
    required String email,
    required String password,
  }) {
    emit(ShopLoginLoadingState());
    DioHelper.postData(
        url: LOGIN,
        data: {
          'email':email,
          'password':password,
        },
        ).then((Value){
          ShopLoginModel.fromJson(Value.data);
        emit(ShopLoginSuccessState(ShopLoginModel.fromJson(Value.data)));
    }).catchError((error){
      emit(ShopLoginErrorState(error.toString()));
    });
  }

}