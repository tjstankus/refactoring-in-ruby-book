require 'rspec'

class Sparky
  def initialize(tosses=nil, points=nil)
    @num_tosses = 1000
    @tosses = tosses || values(@num_tosses)
    @points = points || init_points
  end

  def spark(centre_x, centre_y, value)
<<SVG_MARKUP
<rect x=\"#{centre_x-2}\" y=\"#{centre_y-2}\"
  width=\"4\" height=\"4\"
  fill=\"red\" stroke=\"none\" stroke-width=\"0\" />
<text x=\"#{centre_x+6}\" y=\"#{centre_y+4}\"
  font-family=\"Verdana\" font-size=\"9\"
  fill=\"red\" >#{value}</text>
SVG_MARKUP
  end

  def svg
    markup = <<SVG_MARKUP
<svg xmlns=\"http://www.w3.org/2000/svg\"
  xmlns:xlink=\"http://www.w3.org/1999/xlink\" >
  <!-- x-axis -->
  <line x1=\"0\" y1=\"200\" x2=\"#{@num_tosses}\" y2=\"200\"
    stroke=\"#999\" stroke-width=\"1\" />
  <polyline fill=\"none\" stroke=\"#333\" stroke-width=\"1\"
    points = \"#{@points.join(' ')}\" />
  #{spark(@num_tosses-1, 200-@tosses[-1], @tosses[-1])}
</svg>
SVG_MARKUP

    markup.prepend(
      "Content-Type: image/svg+xml\nContent-Length: #{markup.length}\n\n")
  end

  private

  def values(n)
    a = [0]
    n.times { a << (toss + a[-1]) }
    a
  end

  def toss
    2 * (rand(2)*2 - 1)
  end

  def init_points
    [].tap do |points|
      @tosses.each_index { |i| points << "#{i},#{200-@tosses[i]}" }
    end
  end
end

RSpec.describe "Sparky" do
  it "emits svg" do
    tosses = [0, 2, 4]
    points = ["0,200", "1,198", "2,196"]
    expect(Sparky.new(tosses, points).svg).to eq(expected_svg)
  end

  def expected_svg
<<SVG_MARKUP
Content-Type: image/svg+xml
Content-Length: 463

<svg xmlns="http://www.w3.org/2000/svg"
  xmlns:xlink="http://www.w3.org/1999/xlink" >
  <!-- x-axis -->
  <line x1="0" y1="200" x2="1000" y2="200"
    stroke="#999" stroke-width="1" />
  <polyline fill="none" stroke="#333" stroke-width="1"
    points = "0,200 1,198 2,196" />
  <rect x="997" y="194"
  width="4" height="4"
  fill="red" stroke="none" stroke-width="0" />
<text x="1005" y="200"
  font-family="Verdana" font-size="9"
  fill="red" >4</text>

</svg>
SVG_MARKUP
  end
end
