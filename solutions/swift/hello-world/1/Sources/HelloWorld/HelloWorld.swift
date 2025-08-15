func hello(name: String? = nil) -> String {
  if (name == nil) {
    return "Hello, World!"                     
  } else {
    return "Hello \(name!)"     
  }
}
