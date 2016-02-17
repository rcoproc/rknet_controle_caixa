# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

AccountAppointment.transaction do
  AccountAppointment.delete_all
end

# Destroy with and without scope(active:false)
Account.transaction do
  Account.unscoped.delete_all
end

User.transaction do
  User.delete_all
end

user1 = User.create(name: 'RCO', email: 'caixa@gmail.com', password: '12345678', password_confirmation: '12345678')
user2 = User.create(name: 'Ricardo', email: 'financeiro@gmail.com', password: '12345678', password_confirmation: '12345678')



contas = []

puts "Aguarde, criando contas..."

5.times do |c|
  puts  "Conta #{c}"
  new_conta = {
      name: "Conta #{c}",
      bank: "BANCO 00#{c}",
      bank_office: "Ag. CENTRO",
      active: true,
      initial_balance: 1000,
      user_id: user1.id
  }

  contas.push(new_conta)
end

# Save the fake data to database
Account.create(contas)

puts "5 contas do usuário 1 foram criadas."

Account.create( name: 'Conta Usuario 2 BNDES', bank: 'BANCO BNDES', bank_office: "Ag. DF", active: true, initial_balance: 1, user_id: user2.id)
Account.create( name: 'Conta Usuario 2 CAIXA', bank: 'CEF', bank_office: "Ag. DF", active: true, initial_balance: 1, user_id: user2.id)

puts "2 conta do usuário 2 foram criadas."
