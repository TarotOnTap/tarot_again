/// [SingletonRepository] is the abstract class above all repositories.
/// It does have a constructor, and all sublcasses must call [super] with no arguments.
///
abstract class SingletonRepository {
  /// This constructor does one thing - it registers the newly created instance of this
  /// type with GetIt.  This has the potential to be messy if the constructor is called
  /// more than once, so don't.
}
