part of 'clients_bloc.dart';

abstract class ClientsEvent extends Equatable {
  const ClientsEvent();

  @override
  List<Object> get props => [];
}

class ClientsSetButtonVisibilityEvent extends ClientsEvent {
  const ClientsSetButtonVisibilityEvent(this.isLoadMoreVisibility);
  final bool isLoadMoreVisibility;
}

class ClientsGetAndSetClientListEvent extends ClientsEvent {}

class ClientsSetNewClientListEvent extends ClientsEvent {
  const ClientsSetNewClientListEvent(this.clients);
  final List<ClientModel> clients;
}

class ClientsSetIsLoadingEvent extends ClientsEvent {
  const ClientsSetIsLoadingEvent(this.isLoading);
  final bool isLoading;
}