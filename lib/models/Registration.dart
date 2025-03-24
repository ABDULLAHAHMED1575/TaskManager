class Registration {
  final String email;
  final String password;

  const Registration(this.email, this.password);

  bool matches(String email, String password) {
    return this.email == email && this.password == password;
  }
}