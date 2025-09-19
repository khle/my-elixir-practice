/// Check a Luhn checksum.
pub fn is_valid(code: &str) -> bool {
    const RADIX: u32 = 10;
    let mut output: Vec<u32> = Vec::new();
    let mut valid = true;
    let mut i = 0;
    for c in code.chars().rev() {        
        match c.to_digit(RADIX) {
            Some(digit) => {
                if i % 2 == 0 {
                    output.push(digit);
                } else {
                    let digit_times_2 = c.to_digit(RADIX).unwrap() * 2;
                    if digit_times_2 > 9 {
                        output.push(digit_times_2 - 9);
                    } else {
                        output.push(digit_times_2);
                    }
                }
                i += 1;
            },
            None => {
                valid = c == ' ';                
            },
        }                
    }

    if valid && output.len() > 1 {
        let sum: u32 = output.iter().sum();        
        sum % 10 == 0
    } else {
        false
    }
}
