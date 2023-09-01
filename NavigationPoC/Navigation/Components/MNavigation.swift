import SwiftUI
import NavigationBackport

/*
 NavigationStack is only supported from iOS 16.0. I found a library that allows to using NavigationStack and its
 functions on iOS versions < 16.0. (https://github.com/johnpatrickmorgan/NavigationBackport)
 Even though the library used ensures that it's using the native NavigationStack under the hood when the app is running on iOS 16,
 I saw that it's still using some custom modifiers and stuff like that.
 In order to ensure that we are actually really using the native ones, I created those custom "M..." views and modifiers.
 So in the code, we only use those views and modifiers, not the library ones.
 */

public struct MNavigationStack<Root: View, Data: Hashable>: View {
    
    @Binding var path: [Data]
    var root: Root
    
    public init(path: Binding<[Data]>?, @ViewBuilder root: () -> Root) {
        self._path = path ?? .constant([])
        self.root = root()
    }
    
    public var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack(path: $path) {
                root
            }
        } else {
            NBNavigationStack(path: $path) {
                root
            }
        }
    }
}

public extension MNavigationStack where Data == AnyHashable {
  init(@ViewBuilder root: () -> Root) {
    self.init(path: nil, root: root)
  }
}

public struct MNavigationLink<Value: Hashable, Label: View>: View {
    
    var value: Value?
    var label: () -> Label
    
    public var body: some View {
        if #available(iOS 16.0, *) {
            NavigationLink(value: value) {
                label()
            }
        } else {
            NBNavigationLink(value: value) {
                label()
            }
        }
    }
}

public struct MNavigationDestinationModifier<D: Hashable, C: View>: ViewModifier {
    var type: D.Type
    @ViewBuilder var destination: (D) -> C
    
    public func body(content: Content) -> some View {
        if #available(iOS 16.0, *) {
            content
                .navigationDestination(for: type, destination: destination)
        } else {
            content
                .nbNavigationDestination(for: type, destination: destination)
        }
    }
}

public extension View {
  func mNavigationDestination<D: Hashable, C: View>(for pathElementType: D.Type, @ViewBuilder destination builder: @escaping (D) -> C) -> some View {
    return modifier(MNavigationDestinationModifier(type: pathElementType, destination: builder))
  }
}
