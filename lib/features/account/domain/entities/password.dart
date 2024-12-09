class Password {
  final String old_password;
  final String new_password;
  final String new_password_confirmation;

  Password({
    required this.old_password,
    required this.new_password,
    required this.new_password_confirmation,
  });
}