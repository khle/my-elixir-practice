pub fn reverse(input: &str) -> String {    
    let mut reversed = String::from("");
    for c in input.chars().rev() {
        reversed.push(c);
    }
    reversed
}
