# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Account.destroy_all

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
      user_id: 1
  }

  contas.push(new_conta)
end

# Save the fake data to database
Account.create(contas)

puts "5 contas do usuário 1 foram criadas."