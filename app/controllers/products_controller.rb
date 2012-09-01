require 'csv'

class ProductsController < ApplicationController
  use_google_charts
  
  def download
      if params[:emails]
          if params[:commit]
              if params[:emails].blank?
                  flash[:notice] = "Hey, please enter email address" 
              else
                  if self.check_emails(params[:emails])
                      recipient = params[:emails]

                      Emailer.deliver_downloadto(recipient)

                      flash[:notice]= "Mail sent successfully"
                  else
                      flash[:notice]= "Hey, please enter valid email"
                  end
              end
          else
              flash[:notice] = "Thanks for downloading."
          end
      end
  end
  
  def upload
        if !params[:upload].blank?
            file = params[:upload]
            file_path = "#{RAILS_ROOT}/public/uploads/#{Time.now.to_date}_#{file.original_filename}"

            mime_extension=File.mime_type?(file_path)
        
            if mime_extension.eql? "text/comma-separated-values"
                if !file.local_path.nil?
                       FileUtils.copy_file(file.local_path,"#{file_path}")
                else
                       File.open("#{file_path}", "wb") { |f| f.write(file.read) }
                end

                @file=File.open(file_path)
                
                n=0
                CSV::Reader.parse(File.open("#{file_path}", 'rb')) do |row|
                  product=Product.new
                  
                  product.category= row[0]
                  product.product_class= row[1]
                  product.product_sub_class = row[2]
                  product.cost = row[3]
                  product.margin = row[4]
                  product.UPC_code = row[5]
                  product.sku = row[6]
                  product.date_marked_clearance = row[7]
                  product.description = row[8]
                  product.age = row[9]
                  product.inventory_location = row[10]
                  product.msrp = row[11]
                  product.promotional_price = row[12]
                  product.model_number = row[13]
                  product.color = row[14]
            
                  if product.errors.empty? and product.save
                      n=n+1
                      GC.start if n%50==0
                  end
                  flash[:notice]="CSV Import Successful,  #{n} new records added to data base"
                end
                redirect_to product_action_path("upload")
            else
                flash[:notice]="Hey, please upload only csv file"
            end
        end
  end
  
  def stream
#    @id = params[:id] || 1
    @product1 = draw_graph( rand(100) + 1, rand(80) + 1,rand(70) + 1, rand(60) + 1, rand(50) + 1, rand(30) + 1).to_url
    @product2 = draw_graph( rand(90) + 1, rand(85) + 1,rand(75) + 1, rand(65) + 1, rand(40) + 1, rand(20) + 1).to_url
    if Graph.find(:last)
        if Graph.find(:last).id >= Graph::COUNT
            @id = 1
        else
            @graph = Graph.new(:url => @product1)
            @graph.save
            @graph = Graph.new(:url => @product2)
            @graph.save
            @id = @graph ? @graph.id-1 : 1
        end
    else
        @graph = Graph.new(:url => @product1)
        @graph.save
        @graph = Graph.new(:url => @product2)
        @graph.save
        @id = 1
    end
  end

  def search
      @graphs = Graph.find(:all, :order => ["rand()"],:limit => rand(9) + 1)
  end
  
  def any

      for category in Product::CATEGORY
          #@products_category = Product.find(:all, :conditions => "category='#{category}'", :order => "margin")
          if @products_category
              index_curr = (@products_category.length%2 == 0) ? (@products_category.length/2) : ((@products_category.length + 1)/2) if(@products_category.length > 2)
              @category = Category.new
              @category.category = category
              if(@products_category.length > 0)
                  @category.median_margin = @products_category[index_curr].margin
                  @category.total = @products_category.length
                  @category.product_id = @products_category[index_curr].id
              end
              @category.save
          end
      end
      @categories = Category.find(:all)
      @values1 = Array.new
      @values2 = Array.new
      for category in @categories
          category.update_attribute('median_promotional_price', category.product.promotional_price)
          @values1.push(category.median_margin)
          @values2.push(category.median_promotional_price)
      end
      @product1 = draw_graph( @values1.pop, @values1.pop, @values1.pop, @values1.pop, @values1.pop, @values1.pop).to_url
      @graph = Graph.new(:chart_type => "Median Margin by Category", :url => @product1)
#      @graph.save
      
      @product2 = draw_graph( @values2.pop, @values2.pop, @values2.pop, @values2.pop, @values2.pop, @values2.pop).to_url
      @graph = Graph.new(:chart_type => "Median Promotional Price by Category", :url => @product2)
