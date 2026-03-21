import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import '../view_models/dashboard_view_model.dart';
import '../view_models/disputes_view_model.dart';
import '../view_models/auth_view_model.dart';
import '../view_models/accounts_view_model.dart';
import '../view_models/status_view_model.dart';

List<SingleChildWidget> get appProviders => [
      ChangeNotifierProvider(create: (_) => AuthViewModel()),
      ChangeNotifierProvider(create: (_) => DashboardViewModel()),
      ChangeNotifierProvider(create: (_) => AccountsViewModel()),
      ChangeNotifierProvider(create: (_) => DisputesViewModel()),
      ChangeNotifierProvider(create: (_) => StatusViewModel()),
    ];
