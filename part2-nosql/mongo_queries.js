// ============================================================
// Part 2 – MongoDB Operations (mongo_queries.js)
// Run in: mongosh <db_name> mongo_queries.js
// ============================================================

// OP1: insertMany() – insert all 3 documents from sample_documents.json
db.products.insertMany([
  {
    _id: "prod_elec_001",
    category: "Electronics",
    name: "Sony WH-1000XM5 Headphones",
    brand: "Sony",
    sku: "SONY-WH1000XM5-BLK",
    price: 29990,
    currency: "INR",
    in_stock: true,
    stock_qty: 45,
    specifications: {
      type: "Over-ear",
      connectivity: ["Bluetooth 5.2", "3.5mm Jack", "USB-C"],
      battery_life_hours: 30,
      noise_cancellation: true,
      frequency_response: "4 Hz – 40,000 Hz",
      voltage: "5V DC",
      warranty_years: 1
    },
    certifications: ["CE", "FCC", "BIS"],
    tags: ["audio", "wireless", "anc", "premium"],
    ratings: { average: 4.7, count: 2345 },
    created_at: new Date("2024-01-15T10:00:00Z")
  },
  {
    _id: "prod_cloth_001",
    category: "Clothing",
    name: "Allen Solly Men's Slim Fit Chinos",
    brand: "Allen Solly",
    sku: "AS-CHINO-KH-32",
    price: 1999,
    currency: "INR",
    in_stock: true,
    stock_qty: 120,
    specifications: {
      fabric: "98% Cotton, 2% Elastane",
      fit: "Slim Fit",
      care_instructions: ["Machine wash cold", "Do not bleach", "Tumble dry low"],
      sizes_available: ["28", "30", "32", "34", "36", "38"],
      colors_available: [
        { name: "Khaki", hex: "#C3A882" },
        { name: "Navy",  hex: "#1B2A4A" },
        { name: "Olive", hex: "#556B2F" }
      ],
      gender: "Men",
      occasion: ["Casual", "Semi-formal"]
    },
    tags: ["bottomwear", "chinos", "cotton", "slim-fit"],
    ratings: { average: 4.3, count: 876 },
    created_at: new Date("2024-02-01T08:30:00Z")
  },
  {
    _id: "prod_groc_001",
    category: "Groceries",
    name: "Tata Salt – Iodised Rock Salt",
    brand: "Tata",
    sku: "TATA-SALT-1KG",
    price: 28,
    currency: "INR",
    in_stock: true,
    stock_qty: 500,
    specifications: {
      weight_kg: 1.0,
      form: "Fine grain",
      shelf_life_days: 730,
      expiry_date: new Date("2026-12-31"),
      storage_instructions: "Store in a cool, dry place",
      nutritional_info: {
        per_100g: { energy_kcal: 0, sodium_mg: 38758, iodine_mcg: 30 }
      },
      certifications: ["FSSAI", "ISO 9001"],
      allergens: [],
      vegetarian: true,
      vegan: true
    },
    tags: ["salt", "iodised", "daily-essentials", "fssai-approved"],
    ratings: { average: 4.6, count: 11250 },
    created_at: new Date("2024-01-05T06:00:00Z")
  }
]);

// OP2: find() – retrieve all Electronics products with price > 20000
db.products.find(
  {
    category: "Electronics",
    price: { $gt: 20000 }
  },
  {
    name: 1,
    brand: 1,
    price: 1,
    category: 1
  }
);

// OP3: find() – retrieve all Groceries expiring before 2025-01-01
db.products.find(
  {
    category: "Groceries",
    "specifications.expiry_date": { $lt: new Date("2025-01-01") }
  },
  {
    name: 1,
    brand: 1,
    "specifications.expiry_date": 1
  }
);

// OP4: updateOne() – add a "discount_percent" field to a specific product
// Adding a 10% discount to the Sony Headphones product
db.products.updateOne(
  { _id: "prod_elec_001" },
  {
    $set: {
      discount_percent: 10,
      discounted_price: 26991  // 29990 * 0.90
    }
  }
);

// OP5: createIndex() – create an index on category field and explain why
// Reason: The most common query pattern filters by category (e.g., all Electronics,
// all Groceries). Without an index, MongoDB performs a full collection scan (O(n))
// on every such query. A single-field ascending index on "category" allows MongoDB
// to use an index scan (O(log n)), dramatically reducing query time as the catalog
// grows to thousands of products.
db.products.createIndex(
  { category: 1 },
  {
    name: "idx_category_asc",
    background: true   // non-blocking build in older MongoDB versions
  }
);
