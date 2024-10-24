import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../model/contact.dart';
import '../../provider/contact_provider.dart';
import '../../provider/home_provider.dart';

class MissedCallPage extends StatefulWidget {
  const MissedCallPage({super.key});

  @override
  State<MissedCallPage> createState() => _MissedCallPageState();
}

class _MissedCallPageState extends State<MissedCallPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100
,
      appBar: AppBar(
          foregroundColor: Colors.white,
          centerTitle: true,
          backgroundColor: Color(0xFF0078FB)
,
          title: const Text("Contact App"),
      ),
      body: Consumer<ContactProvider>(
        builder: (BuildContext context, ContactProvider value, Widget? child) {
          if (value.MissedCallList.isEmpty) {
            return const Center(
              child: Text(
                "No Contacts",
                style: TextStyle(fontSize: 50),
              ),
            );
          }
          return ListView.builder(
            itemCount: value.MissedCallList.length,
            itemBuilder: (context, index) {
              Contact contact = value.contactList[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  shadowColor: Colors.red,
                  color: Colors.red.shade50,
                  elevation: 5,
                  child: ListTile(
                    onTap: () {
                      launchUrl(Uri.parse("tel://${contact.number}"));
                    },
                    onLongPress: () {
                      _showDeleteConfirmation(context, index);
                    },
                    leading: CircleAvatar(
                      backgroundColor: Colors.red,
                      child: Text(
                        "${contact.name?.isNotEmpty == true ? contact.name![0].toUpperCase() : '?'}",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text(
                      contact.name ?? "",
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      contact.number ?? "",
                      style: const TextStyle(color: Colors.grey),
                    ),
                    trailing: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed("DetailScreen", arguments: contact);
                      },
                      child: const Icon(Icons.info_outline_rounded),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

void _showDeleteConfirmation(BuildContext context, int index) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Delete Contact"),
        content: const Text("Are you sure you want to delete this contact?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Provider.of<ContactProvider>(context, listen: false).removeContact(index);
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

