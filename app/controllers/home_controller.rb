class HomeController < ApplicationController
    def tinyurl
        if !params[:url].blank?
          @tiny = tinyfy(params[:url])
        end
    end

    def slider
        if params[:slider_input1] || params[:slider_input2]
            @slider_input1 = params[:slider_input1]
            @slider_input2 = params[:slider_input2]
        else
            @slider_input1 = 1
            @slider_input2 = 1
        end
        @graphs = Graph.find(:all, :order => "rand()", :limit => rand(10) + 1)
    end
    
    def data
        num = 0
#        (1..20000).each do |num|
            @product = Product.new
            @product.category = Product::CATEGORY[rand(4)]
            @product.product_class = Product::PRODUCT_CLASS[rand(4)]
            @product.product_sub_class = Product::SUB_CLASS[rand(5)]
            @product.cost = rand(9998) + 1
            @product.margin = rand(18) + 15
            @product.UPC_code = rand(9999999999) + 1
            @product.sku = rand(9998) + 1
            @product.date_marked_clearance = "#{rand(100).to_i + 1909}-#{rand(11) + 1}-#{rand(27) + 1}"
            @product.description = "test #{num}"
            @product.age = rand(50) + 1
            @product.inventory_location = 'US'
            @product.msrp = rand(9998) + 1
            @product.promotional_price = rand(9998) + 1
            @product.model_number = rand(9999999999) + 1
            @product.color = Product::COLOR[rand(6)]
            
#            @product.save
#        end
        redirect_to root_path
    end
end
