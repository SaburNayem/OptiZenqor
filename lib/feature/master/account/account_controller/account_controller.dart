import 'package:optizenqor/feature/master/account/account_model/account_model.dart';

class AccountController {
  const AccountController();

  AccountModel get data => const AccountModel(
    name: 'Shob Bazaar',
    email: 'support@yourapp.com',
    actions: <String>[
      'Personal Details',
      'Settings',
      'Payment Method',
      'Delivery Address',
      'My Order',
    ],
  );
}
