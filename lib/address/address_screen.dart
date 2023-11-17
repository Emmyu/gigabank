import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_country_picker/flutter_country_picker.dart';

class Address {
  String? country;
  String? prefecture;
  String? municipality;
  String? streetAddress;
  String? apartment;

  Address({
    this.country,
    this.prefecture,
    this.municipality,
    this.streetAddress,
    this.apartment,
  });
}

class AddressScreen extends StatefulWidget {
  const AddressScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final _formKey = GlobalKey<FormState>();
  Country? _selectedCountry;
  final _prefectureController = TextEditingController();
  final _municipalityController = TextEditingController();
  final _streetAddressController = TextEditingController();
  final _apartmentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registered Address', style: GoogleFonts.lato()),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Please enter information as written on your ID document.',
                style: GoogleFonts.lato(fontSize: 16.0),
              ),
              SizedBox(height: 16.0),
              CountryPicker(
                dense: false,
                showFlag: true,
                showDialingCode: false,
                onChanged: (Country? country) {
                  setState(() {
                    _selectedCountry = country;
                  });
                },
                selectedCountry: _selectedCountry,
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _prefectureController,
                decoration: InputDecoration(labelText: 'Prefecture'),
                style: GoogleFonts.lato(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your prefecture';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _municipalityController,
                decoration: InputDecoration(labelText: 'Municipality'),
                style: GoogleFonts.lato(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your municipality';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _streetAddressController,
                decoration: InputDecoration(
                  labelText: 'Street address (subarea - block - house ...)',
                ),
                style: GoogleFonts.lato(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your street address';
                  }
                  // Add custom validation for the street address format
                  // For example, check if it follows the subarea - block - house format
                  // Modify this condition according to your specific validation rules
                  if (!value.contains('-')) {
                    return 'Invalid street address format';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _apartmentController,
                decoration: InputDecoration(labelText: 'Apartment, suite or unit'),
                style: GoogleFonts.lato(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your apartment, suite, or unit';
                  }
                  return null;
                },
              ),
              Spacer(),
              SizedBox(height: 16.0),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Store the address in an object
                      Address address = Address(
                        country: _selectedCountry?.name,
                        prefecture: _prefectureController.text,
                        municipality: _municipalityController.text,
                        streetAddress: _streetAddressController.text,
                        apartment: _apartmentController.text,
                      );
                      print('Address: ${address.country}, ${address.prefecture}, ${address.municipality}, ${address.streetAddress}, ${address.apartment}');
                    }
                  },
                  child: Text(
                    'Next',
                    style: GoogleFonts.lato(fontSize: 18.0),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.deepPurple,
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    side: BorderSide(
                      color: Colors.deepPurple,
                      width: 2.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
