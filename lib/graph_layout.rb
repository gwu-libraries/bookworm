# frozen_string_literal: true

module GraphLayout
  def degrees_to_radians(degrees)
    degrees * Math::PI / 180
  end

  def circle_point(center_x, center_y, radius, degrees)
    return [
      radius * Math.cos(degrees_to_radians(degrees)) + center_x,
      radius * Math.sin(degrees_to_radians(degrees)) + center_y
    ]
  end
end
