import 'package:form_field_validator/form_field_validator.dart';


class Validators {
  static final emailValidator = MultiValidator([
    RequiredValidator(errorText: 'Email is required'),
    EmailValidator(errorText: 'Enter a valid email address')
  ]);

  static final requiredValidator =
  RequiredValidator(errorText: 'This field is required');

  static final loginPasswordValidator = MultiValidator([
    RequiredValidator(errorText:  'Password is required'),
    MinLengthValidator(6, errorText: 'Password must be at least 6 digits long'),
  ]);

  static final registerPasswordValidator = MultiValidator([
    RequiredValidator(errorText: 'Password is required'),
    MinLengthValidator(6, errorText:  'Password must be at least 6 digits long'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText: 'Passwords must have at least one special character')
  ]);


  static final phoneValidator = MultiValidator([
    RequiredValidator(errorText: 'Phone number is required'),
    MinLengthValidator(10, errorText: 'Enter a valid phone number'),
    MaxLengthValidator(10, errorText:'Enter a valid phone number'),
    PatternValidator(r'^[0-9]*$', errorText: 'Enter a valid phone number')
  ]);

  static final nameValidator = MultiValidator([
    RequiredValidator(errorText: 'This field is required'),
    MinLengthValidator(3, errorText: 'Enter a 3 character minimum'),

  ]);static final fullNameValidator = MultiValidator([
    RequiredValidator(errorText: 'This field is required'),
    MinLengthValidator(3, errorText: 'Enter a minimum of 3 characters'),
    PatternValidator(r'^[a-zA-Z ]+$', errorText: 'Only alphabets and spaces are allowed'),
  ]);

}
