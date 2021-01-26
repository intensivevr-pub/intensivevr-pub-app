abstract class RegisterError{}

class EmailAlreadyExistsError extends RegisterError{}
class EmailIncorrectError extends RegisterError{}
class UsernameTakenError extends RegisterError{}
class UsernameIncorrectError extends RegisterError{}
class UnknownError extends RegisterError{}
class PasswordsDoNotMatchError extends RegisterError{}
class PasswordToShortError extends RegisterError{}
class PasswordToCommonError extends RegisterError{}