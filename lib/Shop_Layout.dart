import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapplication/Cubit_Shop/cubit.dart';
import 'package:shopapplication/Cubit_Shop/states.dart';

import 'Search_Screen.dart';
import 'Shared/components.dart';


class ShopLayout extends StatelessWidget {
  const ShopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context, state) => {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Center(
              child: Text(
                  'SHOP',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            actions: [
              IconButton(
                  onPressed: ()
                  {
                    navigateTo(context, SearchScreen(),);
                  }
                  , icon: Icon(
                Icons.search,
              )
              ),
              
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                  icon:Icon(
                    Icons.home,
                  ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon:Icon(Icons.favorite),
                label: 'Favourite',
              ),
              BottomNavigationBarItem(
                icon:Icon(Icons.category),
                label: 'Categories',
              ),
              BottomNavigationBarItem(
                icon:Icon(Icons.person),
                label: 'Profile',
              ),
            ],
            currentIndex: ShopCubit.get(context).currentIndex,
            onTap: (value) {
              ShopCubit.get(context).changeBottom(value);
            },
          ),
         body: ShopCubit.get(context).bottomScreens[ShopCubit.get(context).currentIndex],
        );
      },
    );
  }
}
