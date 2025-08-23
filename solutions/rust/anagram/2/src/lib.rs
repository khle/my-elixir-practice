use std::collections::{HashMap, HashSet};

pub fn anagrams_for<'a>(word: &str, possible_anagrams: &[&'a str]) -> HashSet<&'a str> {
    let mut result: HashSet<&'a str> = HashSet::new();

    for possible_anagram in possible_anagrams {
        if has_same_dict_data(word, possible_anagram) {
            result.insert(possible_anagram);
        }
    }

    result
}

fn build_dict(word: &str) -> HashMap<char, u32> {
    let mut characters_dict: HashMap<char, u32> = HashMap::new();

    let lowercase_word = word.to_lowercase();
    for c in lowercase_word.chars() {
        let x = characters_dict.entry(c).or_insert(0);
        *x += 1;
    }

    characters_dict
}

fn has_same_dict_data(word1: &str, word2: &str) -> bool {
    if word1.to_lowercase() == word2.to_lowercase() {
        return false;
    }
    
    let dict1 = build_dict(word1);
    let dict2 = build_dict(word2);

    for key in dict1.keys() {
        if !dict2.contains_key(key) {
            return false;
        }
        if dict1.get(key) != dict2.get(key) {
            return false;
        }
    }
    for key in dict2.keys() {
        if !dict1.contains_key(key) {
            return false;
        }
    }

    true
}
