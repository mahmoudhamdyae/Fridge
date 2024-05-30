part of 'clients_bloc.dart';

class ClientsState extends Equatable {

  final List<Client> clients;
  final List<Client> searchedClients;
  final RequestState getClientsState;
  final String getClientsErrorMessage;

  final List<dynamic> remoteProductsTypes;
  final List<dynamic> remotePackagingTypes;
  final String remotePrice;
  final double remoteSmallBagPrice;
  final double remoteLargeBagPrice;

  final List<Ward> wards;
  final Ward ward;

  final String clientName;
  final String clientPhone;
  final String clientAddress;
  final int clientType;

  final int amountPaid;
  final int amountRemain;
  final num tons;
  final int bags;

  final ProductToAdd productToAdd;

  final List<Position> positions;

  final RequestState addClientState;
  final String addClientErrorMessage;

  final List<Store> stores;
  final Map<String, List<CustomCustomer>> customMap;
  final RequestState getStoresState;
  final String getStoresErrorMessage;

  final ClientInvoiceData invoice;
  final RequestState getInvoiceState;
  final String getClientInvoiceErrorMessage;

  final RequestState delClientState;
  final String delClientErrorMessage;

  final RequestState delStoreState;
  final String delStoreErrorMessage;

  final RequestState addPaidState;
  final String addPaidErrorMessage;

  final RequestState getAmountPaidState;
  final String getAmountPaidErrorMessage;
  final AmountPaid amounts;

  final RequestState storeSahbState;
  final String storeSahbErrorMessage;

  const ClientsState({
    this.clients = const [],
    this.searchedClients = const [],
    this.getClientsState = RequestState.loading,
    this.getClientsErrorMessage = '',
    this.remoteProductsTypes = const [],
    this.remotePackagingTypes = const [],
    this.remotePrice = '',
    this.remoteSmallBagPrice = 0.0,
    this.remoteLargeBagPrice = 0.0,
    this.wards = const [],
    this.ward = const Ward(),
    this.clientName = '',
    this.clientPhone = '',
    this.clientAddress = '',
    this.clientType = 0,
    this.amountPaid = 0,
    this.amountRemain = 0,
    this.tons = 0,
    this.bags = 0,
    this.productToAdd = const ProductToAdd(),
    this.positions = const [],
    this.addClientState = RequestState.loading,
    this.addClientErrorMessage = '',
    this.stores = const [],
    this.customMap = const {},
    this.getStoresState = RequestState.init,
    this.getStoresErrorMessage = '',
    this.invoice = const ClientInvoiceData(),
    this.getInvoiceState = RequestState.init,
    this.getClientInvoiceErrorMessage = '',
    this.delClientState = RequestState.init,
    this.delClientErrorMessage = '',
    this.delStoreState = RequestState.init,
    this.delStoreErrorMessage = '',
    this.addPaidState = RequestState.init,
    this.addPaidErrorMessage = '',
    this.getAmountPaidState = RequestState.init,
    this.getAmountPaidErrorMessage = '',
    this.amounts = const AmountPaid(),
    this.storeSahbState = RequestState.init,
    this.storeSahbErrorMessage = ''
});

