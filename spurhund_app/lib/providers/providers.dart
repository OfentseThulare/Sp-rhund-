import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../data/services/mock_account_service.dart';
import '../data/repositories/account_repository.dart';
import '../view_models/account_view_model.dart';

import '../data/services/mock_bill_service.dart';
import '../data/repositories/bill_repository.dart';
import '../view_models/bill_view_model.dart';

import '../data/services/mock_status_service.dart';
import '../data/repositories/status_repository.dart';
import '../view_models/status_view_model.dart';

import '../data/services/mock_dispute_service.dart';
import '../data/repositories/dispute_repository.dart';
import '../view_models/dispute_view_model.dart';

import '../data/services/mock_contact_service.dart';
import '../data/repositories/contact_repository.dart';
import '../view_models/contact_view_model.dart';

import '../data/services/mock_notification_service.dart';
import '../data/repositories/notification_repository.dart';
import '../view_models/notification_view_model.dart';

import '../data/services/mock_user_service.dart';
import '../data/repositories/user_repository.dart';
import '../view_models/user_view_model.dart';

final List<SingleChildWidget> appProviders = [
  // Services
  Provider<MockAccountService>(create: (_) => MockAccountService()),
  Provider<MockBillService>(create: (_) => MockBillService()),
  Provider<MockStatusService>(create: (_) => MockStatusService()),
  Provider<MockDisputeService>(create: (_) => MockDisputeService()),
  Provider<MockContactService>(create: (_) => MockContactService()),
  Provider<MockNotificationService>(create: (_) => MockNotificationService()),
  Provider<MockUserService>(create: (_) => MockUserService()),

  // Repositories
  ProxyProvider<MockAccountService, AccountRepository>(
    update: (_, service, __) => AccountRepository(service),
  ),
  ProxyProvider<MockBillService, BillRepository>(
    update: (_, service, __) => BillRepository(service),
  ),
  ProxyProvider<MockStatusService, StatusRepository>(
    update: (_, service, __) => StatusRepository(service),
  ),
  ProxyProvider<MockDisputeService, DisputeRepository>(
    update: (_, service, __) => DisputeRepository(service),
  ),
  ProxyProvider<MockContactService, ContactRepository>(
    update: (_, service, __) => ContactRepository(service),
  ),
  ProxyProvider<MockNotificationService, NotificationRepository>(
    update: (_, service, __) => NotificationRepository(service),
  ),
  ProxyProvider<MockUserService, UserRepository>(
    update: (_, service, __) => UserRepository(service),
  ),

  // ViewModels
  ChangeNotifierProxyProvider<AccountRepository, AccountViewModel>(
    create: (context) => AccountViewModel(context.read<AccountRepository>()),
    update: (_, repo, prev) => prev ?? AccountViewModel(repo),
  ),
  ChangeNotifierProxyProvider<BillRepository, BillViewModel>(
    create: (context) => BillViewModel(context.read<BillRepository>()),
    update: (_, repo, prev) => prev ?? BillViewModel(repo),
  ),
  ChangeNotifierProxyProvider<StatusRepository, StatusViewModel>(
    create: (context) => StatusViewModel(context.read<StatusRepository>()),
    update: (_, repo, prev) => prev ?? StatusViewModel(repo),
  ),
  ChangeNotifierProxyProvider<DisputeRepository, DisputeViewModel>(
    create: (context) => DisputeViewModel(context.read<DisputeRepository>()),
    update: (_, repo, prev) => prev ?? DisputeViewModel(repo),
  ),
  ChangeNotifierProxyProvider<ContactRepository, ContactViewModel>(
    create: (context) => ContactViewModel(context.read<ContactRepository>()),
    update: (_, repo, prev) => prev ?? ContactViewModel(repo),
  ),
  ChangeNotifierProxyProvider<NotificationRepository, NotificationViewModel>(
    create: (context) => NotificationViewModel(context.read<NotificationRepository>()),
    update: (_, repo, prev) => prev ?? NotificationViewModel(repo),
  ),
  ChangeNotifierProxyProvider<UserRepository, UserViewModel>(
    create: (context) => UserViewModel(context.read<UserRepository>()),
    update: (_, repo, prev) => prev ?? UserViewModel(repo),
  ),
];
