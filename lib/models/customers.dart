class Customers {
  final String customerName;
  late String passwordCustomer = '';
  final List<String> branches;
  Customers(
      {required this.customerName,
      required this.passwordCustomer,
      required this.branches});
}

class Branches {
  final String customer;
  final String branchName;
  final String passwordBranch;

  Branches(
    this.customer,
    this.branchName,
    this.passwordBranch,
  );
}
