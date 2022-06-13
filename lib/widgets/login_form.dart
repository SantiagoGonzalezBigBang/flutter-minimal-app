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
    LoginBloc loginBloc = BlocProvider.of<LoginBloc>(context, listen: false);

    return Form(
      key: loginBloc.loginFormKey,
      // autovalidateMode: AutovalidateMode.onUserInteraction,
      child: BlocBuilder<LoginBloc, LoginState>(
        buildWhen: (previous, current) {
          return previous.isPasswordObscure != current.isPasswordObscure || 
                 previous.isLoading != current.isLoading;
        },
        builder: (context, state) {
          return Column(
            children: [
              AuthenticationTextFormField(
                hintText: 'Mail',
                textEditingController: loginBloc.loginTextEditingController,
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
                textEditingController: loginBloc.passwordTextEditingController,
                onPressedIcon: () => loginBloc.add(LoginTooglePasswordObscureEvent()),
                keyboardType: TextInputType.visiblePassword,  
                textInputAction: TextInputAction.send,
                enabled: !state.isLoading,
                onFieldSubmitted: (value) {
                  if (!state.isLoading) loginBloc.add(LoginSendFormEvent(context));
                },
                validator: Validator.validatePassword
              ),
              const SizedBox(height: 55.0,),
              CustomButton(
                text: 'Log In',
                onPressed: state.isLoading ? null : () => loginBloc.add(LoginSendFormEvent(context)),
                isLoading: state.isLoading,
              )
            ],
          );
        },
      )
    );
  }
}


