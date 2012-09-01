# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  include ApplicationHelper 
  
  require 'net/http'
  require 'uri'
  
  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  use_google_charts
  protect_from_forgery # :secret => '894ad8027c92f81737c078d7a40e12c2'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  
  def draw_graph(val1,val2,val3,val4,val5,val6)
#      total = val1.to_i + val2.to_i + val3.to_i + val4.to_i + val5.to_i + val6.to_i
      
#      dataset1 = GoogleChartDataset.new :data => [(100*val1.to_i/total),(100*val2.to_i/total),(100*val3.to_i/total),(100*val4.to_i/total),(100*val5.to_i/total),(100*val6.to_i/total)], :color => ['006699','FF9933','006699','116699','226699','336699','446699']
#      dataset1 = GoogleChartDataset.new :data => [val1,val2,val3,val4,val5,val6], :color => ['006699','FF9933','006699','116699','226699','336699','446699']
#      data = GoogleChartData.new :datasets => [dataset1]
      
      dataset1 = GoogleChartDataset.new :data => [val1,val2,val3], :color => 'FF9933'
      dataset2 = GoogleChartDataset.new :data => [val4,val5,val6], :color => '006699'
      data = GoogleChartData.new :datasets => [dataset1,dataset2]
      @chart = GoogleBarChart.new# :width => 495, :height => 199
      @chart.data = data
      return @chart
  end
  
  def tinyfy(newurl)
   url = URI.parse('http://tinyurl.com/')
   res = Net::HTTP.start(url.host, url.port) {|http|
   http.get('/api-create.php?url=' + newurl)
   }
   if res.body.empty?
      #tinyurl is not responding properly… Return the original url
      return '<a href=' + newurl + '>' + newurl + '</a>'
   else
      return '<a href=' + res.body + '>' + res.body + '</a>'
   end
  end

end
