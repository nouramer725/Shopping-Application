import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'Cubit_Shop/cubit.dart';
import 'Cubit_Shop/states.dart';
import 'Shared/components.dart';
import 'models/categoriesModel.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
    listener: (context, state) {},
    builder: (context, state)
    {
      var list=ShopCubit.get(context).categories;
      return ListView.separated(
        itemBuilder: (context, index) => buildCatItem(ShopCubit.get(context).categoriesModel!.data!.data[index],context),
        separatorBuilder: (context, index) => myDivider(), itemCount: ShopCubit.get(context).categoriesModel!.data!.data.length,
      );
      },
    );
  }

    Widget buildCatItem(DataModel model,context)=> Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
      children:
      [
      Image(
      image: NetworkImage('${model.image}'),
      width: 80.0,
      height: 80.0,
      fit: BoxFit.cover,
      ),
      SizedBox(
      width: 20.0,
      ),
      Text(
      '${model.name}',
      style: TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      ),
      ),
      Spacer(),
       CircleAvatar(
         backgroundColor: HexColor('#80532a'),
         child: IconButton(
            onPressed:() {
         
            },
            icon: Icon
              (
              Icons.arrow_forward_ios_rounded,
              color: Colors.white,
            ),
         
          ),
       ),
      ],
      ),
    );
}
