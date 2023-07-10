-- Create the User table
CREATE TABLE users (
  id VARCHAR(255) PRIMARY KEY,
  state VARCHAR(255),
  created_date DATETIME,
  last_login DATETIME,
  role VARCHAR(255) DEFAULT 'CONSUMER',
  active BOOLEAN,
  FOREIGN KEY (id) REFERENCES receipt(user_id)
);

-- Create the Receipt table
CREATE TABLE receipt (
  id VARCHAR(255) PRIMARY KEY,
  bonus_points_earned INT,
  bonus_points_earned_reason VARCHAR(255),
  create_date DATETIME,
  date_scanned DATETIME,
  finished_date DATETIME,
  modify_date DATETIME,
  points_awarded_date DATETIME,
  points_earned DECIMAL(10, 2),
  purchase_date DATETIME,
  purchased_item_count INT,
  rewards_receipt_status VARCHAR(255),
  total_spent DECIMAL(10, 2),
  user_id VARCHAR(255),
  FOREIGN KEY (user_id) REFERENCES users(id)
  FOREIGN KEY (id) REFERENCES receipt_item(receipt_id)
);

-- Create the ReceiptItems table
CREATE TABLE receipt_item (
  receipt_id VARCHAR(255),
  barcode VARCHAR(255),
  description VARCHAR(255),
  final_price DECIMAL(10, 2),
  item_price DECIMAL(10, 2),
  needs_fetch_review BOOLEAN,
  partner_itemId VARCHAR(255),
  prevent_target_gap_points BOOLEAN,
  quantity_purchased INT,
  user_flagged_barcode VARCHAR(255),
  user_flagged_newItem BOOLEAN,
  user_flagged_price DECIMAL(10, 2),
  user_flagged_quantity INT,
  FOREIGN KEY (receipt_id) REFERENCES receipt(id)
  FOREIGN KEY (barcode) REFERENCES brand(barcode)
);

-- Create the Brand table
CREATE TABLE brand (
  id VARCHAR(255) PRIMARY KEY,
  barcode VARCHAR(255),
  brand_code VARCHAR(255),
  category VARCHAR(255),
  category_code VARCHAR(255),
  top_brand BOOLEAN,
  name VARCHAR(255),
  FOREIGN KEY (id) REFERENCES brand_references(brand_id)
  FOREIGN KEY (barcode) REFERENCES receipt_item(barcode)
);

CREATE TABLE brand_references (
    id VARCHAR(255) PRIMARY KEY,
    brand_id INT,
    cpg_id INT,
    cog_id INT,
    FOREIGN KEY (brand_id) REFERENCES brand(id),
    FOREIGN KEY (cpg_id) REFERENCES cpgs(id),
    FOREIGN KEY (cog_id) REFERENCES cogs(id),
    UNIQUE (brand_id)
);

CREATE TABLE cpgs (
    id INT PRIMARY KEY,
);

CREATE TABLE cogs (
    id INT PRIMARY KEY,
);