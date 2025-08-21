use std::fmt::{Display, Formatter, Result};

#[derive(Debug, Eq)]
pub struct Clock {
    hours: i32,
    minutes: i32,
}

fn convert_to_hours_and_minutes(hours: i32, minutes: i32) -> (i32, i32) {
    let total_minutes = hours * 60 + minutes;
    let mut h: i32 = (total_minutes / 60) %24;
    let mut m: i32 = total_minutes % 60;
    
    if m < 0 {
        m += 60;
        h -= 1;
    }

    if h < 0 {
        h = (h + 24) %24;
    }
        
    println!("Exiting convert_to_hours_and_minutes {h}, {m}.");

    (h, m)
}

impl Clock {    
    pub fn new(hours: i32, minutes: i32) -> Self {        
        let (h, m) = convert_to_hours_and_minutes(hours, minutes);
        println!("In function constructor {h}, {m}.");
        Clock { hours: h, minutes: m }
    }

    pub fn add_minutes(&self, min: i32) -> Self {
        Clock::new(self.hours, self.minutes + min)
    }
}

impl Display for Clock {
    fn fmt(&self, f: &mut Formatter<'_>) -> Result {        
        write!(f, "{:02}:{:02}", self.hours, self.minutes)
    }
}

impl PartialEq for Clock {
    fn eq(&self, other: &Self) -> bool {
        self.hours == other.hours && self.minutes == other.minutes
    }
}
