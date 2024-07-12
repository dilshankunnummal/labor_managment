import 'package:flutter/material.dart';
import 'package:labor_managment/constants/colors.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({Key? key}) : super(key: key);

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: primaryColor,
            hintColor: primaryColor,
            colorScheme: ColorScheme.light(primary: primaryColor),
            buttonTheme: ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
              colorScheme: ColorScheme.light(primary: primaryColor),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Select Date ',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: black,
          ),
        ),
      ),
      body: Card(
        color: cardColor,
        margin: EdgeInsets.fromLTRB(20, 60, 20, 20),
        elevation: 5,
        child: Container(
          padding: EdgeInsets.fromLTRB(16, 34, 16, 34),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.date_range, color: primaryColor),
                title: Text(
                  selectedDate != null
                      ? 'Date Selected: ${selectedDate!.toString().substring(0, 10)}'
                      : 'Select Date',
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: ElevatedButton(
                  onPressed: () => _selectDate(context),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: cardColor,
                    backgroundColor: Colors.white, // foreground color
                    textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: Text('Pick'),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Implement booking logic here
                  // Example: Save selectedDate and selectedTime to Firebase or process booking
                  Navigator.pop(
                      context); // Return to previous page after booking
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: cardColor,
                  backgroundColor: Colors.white, // foreground color
                  textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: Text('Confirm Booking'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
