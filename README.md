# movies

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

## Instructions

### Android

1. on Terminal, run below command

- flutter clean
- flutter pub get

2. Run on Physical or Emulator device

### iOS

#### Intel Chip

1. On Terminal, run below command

   - flutter clean
   - flutter pub get
   - sudo xcode-select -r
   - input your local password
   - sudo gem install ffi
   - cd ios
   - pod install

2. Run on iOS Physical or Emulator device

#### M1 and above Chips

1. On Terminal, run below command

   - flutter clean
   - flutter pub get
   - sudo xcode-select -r
   - input your local password
   - sudo arch -x86_64 gem install ffi
   - cd ios
   - arch -x86_64 pod install

2. Run on iOS Physical or Emulator device

## Generate IPA / APK / AAB

### IPA

1. Run The command for iOS Above
2. Run the command below

- flutter build ipa --target (ex : lib/main_development.dart) --flavor (development)

3. Use Transporter App on MacOS to send your IPA to AppStore Connect

### APK

1. Run the command for Android Above
2. Run the command below

- flutter build apk --target (ex : lib/main_development.dart) --flavor (development)

3. Distribute your apk to your preferences (Ex : Firebase Distribution or PlayStore Console)

### AAB

1. Run the command for Android Above
2. Run the command below

- flutter build appbundle --target (ex : lib/main_development.dart) --flavor (development)

3. Distribute your appbundle to your preferences (Ex : Firebase Distribution or PlayStore Console)
