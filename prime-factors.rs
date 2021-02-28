macro_rules! repeat {
  ($body:block until $condition:expr) => (
    loop {
      $body
      if $condition { break }
    }
  );
}

fn gcd(a: u32, b: u32) -> u32 {
  if b == 0 { return a; }
  gcd(b, a % b)
}

struct SmallCoprime {
  number: u32,
  coprime: u32
}

impl SmallCoprime {
  fn init(number: u32) -> SmallCoprime {
    SmallCoprime{ number, coprime: 1 }
  }

  fn even_period(&self) -> u32 {
    let mut period = 2;
    repeat!({
       period += 2
    } until self.coprime.pow(period) % self.number == 1);
    period
  }

  fn factors(&self, period: u32) -> (u32, u32) {
    let w = self.coprime.pow(period / 2);
    let p = gcd(self.number, w + 1);
    let q = gcd(self.number, w - 1);
    (p, q)
  }
}

impl Iterator for SmallCoprime {
  type Item = u32;

  fn next(&mut self) -> Option<Self::Item> {
    if self.coprime >= self.number-1 { return None }
    repeat!({
      self.coprime += 1
    } until gcd(self.number, self.coprime) == 1);
    Some(self.coprime)
  }
}

fn solve(number: u32) -> (u32, u32) {
  let mut coprime = SmallCoprime::init(number);
  let mut factors: (u32, u32);
  repeat!({
    coprime.next();
    let period = coprime.even_period();
    factors = coprime.factors(period);
  } until factors.0 < number && factors.1 < number);
  factors
}

fn main() {
  for number in vec![15, 35, 65, 91] {
    println!("The factors of {} are {:?}", number, solve(number));
  }
}