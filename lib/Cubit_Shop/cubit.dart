import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/Cubit_Shop/states.dart';
import '../Categories_Screen.dart';
import '../Favourites_Screen.dart';
import '../Products_Screen.dart';
import '../Profile_Screen.dart';
import '../Shared/constants.dart';
import '../cubit_login/cubit.dart';
import '../models/ChangeFavorites_Model.dart';
import '../models/FavoritesModel.dart';
import '../models/Home_mode.dart';
import '../models/categoriesModel.dart';
import '../models/login_model.dart';
import '../network/end_points.dart';
import '../network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<dynamic> search = [];

  void getSearch(String value) {
    emit(NewsGetSearchLoadingState());

    DioHelper.getData(
      url: 'v2/everything',
      query:
      {
        'q': '${value}',
        'from': '2024-07-21',
        'to': '2024-07-21',
        'sortBy': 'popularity',
        'apiKey': '5aa9575a433e47688e1244abbcaa00cc',
      },
    ).then((value) {
      //print(value.data['articles'][0]['title']);
      search = value.data['articles'];
      print(search[0]['title']);
      emit(NewsGetSearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }

  List<Widget> bottomScreens = [
    ProductsScreen(),
    FavoritesScreen(),
    CategoriesScreen(),
    ProfileScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;
  CategoriesModel? categoriesModel;
  ChangefavoritesModel? changeFavoritesModel;
  FavoritesModel? favoritesModel;

  Map<int, bool> favorites = {};

  void getHomeData() {
    emit(ShopLoadingHomeDataState());

    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);

      homeModel?.data?.products.forEach((element) {
        if (element.id != null) {
          favorites.addAll({
            element.id!: element.inFavorites!,
          });
        }
      });
      print(favorites.toString());


      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  void getCategories() {
    DioHelper.getData(
      url: CATEGORIES,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);

      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoriesState());
    });
  }

  void changeFavorites(int productId) {
    favorites[productId] = !favorites[productId]!;

    emit(ShopChangeFavoritesState());

    DioHelper.postData(
      url: FAVORITES,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      changeFavoritesModel = ChangefavoritesModel.fromjson(value.data);
      print(value.data);

      if (!changeFavoritesModel!.status!) {
        favorites[productId] = !favorites[productId]!;
      } else {
        getFavorites();
      }
      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel!));
    }).catchError((error) {
      favorites[productId] = !favorites[productId]!;
      emit(ShopErrorChangeFavoritesState());
    });
  }

  void getFavorites() {
    emit(ShopLoadingGetFavoritesState());

    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);

      emit(ShopSuccessGetFavoritesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetFavoritesState());
    });
  }

  ShopLoginModel? userModel;

  void getUserData() {
    emit(ShopLoadingUserDataState());

    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      print(userModel?.data!.name);
      emit(ShopSuccessUserDataState(userModel as ShopLoginCubit));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUserDataState());
    });
  }

  void updateUserData({
    required String name,
    required String email,
    required String phone,
    required String image,


  }) {
    emit(ShopLoadingUpdateUserState());

    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
        'image' :image
      },
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      emit(ShopSuccessUpdateUserState(ShopLoginCubit()));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUpdateUserState());
    });
  }

  List<dynamic> categories=[];


  void getApiData(){
    emit(ShopLoadingCategoriesState());
    DioHelper.getData(
        url: 'v2/everything' ,
        query:
        {
          'q':'Business',
          'from':'2024-07-21',
          'to': '2024-07-21',
          'sortBy':'popularity',
          'apiKey':'5aa9575a433e47688e1244abbcaa00cc',
        }).then((value){
      // print(value.data['articles'][0]['title'].toString());
      categories =value.data['articles'];
      print(categories[0]['description']);
      emit(ShopSuccessCategoriesState());
    }).catchError((error){
      print(error.toString() );
      emit(ShopErrorCategoriesState());

    });
  }



}