  ClientsState copyWith({
    List<Client>? clients,
    List<Client>? searchedClients,
    RequestState? getClientsState,
    String? getClientsErrorMessage,
    List<dynamic>? remoteProductsTypes,
    List<dynamic>? remotePackagingTypes,
    String? remotePrice,
    double? remoteSmallBagPrice,
    double? remoteLargeBagPrice,
    List<Ward>? wards,
    Ward? ward,
    String? clientName,
    String? clientPhone,
    String? clientAddress,
    int? clientType,
    int? amountPaid,
    int? amountRemain,
    num? tons,
    int? bags,
    ProductToAdd? productToAdd,
    List<Position>? positions,
    RequestState? addClientState,
    String? addClientErrorMessage,
    List<Store>? stores,
    Map<String, List<CustomCustomer>>? customMap,
    RequestState? getStoresState,
    String? getStoresErrorMessage,
    ClientInvoiceData? invoice,
    RequestState? getInvoiceState,
    String? getClientInvoiceErrorMessage,
    RequestState? delClientState,
    String? delClientErrorMessage,
    RequestState? delStoreState,
    String? delStoreErrorMessage,
    RequestState? addPaidState,
    String? addPaidErrorMessage,
    RequestState? getAmountPaidState,
    String? getAmountPaidErrorMessage,
    AmountPaid? amounts,
    RequestState? storeSahbState,
    String? storeSahbErrorMessage
  }) {
    return ClientsState(
      clients: clients ?? this.clients,
      searchedClients: searchedClients ?? this.searchedClients,
      getClientsState: getClientsState ?? this.getClientsState,
      getClientsErrorMessage: getClientsErrorMessage ?? this.getClientsErrorMessage,
      remoteProductsTypes: remoteProductsTypes ?? this.remoteProductsTypes,
      remotePackagingTypes: remotePackagingTypes ?? this.remotePackagingTypes,
      remotePrice: remotePrice ?? this.remotePrice,
      remoteSmallBagPrice: remoteSmallBagPrice ?? this.remoteSmallBagPrice,
      remoteLargeBagPrice: remoteLargeBagPrice ?? this.remoteLargeBagPrice,
      wards: wards ?? this.wards,
      ward: ward ?? this.ward,
      clientName: clientName ?? this.clientName,
      clientPhone: clientPhone ?? this.clientPhone,
      clientAddress: clientAddress ?? this.clientAddress,
      clientType: clientType ?? this.clientType,
      amountPaid: amountPaid ?? this.amountPaid,
      amountRemain: amountRemain ?? this.amountRemain,
      tons: tons ?? this.tons,
      bags: bags ?? this.bags,
      productToAdd: productToAdd ?? this.productToAdd,
      positions: positions ?? this.positions,
      addClientState: addClientState ?? this.addClientState,
      addClientErrorMessage: addClientErrorMessage ?? this.addClientErrorMessage,
      stores: stores ?? this.stores,
      customMap: customMap ?? this.customMap,
      getStoresState: getStoresState ?? this.getStoresState,
      getStoresErrorMessage: getStoresErrorMessage ?? this.getStoresErrorMessage,
      invoice: invoice ?? this.invoice,
      getInvoiceState: getInvoiceState ?? this.getInvoiceState,
      getClientInvoiceErrorMessage: getClientInvoiceErrorMessage ?? this.getClientInvoiceErrorMessage,
      delClientState: delClientState ?? this.delClientState,
      delClientErrorMessage: delClientErrorMessage ?? this.delClientErrorMessage,
      delStoreState: delStoreState ?? this.delStoreState,
      delStoreErrorMessage: delStoreErrorMessage ?? this.delStoreErrorMessage,
      addPaidState: addPaidState ?? this.addPaidState,
      addPaidErrorMessage: addPaidErrorMessage ?? this.addPaidErrorMessage,
      getAmountPaidState: getAmountPaidState ?? this.getAmountPaidState,
      getAmountPaidErrorMessage: getAmountPaidErrorMessage ?? this.getAmountPaidErrorMessage,
      amounts: amounts ?? this.amounts,
      storeSahbState: storeSahbState ?? this.storeSahbState,
      storeSahbErrorMessage: storeSahbErrorMessage ?? this.storeSahbErrorMessage
    );
  }

  @override
  List<Object> get props => [
    clients, searchedClients, getClientsState, getClientsErrorMessage,
    remoteProductsTypes, remotePackagingTypes, remotePrice,
    remoteSmallBagPrice, remoteLargeBagPrice,
    wards, ward,
    clientName, clientPhone, clientAddress, clientType,
    amountPaid, amountRemain, tons, bags,
    productToAdd,
    positions,
    addClientState, addClientErrorMessage,
    stores, customMap, getStoresState, getStoresErrorMessage,
    invoice, getInvoiceState, getClientInvoiceErrorMessage,
    delClientState, delClientErrorMessage,
    delStoreState, delStoreErrorMessage,
    addPaidState, addPaidErrorMessage,
    getAmountPaidState, getAmountPaidErrorMessage, amounts,
    storeSahbState, storeSahbErrorMessage
  ];
}
