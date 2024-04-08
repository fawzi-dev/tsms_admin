import 'package:flutter/material.dart';
import 'package:tsms_admin/style/text_style.dart';

class Home extends StatelessWidget {
  Home({super.key});

  // FORM STATE KEY
  final _formKey = GlobalKey<FormState>();

  // APP VERSION CONTROLLER
  final TextEditingController _appVersionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Admin',
          style: xlarge,
        ),
        backgroundColor: Colors.indigo,
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _appVersionController,
                    validator: (value) {
                      if (_appVersionController.text.isEmpty) {
                        return 'The field cannot be empty';
                      }
                      if (double.tryParse(_appVersionController.text) == null) {
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
                  ElevatedButton(
                    style: ButtonStyle(
                      shape: const MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                      ),
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.indigo[400]),
                      minimumSize: const MaterialStatePropertyAll(
                        Size(double.infinity, 50.0),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        // Form is valid, perform your action here
                        // For example, you can get the value from _appVersionController.text
                        // and use it for further processing
                        print('Form is valid');
                      }
                    },
                    child: Text(
                      'Change',
                      style: medium,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
