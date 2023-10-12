# @label Basic Button
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
  # @param variant select [default, large, xlarge]
  def default(text: "Speichern", variant: "default")
    render_primary_button text, variant: variant
  end

end