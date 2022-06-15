import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:minimal_app/blocs/blocs.dart';
import 'package:minimal_app/widgets/widgets.dart';

class AddNewClientButton extends StatelessWidget {
  const AddNewClientButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final clientsBloc = BlocProvider.of<ClientsBloc>(context);

    return BlocBuilder<ClientsBloc, ClientsState>(
      builder: (context, state) {
        return CustomButton(
          text: 'Add New',
          isSmall: true,
          onPressed: () {
            clientsBloc.add(const ClientsSetSelectedClientEvent(null));
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return CustomClientDialog(
                  clientModel: state.selectedClient,
                  clientsBloc: clientsBloc,
                  onCreateOrUpdateTap: () {                    
                    clientsBloc.add(ClientsCreateClientEvent(context));                                          
                  },
                  onCancelTap: () {
                    clientsBloc.add(const ClientsSetSelectedClientEvent(null));
                    Navigator.of(context).pop();
                  },
                );
              }
            );
          },
        );
      },
    );
  }
}