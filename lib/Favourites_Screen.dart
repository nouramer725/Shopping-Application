import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Cubit_Shop/cubit.dart';
import 'Cubit_Shop/states.dart';
import 'Shared/components.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        if (state is! ShopLoadingGetFavoritesState) {
          Center(child: CircularProgressIndicator());
          return ListView.separated(
            itemBuilder: (context, index) =>
                buildListProduct(
                    cubit.favoritesModel?.data?.data?[index].product, context),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: cubit.favoritesModel?.data?.data?.length ?? 0,
          );
        } else {
          return Center(
              child: Text('No favorites yet')); // Or any other default widget
        }
      },
      listener: (context, state) {},
    );
  }
}