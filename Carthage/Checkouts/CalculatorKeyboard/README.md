# CalculatorKeyboard [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage) [![Build Status](https://travis-ci.org/sprint84/CalculatorKeyboard.svg?branch=master)](https://travis-ci.org/sprint84/CalculatorKeyboard) [![GitHub release](https://img.shields.io/badge/version-1.0.3-brightgreen.svg)]()

![CalculatorKeyboard Screenshot](./Screenshot.png?raw=true)

## Usage

To run the example project, clone the repo, and open the 'Example/Example.xcodeproj' file.

## Requirements

This component is written using Swift and Dynamic Frameworks, so iOS 8.x is required. However you may want to manually import the source files into your project, if you need to support 7.x.

## Installation

RFCalculatorKeyboard is available through [Carthage](https://github.com/Carthage/Carthage). To install
it, simply add the following line to your Cartfile:

```ruby
github "sprint84/CalculatorKeyboard" ~> 1.0
```

###Installing Carthage

To install the `carthage` tool on your system, please download and run the `Carthage.pkg` file for the latest release, then follow the on-screen instructions.

Alternately, you can use Homebrew and install the `carthage` tool on your system simply by running brew update and `brew install carthage`.

For further details, please visit the [Carthage Github page](https://github.com/Carthage/Carthage)

##Usage

Using `CalculatorKeyboard` is quite simple. First you need to import the Framework

```swift
import CalculatorKeyboard
```

Then instantiate the view and apply it to a text input (`UITextField` or `UITextView`).

```swift
let calcInputView = CalculatorKeyboard(frame: frame)
calcInputView.delegate = self
textField.inputView = calcInputView
```

`CalculatorKeyboard` uses a delegate to report back the values. That way, you have the flexibility to format the text the way you want before displaying to the user.

```swift
func calculator(calculator: CalculatorKeyboard, didChangeValue value: String) {
	valueTextField.text = value
}
```

### Customization
`CalculatorKeyboard` supports some layout customizations.

```swift
// Show/Hide decimal button in keyboard. When hidden, the decimal input begin from the least
// significative cent. Eg. 0.00 -> 0.02 -> 0.25 -> 2.50
showDecimal: Bool 

numbersBackgroundColor: UIColor
numbersTextColor: UIColor
operationsBackgroundColor: UIColor
operationsTextColor: UIColor
equalBackgroundColor: UIColor
equalTextColor: UIColor
```

## Author

Reefactor, Inc., reefactor@gmail.com

## License

CalculatorKeyboard is available under the MIT license. See the LICENSE file for more info.
