#[derive(Debug, PartialEq, Eq)]
pub enum Comparison {
    Equal,
    Sublist,
    Superlist,
    Unequal,
}

//This fn takes 2 lists, start index of the longer list, and only compares exactly
//the number of the elements in the shorter list against the longer list starting at longer_list_index
fn compare_lists(longer_list_index: usize, shorter_list: &[i32], longer_list: &[i32]) -> Comparison {
    let mut i:usize = 0;
    let mut j:usize = longer_list_index;
    let mut keep_going: bool = true;
    let shorter_list_len = shorter_list.len();
    let longer_list_len = longer_list.len();

    if longer_list_index + shorter_list_len > longer_list_len {
        return Comparison::Unequal;
    }

    while keep_going {
        if shorter_list[i] == longer_list[j] {
            i += 1;
            j += 1;
            keep_going = i < shorter_list_len && j < longer_list_len;
        } else {
            keep_going = false;
        }
    }

    if i == shorter_list_len {
        Comparison::Equal
    } else {
        Comparison::Unequal
    }
}

pub fn sublist(first_list: &[i32], second_list: &[i32]) -> Comparison {
    if first_list.is_empty() && second_list.is_empty() {
        Comparison::Equal
    } else if first_list.is_empty() {
        Comparison::Sublist
    } else if second_list.is_empty() {
        Comparison::Superlist
    } else if first_list.len() < second_list.len() {
        let mut j:usize = 0;
        let mut found_match:bool = false;

        while j <= second_list.len() - first_list.len() && !found_match {
            found_match = compare_lists(j, first_list, second_list) == Comparison::Equal;
            j += 1;
        }

        if found_match {
            Comparison::Sublist
        } else {
            Comparison::Unequal
        }
    } else if first_list.len() > second_list.len() {
        let mut j:usize = 0;
        let mut found_match:bool = false;

        while j <= first_list.len() - second_list.len() && !found_match {
            found_match = compare_lists(j, second_list, first_list) == Comparison::Equal;
            j += 1;
        }

        if found_match {
            Comparison::Superlist
        } else {
            Comparison::Unequal
        }
    } else { //2 lists are of equal length
       compare_lists(0, first_list, second_list)
    }

    
}