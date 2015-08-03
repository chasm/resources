get "/customers" do
  json Customer.all
end

post "/customers" do
  customer = Customer.new(customer_params)
  if customer.save
    json customer: customer
  else
    status 400
  end
end

put "/customers/:id" do
  customer = set_customer
  if customer.update(customer_params)
    json customer: customer
  else
    status 400
  end
end

delete "/customers/:id" do
  customer = set_customer
  if customer.destroy
    status 200
  else
    status 400
  end
end

def customer_params
  params[:customer]
end

def set_customer
  Customer.find(params[:id])
end
