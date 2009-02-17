class DatabaseFormEmailer < ActionMailer::Base

  def form_submission form, response
    @recipients   = form.form_email
    @subject      = "#{ form.form_name} form submitted"
    body :form => form, :response => response
  end
end
