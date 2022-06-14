part of 'clients_bloc.dart';

class ClientsState extends Equatable {
  const ClientsState({
    this.isLoadMoreVisibility = true,
    this.isLoading = true,
    this.clients = const []
  });

  final bool isLoadMoreVisibility;
  final bool isLoading;
  final List<ClientModel> clients;

  ClientsState copyWith({
    bool? isLoadMoreVisibility,
    bool? isLoading,
    List<ClientModel>? clients
  }) => ClientsState(
    isLoadMoreVisibility: isLoadMoreVisibility ?? this.isLoadMoreVisibility,
    isLoading: isLoading ?? this.isLoading,
    clients: clients ?? this.clients,
  );
  
  @override
  List<Object> get props => [isLoadMoreVisibility, isLoading, clients];
}