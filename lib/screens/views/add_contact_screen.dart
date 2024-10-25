import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/contact.dart';
import '../../provider/contact_provider.dart';
import '../../provider/home_provider.dart';

class AddContact extends StatefulWidget {
  const AddContact({super.key});

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  int? editIndex;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    editIndex = ModalRoute.of(context)?.settings.arguments as int?;
    if (editIndex != null) {
      Contact contact = Provider.of<ContactProvider>(context, listen: false)
          .contactList[editIndex!];
      nameController.text = contact.name ?? "";
      numberController.text = contact.number ?? "";
      emailController.text = contact.email ?? "";
      addressController.text = contact.address ?? "";
    }
    if (Provider.of<HomeProvider>(context).isAndroid) {
      return Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: Color(0xFF0078FB),
          title: Text(editIndex != null ? "Edit Contact" : "Add Contact",style: const TextStyle(fontSize: 24, color: CupertinoColors.white),),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(18.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 16),
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter your name',
                    prefixIcon: Icon(Icons.person),
                    labelText: 'Your Name',
                  ),
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter a name' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: numberController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter your phone number',
                    prefixIcon: Icon(Icons.call),
                    labelText: 'Your Phone Number',
                  ),
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter a phone number' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter your email',
                    prefixIcon: Icon(Icons.email),
                    labelText: 'Your Email',
                  ),
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter an email' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: addressController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter your address',
                    prefixIcon: Icon(Icons.location_on),
                    labelText: 'Your Address',
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Contact con = Contact(
                        name: nameController.text,
                        number: numberController.text,
                        email: emailController.text,
                        address: addressController.text,
                      );

                      if (editIndex == null) {
                        Provider.of<ContactProvider>(context, listen: false)
                            .addContact(con);
                      } else {
                        Provider.of<ContactProvider>(context, listen: false)
                            .editContact(con, editIndex!);
                      }
                      nameController.clear();
                      numberController.clear();
                      emailController.clear();
                      addressController.clear();
                      Navigator.pop(context);
                    }
                  },
                  child:
                      Text(editIndex != null ? "Edit Contact" : "Add Contact"),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text(editIndex != null ? "Edit Contact" : "Add Contact",style: const TextStyle(fontSize: 24, color: CupertinoColors.white),),
          backgroundColor: CupertinoColors.activeBlue,

        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  CupertinoTextFormFieldRow(
                    controller: nameController,
                    prefix: const Icon(CupertinoIcons.person,
                        color: CupertinoColors.white),
                    placeholder: 'Enter your name',style :TextStyle(color: CupertinoColors.white),
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  CupertinoTextFormFieldRow(
                    controller: numberController,
                    keyboardType: TextInputType.phone,
                    prefix: const Icon(CupertinoIcons.phone,
                        color: CupertinoColors.white),
                    placeholder: 'Enter your phone number',style :TextStyle(color: CupertinoColors.white),
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a phone number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  CupertinoTextFormFieldRow(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    prefix: const Icon(CupertinoIcons.mail,
                        color: CupertinoColors.white),
                    placeholder: 'Enter your email',style :TextStyle(color: CupertinoColors.white),
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  CupertinoTextFormFieldRow(
                    controller: addressController,
                    prefix: const Icon(CupertinoIcons.location,
                        color: CupertinoColors.white),
                    placeholder: 'Enter your address',style:  TextStyle(color: CupertinoColors.white),
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CupertinoButton.filled(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 15),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Contact con = Contact(
                              name: nameController.text,
                              number: numberController.text,
                              email: emailController.text,
                              address: addressController.text,
                            );

                            if (editIndex == null) {
                              Provider.of<ContactProvider>(context,
                                      listen: false)
                                  .addContact(con);
                            } else {
                              Provider.of<ContactProvider>(context,
                                      listen: false)
                                  .editContact(con, editIndex!);
                            }
                            
                            nameController.clear();
                            numberController.clear();
                            emailController.clear();
                            addressController.clear();
                            Navigator.pop(context);
                          }
                        },
                        child: Text(
                          editIndex != null ? "Update Contact" : "Add Contact",
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
}
