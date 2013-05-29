# encoding: utf-8

class OrderMailer < ActionMailer::Base
  default from: "PROAPI Michał Pawelski <kontakt@proapi.pl>"

  def order_1(order, shop)
    @order = order
    shop ? (to = "PROAPI Michał Pawelski <kontakt@proapi.pl>") : (to = "#{order.full_name} <#{order.email}>")
    shop ? (reply_to = "#{order.full_name} <#{order.email}>") : (reply_to = "PROAPI Michał Pawelski <kontakt@proapi.pl>")
    mail(to: to, subject: "Zamówienie nr #{order.number}", reply_to: reply_to)
  end

  def order_2(order)
    @order = order
    mail(to: "#{order.full_name} <#{order.email}>", subject: "Zmiana statusu zamówienia nr #{order.number}")
  end

  def client_message(message)
    @message = message
    mail(to: "#{message.name} <#{message.email}>", subject: message.title)
  end

  def password_reset_instructions(client)
    @client = client
    mail(to: "#{client.full_name} <#{client.email}>", subject: "Instrukcje zmiany hasła na nowe")
  end

end
