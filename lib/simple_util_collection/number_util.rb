module SimpleUtilCollection
  module NumberUtilModule
    def numeric?(obj) 
      !!obj.to_s.match(/\A[+-]?\d+?(\.\d+)?\Z/) if obj
    end 

    def integral?(obj) 
      !!obj.to_s.match(/\A[+-]?\d+\Z/) if obj
    end     
  end
  
  class NumberUtil
    extend SimpleUtilCollection::NumberUtilModule      
  end
end