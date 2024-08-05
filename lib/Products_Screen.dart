import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shopapplication/Cubit_Shop/cubit.dart';
import 'package:shopapplication/Cubit_Shop/states.dart';
import 'package:shopapplication/models/Home_mode.dart';
import 'Shared/components.dart';
import 'models/categoriesModel.dart';


class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state)
      {
        if(state is ShopSuccessChangeFavoritesState)
        {
          if (!(state.model.status ?? true)){
            {
              ShowToast(text: '${state.model.message}', state: ChooseToastColor.ERROR);
            }
          }
        }
      },
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        var list1 = cubit.homeModel;
        var list2 = cubit.categoriesModel;

        if (list1 != null && list2 != null) { // Check if both lists are available
          return ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) => builderWidget(list1, list2, context),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: 1,
          );
        } else {
          return Center(
              child: CircularProgressIndicator()
          ); // Or any other loading widget
        }
      },
    );
  }


  Widget builderWidget(HomeModel model,CategoriesModel categoriesModel, context) =>
      // categoriesModel categoriesModel
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CarouselSlider(
              items: model.data?.banners
                  .map(
                    (e) => Image(
                  image: NetworkImage('${e.image}'),
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ).toList(),
              options: CarouselOptions(
                height: 300,
                scrollPhysics: ScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()
                ) ,
                viewportFraction: 1.0,
                enlargeCenterPage: false,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(seconds: 1),
                autoPlayCurve: Curves.easeOutSine,
                scrollDirection: Axis.horizontal,
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 27.0,
                      fontWeight: FontWeight.bold,
                      color: HexColor('#dba06b'),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    height: 100.0,
                    child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => buildCategoryItem(categoriesModel.data!.data[index]),
                      separatorBuilder: (context, index) => SizedBox(width: 10.0,),
                      itemCount: categoriesModel.data!.data.length,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'New Products',
                    style: TextStyle(
                      fontSize: 27.0,
                      fontWeight: FontWeight.w800,
                      color: HexColor('#dba06b'),

                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 0.0,
                  crossAxisSpacing: 30.0,
                  childAspectRatio: 1 / 2.2,
                  children: List.generate(
                    model.data!.products.length,
                        (index) =>
                        buildGridProduct(model.data!.products[index], context),
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  Widget buildGridProduct(ProductModel model, context) => Container(
    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              fit: BoxFit.fill,
              image: NetworkImage('${model.image}'),
              width: double.infinity,
              height: 200.0,
            ),
            if (model.discount != 0)
              Container(
                color: Colors.red,
                padding: EdgeInsets.symmetric(
                  horizontal: 12.0,
                ),
                child: Text(
                  'DISCOUNT',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${model.name}',
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 20.0,
                  height: 1.4,
                ),
              ),
              Row(
                children: [
                  Text(
                    '${model.price.round()}',
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  if (model.discount != 0)
                    Text(
                      '${model.oldPrice.round()}',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  Spacer(),
                  IconButton( // Assuming you want to uncomment this later
                    onPressed: () {
                      if (model.id != null) {
                        ShopCubit.get(context).changeFavorites(model.id!); // Use non-null assertion operator (!)
                      }
                      print(model.id);
                    },
                    icon: CircleAvatar(
                      radius: 15.0,
                      backgroundColor: (ShopCubit.get(context).favorites[model.id] ?? true) // Use null-aware operator (??)
                          ? Colors.pinkAccent
                          : Colors.grey,
                      child: Icon(
                        Icons.favorite_border,
                        size: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );

  Widget buildCategoryItem(DataModel model) => Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children: [
      Image(
        image: NetworkImage('${model.image}'),
        height: 100.0,
        width: 100.0,
        fit: BoxFit.cover,
      ),
      Container(
        color: Colors.black.withOpacity(
          .8,
        ),
        width: 100.0,
        child: Text(
          '${model.name}',
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    ],
  );


}
