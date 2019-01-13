require('pry-byebug')
require_relative("./models/customer")
require_relative("./models/film")
require_relative("./models/ticket")

Customer.delete_all()
Film.delete_all()
Ticket.delete_all()

customer1 = Customer.new({'name' => 'Paul', 'funds' => 20})
customer1.save
customer2 = Customer.new({'name' => 'John', 'funds' => 50})
customer2.save
customer3 = Customer.new({'name' => 'Ringo', 'funds' => 10})
customer3.save
customer4 = Customer.new({'name' => 'George', 'funds' => 1})
customer4.save

film1 = Film.new({'title' => 'RocoCop', 'price' => 5})
film1.save
film2 = Film.new({'title' => 'Star Wars', 'price' => 1})
film2.save
film3 = Film.new({'title' => 'Lord of the Rings', 'price' => 10})
film3.save

ticket1 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film1.id})
ticket1.save
ticket2 = Ticket.new({'customer_id' => customer3.id, 'film_id' => film3.id})
ticket2.save
ticket3 = Ticket.new({'customer_id' => customer3.id, 'film_id' => film2.id})
ticket3.save
ticket4 = Ticket.new({'customer_id' => customer2.id, 'film_id' => film3.id})
ticket4.save
ticket4.save
ticket5 = Ticket.new({'customer_id' => customer4.id, 'film_id' => film3.id})
ticket5.save
ticket6 = Ticket.new({'customer_id' => customer4.id, 'film_id' => film1.id})
ticket6.save

film2.title = 'Star Trek'
film2.save

binding.pry
nil
