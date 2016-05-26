# Application-wide view logic to clean up any templates
module ApplicationHelper

  ##
  # Determines which http verb to apply to a form.
  # @return [Symbol] verb of either :post or :patch.
  def form_action
    current_page?(action: :edit) ? :patch : :post
  end
end
