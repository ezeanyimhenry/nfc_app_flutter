import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:nfc_app/models/languages.dart';

class LanguagesDropdown extends StatefulWidget {
  final ValueChanged<String?> onLanguageSelected;
  const LanguagesDropdown({super.key, required this.onLanguageSelected});
  @override
  State<LanguagesDropdown> createState() => _LanguagesDropdownState();
}

class _LanguagesDropdownState extends State<LanguagesDropdown> {
  String? _selectedLanguage;

  @override
  Widget build(BuildContext context) {
    return languageselection();
  }

  Column languageselection() {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // const SizedBox(height: 15),
        // Container(
        //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
        //   decoration: BoxDecoration(
        //     border: Border.all(color: Colors.grey, width: 1),
        //     borderRadius: BorderRadius.circular(5.0),
        //   ),
        //   child: DropdownSearch<String>(
        //     mode: Mode.MENU,
        //     showSearchBox: true,
        //     items: Languages().languages,
        //     label: "Select Language",
        //     hint: "Search Language",
        //     onChanged: (String? newValue) {
        //       setState(() {
        //         _selectedLanguage = newValue;
        //       });
        //     },
        //     selectedItem: _selectedLanguage,
        //   ),
        // ),
        const SizedBox(height: 15),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: DropdownSearch<String>(
            dropdownDecoratorProps: const DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                hintText: "Select Language",
                border: InputBorder.none,
              ),
            ),
            items: Languages().languages,
            selectedItem: _selectedLanguage,
            onChanged: (String? newValue) {
              setState(() {
                _selectedLanguage = newValue;
              });
              widget.onLanguageSelected(newValue);
            },
            popupProps: PopupProps.menu(
              showSearchBox: true,
              searchFieldProps: TextFieldProps(
                decoration: InputDecoration(
                  hintText: "Search Language",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
            ),
          ),
        ),
        // Container(
        //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
        //   decoration: BoxDecoration(
        //     border: Border.all(color: Colors.grey, width: 1),
        //     borderRadius: BorderRadius.circular(5.0),
        //   ),
        //   child: DropdownButton<String>(
        //     dropdownColor: const Color(0xFFF3E8EB),
        //     value: _selectedLanguage,
        //     hint: const Text('Select Language'),
        //     onChanged: (String? newValue) {
        //       setState(() {
        //         _selectedLanguage = newValue;
        //       });
        //       widget.onLanguageSelected(newValue);
        //     },
        //     items: Languages()
        //         .languages
        //         .map<DropdownMenuItem<String>>((String value) {
        //       return DropdownMenuItem<String>(
        //         value: value,
        //         child: Text(value),
        //       );
        //     }).toList(),
        //   ),
        // ),

        // const SizedBox(height: 20),
        // if (_selectedLanguage != null)
        //   Text("Selected Nationality: $_selectedLanguage"),
      ],
    );
  }
}
