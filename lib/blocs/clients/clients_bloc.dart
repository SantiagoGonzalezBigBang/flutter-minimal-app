import 'dart:async';

import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:minimal_app/helpers/helpers.dart';

import 'package:minimal_app/models/models.dart';
import 'package:minimal_app/services/services.dart';
import 'package:minimal_app/ui/ui.dart';

part 'clients_event.dart';
part 'clients_state.dart';

class ClientsBloc extends Bloc<ClientsEvent, ClientsState> {

  ClientsBloc() : super(const ClientsState()) {

    on<ClientsSetButtonVisibilityEvent>(onClientsSetButtonVisibilityEvent);
    on<ClientsSetIsLoadingEvent>(onClientsSetIsLoadingEvent);

    on<ClientsCreateClientEvent>(onClientsCreateClientEvent);
    on<ClientsSetNewClientListEvent>(onClientsSetNewClientListEvent);
    on<ClientsGetAndSetClientListEvent>(onClientsGetAndSetClientListEvent);
    on<ClientsSetSelectedClientEvent>(onClientsSetSelectedClientEvent);
    on<ClientsUpdateClientEvent>(onClientsUpdateClientEvent);
    on<ClientsDeleteClientEvent>(onClientsDeleteClientEvent);

    initClientsBloc();

  }

  final dialogFormKey = GlobalKey<FormState>();

  TextEditingController searchTextEditingController = TextEditingController();

  TextEditingController firstNameTextEditingController = TextEditingController();
  TextEditingController lastNameTextEditingController = TextEditingController();
  TextEditingController mailTextEditingController = TextEditingController();

  ScrollController clientsScrollController = ScrollController();
  double previousScroll = 0.0;

  final clientsService = ClientsService();
  int nextPage = 1;
  
  final debouncer = Debouncer(
    duration: const Duration(milliseconds: 500),
  );


  //* Events
  void onClientsSetButtonVisibilityEvent(ClientsSetButtonVisibilityEvent event, Emitter<ClientsState> emit) {
    emit(state.copyWith(isLoadMoreVisibility: event.isLoadMoreVisibility));
  }

  void onClientsSetIsLoadingEvent(ClientsSetIsLoadingEvent event, Emitter<ClientsState> emit) {
    emit(state.copyWith(isLoading: event.isLoading));
  }

  void onClientsSetSelectedClientEvent(ClientsSetSelectedClientEvent event, Emitter<ClientsState> emit) {
    if (event.clientModel == null) {
      firstNameTextEditingController.text = '';
      lastNameTextEditingController.text  = '';
      mailTextEditingController.text      = '';
      emit(state.setSelectedClientNull());
    } else {
      firstNameTextEditingController.text = event.clientModel!.firstname;
      lastNameTextEditingController.text  = event.clientModel!.lastname;
      mailTextEditingController.text      = event.clientModel!.email;
      emit(state.copyWith(selectedClient: event.clientModel));
    }
  }

  void onClientsCreateClientEvent(ClientsCreateClientEvent event, Emitter<ClientsState> emit) async {        
    FocusScope.of(event.context).unfocus();
    if (!isValidForm()) return;

    emit(state.copyWith(isLoading: true));
    Navigator.of(event.context).pop();
    
    final isOk = await clientsService.createClient(
      firstName: firstNameTextEditingController.text,
      lastName: lastNameTextEditingController.text,
      email: mailTextEditingController.text
    );

    add(const ClientsSetSelectedClientEvent(null));
    if (isOk) {
      add(ClientsGetAndSetClientListEvent()); 
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(event.context).showSnackBar(
        SnackBars.getNormalSnackBar('There was a mistake')
      );
    }
  }

  void onClientsUpdateClientEvent(ClientsUpdateClientEvent event, Emitter<ClientsState> emit) async {        
    FocusScope.of(event.context).unfocus();
    if (!isValidForm() || state.selectedClient == null) return;

    emit(state.copyWith(isLoading: true));
    Navigator.of(event.context).pop();

    final isOk = await clientsService.updateClient(
      id: state.selectedClient!.id,
      firstName: firstNameTextEditingController.text,
      lastName: lastNameTextEditingController.text,
      email: mailTextEditingController.text
    );

    add(const ClientsSetSelectedClientEvent(null));
    if (isOk) {
      add(ClientsGetAndSetClientListEvent()); 
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(event.context).showSnackBar(
        SnackBars.getNormalSnackBar('There was a mistake')
      );
    }
  }
  
  void onClientsDeleteClientEvent(ClientsDeleteClientEvent event, Emitter<ClientsState> emit) async {
    emit(state.copyWith(isLoading: true));

    final isOk = await clientsService.deleteClient(
      id: event.clientId
    );

    if (isOk) {
      add(ClientsGetAndSetClientListEvent()); 
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(event.context).showSnackBar(
        SnackBars.getNormalSnackBar('There was a mistake')
      );
    }
  }

  void onClientsSetNewClientListEvent(ClientsSetNewClientListEvent event, Emitter<ClientsState> emit) {
    emit(state.copyWith(clients: event.clients));
  }

  void onClientsGetAndSetClientListEvent(ClientsGetAndSetClientListEvent event, Emitter<ClientsState> emit) async {    
    emit(state.copyWith(isLoading: true));

    nextPage = 1;
    final clientListResponseModel = await clientsService.getClientPage(page: nextPage);
    if (clientListResponseModel.response == null || !clientListResponseModel.success) {
      return emit(state.copyWith(isLoading: false));
    } else {
      nextPage++;
      emit(state.copyWith(clients: clientListResponseModel.response!.data, isLoading: false));
    }
  }

  void getClientsByQuery(String query) async {
    debouncer.value = '';
    debouncer.onValue = (value) async {
      if (searchTextEditingController.text.isNotEmpty) {
        add(const ClientsSetIsLoadingEvent(true));
        final clientModel = await clientsService.getClientByQuery(query: value);
        add(ClientsSetNewClientListEvent(clientModel != null ? [clientModel] : []));
        add(const ClientsSetIsLoadingEvent(false));
      }
    };

    final timer = Timer.periodic(const Duration(milliseconds: 300), (_) {
      debouncer.value = query;
    });

    Future.delayed(const Duration(milliseconds: 301)).then((_) => timer.cancel());
  }


  //* Methods
  bool isValidForm() {
    return dialogFormKey.currentState?.validate() ?? false;
  }


  //* Init Bloc
  void initClientsBloc() {
    clientsScrollController.addListener(() {
      if (clientsScrollController.offset > previousScroll) {      
        if (clientsScrollController.offset >= clientsScrollController.position.maxScrollExtent - 20.0 || clientsScrollController.offset <= 0) {
          add(const ClientsSetButtonVisibilityEvent(true));     
        } else {
          add(const ClientsSetButtonVisibilityEvent(false));
        }
      } else {
        add(const ClientsSetButtonVisibilityEvent(true));
      }

      previousScroll = clientsScrollController.offset;
    });

    add(ClientsGetAndSetClientListEvent());
  }


  //* Close
  @override
  Future<void> close() {
    clientsScrollController.dispose();
    return super.close();
  }

}
