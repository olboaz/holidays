class PdfMailer < ApplicationMailer

  # default from: 'toto'
  layout 'pdf'

  def order_mailer(order)

    @orderpdf = order
    @restaurant = params[:rest]
    attachments.inline["logo.png"] = File.read("#{Rails.root}/app/assets/images/logolimofavicon.png")
    #attachments.inline["cart.png"] = File.read("#{Rails.root}/app/assets/images/cartmail.png")

    attachments["#{Date.today.strftime('%d%m%Y')}-Commande n°: #{order.name}"] = {
      mime_type: 'application/pdf',
      content: rendered_pdf(order)
    }
    email_with_name = "#{order.name} <#{@restaurant.email}>"
    email_with_namebis = "#{order.name} <commandes@limo-app.com>"

    headers['Return-Receipt-To'] = email_with_name
    headers['Disposition-Notification-To'] = email_with_name
    headers['X-Confirm-Reading-To'] = email_with_name
    headers['X-No-Spam'] = 'True'

    # pour gmail, le from & le reply_to doivent être identique pour pouvoir faire le reply_to
    mail( from: email_with_namebis,
          reply_to: email_with_name,
          bcc: email_with_name,
          to: order.email,
          subject: "#{@restaurant.username} - Commande n°: #{order.name}"
          )
    end

  private

  def rendered_pdf(order)
    WickedPdf.new.pdf_from_string(rendered_view(order))
    # WickedPdf.new.pdf_from_string(template: "orders/show.pdf.erb")
  end

  def rendered_view(order)
    render_to_string(template: 'places/show.pdf.erb', locals: { order: @orderpdf }, layout: 'pdf.html')
  end

end
