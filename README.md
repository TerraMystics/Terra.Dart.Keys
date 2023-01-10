<br/>
<p align="center">
    <a href="https://github.com/TerraMystics"><img src="https://github.com/TerraMystics/Terra.Dart.Keys/blob/main/Dart.svg" align="center" width=350/></a>
</p>

<p align="center">
A lightweight key management library for the terra ecosystem

</p>
<br/>

<p align="center">
  <a href="https://github.com/TerraMystics/Terra.Dart.Keys/blob/main/LICENSE.md">
  <img alt="GitHub" src="https://img.shields.io/github/license/terra-money/terra.js">
  </a>

  <a href="https://pub.dev/packages/terra_dart_keys">
  <img alt="GitHub" src="https://img.shields.io/pub/v/terra_dart_keys">
  </a>
  
  
  <a href="https://pub.dev/packages/terra_dart_keys">
  <img alt="GitHub" src="https://img.shields.io/pub/likes/terra_dart_keys?color=red">
  </a>
</p>

<p align="center">
  <a href="https://docs.terra.money/"><strong>Explore the Docs »</strong></a>
  <br />
  <br/>
  <a href="https://github.com/TerraMystics/Terra.Dart.Keys/tree/main/example/terra_dart_example">Example App</a>
  ·
  <a href="https://github.com/TerraMystics/Terra.Dart.Keys/blob/main/README.md">API Reference</a>
  ·
  <a href="https://pub.dev/packages/terra_dart_keys">Pub Package</a>
  ·
  <a href="https://github.com/TerraMystics/Terra.Dart.Keys">GitHub</a>
</p>

A lightweight key management library for dart

## Features

- **Written in Dart**, with type definitions
- Works with the Flutter & Dart Ecosystems, in the browser, and Mobile
- Easy & Versatile support for [key management](https://docs.terra.money/develop/feather-js/keys) solutions for anyone building on the Terra Ecosystem

## Installation & Configuration

Grab the latest version off [Pub](https://pub.dev/packages/terra_dart_keys)

```sh
dart pub add terra_dart_keys
```

## Usage

This package can be used for Mobile & Web Developers, or SDK Developers looking to extend the Terra Platform

### Generating a Mnemonic Key

```dart
MnemonicKey GenerateMnemonic() {

  // Create a key out of a mnemonic string (recovery words)
  string recoveryWords = "notice oak worry limit wrap speak medal online prefer cluster roof addict wrist behave treat actual wasp year salad speed social layer crew genius";

  // If creating a random mnemonic, don't pass the recovery words
  return MnemonicKey(recoveryWords);
}

//ONLY FOR TESTING & DEVELOPMENT PURPOSES: DO NOT EXPOSE PRIVATE KEY, IT COULD RISK EXPOSING THE WALLET FUNDS IF LOST
MnemonicKey GenerateMnemonicWithPrivateKey() {

  string recoveryWords = "notice oak worry limit wrap speak medal online prefer cluster roof addict wrist behave treat actual wasp year salad speed social layer crew genius";

  // Create a key out of a mnemonic string (recovery words)
  var mnmonic =  MnemonicKey(recoveryWords, exposePrivateKey: true);

  print("PrivateKey: ${mnmonic.privateKeyExposed}");

  return mnmonic;
}
```

## License

This software is licensed under the MIT license. See [LICENSE](https://github.com/TerraMystics/terra_dart_keys/blob/main/LICENSE) for full disclosure.

© 2022 TerraMystics.