#      @graph.save
      
      for product in Product::PRODUCT_CLASS
          #@products_category = Product.find(:all, :conditions => "product_class='#{product}'", :order => "margin")
          if @products_category
              index_curr = (@products_category.length%2 == 0) ? (@products_category.length/2) : ((@products_category.length + 1)/2) if(@products_category.length > 2)
              @product = ProductClass.new
              @product.product_class = product
              if(@products_category.length > 0)
                  @product.median_margin = @products_category[index_curr].margin
                  @product.total = @products_category.length
                  @product.product_id = @products_category[index_curr].id
              end
              @product.save
          end
      end
      @product_classes = ProductClass.find(:all)
      @values1 = Array.new
      @values2 = Array.new
      for product_class in @product_classes
          product_class.update_attribute('median_promotional_price', product_class.product.promotional_price)
          @values1.push(product_class.median_margin)
          @values2.push(product_class.median_promotional_price)
      end
      @product1 = draw_graph( @values1.pop, @values1.pop, @values1.pop, @values1.pop, @values1.pop, @values1.pop).to_url
      @graph = Graph.new(:chart_type => "Median Margin by Product Class", :url => @product1)
#      @graph.save
      
      @product2 = draw_graph( @values2.pop, @values2.pop, @values2.pop, @values2.pop, @values2.pop, @values2.pop).to_url
      @graph = Graph.new(:chart_type => "Median Promotional Price by Product Class", :url => @product2)
#      @graph.save
      
      for product in Product::SUB_CLASS
          #@products_category = Product.find(:all, :conditions => "product_sub_class='#{product}'", :order => "margin")
          if @products_category
              index_curr = (@products_category.length%2 == 0) ? (@products_category.length/2) : ((@products_category.length + 1)/2) if(@products_category.length > 2)
              @product = ProductSubClass.new
              @product.product_class = product
              if(@products_category.length > 0)
                  @product.median_margin = @products_category[index_curr].margin
                  @product.total = @products_category.length
                  @product.product_id = @products_category[index_curr].id
              end
              @product.save
          end
      end
      @product_classes = ProductSubClass.find(:all)
      @values1 = Array.new
      @values2 = Array.new
      for product_sub_class in @product_classes
          product_sub_class.update_attribute('median_promotional_price', product_sub_class.product.promotional_price)
          @values1.push(product_sub_class.median_margin)
          @values2.push(product_sub_class.median_promotional_price)
      end
      @product1 = draw_graph( @values1.pop, @values1.pop, @values1.pop, @values1.pop, @values1.pop, @values1.pop).to_url
      @graph = Graph.new(:chart_type => "Median Margin by Product Sub Class", :url => @product1)
#      @graph.save
      
      @product2 = draw_graph( @values2.pop, @values2.pop, @values2.pop, @values2.pop, @values2.pop, @values2.pop).to_url
      @graph = Graph.new(:chart_type => "Median Promotional Price by Product Sub Class", :url => @product2)
#      @graph.save
      
#      @graphs = Graph.find(:all, :order => ["rand()"],:limit => 6)
  end
  
  def analyze
      @graphs = Graph.find(:all, :limit => 6)
  end
  
  def rate
      @id = params[:id].to_i
      @like = params[:like].to_i
      @message = ''
      if Rating.find(:last, :conditions => ["ip='#{request.remote_ip}' and graph_id=#{@id}"])
          @message = "No double voting!  "
      else
          @rate = Rating.new
          @rate.graph_id = @id
          @rate.rate = @like
          @rate.ip = request.remote_ip
          @rate.save
          @message = "Thanks for voting.  "
      end
      
      @like_count = Rating.find(:first, :select => ["count(id) as 'cnt'"], :conditions => ["rate=1 and graph_id=#{@id}"])
      @dislike_count = Rating.find(:first, :select => ["count(id) as 'cnt'"], :conditions => ["rate=0 and graph_id=#{@id}"])
      @like = @like_count.cnt
      @dislike = @dislike_count.cnt
      
      @comments = Comment.find_all_by_graph_id(@id, :order => "id desc")

      render :layout => false
  end
  
  def send_capsule
    if self.check_emails(params[:emails])
        name = params[:name].blank? ? 'Someone' : params[:name]
        recipient = params[:emails]
        
        Emailer.deliver_sendto(recipient,params[:id],name,params[:message])
        
        flash[:notice]= "Mail sent successfully"
    else
        flash[:notice]= "Hey, please enter valid emails"
    end
    redirect_to product_action_path("send",params[:id])
  end
  
  def new_graph
    @id = params[:id].to_i + 1
    @product1 = draw_graph( rand(100) + 1, rand(80) + 1,rand(70) + 1, rand(60) + 1, rand(50) + 1, rand(30) + 1).to_url
    if Graph.find(:last).id < Graph::COUNT
        if Graph.find_by_id(@id-1)
            @product1 = Graph.find(@id-1).url
        else
            @graph = Graph.new(:url => @product1)
            @graph.save
        end
    end
    render :layout => false
  end
  
  def new_slider_graph
    @graphs = Graph.find(:all, :order => "rand()", :limit => rand(9) + 1)
    render :layout => false
  end
    
  protected
  
  def check_emails(emails)
    return false if emails.blank?
    return false if emails.gsub(',','').blank?
    emails.split(',').each do |email|
        unless email.strip =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/
          return false
        end
    end
    return true
  end
  
end
