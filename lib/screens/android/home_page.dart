import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../model/contact.dart';
import '../../provider/contact_provider.dart';
import '../../provider/home_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _searchController = TextEditingController();
  List<Contact> _filteredContacts = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterContacts);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterContacts() {
    final provider = Provider.of<ContactProvider>(context, listen: false);
    String ser = _searchController.text.toLowerCase();
    setState(() {
      _filteredContacts = provider.contactList.where((contact) {
        return contact.name?.toLowerCase().contains(ser) ?? false;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "AddContact");
        },
        child: const Icon(Icons.add),
        backgroundColor: Color(0xFF0078FB),
      ),
      appBar: AppBar(
          foregroundColor: Colors.white,
          centerTitle: true,
          backgroundColor: Color(0xFF0078FB),
          title: const Text("Contact App"),
          actions: [
            IconButton(
              onPressed: () {
                Provider.of<HomeProvider>(context, listen: false).change();
              },
              icon: Column(
                children: [
                  const Icon(
                    Icons.swap_horiz,
                    size: 25,
                  ),
                  Text("Android Mode",
                      style: TextStyle(fontSize: 10, color: Colors.white)),
                ],
              ),
            ),
          ]),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search Contacts',
                prefixIcon: const Icon(Icons.search),
                border: const OutlineInputBorder(),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF0078FB)),
                ),
              ),
            ),
          ),
          Expanded(
            child: Consumer<ContactProvider>(
              builder: (BuildContext context, ContactProvider value, Widget? child) {
                List<Contact> contactsToDisplay = _searchController.text.isEmpty
                    ? value.contactList
                    : _filteredContacts;

                if (contactsToDisplay.isEmpty) {
                  return const Center(
                    child: Text(
                      "No Contacts",
                      style: TextStyle(fontSize: 50),
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: contactsToDisplay.length,
                  itemBuilder: (context, index) {
                    Contact contact = contactsToDisplay[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        shadowColor: Color(0xFF0078FB),
                        elevation: 5,
                        child: ListTile(
                          onTap: () {
                            launchUrl(Uri.parse("tel://${contact.number}"));
                          },
                          onLongPress: () {
                            _showDeleteConfirmation(context, contactsToDisplay[index]);
                          },
                          leading: CircleAvatar(
                            backgroundColor: Color(0xFF0078FB),
                            child: Text(
                              "${contact.name?.isNotEmpty == true ? contact.name![0].toUpperCase() : '?'}",
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          title: Text(
                            contact.name ?? "",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            contact.number ?? "",
                            style: const TextStyle(color: Colors.grey),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, "AddContact",
                                      arguments: index);
                                },
                                icon: const Icon(Icons.edit, color: Color(0xFF0078FB)),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed("DetailScreen", arguments: contact);
                                },
                                child: const Icon(Icons.info_outline_rounded),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

void _showDeleteConfirmation(BuildContext context, Contact contact) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Delete Contact"),
        content: const Text("Are you sure you want to delete this contact?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              final provider = Provider.of<ContactProvider>(context, listen: false);
              provider.removeContact(provider.contactList.indexOf(contact));
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Contact deleted")),
              );
            },
            child: const Text("Delete"),
          ),
        ],
      );
    },
  );
}
