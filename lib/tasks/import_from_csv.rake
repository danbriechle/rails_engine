require 'csv'

namespace :import do

  desc 'Imports customer data from CSV'
  task :customers => :environment do
    Customer.destroy_all
    CSV.foreach("db/csv_files/customers.csv", headers: true) do |row|
      Customer.create!(row.to_h)
    end
  end
  desc 'Imports invoice_item data from CSV'
  task :invoice_items => :environment do
    InvoiceItem.destroy_all
    CSV.foreach("db/csv_files/invoice_items.csv", headers: true) do |row|
      InvoiceItem.create!(row.to_h)
    end
  end
  desc 'Imports invoice data from CSV'
  task :invoices => :environment do
    Invoice.destroy_all
    CSV.foreach("db/csv_files/invoices.csv", headers: true) do |row|
      Invoice.create!(row.to_h)
    end
  end
  desc 'Imports item data from CSV'
  task :items => :environment do
    Item.destroy_all
    CSV.foreach("db/csv_files/items.csv", headers: true) do |row|
      Item.create!(row.to_h)
    end
  end
desc 'Imports merchant data from CSV'
  task :merchants => :environment do
    Merchant.destroy_all
    CSV.foreach("db/csv_files/merchants.csv", headers: true) do |row|
      Merchant.create!(row.to_h)
    end
  end
desc 'Imports transaction data from CSV'
  task :transactions => :environment do
    Transaction.destroy_all
    CSV.foreach("db/csv_files/transactions.csv", headers: true) do |row|
      Transaction.create!(row.to_h)
    end
  end
end
