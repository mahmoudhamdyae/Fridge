import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fridge/clients/presentation/bloc/clients_bloc.dart';
import 'package:fridge/core/extensions/context_extension.dart';
import 'package:fridge/core/services/services_locator.dart';

import '../../../core/components/appbar.dart';
import '../../../core/components/decorations.dart';
import '../components/add_client_button.dart';
import '../components/client_details_button.dart';

class ClientsScreen extends StatefulWidget {
  const ClientsScreen({super.key});

  @override
  State<ClientsScreen> createState() => _ClientsScreenState();
}

class _ClientsScreenState extends State<ClientsScreen> {

  late ClientsBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = instance<ClientsBloc>();
    bloc.add(GetClientsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Container(
            height: context.height,
            padding: getMainPadding(context),
            decoration: getMainDecoration(),
            child: ListView(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: [
                const MainAppBar(),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AddClientButton(),
                    ClientDetailsButton()
                  ],
                ),
                BlocBuilder<ClientsBloc, ClientsState>(
                  builder: (context, state) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: state.clients.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Text(state.clients[index].name ?? '');
                      },
                    );
                  },
                )
              ],
            ),
          ),
        )
    );
  }
}
