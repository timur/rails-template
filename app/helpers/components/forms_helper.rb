module Components::FormsHelper
  def render_form_with(**opts)
    form_with(**opts.merge(builder: Railsbootstrap::FormBuilder)) do |form|
      yield form
    end
  end

  def render_form_for(obj, **opts)
    form_for(obj, **opts.merge(builder: Railsbootstrap::FormBuilder), html: opts) do |form|
      yield form
    end
  end
end
