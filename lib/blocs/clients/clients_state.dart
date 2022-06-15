part of 'clients_bloc.dart';

class ClientsState extends Equatable {
  const ClientsState({
    this.isLoadMoreVisibility = true,
    this.isLoading = true,
    this.clients = const [],
    this.selectedClient
  });

  final bool isLoadMoreVisibility;
  final bool isLoading;
  final List<ClientModel> clients;
  final ClientModel? selectedClient;



  ClientsState setSelectedClientNull() => ClientsState(
    isLoadMoreVisibility: isLoadMoreVisibility,
    isLoading: isLoading,
    clients: clients,
    selectedClient: null,
  );

  ClientsState copyWith({
    bool? isLoadMoreVisibility,
    bool? isLoading,
    List<ClientModel>? clients,
    ClientModel? selectedClient
  }) => ClientsState(
    isLoadMoreVisibility: isLoadMoreVisibility ?? this.isLoadMoreVisibility,
    isLoading: isLoading ?? this.isLoading,
    clients: clients ?? this.clients,
    selectedClient: selectedClient ?? this.selectedClient,
  );
  
  @override
  List<Object?> get props => [isLoadMoreVisibility, isLoading, clients, selectedClient];
}