import 'package:flutter/material.dart';
import 'package:oneid_mobile_app/components/form_textfield.dart';
import 'package:oneid_mobile_app/components/progress_bar.dart';

class ApplyDL extends StatefulWidget {
  ApplyDL({Key? key}) : super(key: key);

  @override
  State<ApplyDL> createState() => _ApplyDL();
}

class _ApplyDL extends State<ApplyDL>{
  
  final searchController = TextEditingController();
  String? _selectedGender;
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [

                // Back button icon
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: const Icon(Icons.chevron_left),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
        
                //Progress Bar
                const SizedBox(height: 10,),
                const ProgressBar(
                  step: 1,
                ),
                
                const SizedBox(height: 5,),
                const Padding(
                  padding: EdgeInsets.only(left: 25),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Fill out the below form with your details',
                      style: TextStyle(
                        color: Color(0xFF27187E),
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  )
                ),
        
                SizedBox(height: 20,),
        
                //User details form
                Form(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        const textField(
                          hintText: 'Full Name',
                        ),
                        const SizedBox(height: 20,),
                        const textField(
                          hintText: 'NIC',
                        ),
                        const SizedBox(height: 20,),
                        const textField(
                          hintText: 'Permanent Address',
                        ),
                        const SizedBox(height: 20,),
                        const textField(
                          hintText: 'District',
                        ),
                        const SizedBox(height: 20,),
                        
                        //Date of Birth date picker
                        TextFormField(
                          onTap: () => _selectDate(context),
                          controller: TextEditingController(
                            text: _selectedDate != null ? _selectedDate.toString() : '',
                          ),
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText: 'Date of Birth',
                            suffixIcon: IconButton(
                              onPressed: () => _selectDate(context),
                              icon: Icon(Icons.calendar_today),
                            )
                          ),
                        ),
                        SizedBox(height: 20,),
                        
                        //Gender Radio Button
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Gender',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey.shade700,
                              ),
                            ),
                            RadioListTile(
                              title: Text('Male'),
                              value: 'Male', 
                              groupValue: _selectedGender, 
                              onChanged: (value){
                                setState(() {
                                  _selectedGender = value as String?;
                                });
                              },
                            ),
                            RadioListTile(
                              title: Text('Female'),
                              value: 'Female',
                              groupValue: _selectedGender,
                              onChanged: (value){
                                setState(() {
                                  _selectedGender = value as String?;
                                });
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 20,),
                        textField(
                          hintText: 'Profession/ Occupation/ Job',
                        ),
                        SizedBox(height: 20,),
                        textField(
                          hintText: 'Place of Birth',
                        ),
                        SizedBox(height: 20,),
                        textField(
                          hintText: 'Phone Number',
                        ),
                        SizedBox(height: 20,),
                        textField(
                          hintText: 'Email Address',
                        ),
                      ],
                    ),
                  ),
                ),
        
              ],
            ),
          ),
        )
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: _selectedDate ?? DateTime.now(),
    firstDate: DateTime(1900),
    lastDate: DateTime.now(),
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: ThemeData.light().copyWith(
          primaryColor: Color(0xFF27187E),
          colorScheme: ColorScheme.light(primary: Color(0xFF27187E)),
          buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
        ),
        child: child!,
      );
    },
  );

  if (picked != null && picked != _selectedDate) {
    setState(() {
      _selectedDate = DateTime(picked.year, picked.month, picked.day);
    });
  }
}
  
}