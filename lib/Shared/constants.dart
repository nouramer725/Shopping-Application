

import '../Login_Screen.dart';
import '../network/local/cache_helper.dart';
import 'components.dart';

String token='q6RuBY2arJ0UoXZ1mJzi5tvzjdOZSm1UP9JUcfM1BnHJJrkn7aJJExZyks7sVnS0MHP45J';

void SignOut(context){
  
  CacheHelper.removeData(key: 'token' ,).then((value){
    if(value){
      navigateandfinish(context, ShopLoginScreen());
    }
  });

}