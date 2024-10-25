import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../model/contact.dart';
import '../../provider/contact_provider.dart';
import '../../provider/home_provider.dart';

class IosHomePage extends StatefulWidget {
  const IosHomePage({super.key});

  @override
  State<IosHomePage> createState() => _IosHomePageState();
}

class _IosHomePageState extends State<IosHomePage> {
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
    String query = _searchController.text.toLowerCase();
    setState(() {
      _filteredContacts = provider.contactList.where((contact) {
        return contact.name?.toLowerCase().contains(query) ?? false;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      navigationBar: CupertinoNavigationBar(
        middle: const Text(
          "Contact App",
          style: TextStyle(color: CupertinoColors.white, fontSize: 24),
        ),
        backgroundColor: CupertinoColors.activeBlue,
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            Provider.of<HomeProvider>(context, listen: false).change();
          },
          child: Column(
            children: const [
              Icon(
                CupertinoIcons.arrow_right_arrow_left_square_fill,
                color: CupertinoColors.white,
                size: 25,
              ),
              Text(
                "iOS Mode",
                style: TextStyle(color: CupertinoColors.white, fontSize: 15),
              ),
            ],
          ),
        ),
      ),
      child: Consumer<ContactProvider>(
        builder: (BuildContext context, ContactProvider value, Widget? child) {
          List<Contact> contactsToDisplay = _searchController.text.isEmpty
              ? value.contactList
              : _filteredContacts;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                Column(
                  children: [
                    Card(
                      child: CupertinoTextField(
                        controller: _searchController,
                        placeholder: 'Search Contacts',
                        prefix: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Icon(CupertinoIcons.search),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: ListView.builder(
                        itemCount: contactsToDisplay.length,
                        itemBuilder: (context, index) {
                          Contact contact = contactsToDisplay[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                launchUrl(Uri.parse("tel://${contact.number}"));
                              },
                              onLongPress: () {
                                _showDeleteConfirmation(context, index);
                              },
                              child: CupertinoButton(
                                onPressed: () {
                                  launchUrl(Uri.parse("tel://${contact.number}"));
                                },
                                padding: EdgeInsets.zero,
                                child: Card(
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: CupertinoColors.activeBlue,
                                          child: Text(
                                            "${contact.name?.isNotEmpty == true ? contact.name![0].toUpperCase() : '?'}",
                                            style: const TextStyle(color: CupertinoColors.white),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                contact.name ?? "",
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                contact.number ?? "",
                                                style: const TextStyle(
                                                  color: CupertinoColors.systemGrey,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        CupertinoButton(
                                          padding: EdgeInsets.zero,
                                          child: const Icon(CupertinoIcons.pencil, color: CupertinoColors.activeBlue),
                                          onPressed: () {
                                            Navigator.pushNamed(context, "AddContact", arguments: index);
                                          },
                                        ),
                                        CupertinoButton(
                                          padding: EdgeInsets.zero,
                                          child: const Icon(CupertinoIcons.info, color: CupertinoColors.systemGrey),
                                          onPressed: () {
                                            Navigator.of(context).pushNamed("DetailScreen", arguments: contact);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 5.0,
                  right: 5.0,
                  child: CupertinoButton(
                    color: CupertinoColors.activeBlue,
                    borderRadius: BorderRadius.circular(30.0),
                    child: const Icon(CupertinoIcons.add, color: CupertinoColors.white),
                    onPressed: () {
                      Navigator.pushNamed(context, "AddContact");
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, int index) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text("Delete Contact"),
          content: const Text("Are you sure you want to delete this contact?"),
          actions: [
            CupertinoDialogAction(
              onPressed: () {
                Navigator.of(context).pop(); 
              },
              child: const Text("Cancel"),
            ),
            CupertinoDialogAction(
              onPressed: () {
                Provider.of<ContactProvider>(context, listen: false).removeContact(index);
                Navigator.of(context).pop();
                _showContactDeletedMessage(context); 
              },
              isDestructiveAction: true,
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  void _showContactDeletedMessage(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text("Contact Deleted"),
          actions: [
            CupertinoDialogAction(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
