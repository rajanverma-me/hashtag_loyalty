# Preview all emails at http://localhost:3000/rails/mailers/inform_mailer
class InformMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/inform_mailer/data_uploaded
  def data_uploaded
    InformMailer.data_uploaded
  end

end
