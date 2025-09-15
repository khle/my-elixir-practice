pub fn annotate(garden: &[&str]) -> Vec<String> {
    let mut flowers: Vec<String> = Vec::new();
    for i in 0..garden.len() {
        let mut characters: Vec<char> = Vec::new();

        for (j, c) in garden[i].chars().enumerate() {
            if c == '*' {
                characters.push(c);
            } else {
                let mut count = 0;
                //row above
                if check_neighbor(garden, i as i32 - 1, j as i32 - 1) {
                    count += 1;
                }
                if check_neighbor(garden, i as i32 - 1, j as i32) {
                    count += 1;
                }
                if check_neighbor(garden, i as i32 - 1, j as i32 + 1) {
                    count += 1;
                }

                //current row
                if check_neighbor(garden, i as i32, j as i32 - 1) {
                    count += 1;
                }
                if check_neighbor(garden, i as i32, j as i32 + 1) {
                    count += 1;
                }

                //row below
                if check_neighbor(garden, i as i32 + 1, j as i32 - 1) {
                    count += 1;
                }
                if check_neighbor(garden, i as i32 + 1, j as i32) {
                    count += 1;
                }
                if check_neighbor(garden, i as i32 + 1, j as i32 + 1) {
                    count += 1;
                }

                if count > 0 {
                    //characters.push(count as u8 as char);
                    characters.push((count as u8 + b'0') as char);
                } else {
                    characters.push(' ');
                }
                /*
                The problem is on the following line:

                characters.push(count as u8 as char);

                This line is converting the numeric count (which can be 0, 1, 2, 3, etc.) directly to a character. When the count is 3, it's being converted to the ASCII control character with value 3 (ETX - End of Text), which displays as \u{3}.

                What you want is to convert the number to its character representation (e.g., 3 → '3', not 3 → control character).

                What was the problem?
                The original code was converting the neighbor count directly to a character using count as u8 as char. When the count was 3, this created the ASCII control character with value 3 (ETX - End of Text), which displays as \u{3}.

                The fix:
                Change from:

                characters.push(count as u8 as char);

                to:

                characters.push((count as u8 + b'0') as char);

                This converts the numeric count to its character representation (3 → '3', 2 → '2', etc.) instead of to a control character. The + b'0' adds the ASCII value of '0' to convert from a number to its character representation.
                */
            }
        }

        flowers.push(characters.into_iter().collect());
    }

    flowers
}

fn check_neighbor(garden: &[&str], i: i32, j: i32) -> bool {
    if i < 0 || j < 0 || i >= garden.len() as i32 || j >= garden[i as usize].len() as i32 {
        false
    }
    else {
        if garden[i as usize].chars().nth(j as usize) == Some('*') {
            true
        } else {
            false
        }
    }
}

fn main() {
    println!("Starting garden...");
    //let garden = vec!["roses", "daisies", "tulips", "sunflowers"];
    let garden = [" * ", "***", "***"];
    println!("{:?}", garden);
    let flowers = annotate(&garden);
    println!("{:?}", flowers);
}
