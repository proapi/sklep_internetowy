# encoding: utf-8

class Order < ActiveRecord::Base
  belongs_to :client
  belongs_to :pack_machine
  has_many :order_items, :order => "id asc"

  before_create :check_params
  after_create :send_mail, :add_hits_quantity

  validates_presence_of :street, :city, :building_no, :code, :full_name
  validates :email, presence: true, confirmation: true, email: true
  validates_acceptance_of :agreement, :accept => true
  validates_presence_of :payment
  validates_presence_of :delivery_method
  validates_presence_of :pack_machine_id, :if => lambda { self.delivery_method.eql?("Paczkomaty InPost") }
  validates_numericality_of :pack_machine_id, :if => lambda { self.delivery_method.eql?("Paczkomaty InPost") }, :only_integer => true, :message => '- nie wybrano prawidłowej wartości'
  validates_inclusion_of :payment, :in => [0, 2], :if => lambda { self.delivery_method.eql?("Paczkomaty InPost") }, :message => '- nie wybrano prawidłowej wartości'

  #tak musi na tą chwilę zostać, żeby odfiltrować stare zamówienia
  default_scope where("status > 0")

  def self.payments
    ['Przedpłata przelewem na konto', 'Płatność gotówką przy odbiorze', 'Płatności on-line PayU']
  end

  def recalculate
    result = 0.0
    for order_item in order_items
      unless order_item.product.nil?
        result += order_item.product.final_price.to_f * order_item.quantity
      end
    end
    self.total = result
  end

  # method written to achieve backwards compatibility
  #def recalculate_deliveries
  #  result = 0.0
  #  if payment.eql?(1)
  #    result = 10.5
  #  end
  #  self.delivery_payment = result
  #end

  def check_params
    self.number = "#{get_next_number}/#{Time.now.year}"
    self.status = 2
  end

  # TODO koniecznie odkomentować!!! po deploy na production
  def send_mail
    #OrderMailer.order_1(self, false).deliver
    #OrderMailer.order_1(self, true).deliver
  end

  def get_next_number
    connection.select_value("SELECT nextval('order_number_seq')")
  end

  def status_text
    text = case self.status
             when 0
               "Nowe"
             when 2
               "W realizacji"
             when 3
               "Zrealizowane"
             when 4
               "Przedsprzedaż"
             when 5
               "Powiadomienie"
             when 6
               "Anulowane"
             else
               "Błąd statusu!"
           end
    text
  end

#dodane wg railscasts
  attr_writer :current_step

  def current_step
    @current_step || steps.first
  end

  def steps
    %w[step_1 step_2 step_3]
  end

  def next_step
    self.current_step = steps[steps.index(current_step)+1]
  end

  def previous_step
    self.current_step = steps[steps.index(current_step)-1]
  end

  def first_step?
    current_step == steps.first
  end

  def last_step?
    current_step == steps.last
  end

  def all_valid?
    steps.all? do |step|
      self.current_step = step
      valid?
    end
  end

  private
  def add_hits_quantity
    order_items.each do |order_item|
      product = Product.find_by_id(order_item.product_id)
      if product
        product.update_attribute(:hits_quantity, product.hits_quantity + order_item.quantity)
      end
    end
  end

end
