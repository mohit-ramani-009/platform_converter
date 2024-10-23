import 'package:flutter/material.dart';

import '../model/contact.dart';

class ContactProvider extends ChangeNotifier {
  List<Contact> contactList = [
    Contact(name: "John Doe", number: "1234567890", email: "johndoe@example.com", address: "123 Main St"),
    Contact(name: "Jane Doe", number: "9876543210", email: "janedoe@example.com", address: "456 Main St"),
    Contact(name: "Alice Smith", number: "5551234567", email: "alice@example.com", address: "789 Main St"),
    Contact(name: "Bob Johnson", number: "5559876543", email: "bob@example.com", address: "101 Main St"),
    Contact(name: "Charlie Brown", number: "5555555555", email: "charlie@example.com", address: "202 Main St"),
    Contact(name: "Daisy Miller", number: "5550000001", email: "daisy@example.com", address: "303 Main St"),
    Contact(name: "Ethan Hunt", number: "5550000002", email: "ethan@example.com", address: "404 Main St"),
    Contact(name: "Fiona Green", number: "5550000003", email: "fiona@example.com", address: "505 Main St"),
    Contact(name: "George Black", number: "5550000004", email: "george@example.com", address: "606 Main St"),
    Contact(name: "Hannah White", number: "5550000005", email: "hannah@example.com", address: "707 Main St"),
    Contact(name: "Ian Red", number: "5550000006", email: "ian@example.com", address: "808 Main St"),
    Contact(name: "Julia Blue", number: "5550000007", email: "julia@example.com", address: "909 Main St"),
    Contact(name: "Kevin Gray", number: "5550000008", email: "kevin@example.com", address: "1010 Main St"),
    Contact(name: "Laura Silver", number: "5550000009", email: "laura@example.com", address: "1111 Main St"),
    Contact(name: "Mark Gold", number: "5550000010", email: "mark@example.com", address: "1212 Main St"),
    Contact(name: "Nina Purple", number: "5550000011", email: "nina@example.com", address: "1313 Main St"),
    Contact(name: "Oscar Orange", number: "5550000012", email: "oscar@example.com", address: "1414 Main St"),
    Contact(name: "Paula Pink", number: "5550000013", email: "paula@example.com", address: "1515 Main St"),
    Contact(name: "Quentin Yellow", number: "5550000014", email: "quentin@example.com", address: "1616 Main St"),
    Contact(name: "Rita Cyan", number: "5550000015", email: "rita@example.com", address: "1717 Main St"),
    Contact(name: "Sam Brown", number: "5550000016", email: "sam@example.com", address: "1818 Main St"),
  ];
  List<Contact> MissedCallList = [
    Contact(name: "John Doe", number: "1234567890", email: "johndoe@example.com", address: "123 Main St"),
    Contact(name: "Jane Doe", number: "9876543210", email: "janedoe@example.com", address: "456 Main St"),
    Contact(name: "Alice Smith", number: "5551234567", email: "alice@example.com", address: "789 Main St"),
    Contact(name: "Bob Johnson", number: "5559876543", email: "bob@example.com", address: "101 Main St"),
    Contact(name: "Charlie Brown", number: "5555555555", email: "charlie@example.com", address: "202 Main St"),
    Contact(name: "Daisy Miller", number: "5550000001", email: "daisy@example.com", address: "303 Main St"),
    Contact(name: "Ethan Hunt", number: "5550000002", email: "ethan@example.com", address: "404 Main St"),
    Contact(name: "Fiona Green", number: "5550000003", email: "fiona@example.com", address: "505 Main St"),
    Contact(name: "George Black", number: "5550000004", email: "george@example.com", address: "606 Main St"),
    Contact(name: "Hannah White", number: "5550000005", email: "hannah@example.com", address: "707 Main St"),

  ];

  void addContact(Contact contact) {
    contactList.add(contact);
    notifyListeners();
  }

  void editContact(Contact contact, int index) {
    contactList[index] = contact;
    notifyListeners();
  }

  void removeContact(int index) {
    contactList.removeAt(index);
    notifyListeners();
  }
}
