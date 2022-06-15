import 'package:flutter/material.dart';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:minimal_app/blocs/blocs.dart';
import 'package:minimal_app/models/models.dart';
import 'package:minimal_app/widgets/widgets.dart';

class ClientCard extends StatelessWidget {
  const ClientCard({
    Key? key, 
    required this.clientModel
  }) : super(key: key);

  final ClientModel clientModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: buildBoxDecoration(),
      padding: const EdgeInsets.symmetric(
        horizontal: 15.0,
        vertical: 20.0
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CustomCircleAvatar(url: clientModel.photo,),
              const SizedBox(width: 10.0,),
              _NameEmailColumn(clientModel: clientModel,),
            ],
          ),
          _EditClientButton(clientModel: clientModel,),
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20.0),                
      border: Border.all(        
        width: 1.0,
        color: const Color(0xff000000),
      ),
    );
  }
}

class _NameEmailColumn extends StatelessWidget {
  const _NameEmailColumn({
    Key? key,
    required this.clientModel
  }) : super(key: key);

  final ClientModel clientModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${clientModel.firstname} ${clientModel.lastname}',
          style: GoogleFonts.dmSans(
            fontWeight: FontWeight.w500,
            fontSize: 14.0,
            letterSpacing: 0.25
          ),
        ),
        Text(
          clientModel.email,
          style: GoogleFonts.dmSans(
            fontWeight: FontWeight.w400,
            fontSize: 12.0,
            letterSpacing: 0.25
          ),
        ),
      ],
    );
  }
}

class _EditClientButton extends StatelessWidget {
  const _EditClientButton({
    Key? key, 
    required this.clientModel,
  }) : super(key: key);

  final ClientModel clientModel;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(      
      child: DropdownButton2<String>(
        customButton: const Icon(
          Icons.more_vert,
          size: 30,
        ),        
        items: [
          DropdownMenuItem(
            value: 'edit',            
            onTap: null,
            child: GestureDetector(
              onTap: () {
                final clientsBloc = BlocProvider.of<ClientsBloc>(context);
                clientsBloc.add(ClientsSetSelectedClientEvent(clientModel));
                Navigator.of(context).pop();              
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return CustomClientDialog(
                      clientModel: clientModel,
                      clientsBloc: clientsBloc,
                      onCreateOrUpdateTap: () {   
                        clientsBloc.searchTextEditingController.text = '';  
                        FocusScope.of(context).unfocus();               
                        clientsBloc.add(ClientsUpdateClientEvent(context));
                      },
                      onCancelTap: () {
                        clientsBloc.add(const ClientsSetSelectedClientEvent(null));
                        Navigator.of(context).pop();
                      },
                    );
                  }
                ); 
              },
              child: Row(
                children: [
                  const Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 10.0,),
                  Text(
                    'Edit',
                    style: GoogleFonts.dmSans(
                      fontWeight: FontWeight.w400,
                      fontSize: 16.0,
                      color: Colors.white
                    ),
                  ),
                ],
              ),
            )
          ),
          DropdownMenuItem(
            value: 'delete',            
            onTap: () {
              final clientsBloc = BlocProvider.of<ClientsBloc>(context);
              clientsBloc.searchTextEditingController.text = '';
              FocusScope.of(context).unfocus();
              clientsBloc.add(ClientsDeleteClientEvent(context, clientModel.id));
            },
            child: Row(
              children: [
                const Icon(
                  Icons.delete_forever,
                  color: Colors.white,
                ),
                const SizedBox(width: 10.0,),
                Text(
                  'Delete',
                  style: GoogleFonts.dmSans(
                    fontWeight: FontWeight.w400,
                    fontSize: 16.0,
                    color: Colors.white
                  ),
                ),
              ],
            )
          ),
        ],
        onChanged: (value) {},
        dropdownWidth: 120,
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xff0D1111),
          boxShadow: const [
            BoxShadow(
              color: Colors.black54,
              blurRadius: 10.0
            )
          ]
        ),
        dropdownElevation: 10,
        offset: const Offset(-70, 0),
      ),
    );
  }
}