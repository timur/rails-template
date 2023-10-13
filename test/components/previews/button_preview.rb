# @label Buttons
# @display Primary Color
# @logical_path app/helpers/button_helper
class ButtonPreview < Lookbook::Preview
  layout "preview"
  include Components::ButtonHelper
  include ComponentsHelper
  include InlineSvg::ActionView::Helpers  

  # Default Button
  # ----------------
  # This example uses dynamic preview parameters
  # which can be edited live in the Lookbook UI
  #
  # @param text
  # @param variant select [sm, md, lg, xl, xxl]
  def primary(text: "Speichern", variant: "lg")
    render_primary_button text, variant: variant
  end

  # Secondary Button
  # ----------------
  # This example uses dynamic preview parameters
  # which can be edited live in the Lookbook UI
  #
  # @param text
  # @param variant select [sm, md, lg, xl, xxl]
  def secondary(text: "Speichern", variant: "lg")
    render_secondary_button text, variant: variant
  end

  # Primary Rounded Button
  # ----------------
  # This example uses dynamic preview parameters
  # which can be edited live in the Lookbook UI
  #
  # @param text
  # @param variant select [sm, md, lg, xl, xxl]
  def primary_rounded(text: "Speichern", variant: "lg")
    render_primary_rounded_button text, variant: variant
  end

  # Secondary Rounded Button
  # ----------------
  # This example uses dynamic preview parameters
  # which can be edited live in the Lookbook UI
  #
  # @param text
  # @param variant select [sm, md, lg, xl, xxl]
  def secondary_rounded(text: "Speichern", variant: "lg")
    render_secondary_rounded_button text, variant: variant
  end

  # Primary Icon Leading Button
  # ----------------
  # This example uses dynamic preview parameters
  # which can be edited live in the Lookbook UI
  #
  # @param text
  # @param variant select [sm, md, lg, xl, xxl]
  def primary_leading_icon(text: "Speichern", variant: "lg")
    render_primary_leading_icon_button text, variant: variant do
      inline_svg_tag "heroicons-users.svg", class: "-ml-0.5 h-5 w-5"
    end
  end

  # Primary Icon Trailing Button
  # ----------------
  # This example uses dynamic preview parameters
  # which can be edited live in the Lookbook UI
  #
  # @param text
  # @param variant select [sm, md, lg, xl, xxl]
  def primary_trailing_icon(text: "Speichern", variant: "lg")
    render_primary_trailing_icon_button text, variant: variant do
      inline_svg_tag "heroicons-users.svg", class: "-ml-0.5 h-5 w-5"
    end
  end
  
  # Circular Icon Button
  # ----------------
  # This example uses dynamic preview parameters
  # which can be edited live in the Lookbook UI
  #
  # @param text
  # @param variant select [sm-rounded, md-rounded, lg-rounded]
  def circular_icon(text: "", variant: "sm-rounded")
    render_circular_icon_button text, variant: variant do
      inline_svg_tag "heroicons-plus.svg", class: "h-5 w-5"
    end
  end   
end