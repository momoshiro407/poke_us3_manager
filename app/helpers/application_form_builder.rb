class ApplicationFormBuilder < ActionView::Helpers::FormBuilder
  def enum_select(recode, options = {}, html_options = {})
    pluralized = recode.to_s.pluralize
    base = Code.send(pluralized)
    i18n = Code.send("#{pluralized}_i18n")
    select recode.to_sym, base.keys.map { |k| [i18n[k], k]}, options, html_options
  end
end
