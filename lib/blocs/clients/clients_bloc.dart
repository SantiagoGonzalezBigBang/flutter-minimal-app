import 'dart:async';

import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:minimal_app/helpers/helpers.dart';

import 'package:minimal_app/models/models.dart';
import 'package:minimal_app/services/services.dart';

part 'clients_event.dart';
part 'clients_state.dart';

class ClientsBloc extends Bloc<ClientsEvent, ClientsState> {

  ClientsBloc() : super(const ClientsState()) {

    on<ClientsSetButtonVisibilityEvent>(onClientsSetButtonVisibilityEvent);
    on<ClientsSetIsLoadingEvent>(onClientsSetIsLoadingEvent);
    on<ClientsSetNewClientListEvent>(onClientsSetNewClientListEvent);
    on<ClientsGetAndSetClientListEvent>(onClientsGetAndSetClientListEvent);

    initClientsBloc();

  }

  TextEditingController searchTextEditingController = TextEditingController();

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
