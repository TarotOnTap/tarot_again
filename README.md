# tarot_again

A hobby project to create a cross-platform application for reading and exploring tarot, for fun and
insights. It is very much a work in progress.

## Getting Started

### Setting up the dev environment

This project is written in [Dart](https://dart.dev/) and uses the [Flutter](https://flutter.dev)
cross-platform framework for presentation. Install these following the
instructions found at the Flutter website; installing Flutter automatically
installs the Dart SDK and tooling.

This project uses [Android Studio](https://developer.android.com/studio) as its
IDE, so you'll need to set that up after getting Flutter installed.

### Preparing to run the app

Clone this repository into a directory. Android Studio has git and github
built in, and you can use those or the command line or GUI tools to do the
job.

Then, run the code generator to generate files necessary for
compilation.

Open Android Studio's terminal (or, open a regular terminal
and `cd` into the project directory))

In the terminal, run
```dart run build_runner build```

to generate files necessary for a successful application build. Don't try to use
Android Studio's `Build` menu for this; that runs the compiler build step
instaed of the code generator build step.

### Run the app

Once you've done all that, you can use Android Studio's usual application
tools to compile all the code and run it.

Alternatively, you can run the app from the terminal with

```flutter run```

### Code testing

If you want to develop with this project, use the terminal to run

```flutter test```

See the [Flutter documentation](https://flutter.dev/docs/testing) for
more information.

Have fun!
