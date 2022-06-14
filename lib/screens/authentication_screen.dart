import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';

import 'package:minimal_app/blocs/blocs.dart';
import 'package:minimal_app/screens/screens.dart';

import 'package:minimal_app/widgets/widgets.dart';

class AuthenticationScreen extends StatelessWidget {
   
  const AuthenticationScreen({
    Key? key
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(      
      body: AuthenticationBackground(
        child: Center(
          child: FutureBuilder<bool>(
            future: checkLoginState(context),
            initialData: false,
            builder: (context, snapshot) {
              if (snapshot.data ?? false) {
                return SingleChildScrollView(        
                  child: Column(
                    children: const [
                      SizedBox(height: 20.0,),
                      MinimalLogo(),
                      SizedBox(height: 58.0,),
                      AuthenticationTitle(),
                      SizedBox(height: 46.0,),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 48.0),
                        child: AuthenticationForm(),
                      ),
                      SizedBox(height: 20.0,),
                      AuthenticationToggleModeButton(),
                      SizedBox(height: 70.0,),
                    ],
                  ),
                );
              }

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const MinimalLogo(),
                  FadeIn(
                    duration: const Duration(milliseconds: 1500),
                    delay: const Duration(milliseconds: 400),
                    child: const Hero(
                      tag: 'loading',
                      child: SizedBox(
                        height: 50.0,
                        width: 50.0,
                        child: LoadingIndicator(
                          indicatorType: Indicator.lineScaleParty,
                          colors: [
                            Colors.black
                          ],          
                        ),
                      ),
                    )
                  ),
                ],
              );
            }
          ),
        ),
      )
    );
  }

  Future<bool> checkLoginState(BuildContext context) async {
    
    final isLoggedIn = await BlocProvider.of<AuthenticationBloc>(context, listen: false).isLoggedIn();

    if (isLoggedIn) {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => const ClientsStateScreen(),
      ));
      return false;
    } else {
      return true;
    }
  }

}

