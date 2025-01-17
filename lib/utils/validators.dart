Function(String?) emailValidator = (String? value) {
  if (value == null) {
    return 'Please enter your email';
  }
  if (value.isEmpty) {
    return 'Please enter your email';
  }
  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
    return 'Please enter a valid email';
  }
  return null;
};

Function(String?) passwordValidator = (String? value) {
  if (value == null) {
    return 'Please enter your password';
  }
  if (value.isEmpty) {
    return 'Please enter your password';
  }
  if (value.length < 6) {
    return 'Password must be at least 6 characters';
  }
  return null;
};

Function(String?) nameValidator = (String? value) {
  if (value == null) {
    return 'Please enter your name';
  }
  if (value.isEmpty) {
    return 'Please enter your name';
  }
  if (value.length < 3) {
    return 'Name must be at least 3 characters';
  }
  if (value.length > 20) {
    return 'Name must be less than 20 characters';
  }
  return null;
};

Function(String?) usernameValidator = (String? value) {
  if (value == null) {
    return 'Please enter your username';
  }
  if (value.isEmpty) {
    return 'Please enter your username';
  }
  if (value.length < 6) {
    return 'Username must be at least 6 characters';
  }
  if (value.length > 20) {
    return 'Username must be less than 20 characters';
  }
  if (!RegExp(r'^[a-zA-Z0-9_.]+$').hasMatch(value)) {
    return 'Username must contain only letters, numbers, _, and .';
  }
  if (value.contains(' ')) {
    return 'Username must not contain spaces';
  }
  return null;
};
