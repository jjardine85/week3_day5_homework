require_relative('../db/sql_runner')
require_relative('./customer')

class Film

attr_reader :id
attr_accessor :title, :price

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price'].to_i
  end

  def self.delete_all
    sql = 'DELETE FROM films'
    SqlRunner.run(sql)
  end

  def save
    sql = "INSERT INTO films (title, price)
          VALUES ($1, $2)
          RETURNING id"
    values = [@title, @price]
    film = SqlRunner.run(sql, values)[0]
    @id = film['id'].to_i
  end

  def self.all
    sql = "SELECT * FROM films"
    film_info = SqlRunner.run(sql)
    return film_info.map {|film| Film.new(film)}
  end

  def update
    sql = "UPDATE films (title, price)
    VALUES ($1, $2)
    WHERE id = $3"
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE * FROM films where id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

# shows viewers for a film
  def viewers
  sql = "SELECT customers.*
FROM customers
INNER JOIN tickets
ON customers.id = tickets.customer_id
INNER JOIN films
ON tickets.film_id = films.id
WHERE film_id = $1"
  values = [@id]
  data = SqlRunner.run(sql, values)
  return data.map{|customer| Customer.new(customer)}
  end
end
