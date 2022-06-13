import 'package:flutter/material.dart';

import 'package:minimal_app/widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
   
  const LoginScreen({
    Key? key
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {    

    return Scaffold(      
      body: LoginBackground(
        child: Center(
          child: SingleChildScrollView(        
            child: Column(
              children: const [
                SizedBox(height: 20.0,),
                MinimalLogo(),
                SizedBox(height: 58.0,),
                AuthenticationTitle(),
                SizedBox(height: 46.0,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 48.0),
                  child: LoginForm(),
                ),
                SizedBox(height: 90.0,)
              ],
            ),
          ),
        ),
      )
    );
  }

}