# SwiftNFCClosureHandler

**SwiftNFCClosureHandler** is a Swift package for scanning NFC tags on iOS for your SwiftUI projects.

The scanned NFC data is returned as a Swift Data via closure. You can then massage the data to your specific needs.

## How to

Once you import the Swift package to your project, this is what you can do:

```swift
import SwiftNFCClosureHandler

struct ContentView: View {
    // Declare a @StateObject for the SwiftNFCClosureHandler
    @StateObject var nfc: SwiftNFCClosureHandler = SwiftNFCClosureHandler()

    // Your button code
    ...
    Button(action: {
        nfc.begin(action: { data in
                if let string = String(data: data, encoding: .ascii) {
                    self.nfc_value = string
                }
            })
        }) {
            Text("Click to Scan")
        }
    ...

}

```

## Setup

Here is the step-by-step guide at getting your SwiftUI project running with **SwiftNFCClosureHandler**:

1. Open the `File` menu at XCode, then select `Add the packages`. Pasted the URL https://github.com/pulsely/SwiftNFCClosureHandler at the search box.

2. Then, click the project name at the Project Panel, and select `Signing & Capabilities`. Add the `Near Field Communication Tag Reading` capability to your project.

3. For your project target, select `Info`, and add the `Privacy - NFC Scan Usage Description` as a string property with your privacy message of choice.

4. Now, make sure you have linked `CoreNFC.framework` at the `Build Phases` of your target.

5. Add your own SwiftUI code.

## Sample code

Sample project for using the **SwiftNFCClosureHandler** will be available.

## License

The **SwiftNFCClosureHandler** Swift package is licenced under the MIT License.
