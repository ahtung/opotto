if defined? Faker
  Faker::Commerce.class_eval do
    class << self
      def price(min: 1.00, max:100.0, precision: 2)
        rand(min..max).round(precision)
      end
    end
  end
end
