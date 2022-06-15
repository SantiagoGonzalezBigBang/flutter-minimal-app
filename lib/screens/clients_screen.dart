import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:animate_do/animate_do.dart';

import 'package:minimal_app/blocs/blocs.dart';
import 'package:minimal_app/widgets/widgets.dart';

class ClientsStateScreen extends StatelessWidget {
  const ClientsStateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) => ClientsBloc(),
      )
    ], child: const ClientsScreen());
  }
}

class ClientsScreen extends StatelessWidget {
  const ClientsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ClientsBackground(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Column(
                children: const [
                  SizedBox(
                    height: 50.0,
                  ),
                  MinimalLogo(
                    size: 60.0,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    width: double.infinity, 
                    child: TitleText(text: 'CLIENTS')
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  _SearchAndAddNewClient(),
                  _ClientsListView(),
                ],
              ),
              const _VisibilityButton(),
            ],
          ),
        )
      )
    );
  }
}

class _VisibilityButton extends StatelessWidget {
  const _VisibilityButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final clientsBloc = BlocProvider.of<ClientsBloc>(context);

    return BlocBuilder<ClientsBloc, ClientsState>(
      buildWhen: (previous, current) {
        return previous.isLoadMoreVisibility != current.isLoadMoreVisibility ||
               previous.isLoading != current.isLoading;
      },
      builder: (context, state) {

        final size = MediaQuery.of(context).size;

        if (state.isLoading || state.clients.isEmpty) {
          return SizedBox(
            width: size.width,
            height: size.height,
            child: Center(
              child: state.isLoading ? FadeIn(
                duration: const Duration(milliseconds: 500),
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
              ) : Text(
                clientsBloc.searchTextEditingController.text.isEmpty 
                  ? 'No clients were found' : 'No clients were found with the search "${clientsBloc.searchTextEditingController.text}"',
                textAlign: TextAlign.center,
                style: GoogleFonts.dmSans(
                  fontWeight: FontWeight.w500
                ),
              ),
            ),
          );
        }
        
        return Row(
          children: [
            Expanded(
              flex: 1,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 250),
                opacity: state.isLoadMoreVisibility ? 1.0 : 0.0,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 30.0, left: 10.0, right: 10.0),
                  child: CustomButton(
                    text: 'Log Out',
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      BlocProvider.of<AuthenticationBloc>(context).add(AuthenticationLogOutEvent(context));
                    } 
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 250),
                opacity: state.isLoadMoreVisibility ? 1.0 : 0.0,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 30.0, left: 10.0, right: 10.0),
                  child: CustomButton(
                    text: 'Refresh',
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      clientsBloc.searchTextEditingController.text = '';
                      clientsBloc.add(ClientsGetAndSetClientListEvent());
                    } 
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ClientsListView extends StatelessWidget {
  const _ClientsListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final clientsBloc = BlocProvider.of<ClientsBloc>(context);
    // final size = MediaQuery.of(context).size;

    return BlocBuilder<ClientsBloc, ClientsState>(
      builder: (context, state) {
        return state.isLoading ? const SizedBox() : Expanded(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: state.clients.length,
            controller: clientsBloc.clientsScrollController,
            itemBuilder: (context, index) {
              final clientModel = state.clients[index];

              return Padding(
                padding: EdgeInsets.only(bottom: index == state.clients.length - 1 ? 70.0 : 16.0),
                child: ClientCard(clientModel: clientModel),
              );
            },
          ),
        );          
      },
    );
  }
}

class _SearchAndAddNewClient extends StatelessWidget {
  const _SearchAndAddNewClient({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final clientsBloc = BlocProvider.of<ClientsBloc>(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 2,
          child: SearchTextField(
            controller: clientsBloc.searchTextEditingController,
            onChanged: (value) {
              if (value.isNotEmpty) {
                clientsBloc.getClientsByQuery(value);
              } else {
                clientsBloc.add(ClientsGetAndSetClientListEvent());
              }
            } 
          ),
        ),
        const SizedBox(
          width: 16.0,
        ),
        const Expanded(flex: 1, child: AddNewClientButton())
      ],
    );
  }
}
