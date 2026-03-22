
// OP1: insertMany() — insert all 3 documents from sample_documents.json
use ecommerce_catalog
db.products.insertMany([
     {
     "category" : "Electronics",
    "item_code" : "ITM_RT28C3733S8",
    "item_name" : "Refrigerator",

    "product_info" : {
    "brand_name": "Samsung",
    "model" : "RT28C3733S8",
    "item_type": "Multi Door"},

         "design_and_body" : {
         "weight" : "46 kg",
        "height" : "154.5 cm",
        "width" : "55.5 cm",
        "depth" : "63.7 cm",
"freezer_mounted" : "Top",
"handle_type" : "Recess Handle",
"colors_available" : ["Red","White","Blue"]

     },

"interior_features" : {
"interior_lamp" : true,
"toughened_glass" : true,
"ice_tray" : true,
"door_basket" : true,
"egg_tray" : true,
"bottle_shelves" : 2,
"freezer_shelves" : 2,
"flexible_rack" : true

},

"technical" : {
"capacity" : {
  "total" : "236 L",
  "refrigerator" : "183 L",
   "freezer" : "53 L"},
"compressor" : "Digital Inverter Compressor",
 "refrigerant" : "R-600a",
 "cooling_technology" : "Direct Cool"
},
          
"pricing": {
   "price": 23000,
   "currency": "INR"
}

},

{
  "category": "Clothing",
  "item_code": "ITM_TS35008808",
  "item_name": "T-shirt",

  "product_info": {
    "brand_name": "Tommy Hilfiger",
    "product_title": "Europe Self Design Round Neck Slim Fit T-shirt",
    "product_code": "35008808",
    "gender": "Men",
    "color": "Grey"
  },

  "pricing": {
    "mrp": 2249,
    "selling_price": 1281,
    "discount_percent": 43,
    "currency": "INR"
  },

  "size_options": ["S", "M", "L", "XL", "XXL"],

  "material_details": {
    "fabric": "Cotton",
    "composition": "100% Regenerative Cotton",
    "care_instructions": "Hand Wash"
  },

  "product_features": {
    "fit": "Slim Fit",
    "length": "Regular",
    "neck": "Round Neck",
    "sleeve_type": "Short Sleeves",
    "pattern": "Self Design"
  },

  "ratings": {
    "average_rating": 4,
    "total_ratings": 41,
    "reviews_count": 3
  },

  "inventory": {
    "stock_available": true,
    "seller": "Myntra",
    "return_policy_days": 7
  }
},

 {
"category": "Groceries",
"item_code": "ITM_MLK500A2",
"item_name": "Buffalo A2 Milk",

"product_info": {
"brand_name": "Amul",
"product_title": "Amul Buffalo A2 Milk",
"unit": "500 ml",
"country_of_origin": "India"
},
"expiry_date": ISODate("2024-12-31"),
"pricing": {
"selling_price": 38,
"currency": "INR",
"tax_included": true
},

"nutritional_information": {
"energy_kcal_per_100g": 91,
"protein_g_per_100g": 3,
"carbohydrates_g_per_100g": 5,
"total_sugar_g_per_100g": 5,
"added_sugar_g_per_100g": 0,
"total_fat_g_per_100g": 6,
"saturated_fat_g_per_100g": 4,
"trans_fat_g_per_100g": 0,
"calcium_per_100g": "0.1 g"
},

"product_features": {
"fat_profile": "Full Cream",
"processing_type": "A2 Milk",
"biological_source": "Buffalo Milk",
"sugar_profile": "No Added Sugar"
},

"additional_details": {
"shelf_life": "2 days",
"storage_tips": "Keep under refrigeration",
"fssai_license": "10012021000071"
},

"inventory": {
"stock_available": true,
"seller": "Zomato Hyperpure Private Limited",
"return_policy": "Replacement within 24 hours if damaged or incorrect"
}
}

]);


// OP2: find() — retrieve all Electronics products with price > 20000
use ecommerce_catalog
db.products.find({
  category: "Electronics",
  "pricing.price": { $gt: 20000 }
});

// OP3: find() — retrieve all Groceries expiring before 2025-01-01
use ecommerce_catalog
db.products.find({
    "category" : "Groceries",
    expiry_date: { $lt: ISODate("2025-01-01")}
});
// OP4: updateOne() — add a "discount_percent" field to a specific product
use ecommerce_catalog
db.products.updateOne(
  { "item_code": "ITM_RT28C3733S8" },
  {
    "$set" : {
      "pricing.discount_percent": 15
    }
  }
);

// OP5: createIndex() — create an index on category field and explain why
use ecommerce_catalog
db.products.createIndex({ category: 1 });

Explanation
Without an index, MongoDB performs a collection scan (COLLSCAN), meaning it checks every document in the collection to find matching records.
Creating an index on the category field allows MongoDB to perform an index scan (IXSCAN). This enables MongoDB to quickly locate matching 
documents without scanning the entire collection, improving query performance.For example, after creating the index, if we run the query:
db.products.find({ category: "Electronics" });
MongoDB will use the index on the category field to locate the relevant documents faster. Based on my inserted documents, the collection 
initially stores the documents in the following 
order:
Electronics - doc1
Clothing - doc2
Groceries - doc3
However, when the index is created, MongoDB builds a separate lookup structure where the category values are stored in ascending order:
Clothing - doc2
Electronics - doc1
Groceries - doc3
When a query such as find({ category: "Electronics" }) is executed, MongoDB searches the index using IXSCAN, which allows it to quickly 
locate the matching document instead of scanning all documents in the collection.



