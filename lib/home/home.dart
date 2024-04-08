import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tsms_admin/manager/firebase-init/init_firebase_bloc.dart';
import 'package:tsms_admin/manager/get-version/get_version_bloc.dart';
import 'package:tsms_admin/style/text_style.dart';

class Home extends StatelessWidget {
  Home({super.key});

  // FORM STATE KEY
  final _formKey = GlobalKey<FormState>();

  // APP VERSION CONTROLLER
  final TextEditingController _appVersionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // CHECKING IF FIREBASE IS INITIALIZED
    BlocProvider.of<GetVersionBloc>(context).add(GetVersion());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Admin',
          style: xlarge,
        ),
        backgroundColor: Colors.indigo,
        centerTitle: true,
      ),
      body: BlocBuilder<GetVersionBloc, GetVersionState>(
          builder: (context, state) {
        if (state is GetVersionSuccess) {
          // GETTING CURRENT VERSION
          _appVersionController.text = state.version.toString() ?? '';

          return Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: state.isFirebaseInit
                        ? [
                            TextFormField(
                              keyboardType: TextInputType.number,
                              controller: _appVersionController,
                              validator: (value) {
                                if (_appVersionController.text.isEmpty) {
                                  return 'The field cannot be empty';
                                }
                                if (double.tryParse(
                                        _appVersionController.text) ==
                                    null) {
                                  return 'Please enter a valid decimal number';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                hintText: 'App version',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(
                              height: 12.0,
                            ),
                            CustomButton(
                              label: 'Change',
                              onPressed: () {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  BlocProvider.of<InitFirebaseBloc>(context)
                                      .add(
                                    UpdateVersion(
                                      version: double.tryParse(
                                              _appVersionController.text) ??
                                          1.0,
                                    ),
                                  );

                                  // CHECKING IF FIREBASE IS INITIALIZED
                                  BlocProvider.of<GetVersionBloc>(context)
                                      .add(GetVersion());
                                }
                              },
                            ),
                            const SizedBox(
                              height: 12.0,
                            ),
                            Text(
                              'Current app version is : ${state.version}',
                              style: medium.copyWith(color: Colors.grey),
                            )
                          ]
                        : [
                            CustomButton(
                              label: 'Init Firebase',
                              onPressed: () {
                                BlocProvider.of<InitFirebaseBloc>(context)
                                    .add(InitializeFirebase());

                                // CHECKING IF FIREBASE IS INITIALIZED
                                BlocProvider.of<GetVersionBloc>(context)
                                    .add(GetVersion());
                              },
                            )
                          ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.label, this.onPressed});

  final String label;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        shape: const MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
        ),
        backgroundColor: MaterialStatePropertyAll(Colors.indigo[400]),
        minimumSize: const MaterialStatePropertyAll(
          Size(double.infinity, 50.0),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        label,
        style: medium,
      ),
    );
  }
}
