import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'Cubit_Register/Cubit.dart';
import 'Cubit_Register/States.dart';
import 'Shared/components.dart';
import 'Shared/constants.dart';
import 'Shop_Layout.dart';
import 'network/local/cache_helper.dart';

class ShopRegisterScreen extends StatelessWidget
{
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  ShopRegisterScreen({super.key});


  @override
  Widget build(BuildContext context)
  {
    return BlocProvider(
      create: (BuildContext context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state)
        {
          if (state is ShopRegisterSuccessState)
          {
            if (state.loginModell.status!)
            {
              print(state.loginModell.message);
              print(state.loginModell.data!.token);

              CacheHelper.saveData(
                key: 'token',
                value: state.loginModell.data!.token,
              ).then((value)
              {
                token = state.loginModell.data!.token!;

                navigateandfinish(
                  context,
                  ShopLayout(),
                );
              });
            } else {
              print(state.loginModell.message);

              ShowToast(
                text: '${state.loginModell.message}',
                state: ChooseToastColor.ERROR,
              );
            }
          }
        },
        builder: (context, state)
        {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            'REGISTER',
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontSize: 40,
                              color: HexColor('#301c06'),
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            'Register now to browse our hot offers',
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                 color: HexColor('#dba06b'),
                                ),
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'please enter your name';
                            }
                            return null;
                          },
                          label: 'User Name',
                          prefix: Icons.person,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: ( value) {
                            if (value == null || value.isEmpty) {
                              return 'please enter your email address';
                            }
                            return null;
                          },
                          label: 'Email Address',
                          prefix: Icons.email_outlined,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          suffix: ShopRegisterCubit.get(context).suffix,
                          onSubmit: (value)
                          {

                          },
                          isPassword: ShopRegisterCubit.get(context).isPassword,
                          suffixPressed: () {
                            ShopRegisterCubit.get(context)
                                .changePasswordVisibility();
                          },
                          validate: ( value) {
                            if (value == null || value.isEmpty) {
                              return 'password is too short';
                            }
                            return null;
                          },
                          label: 'Password',
                          prefix: Icons.lock_outline,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          controller: _passwordController,
                          type: TextInputType.visiblePassword,
                          suffix: ShopRegisterCubit.get(context).suffix,
                          onSubmit: (value) {
                          },
                          isPassword: ShopRegisterCubit.get(context).isPassword,
                          suffixPressed: () {
                            ShopRegisterCubit.get(context)
                                .changePasswordVisibility();
                          },
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please confirm your password';
                            }
                            if (value != passwordController.text) {
                              return 'Confirm Passwords do not match Password';
                            }
                            return null;
                          },
                          label: 'Confirm Password',
                          prefix: Icons.lock_outline,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          validate: ( value) {
                            if (value == null || value.isEmpty) {
                              return 'please enter your phone number';
                            }
                            return null;
                          },
                          label: 'Phone',
                          prefix: Icons.phone,
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        ListView(
                          shrinkWrap: true, // Prevent ListView from taking up full screen height
                          physics: NeverScrollableScrollPhysics(), // Disable scrolling
                          children: [
                            if (state is! ShopRegisterLoadingState) // Condition check
                              defaultButton(
                                function: () {
                                  if (formKey.currentState!.validate()) {
                                    ShopRegisterCubit.get(context).userRegister(
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                      phone: phoneController.text,
                                      ConfirmPassword:  _passwordController.text
                                    );
                                  }
                                },
                                text: 'register',
                                isUpperCase: true,
                                background: HexColor('#80532a'),
                              )
                            else // Fallback
                              Center(child: CircularProgressIndicator()),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}