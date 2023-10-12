# @label Primary Button
# @display Primary Color
# @logical_path app/helpers/button_helper
class ButtonPreview < Lookbook::Preview
  layout "preview"
  include Components::ButtonHelper
  include ComponentsHelper

  # Default Button
  # ----------------
  # This example uses dynamic preview parameters
  # which can be edited live in the Lookbook UI
  #
  # @param text
  # @param variant select [sm, md, lg, xl, xxl]
  def default(text: "Speichern", variant: "lg")
    render_button text, variant: variant
  end

end