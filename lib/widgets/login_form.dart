import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:minimal_app/blocs/blocs.dart';
import 'package:minimal_app/helpers/helpers.dart';
import 'package:minimal_app/widgets/widgets.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthenticationBloc authenticationBloc = BlocProvider.of<AuthenticationBloc>(context, listen: false);

    return Form(
      key: authenticationBloc.authenticationFormKey,
      // autovalidateMode: AutovalidateMode.onUserInteraction,
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(        
        builder: (context, state) {
          return Column(
            children: [
              AuthenticationTextFormField(
                hintText: 'Mail',
                textEditingController: authenticationBloc.emailTextEditingController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                validator: Validator.validateMail,
                enabled: !state.isLoading,
              ),
              const SizedBox(
                height: 35.0,
              ),
              AuthenticationTextFormField(
                hintText: 'Password',
                obscureText: state.isPasswordObscure,
                textEditingController: authenticationBloc.passwordTextEditingController,
                onPressedIcon: () => authenticationBloc.add(AuthenticationTogglePasswordObscureEvent()),
                keyboardType: TextInputType.visiblePassword,  
                textInputAction: TextInputAction.send,
                enabled: !state.isLoading,
                onFieldSubmitted: (value) {
                  if (!state.isLoading) authenticationBloc.add(AuthenticationSendFormEvent(context));
                },
                validator: Validator.validatePassword
              ),
              const SizedBox(height: 55.0,),
              CustomButton(
                text: state.isLogin ? 'Log In' : 'Sign Up',
                onPressed: state.isLoading ? null : () => authenticationBloc.add(AuthenticationSendFormEvent(context)),
                isLoading: state.isLoading,
              )
            ],
          );
        },
      )
    );
  }
}


