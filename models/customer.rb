require_relative('../db/sql_runner')

class Customer

attr_reader :id
attr_accessor :name, :funds

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds'].to_i
  end

  def self.delete_all
    sql = 'DELETE FROM customers'
    SqlRunner.run(sql)
  end

  def save
    sql = "INSERT INTO customers (name, funds)
          VALUES ($1, $2)
          RETURNING id"
    values = [@name, @funds]
    customer = SqlRunner.run(sql, values)[0]
    @id = customer['id'].to_i
  end

  def self.all
    sql = "SELECT * FROM customers"
    customer_data = SqlRunner.run(sql)
    return customer_data.map { |customer| Customer.new(customer) }
  end

  def update
    sql = "UPDATE customers (name, funds)
    VALUES ($1, $2)
    WHERE id = $3"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE * FROM customers where id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end
# films the customer is going to see
  def customer_plans
    sql = "SELECT films.*
FROM films
INNER JOIN tickets
ON films.id = tickets.film_id
INNER JOIN customers
ON tickets.customer_id = customers.id
WHERE customer_id = $1"
    values = [@id]
    data = SqlRunner.run(sql, values)
    data.map {|data| Film.new(data)}
  end
end
