class InformMailer < ApplicationMailer

  def data_uploaded(email, users, transactions)
    @users = users
    @email = email
    @transactions = transactions
    mail to: "rajan4436@gmail.com", subject: "Your data has been uploaded"
  end
end
