def fun_name3(start, end_, mappings)
  mapped = []
  unmapped = [[start, end_]]

  mappings.each do |dst, src, len|
    m = []
    unmapped.each do |start, end_|
      fun_name2(start, end_, src, len, m, mapped, dst)
    end
    unmapped = m
  end

  mapped.concat(unmapped)
end

def fun_name2(start, end_, src, len, m, mapped, dst)
  a = [start, [end_, src].min]
  b = [[start, src].max, [src + len, end_].min]
  c = [[src + len, start].max, end_]

  m << a if a[0] < a[1]
  mapped << [b[0] - src + dst, b[1] - src + dst] if b[0] < b[1]
  m << c if c[0] < c[1]
end

def parse_maps(s)
  s.split("\n")[1..].map { |l| find_ranges(l) }
end

def find_ranges(l)
  l.split.map(&:to_i)
end

def p2(seeds, layers)
  seeds = make_seeds(seeds)
  locations = make_locations(layers, seeds)
  locations.map { |r| r[0] }.min
end

def make_locations(layers, seeds)
  layers.reduce(seeds) do |seeds, mappings|
    seeds.flat_map { |start, end_| fun_name3(start, end_, mappings) }
  end
end

def make_seeds(seeds)
  seeds.each_slice(2).map { |a, len| [a, a + len] }
end

def part2(input)
  seeds, rest = input.split("\n\n")
  seeds = seeds.split[1..].map(&:to_i)
  layers = rest.strip.split("\n\n").map { |s| parse_maps(s) }
  p2(seeds, layers)
end

if __FILE__ == $PROGRAM_NAME
  input = File.read('input.txt')
  p part2(input)
end
