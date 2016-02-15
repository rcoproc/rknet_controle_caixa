module ModelUtil
  extend ActiveSupport::Concern

  def date_br(field)
    field.strftime("%d/%m/%Y")
  end

  def money_number_br(field)
    # field.to_currency(Currency::BRL)
    ActionController::Base.helpers.number_to_currency(field)
  end

  def number_br(field)
    field.to_currency
  end

end