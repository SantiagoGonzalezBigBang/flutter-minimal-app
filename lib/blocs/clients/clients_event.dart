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

class ClientsSetIsLoadingEvent extends ClientsEvent {
  const ClientsSetIsLoadingEvent(this.isLoading);
  final bool isLoading;
}

class ClientsCreateClientEvent extends ClientsEvent {
  const ClientsCreateClientEvent(this.context);
  final BuildContext context;
}

class ClientsUpdateClientEvent extends ClientsEvent {
  const ClientsUpdateClientEvent(this.context);
  final BuildContext context;
}

class ClientsGetAndSetClientListEvent extends ClientsEvent {}

class ClientsSetNewClientListEvent extends ClientsEvent {
  const ClientsSetNewClientListEvent(this.clients);
  final List<ClientModel> clients;
}


class ClientsSetSelectedClientEvent extends ClientsEvent {
  const ClientsSetSelectedClientEvent(this.clientModel);
  final ClientModel? clientModel;
}

class ClientsDeleteClientEvent extends ClientsEvent {
  const ClientsDeleteClientEvent(this.context, this.clientId);
  final int clientId;
  final BuildContext context;
}