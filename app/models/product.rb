class Product < ActiveRecord::Base
    CATEGORY = [
          "Televisions",
          "Home Audio",
          "Accessories",
          "Cameras",
          "Laptop"
    ]
    PRODUCT_CLASS = [
          "LCD",
          "Speakers",
          "Surge Protectors",
          "Digital",
          "PC"
    ]
    SUB_CLASS = [
          "21\" - 30\"",
          "31\"- 40\"",
          "41\" and above",
          "Power speakers",
          "In-Wall Speakers",
          "Outdoor Speakers"
    ]
    COLOR = [
      "black",
      "white",
      "blue",
      "green",
      "red",
      "yellow",
      "grey",
    ]
end
