# @label SVG Icons
class SvgPreview < Lookbook::Preview
  layout "preview"

  # Users Icon
  # ----------------
  # From Heroicons
  def users
    inline_svg_tag "heroicons-users.svg", class: "text-gray-400"
  end

end