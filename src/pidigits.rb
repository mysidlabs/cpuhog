# Originally contirbuted to The Computer Language Benchmarks Game
# by Aaron Tavistock
# https://salsa.debian.org/benchmarksgame-team/benchmarksgame/

# Modified by Matt Godby for creation of load-generation microservice

# Leverage GMP like all the other languages
require 'gmp'

# Helpers that improve readability
class GMP::Z
  def mul!(a,b)
    GMP::Z.mul(self, a, b)
  end

  def times!(a)
    GMP::Z.mul(self, self, a)
  end
end

class PiRun
  def initialize
    @ZERO = GMP::Z(0)
    @ONE = GMP::Z(1)
    @TWO = GMP::Z(2)
    @THREE = GMP::Z(3)
    @TEN = GMP::Z(10)

    # Allocate these expensive objects once
    @display_chunk = GMP::Z(0)
    @k = GMP::Z(0)
    @a = GMP::Z(0)
    @t = GMP::Z(0)
    @u = GMP::Z(0)
    @k1 = GMP::Z(1)
    @n = GMP::Z(1)
    @d = GMP::Z(1)
    @tmp = GMP::Z(0)
  end

  def self.next_chunk
    @tmp.mul!(@d, @t)
    @a.sub!(@tmp)
    @a.times!(@TEN)
    @n.times!(@TEN)
  end

  def self.produce_chunk
    @k.add!(@ONE)
    @t.mul!(@n, @TWO)
    @n.times!(@k)

    @a.add!(@t)
    @k1.add!(@TWO)
    @a.times!(@k1)
    @d.times!(@k1)

    if @a >= @n
      @tmp.mul!(@n, @THREE)
      @tmp.add!(@a)
      @t = @tmp.fdiv(@d)
      @u = @tmp.fmod(@d)
      @u.add!(@n)
      if @d > @u
        @display_chunk.times!(@TEN)
        @display_chunk.add!(@t)
        return true
      end
    end

    false
  end

  def self.run(dignum)
    @ZERO = GMP::Z(0)
    @ONE = GMP::Z(1)
    @TWO = GMP::Z(2)
    @THREE = GMP::Z(3)
    @TEN = GMP::Z(10)

    # Allocate these expensive objects once
    @display_chunk = GMP::Z(0)
    @k = GMP::Z(0)
    @a = GMP::Z(0)
    @t = GMP::Z(0)
    @u = GMP::Z(0)
    @k1 = GMP::Z(1)
    @n = GMP::Z(1)
    @d = GMP::Z(1)
    @tmp = GMP::Z(0)

    n = (dignum || 100).to_i
    count = 0

    runout = {}

    while(count < n) do
      if produce_chunk
        count += 1
        if count % 10 == 0
          # Uncomment the next line for STDOUT during calculation
          # STDOUT.write "%010d\t:%d\n" % [@display_chunk.to_i, count]
          runout[count] = @display_chunk.to_s.ljust(10)
          @display_chunk.times!(@ZERO)
        end
        next_chunk
      end
    end

    if @display_chunk.to_i > 0
      # Uncomment the next line for STDOUT during calculation
      # STDOUT.write "%s\t:%d\n" % [@display_chunk.to_s.ljust(10), count]
      runout[count] = @display_chunk.to_s.ljust(10)
    end

    puts(runout)
    runout
  end
end
