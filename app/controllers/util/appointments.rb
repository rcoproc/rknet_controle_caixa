# require 'date'
# require 'time'

class AppTransfer
  include ModelUtil
  def self.call(conta_origem_id, conta_destino_id, value_debt)

    account = Account.find(conta_origem_id) # I need actual balance

    if account
      tax_value = tax_value(value_debt)

      if ((account.balance - tax_value - value_debt) >= 0)

        # Atomicity Control
        AccountAppointment.transaction do

          # Transfer Debt
          @lancto_origem = AccountAppointment.create(:account_id => conta_origem_id,
                                          date: Date.current, description: 'SAIDA P/ TRANSFERÊNCIA', deb_cre: 'D', value: value_debt , document: "CONTA: #{conta_destino_id}" )

          # Tax Debt
          @lancto_origem = AccountAppointment.create(:account_id => conta_origem_id,
                                                     date: Date.current, description: 'TAXA DE TRANSFERÊNCIA', deb_cre: 'D', value: tax_value )

          # Credit in Target Account
          @lancto_destino = AccountAppointment.create(:account_id => conta_destino_id,
                                           date: Date.current, description: 'TRANSFERENCIA', deb_cre: 'C', value: value_debt, document: "TRANSF. DA CC: #{conta_origem_id}"  )
          msg = 'Transferência realizada com Sucesso!'
        end
      else
        msg = "Saldo insuficiente descontado o valor da TAXA de #{ActionController::Base.helpers.number_to_currency(tax_value)}, operação não realizada"
      end

    else
      msg = "Conta ORIGEM - Cód. #{conta_origem_id} não encontrada!"
    end

    return msg

  end

  def self.tax_value(value_debt)
    # Debita o valor das taxas conforme a regra
    # Segunda a sexta-feira 9 as 18 a taxa é 5 reais
    #                       Fora deste horário é de 7 reais
    # Acima de 1000 , adicional de 10 reais

    # Date and time Local( Time Zone de São Paulo )
    date_transf = Time.current

    week_day = date_transf.wday # onde 0 é domingo
    hour = date_transf.hour

    normal_day = *(1..5) # Segunda a Sexta
    if normal_day.include?(week_day) and (hour >= 9 and hour <= 18)
      tax = 5
    else
      tax = 7
    end

    if (value_debt > 1000) # Acima de 1000 , adicional de 10 reais
      tax += 10
    end

    return tax
  end

end