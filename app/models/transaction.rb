class Transaction < ActiveRecord::Base

  def self.balance
    credits = 0
    debits = 0
    self.all.each do |transaction|
      credits += transaction.amount if transaction.debit_or_credit == "Credit"
      debits += transaction.amount if transaction.debit_or_credit == "Debit"
    end
    @balance = credits - debits
  end

  def self.total_current_month
    @total_current_month = 0
    current_time = Time.now
    current_month = current_time.mon
    self.all.each do |transaction|
      if ((transaction.debit_or_credit == "Debit") && (transaction.created_at.mon == current_month))
        @total_current_month += transaction.amount
      end
    end
    @total_current_month
  end

  def self.total_previous_month
    @total_previous_month = 0
    current_time = Time.now
    previous_month = current_time.mon - 1
    self.all.each do |transaction|
      if ((transaction.debit_or_credit == "Debit") && (transaction.created_at.mon == previous_month))
        @total_previous_month += transaction.amount
      end
    end
    @total_previous_month
  end

end
