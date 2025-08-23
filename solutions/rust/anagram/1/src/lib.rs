use std::collections::{HashMap, HashSet};

pub fn anagrams_for<'a>(word: &str, possible_anagrams: &[&'a str]) -> HashSet<&'a str> {
    let mut result: HashSet<&'a str> = HashSet::new();

    println!(
        "For the '{word}' word find anagrams among the following words: {possible_anagrams:?}"
    );

    let dict_for_word = build_dict(word);

    for possible_anagram in possible_anagrams {
        println!("{possible_anagram}");
        let dict_for_possible_anagram = build_dict(possible_anagram);

        if has_same_dict_data(&dict_for_word, &dict_for_possible_anagram) {
            result.insert(possible_anagram);
        }
    }

    result
}

fn build_dict(word: &str) -> HashMap<char, u32> {
    let mut characters_dict: HashMap<char, u32> = HashMap::new();

    for c in word.chars() {
        let x = characters_dict.entry(c).or_insert(0);
        *x += 1;
    }

    characters_dict
}

fn has_same_dict_data(dict1: &HashMap<char, u32>, dict2: &HashMap<char, u32>) -> bool {
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
