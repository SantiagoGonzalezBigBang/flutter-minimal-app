import 'package:flutter/material.dart';

import 'package:minimal_app/helpers/helpers.dart';
import 'package:minimal_app/blocs/blocs.dart';
import 'package:minimal_app/models/models.dart';
import 'package:minimal_app/widgets/widgets.dart';

class CustomClientDialog extends StatelessWidget {
  const CustomClientDialog({
    Key? key, 
    this.clientModel, 
    this.onCreateOrUpdateTap, 
    this.onCancelTap, 
    required this.clientsBloc, 
  }) : super(key: key);

  final ClientModel? clientModel;

  final VoidCallback? onCreateOrUpdateTap;
  final VoidCallback? onCancelTap;

  final ClientsBloc clientsBloc;

  @override
  Widget build(BuildContext context) {
    return Dialog(      
      elevation: 0,      
      backgroundColor: Colors.transparent,
      child: DialogChild(
        clientModel: clientModel,
        onCreateOrUpdateTap: onCreateOrUpdateTap,
        onCancelTap: onCancelTap,
        clientsBloc: clientsBloc
      )        
    );
  }
}

class DialogChild extends StatelessWidget {
  const DialogChild({
    Key? key, 
    required this.clientModel, 
    required this.onCreateOrUpdateTap, 
    required this.onCancelTap,
    required this.clientsBloc
  }) : super(key: key);

  final ClientModel? clientModel;
  final VoidCallback? onCreateOrUpdateTap;
  final VoidCallback? onCancelTap;

  final ClientsBloc clientsBloc;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, 
        borderRadius: BorderRadius.circular(20.0)       
      ),
      padding: const EdgeInsets.only(
        top: 25.0,
        left: 25.0,
        right: 25.0,
        bottom: 15.0
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              DialogTitle(text: clientModel != null ? 'Edit client' : 'Add new client',),
            ],
          ),
          const SizedBox(height: 48.0,),
          CustomCircleAvatar(
            size: 119.0,
            isDialog: true,
            url: clientModel != null ? clientModel!.photo : '',            
          ),
          const SizedBox(height: 30.0,),
          _CustomClientDialogForm(
            clientModel: clientModel,
            clientsBloc: clientsBloc
          ),
          const SizedBox(height: 60.0,),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: CustomButton(
                  text: 'Cancel',
                  isOnlyText: true,
                  onPressed: onCancelTap
                ),
              ),
              const SizedBox(width: 10.0,),
              Expanded(
                flex: 4,
                child: CustomButton(
                  text: clientModel == null ? 'Create' : 'Save',
                  onPressed: onCreateOrUpdateTap
                ),
              )
            ],
          ) 
        ],
      ),
    );
  }
}

class _CustomClientDialogForm extends StatelessWidget {
  const _CustomClientDialogForm({
    Key? key,
    required this.clientModel,
    required this.clientsBloc
  }) : super(key: key);

  final ClientModel? clientModel;

  final ClientsBloc clientsBloc;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: clientsBloc.dialogFormKey,
      child: Column(
        children: [
          AuthenticationTextFormField(
            hintText: 'First name',
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.name,
            validator: Validator.validateName,
            textEditingController: clientsBloc.firstNameTextEditingController,
          ),
          const SizedBox(height: 20.0,),
          AuthenticationTextFormField(
            hintText: 'Last name',
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.name,
            validator: Validator.validateLastName,  
            textEditingController: clientsBloc.lastNameTextEditingController,
          ),
          const SizedBox(height: 20.0,),
          AuthenticationTextFormField(
            hintText: 'Mail',
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.emailAddress,
            validator: Validator.validateMail,  
            textEditingController: clientsBloc.mailTextEditingController,
            enabled: clientModel == null ? true : false,          
          )
        ],
      )
    );
  }
}

