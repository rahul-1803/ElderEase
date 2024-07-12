import 'package:dementia/appointements/screens/preview_page.dart';
import 'package:flutter/material.dart';


class DetailsPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final doctorNameController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final ageController = TextEditingController();
  final sexController = TextEditingController();
  final ailmentController = TextEditingController();
  final appointmentDateController = TextEditingController();
  final timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Patient Details',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 63, 62, 62),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              _buildSectionTitle('Personal Information'),
              _buildTextField(doctorNameController, 'Consulting Doctor Name'),
              _buildTextField(firstNameController, 'First Name'),
              _buildTextField(lastNameController, 'Last Name'),
              _buildTextField(phoneNumberController, 'Phone Number'),
              _buildSectionTitle('Medical Information'),
              _buildTextField(ageController, 'Age'),
              _buildTextField(sexController, 'Sex'),
              _buildTextField(ailmentController, 'Ailment'),
              _buildTextField(appointmentDateController, 'Appointment Date'),
              _buildTextField(timeController, 'Time'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PreviewPage(
                          doctorname: doctorNameController.text,
                          firstName: firstNameController.text,
                          lastName: lastNameController.text,
                          phoneNumber: phoneNumberController.text,
                          age: ageController.text,
                          sex: sexController.text,
                          ailment: ailmentController.text,
                          appointmentDate: appointmentDateController.text,
                          time: timeController.text,
                        ),
                      ),
                    );
                  }
                },
                child: Text('View Preview'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.indigoAccent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 3,
              offset: Offset(0, 2),
            ),
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            labelText: labelText,
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(10),
          ),
          style: TextStyle(fontWeight: FontWeight.bold),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your $labelText';
            }
            return null;
          },
        ),
      ),
    );
  }
}