def find_item_by_name_in_collection(name, collection)
  collection.length.times do |idx|
    item = collection[idx][:item]
    return collection[idx] if(item == name)
  end
  return nil
end

def consolidate_cart(cart)
  temp_hash = {}
  results_arr = []
  
  cart.length.times do |idx|
    item = cart[idx]
    item_name = item[:item]
    if(temp_hash[item_name] == nil)
      temp_hash[item_name] = item
      temp_hash[item_name][:count] = 1
    else
      temp_hash[item_name][:count]+=1
    end
  end
  
  temp_hash.each do |key,value|
    results_arr << value
  end
  
  results_arr
end

def apply_coupons(cart, coupons)
    # Consult README for inputs and outputs
    #
    # REMEMBER: This method **should** update cart

    #puts "\nOriginal Cart\n"
    #puts cart
    #puts "\n======================\n\n"

    coupons.length.times do |idx|

      coupon = coupons[idx]
      coupon_name = coupon[:item]
      coupon_quantity = coupon[:num]
      coupon_deduction = coupon[:cost]

      cart.length.times do |i_idx|
        item = cart[i_idx]
        item_name = item[:item]
        item_quantity = item[:count]
        item_price = item[:price]


        if((coupon_name == item_name) && (item_quantity >= coupon_quantity))

          if(item[:count] >= coupon_quantity)
            item[:count] -= coupon_quantity
            #cart.delete_at(i_idx) if (item[:count] == 0)
            copy = {:item=>(item_name+" W/COUPON"),:price=>(coupon_deduction/coupon_quantity),:clearance=>(item[:clearance]),:count=>(coupon_quantity)}
            cart << copy
          end
        end
      end


    end
    cart
end



def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  
  cart.length.times do |idx|
    if(cart[idx][:clearance] == true)
      cart[idx][:price] -= (cart[idx][:price]*0.2)
      cart[idx][:price].round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
  
  grand_total = 0
  
  consolidated_cart = consolidate_cart(cart)
  consolidated_cart = apply_coupons(consolidated_cart,coupons)
  consolidated_cart = apply_clearance(consolidated_cart)
  
  consolidated_cart.length.times do |idx|
    grand_total += (consolidated_cart[idx][:price]*consolidated_cart[idx][:count])
  end
  
  puts grand_total
end
