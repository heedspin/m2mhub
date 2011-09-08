# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 0) do

  create_table "DBRRSLI", :primary_key => "identity_column", :force => true do |t|
    t.string  "L1",               :limit => 13
    t.string  "L2",               :limit => 13
    t.string  "L3",               :limit => 13
    t.string  "L4",               :limit => 13
    t.string  "L5",               :limit => 13
    t.string  "L6",               :limit => 13
    t.string  "L7",               :limit => 13
    t.string  "L8",               :limit => 13
    t.string  "L9",               :limit => 13
    t.string  "L10",              :limit => 13
    t.string  "PNAME1",           :limit => 10
    t.string  "PNAME2",           :limit => 10
    t.string  "PNAME3",           :limit => 10
    t.string  "PNAME4",           :limit => 10
    t.string  "PNAME5",           :limit => 10
    t.string  "PNAME6",           :limit => 10
    t.string  "PNAME7",           :limit => 10
    t.string  "PNAME8",           :limit => 10
    t.string  "PNAME9",           :limit => 10
    t.string  "PNAME10",          :limit => 10
    t.string  "PNAME11",          :limit => 10
    t.string  "PNAME12",          :limit => 10
    t.string  "PNAME13",          :limit => 10
    t.string  "PNAME14",          :limit => 10
    t.string  "PNAME15",          :limit => 10
    t.string  "PNAME16",          :limit => 10
    t.string  "PNAME17",          :limit => 10
    t.string  "PNAME18",          :limit => 10
    t.string  "PNAME19",          :limit => 10
    t.string  "PNAME20",          :limit => 10
    t.string  "PNAME21",          :limit => 10
    t.string  "PNAME22",          :limit => 10
    t.string  "PNAME23",          :limit => 10
    t.string  "PNAME24",          :limit => 10
    t.string  "PNAME25",          :limit => 10
    t.string  "PNAME26",          :limit => 10
    t.string  "fcFac",            :limit => 20
    t.string  "UserID",           :limit => 30
    t.integer "SEQNO"
    t.string  "cBatchName",       :limit => 15
    t.string  "cSource",          :limit => 1
    t.binary  "timestamp_column"
  end

  add_index "DBRRSLI", ["fcFac", "UserID", "cBatchName"], :name => "byfacility"
  add_index "DBRRSLI", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "DBRRSQ", :id => false, :force => true do |t|
    t.string  "LINK_FLD",         :limit => 25,                                :null => false
    t.decimal "L1Q1",                           :precision => 14, :scale => 4
    t.decimal "L1Q2",                           :precision => 14, :scale => 4
    t.decimal "L1Q3",                           :precision => 14, :scale => 4
    t.decimal "L1Q4",                           :precision => 14, :scale => 4
    t.decimal "L1Q5",                           :precision => 14, :scale => 4
    t.decimal "L1Q6",                           :precision => 14, :scale => 4
    t.decimal "L1Q7",                           :precision => 14, :scale => 4
    t.decimal "L1Q8",                           :precision => 14, :scale => 4
    t.decimal "L1Q9",                           :precision => 14, :scale => 4
    t.decimal "L1Q10",                          :precision => 14, :scale => 4
    t.decimal "L1Q11",                          :precision => 14, :scale => 4
    t.decimal "L1Q12",                          :precision => 14, :scale => 4
    t.decimal "L1Q13",                          :precision => 14, :scale => 4
    t.decimal "L1Q14",                          :precision => 14, :scale => 4
    t.decimal "L1Q15",                          :precision => 14, :scale => 4
    t.decimal "L1Q16",                          :precision => 14, :scale => 4
    t.decimal "L1Q17",                          :precision => 14, :scale => 4
    t.decimal "L1Q18",                          :precision => 14, :scale => 4
    t.decimal "L1Q19",                          :precision => 14, :scale => 4
    t.decimal "L1Q20",                          :precision => 14, :scale => 4
    t.decimal "L1Q21",                          :precision => 14, :scale => 4
    t.decimal "L1Q22",                          :precision => 14, :scale => 4
    t.decimal "L1Q23",                          :precision => 14, :scale => 4
    t.decimal "L1Q24",                          :precision => 14, :scale => 4
    t.decimal "L1Q25",                          :precision => 14, :scale => 4
    t.decimal "L1Q26",                          :precision => 14, :scale => 4
    t.decimal "L2Q1",                           :precision => 14, :scale => 4
    t.decimal "L2Q2",                           :precision => 14, :scale => 4
    t.decimal "L2Q3",                           :precision => 14, :scale => 4
    t.decimal "L2Q4",                           :precision => 14, :scale => 4
    t.decimal "L2Q5",                           :precision => 14, :scale => 4
    t.decimal "L2Q6",                           :precision => 14, :scale => 4
    t.decimal "L2Q7",                           :precision => 14, :scale => 4
    t.decimal "L2Q8",                           :precision => 14, :scale => 4
    t.decimal "L2Q9",                           :precision => 14, :scale => 4
    t.decimal "L2Q10",                          :precision => 14, :scale => 4
    t.decimal "L2Q11",                          :precision => 14, :scale => 4
    t.decimal "L2Q12",                          :precision => 14, :scale => 4
    t.decimal "L2Q13",                          :precision => 14, :scale => 4
    t.decimal "L2Q14",                          :precision => 14, :scale => 4
    t.decimal "L2Q15",                          :precision => 14, :scale => 4
    t.decimal "L2Q16",                          :precision => 14, :scale => 4
    t.decimal "L2Q17",                          :precision => 14, :scale => 4
    t.decimal "L2Q18",                          :precision => 14, :scale => 4
    t.decimal "L2Q19",                          :precision => 14, :scale => 4
    t.decimal "L2Q20",                          :precision => 14, :scale => 4
    t.decimal "L2Q21",                          :precision => 14, :scale => 4
    t.decimal "L2Q22",                          :precision => 14, :scale => 4
    t.decimal "L2Q23",                          :precision => 14, :scale => 4
    t.decimal "L2Q24",                          :precision => 14, :scale => 4
    t.decimal "L2Q25",                          :precision => 14, :scale => 4
    t.decimal "L2Q26",                          :precision => 14, :scale => 4
    t.decimal "L3Q1",                           :precision => 14, :scale => 4
    t.decimal "L3Q2",                           :precision => 14, :scale => 4
    t.decimal "L3Q3",                           :precision => 14, :scale => 4
    t.decimal "L3Q4",                           :precision => 14, :scale => 4
    t.decimal "L3Q5",                           :precision => 14, :scale => 4
    t.decimal "L3Q6",                           :precision => 14, :scale => 4
    t.decimal "L3Q7",                           :precision => 14, :scale => 4
    t.decimal "L3Q8",                           :precision => 14, :scale => 4
    t.decimal "L3Q9",                           :precision => 14, :scale => 4
    t.decimal "L3Q10",                          :precision => 14, :scale => 4
    t.decimal "L3Q11",                          :precision => 14, :scale => 4
    t.decimal "L3Q12",                          :precision => 14, :scale => 4
    t.decimal "L3Q13",                          :precision => 14, :scale => 4
    t.decimal "L3Q14",                          :precision => 14, :scale => 4
    t.decimal "L3Q15",                          :precision => 14, :scale => 4
    t.decimal "L3Q16",                          :precision => 14, :scale => 4
    t.decimal "L3Q17",                          :precision => 14, :scale => 4
    t.decimal "L3Q18",                          :precision => 14, :scale => 4
    t.decimal "L3Q19",                          :precision => 14, :scale => 4
    t.decimal "L3Q20",                          :precision => 14, :scale => 4
    t.decimal "L3Q21",                          :precision => 14, :scale => 4
    t.decimal "L3Q22",                          :precision => 14, :scale => 4
    t.decimal "L3Q23",                          :precision => 14, :scale => 4
    t.decimal "L3Q24",                          :precision => 14, :scale => 4
    t.decimal "L3Q25",                          :precision => 14, :scale => 4
    t.decimal "L3Q26",                          :precision => 14, :scale => 4
    t.decimal "L4Q1",                           :precision => 14, :scale => 4
    t.decimal "L4Q2",                           :precision => 14, :scale => 4
    t.decimal "L4Q3",                           :precision => 14, :scale => 4
    t.decimal "L4Q4",                           :precision => 14, :scale => 4
    t.decimal "L4Q5",                           :precision => 14, :scale => 4
    t.decimal "L4Q6",                           :precision => 14, :scale => 4
    t.decimal "L4Q7",                           :precision => 14, :scale => 4
    t.decimal "L4Q8",                           :precision => 14, :scale => 4
    t.decimal "L4Q9",                           :precision => 14, :scale => 4
    t.decimal "L4Q10",                          :precision => 14, :scale => 4
    t.decimal "L4Q11",                          :precision => 14, :scale => 4
    t.decimal "L4Q12",                          :precision => 14, :scale => 4
    t.decimal "L4Q13",                          :precision => 14, :scale => 4
    t.decimal "L4Q14",                          :precision => 14, :scale => 4
    t.decimal "L4Q15",                          :precision => 14, :scale => 4
    t.decimal "L4Q16",                          :precision => 14, :scale => 4
    t.decimal "L4Q17",                          :precision => 14, :scale => 4
    t.decimal "L4Q18",                          :precision => 14, :scale => 4
    t.decimal "L4Q19",                          :precision => 14, :scale => 4
    t.decimal "L4Q20",                          :precision => 14, :scale => 4
    t.decimal "L4Q21",                          :precision => 14, :scale => 4
    t.decimal "L4Q22",                          :precision => 14, :scale => 4
    t.decimal "L4Q23",                          :precision => 14, :scale => 4
    t.decimal "L4Q24",                          :precision => 14, :scale => 4
    t.decimal "L4Q25",                          :precision => 14, :scale => 4
    t.decimal "L4Q26",                          :precision => 14, :scale => 4
    t.decimal "L5Q1",                           :precision => 14, :scale => 4
    t.decimal "L5Q2",                           :precision => 14, :scale => 4
    t.decimal "L5Q3",                           :precision => 14, :scale => 4
    t.decimal "L5Q4",                           :precision => 14, :scale => 4
    t.decimal "L5Q5",                           :precision => 14, :scale => 4
    t.decimal "L5Q6",                           :precision => 14, :scale => 4
    t.decimal "L5Q7",                           :precision => 14, :scale => 4
    t.decimal "L5Q8",                           :precision => 14, :scale => 4
    t.decimal "L5Q9",                           :precision => 14, :scale => 4
    t.decimal "L5Q10",                          :precision => 14, :scale => 4
    t.decimal "L5Q11",                          :precision => 14, :scale => 4
    t.decimal "L5Q12",                          :precision => 14, :scale => 4
    t.decimal "L5Q13",                          :precision => 14, :scale => 4
    t.decimal "L5Q14",                          :precision => 14, :scale => 4
    t.decimal "L5Q15",                          :precision => 14, :scale => 4
    t.decimal "L5Q16",                          :precision => 14, :scale => 4
    t.decimal "L5Q17",                          :precision => 14, :scale => 4
    t.decimal "L5Q18",                          :precision => 14, :scale => 4
    t.decimal "L5Q19",                          :precision => 14, :scale => 4
    t.decimal "L5Q20",                          :precision => 14, :scale => 4
    t.decimal "L5Q21",                          :precision => 14, :scale => 4
    t.decimal "L5Q22",                          :precision => 14, :scale => 4
    t.decimal "L5Q23",                          :precision => 14, :scale => 4
    t.decimal "L5Q24",                          :precision => 14, :scale => 4
    t.decimal "L5Q25",                          :precision => 14, :scale => 4
    t.decimal "L5Q26",                          :precision => 14, :scale => 4
    t.decimal "L6Q1",                           :precision => 14, :scale => 4
    t.decimal "L6Q2",                           :precision => 14, :scale => 4
    t.decimal "L6Q3",                           :precision => 14, :scale => 4
    t.decimal "L6Q4",                           :precision => 14, :scale => 4
    t.decimal "L6Q5",                           :precision => 14, :scale => 4
    t.decimal "L6Q6",                           :precision => 14, :scale => 4
    t.decimal "L6Q7",                           :precision => 14, :scale => 4
    t.decimal "L6Q8",                           :precision => 14, :scale => 4
    t.decimal "L6Q9",                           :precision => 14, :scale => 4
    t.decimal "L6Q10",                          :precision => 14, :scale => 4
    t.decimal "L6Q11",                          :precision => 14, :scale => 4
    t.decimal "L6Q12",                          :precision => 14, :scale => 4
    t.decimal "L6Q13",                          :precision => 14, :scale => 4
    t.decimal "L6Q14",                          :precision => 14, :scale => 4
    t.decimal "L6Q15",                          :precision => 14, :scale => 4
    t.decimal "L6Q16",                          :precision => 14, :scale => 4
    t.decimal "L6Q17",                          :precision => 14, :scale => 4
    t.decimal "L6Q18",                          :precision => 14, :scale => 4
    t.decimal "L6Q19",                          :precision => 14, :scale => 4
    t.decimal "L6Q20",                          :precision => 14, :scale => 4
    t.decimal "L6Q21",                          :precision => 14, :scale => 4
    t.decimal "L6Q22",                          :precision => 14, :scale => 4
    t.decimal "L6Q23",                          :precision => 14, :scale => 4
    t.decimal "L6Q24",                          :precision => 14, :scale => 4
    t.decimal "L6Q25",                          :precision => 14, :scale => 4
    t.decimal "L6Q26",                          :precision => 14, :scale => 4
    t.decimal "L7Q1",                           :precision => 14, :scale => 4
    t.decimal "L7Q2",                           :precision => 14, :scale => 4
    t.decimal "L7Q3",                           :precision => 14, :scale => 4
    t.decimal "L7Q4",                           :precision => 14, :scale => 4
    t.decimal "L7Q5",                           :precision => 14, :scale => 4
    t.decimal "L7Q6",                           :precision => 14, :scale => 4
    t.decimal "L7Q7",                           :precision => 14, :scale => 4
    t.decimal "L7Q8",                           :precision => 14, :scale => 4
    t.decimal "L7Q9",                           :precision => 14, :scale => 4
    t.decimal "L7Q10",                          :precision => 14, :scale => 4
    t.decimal "L7Q11",                          :precision => 14, :scale => 4
    t.decimal "L7Q12",                          :precision => 14, :scale => 4
    t.decimal "L7Q13",                          :precision => 14, :scale => 4
    t.decimal "L7Q14",                          :precision => 14, :scale => 4
    t.decimal "L7Q15",                          :precision => 14, :scale => 4
    t.decimal "L7Q16",                          :precision => 14, :scale => 4
    t.decimal "L7Q17",                          :precision => 14, :scale => 4
    t.decimal "L7Q18",                          :precision => 14, :scale => 4
    t.decimal "L7Q19",                          :precision => 14, :scale => 4
    t.decimal "L7Q20",                          :precision => 14, :scale => 4
    t.decimal "L7Q21",                          :precision => 14, :scale => 4
    t.decimal "L7Q22",                          :precision => 14, :scale => 4
    t.decimal "L7Q23",                          :precision => 14, :scale => 4
    t.decimal "L7Q24",                          :precision => 14, :scale => 4
    t.decimal "L7Q25",                          :precision => 14, :scale => 4
    t.decimal "L7Q26",                          :precision => 14, :scale => 4
    t.decimal "L8Q1",                           :precision => 14, :scale => 4
    t.decimal "L8Q2",                           :precision => 14, :scale => 4
    t.decimal "L8Q3",                           :precision => 14, :scale => 4
    t.decimal "L8Q4",                           :precision => 14, :scale => 4
    t.decimal "L8Q5",                           :precision => 14, :scale => 4
    t.decimal "L8Q6",                           :precision => 14, :scale => 4
    t.decimal "L8Q7",                           :precision => 14, :scale => 4
    t.decimal "L8Q8",                           :precision => 14, :scale => 4
    t.decimal "L8Q9",                           :precision => 14, :scale => 4
    t.decimal "L8Q10",                          :precision => 14, :scale => 4
    t.decimal "L8Q11",                          :precision => 14, :scale => 4
    t.decimal "L8Q12",                          :precision => 14, :scale => 4
    t.decimal "L8Q13",                          :precision => 14, :scale => 4
    t.decimal "L8Q14",                          :precision => 14, :scale => 4
    t.decimal "L8Q15",                          :precision => 14, :scale => 4
    t.decimal "L8Q16",                          :precision => 14, :scale => 4
    t.decimal "L8Q17",                          :precision => 14, :scale => 4
    t.decimal "L8Q18",                          :precision => 14, :scale => 4
    t.decimal "L8Q19",                          :precision => 14, :scale => 4
    t.decimal "L8Q20",                          :precision => 14, :scale => 4
    t.decimal "L8Q21",                          :precision => 14, :scale => 4
    t.decimal "L8Q22",                          :precision => 14, :scale => 4
    t.decimal "L8Q23",                          :precision => 14, :scale => 4
    t.decimal "L8Q24",                          :precision => 14, :scale => 4
    t.decimal "L8Q25",                          :precision => 14, :scale => 4
    t.decimal "L8Q26",                          :precision => 14, :scale => 4
    t.decimal "L9Q1",                           :precision => 14, :scale => 4
    t.decimal "L9Q2",                           :precision => 14, :scale => 4
    t.decimal "L9Q3",                           :precision => 14, :scale => 4
    t.decimal "L9Q4",                           :precision => 14, :scale => 4
    t.decimal "L9Q5",                           :precision => 14, :scale => 4
    t.decimal "L9Q6",                           :precision => 14, :scale => 4
    t.decimal "L9Q7",                           :precision => 14, :scale => 4
    t.decimal "L9Q8",                           :precision => 14, :scale => 4
    t.decimal "L9Q9",                           :precision => 14, :scale => 4
    t.decimal "L9Q10",                          :precision => 14, :scale => 4
    t.decimal "L9Q11",                          :precision => 14, :scale => 4
    t.decimal "L9Q12",                          :precision => 14, :scale => 4
    t.decimal "L9Q13",                          :precision => 14, :scale => 4
    t.decimal "L9Q14",                          :precision => 14, :scale => 4
    t.decimal "L9Q15",                          :precision => 14, :scale => 4
    t.decimal "L9Q16",                          :precision => 14, :scale => 4
    t.decimal "L9Q17",                          :precision => 14, :scale => 4
    t.decimal "L9Q18",                          :precision => 14, :scale => 4
    t.decimal "L9Q19",                          :precision => 14, :scale => 4
    t.decimal "L9Q20",                          :precision => 14, :scale => 4
    t.decimal "L9Q21",                          :precision => 14, :scale => 4
    t.decimal "L9Q22",                          :precision => 14, :scale => 4
    t.decimal "L9Q23",                          :precision => 14, :scale => 4
    t.decimal "L9Q24",                          :precision => 14, :scale => 4
    t.decimal "L9Q25",                          :precision => 14, :scale => 4
    t.decimal "L9Q26",                          :precision => 14, :scale => 4
    t.decimal "L10Q1",                          :precision => 14, :scale => 4
    t.decimal "L10Q2",                          :precision => 14, :scale => 4
    t.decimal "L10Q3",                          :precision => 14, :scale => 4
    t.decimal "L10Q4",                          :precision => 14, :scale => 4
    t.decimal "L10Q5",                          :precision => 14, :scale => 4
    t.decimal "L10Q6",                          :precision => 14, :scale => 4
    t.decimal "L10Q7",                          :precision => 14, :scale => 4
    t.decimal "L10Q8",                          :precision => 14, :scale => 4
    t.decimal "L10Q9",                          :precision => 14, :scale => 4
    t.decimal "L10Q10",                         :precision => 14, :scale => 4
    t.decimal "L10Q11",                         :precision => 14, :scale => 4
    t.decimal "L10Q12",                         :precision => 14, :scale => 4
    t.decimal "L10Q13",                         :precision => 14, :scale => 4
    t.decimal "L10Q14",                         :precision => 14, :scale => 4
    t.decimal "L10Q15",                         :precision => 14, :scale => 4
    t.decimal "L10Q16",                         :precision => 14, :scale => 4
    t.decimal "L10Q17",                         :precision => 14, :scale => 4
    t.decimal "L10Q18",                         :precision => 14, :scale => 4
    t.decimal "L10Q19",                         :precision => 14, :scale => 4
    t.decimal "L10Q20",                         :precision => 14, :scale => 4
    t.decimal "L10Q21",                         :precision => 14, :scale => 4
    t.decimal "L10Q22",                         :precision => 14, :scale => 4
    t.decimal "L10Q23",                         :precision => 14, :scale => 4
    t.decimal "L10Q24",                         :precision => 14, :scale => 4
    t.decimal "L10Q25",                         :precision => 14, :scale => 4
    t.decimal "L10Q26",                         :precision => 14, :scale => 4
    t.string  "UserID",           :limit => 30
    t.string  "fcFac",            :limit => 20
    t.integer "SEQNO"
    t.string  "cBatchName",       :limit => 15
    t.string  "cSource",          :limit => 1
    t.binary  "timestamp_column"
    t.string  "fprodcl",          :limit => 2
    t.string  "fgroup",           :limit => 6
    t.string  "fabccode",         :limit => 1
    t.string  "fbuyer",           :limit => 3
    t.string  "cAggregate",       :limit => 1,                                 :null => false
    t.decimal "fonhand",                        :precision => 17, :scale => 4, :null => false
    t.decimal "fsafety",                        :precision => 17, :scale => 4, :null => false
    t.string  "Link_fld2",        :limit => 25,                                :null => false
  end

  add_index "DBRRSQ", ["fcFac", "UserID", "cBatchName", "LINK_FLD"], :name => "byfacility"

  create_table "DBRcmRP", :primary_key => "identity_column", :force => true do |t|
    t.string  "USERID",           :limit => 15,                                :null => false
    t.string  "FACILITYID",       :limit => 20,                                :null => false
    t.string  "SDTYPE",           :limit => 10,                                :null => false
    t.string  "WSSONO",           :limit => 15,                                :null => false
    t.string  "SOURCE",           :limit => 10,                                :null => false
    t.string  "OUTQTYSPLY",       :limit => 14,                                :null => false
    t.string  "OUTQTYDMND",       :limit => 14,                                :null => false
    t.string  "SHOWDATE",         :limit => 10,                                :null => false
    t.decimal "PAB1",                           :precision => 14, :scale => 5, :null => false
    t.decimal "PAB2",                           :precision => 14, :scale => 5, :null => false
    t.binary  "timestamp_column"
  end

  add_index "DBRcmRP", ["USERID", "FACILITYID"], :name => "byfacility"
  add_index "DBRcmRP", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "DBRpla", :primary_key => "identity_column", :force => true do |t|
    t.string  "USERID",           :limit => 15,                                :null => false
    t.string  "FACILITYID",       :limit => 20,                                :null => false
    t.string  "CBATCHNAME",       :limit => 15,                                :null => false
    t.string  "Type",             :limit => 15,                                :null => false
    t.string  "EXCEPTTYPE",       :limit => 15,                                :null => false
    t.string  "SOItemKey",        :limit => 14,                                :null => false
    t.string  "PartKey",          :limit => 29,                                :null => false
    t.string  "PARTNO",           :limit => 25,                                :null => false
    t.string  "REV",              :limit => 3,                                 :null => false
    t.string  "DESCRIPTION",      :limit => 35,                                :null => false
    t.string  "JOBNO",            :limit => 10,                                :null => false
    t.string  "SONO",             :limit => 6,                                 :null => false
    t.string  "ENUMBER",          :limit => 3,                                 :null => false
    t.string  "INUMBER",          :limit => 3,                                 :null => false
    t.string  "RELEASENO",        :limit => 3,                                 :null => false
    t.string  "CSTATUS",          :limit => 10,                                :null => false
    t.string  "SOURCE",           :limit => 1,                                 :null => false
    t.decimal "QTY",                            :precision => 14, :scale => 5, :null => false
    t.string  "DUEDATE",          :limit => 10,                                :null => false
    t.string  "SCHEDDATE",        :limit => 10,                                :null => false
    t.decimal "PQTY",                           :precision => 14, :scale => 5, :null => false
    t.string  "PDUEDATE",         :limit => 10,                                :null => false
    t.string  "PSCHEDDATE",       :limit => 10,                                :null => false
    t.string  "CTEXT",            :limit => 80,                                :null => false
    t.binary  "timestamp_column"
  end

  add_index "DBRpla", ["USERID", "CBATCHNAME", "FACILITYID"], :name => "byfacility"
  add_index "DBRpla", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "DBRplmrp", :primary_key => "identity_column", :force => true do |t|
    t.string  "PARTNO",           :limit => 25,                                :null => false
    t.string  "REV",              :limit => 3,                                 :null => false
    t.string  "JOBNO",            :limit => 10,                                :null => false
    t.string  "CSTATUS",          :limit => 10,                                :null => false
    t.string  "SONO",             :limit => 6,                                 :null => false
    t.string  "ENUMBER",          :limit => 3,                                 :null => false
    t.string  "RELEASENO",        :limit => 3,                                 :null => false
    t.string  "SOURCE",           :limit => 1,                                 :null => false
    t.decimal "QTY",                            :precision => 14, :scale => 5, :null => false
    t.string  "DUEDATE",          :limit => 10,                                :null => false
    t.decimal "PQTY",                           :precision => 14, :scale => 5, :null => false
    t.string  "PDUEDATE",         :limit => 10,                                :null => false
    t.binary  "timestamp_column"
    t.string  "ExceptType",       :limit => 15,                                :null => false
  end

  add_index "DBRplmrp", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "DBRstage", :id => false, :force => true do |t|
    t.string "UpdateType",       :limit => 6
    t.string "ObjectType",       :limit => 10
    t.string "KeyFlds",          :limit => 100
    t.string "KeyVals",          :limit => 200
    t.string "KeyTypes",         :limit => 10
    t.string "ModFlds",          :limit => 500
    t.string "ModVals",          :limit => 2048
    t.string "ModTypes",         :limit => 50
    t.binary "Timestamp_Column"
  end

  create_table "DuplicateIndexes", :id => false, :force => true do |t|
    t.string "TABLE_NAME", :limit => 128,  :null => false
    t.string "name",       :limit => 128,  :null => false
    t.string "expr",       :limit => 2000, :null => false
    t.string "col1",       :limit => 128
    t.string "col2",       :limit => 128
    t.string "col3",       :limit => 128
    t.string "col4",       :limit => 128
    t.string "col5",       :limit => 128
    t.string "col6",       :limit => 128
    t.string "col7",       :limit => 128
    t.string "col8",       :limit => 128
    t.string "col9",       :limit => 128
  end

  create_table "FacilityDominantIndexes", :id => false, :force => true do |t|
    t.string  "TableName",   :limit => 128, :null => false
    t.string  "IndexName",   :limit => 128, :null => false
    t.string  "Col1",        :limit => 128, :null => false
    t.string  "Col2",        :limit => 128, :null => false
    t.string  "Col3",        :limit => 128
    t.string  "Col4",        :limit => 128
    t.string  "Col5",        :limit => 128
    t.string  "Col6",        :limit => 128
    t.string  "Col7",        :limit => 128
    t.string  "Col8",        :limit => 128
    t.string  "Col9",        :limit => 128
    t.string  "Col10",       :limit => 128
    t.string  "Col11",       :limit => 128
    t.string  "Col12",       :limit => 128
    t.string  "Col13",       :limit => 128
    t.string  "Col14",       :limit => 128
    t.string  "Col15",       :limit => 128
    t.string  "Col16",       :limit => 128
    t.boolean "IsClustered"
    t.boolean "IsUnique"
  end

  create_table "INUM", :primary_key => "identity_column", :force => true do |t|
    t.integer  "FICSPOPUPI",                                                                     :null => false
    t.binary   "timestamp_column"
    t.boolean  "FLISSCALAR",                                                                     :null => false
    t.boolean  "FLISSTD",                                                                        :null => false
    t.string   "FCUSRCHR1",        :limit => 20,                                                 :null => false
    t.string   "FCUSRCHR2",        :limit => 40,                                :default => " ", :null => false
    t.string   "FCUSRCHR3",        :limit => 40,                                :default => " ", :null => false
    t.decimal  "FNUSRQTY1",                      :precision => 16, :scale => 5,                  :null => false
    t.decimal  "FNUSRCUR1",                      :precision => 19, :scale => 5,                  :null => false
    t.datetime "FDUSRDATE1",                                                                     :null => false
    t.text     "FMUSRMEMO1",                                                    :default => " ", :null => false
  end

  add_index "INUM", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "INUMCONV", :primary_key => "identity_column", :force => true do |t|
    t.integer "FIFROMUM",                                         :null => false
    t.binary  "timestamp_column"
    t.integer "FITOUM",                                           :null => false
    t.boolean "FLFORMULA",                                        :null => false
    t.string  "FCFORMULA",        :limit => 254, :default => " ", :null => false
    t.integer "FIPART",                                           :null => false
    t.integer "FICUST",                                           :null => false
    t.integer "FIVEND",                                           :null => false
  end

  add_index "INUMCONV", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "ISO", :primary_key => "identity_column", :force => true do |t|
    t.string   "isono",            :limit => 10
    t.string   "idono",            :limit => 10
    t.string   "dfac",             :limit => 20
    t.string   "sfac",             :limit => 20
    t.string   "status",           :limit => 25
    t.string   "partno",           :limit => 25
    t.string   "partrev",          :limit => 3
    t.datetime "duedate"
    t.decimal  "quantity",                       :precision => 15, :scale => 5
    t.decimal  "qtyrecd",                        :precision => 15, :scale => 5
    t.binary   "timestamp_column"
    t.string   "jobno",            :limit => 10
    t.string   "sono",             :limit => 6
    t.string   "source",           :limit => 1
    t.string   "jo_bominum",       :limit => 4,                                 :default => "", :null => false
    t.string   "so_itemno",        :limit => 3,                                 :default => "", :null => false
    t.string   "so_rel",           :limit => 3,                                 :default => "", :null => false
    t.string   "fcudrev",          :limit => 3,                                 :default => "", :null => false
    t.integer  "fndbrmod",         :limit => 1,                                                 :null => false
    t.datetime "SchedDate",                                                                     :null => false
  end

  add_index "ISO", ["identity_column"], :name => "identity_column_idx1", :unique => true
  add_index "ISO", ["isono"], :name => "IX_ISONO"
  add_index "ISO", ["jobno", "jo_bominum"], :name => "jobitem"
  add_index "ISO", ["sono", "so_itemno", "so_rel"], :name => "sorelease"

  create_table "InOnHdDl", :primary_key => "identity_column", :force => true do |t|
    t.integer "fiInOnHdID",                                                         :null => false
    t.binary  "timestamp_column"
    t.integer "fiType",                                          :default => 0,     :null => false
    t.integer "fiQty",                                           :default => 0,     :null => false
    t.boolean "flPartial",                                       :default => false, :null => false
    t.integer "fiUM1"
    t.decimal "fnSize1",          :precision => 18, :scale => 5
    t.integer "fiUM2"
    t.decimal "fnSize2",          :precision => 18, :scale => 5
    t.integer "fiUM3"
    t.decimal "fnSize3",          :precision => 18, :scale => 5
    t.integer "fiUM4"
    t.decimal "fnSize4",          :precision => 18, :scale => 5
    t.integer "fiUM5"
    t.decimal "fnSize5",          :precision => 18, :scale => 5
    t.integer "fiCount",                                         :default => 0,     :null => false
  end

  add_index "InOnHdDl", ["fiInOnHdID", "fiType"], :name => "InOnHdIDType"
  add_index "InOnHdDl", ["fiInOnHdID", "fnSize1", "fnSize2", "fnSize3", "fnSize4", "fnSize5"], :name => "Qtys"
  add_index "InOnHdDl", ["identity_column"], :name => "identity_column_idx1"

  create_table "InTranDl", :primary_key => "identity_column", :force => true do |t|
    t.integer "fiInTranID",                                                         :null => false
    t.integer "fiType",                                          :default => 0,     :null => false
    t.boolean "flPartial",                                       :default => false, :null => false
    t.integer "fiQty",                                                              :null => false
    t.decimal "fnQty1",           :precision => 16, :scale => 5
    t.integer "fiUM1"
    t.decimal "fnQty2",           :precision => 16, :scale => 5
    t.integer "fiUM2"
    t.decimal "fnQty3",           :precision => 16, :scale => 5
    t.integer "fiUM3"
    t.decimal "fnQty4",           :precision => 16, :scale => 5
    t.integer "fiUM4"
    t.decimal "fnQty5",           :precision => 16, :scale => 5
    t.integer "fiUM5"
    t.binary  "timestamp_column"
  end

  add_index "InTranDl", ["identity_column"], :name => "identity_column_idx1"

  create_table "M2MDBVersion", :id => false, :force => true do |t|
    t.decimal "Version",                 :precision => 10, :scale => 4, :default => 0.0, :null => false
    t.string  "SystemDB", :limit => 128
  end

  create_table "M2MDeleteLog", :primary_key => "RecordID", :force => true do |t|
    t.string   "UserName",    :limit => 30,  :null => false
    t.integer  "UserSPID",    :limit => 2,   :null => false
    t.datetime "LogDate",                    :null => false
    t.string   "Workstation", :limit => 30,  :null => false
    t.string   "LogInfo",     :limit => 256, :null => false
  end

  add_index "M2MDeleteLog", ["RecordID"], :name => "RecordID"

  create_table "M2MPOUPDATE", :id => false, :force => true do |t|
    t.string   "UserName", :limit => 30,  :null => false
    t.integer  "UserSPID", :limit => 2,   :null => false
    t.datetime "LogDate",                 :null => false
    t.string   "SQLStmt",  :limit => 256, :null => false
    t.integer  "RecordID"
  end

  create_table "M2MS2SUtIndexKeys", :id => false, :force => true do |t|
    t.string "TABLE_NAME", :limit => 128, :null => false
    t.string "INDEX_NAME", :limit => 128, :null => false
    t.string "EXPR",       :limit => 100, :null => false
  end

  create_table "SQLIDX$", :primary_key => "identity_column", :force => true do |t|
    t.string "ctable"
    t.string "cindex"
    t.string "cfield"
    t.binary "timestamp_column"
  end

  add_index "SQLIDX$", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "ShSrceDl", :primary_key => "identity_column", :force => true do |t|
    t.integer "FiShSrceID",                                      :null => false
    t.binary  "timestamp_column"
    t.integer "FITYPE",                                          :null => false
    t.integer "FIQTY",                                           :null => false
    t.boolean "FLPARTIAL",                                       :null => false
    t.integer "FIUM1"
    t.decimal "FNSIZE1",          :precision => 16, :scale => 5
    t.integer "FIUM2"
    t.decimal "FNSIZE2",          :precision => 16, :scale => 5
    t.integer "FIUM3"
    t.decimal "FNSIZE3",          :precision => 16, :scale => 5
    t.integer "FIUM4"
    t.decimal "FNSIZE4",          :precision => 16, :scale => 5
    t.integer "FIUM5"
    t.decimal "fnSize5",          :precision => 16, :scale => 5
  end

  add_index "ShSrceDl", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "Test", :id => false, :force => true do |t|
    t.string "PropertyValue"
    t.string "ColPrecision"
    t.string "ColScale"
    t.string "Length"
    t.string "PropertyName"
    t.string "PropertyType"
    t.string "ColumnName"
    t.string "TableName"
    t.string "IndexName"
    t.string "ColType"
  end

  create_table "apchac", :primary_key => "identity_column", :force => true do |t|
    t.string  "fcacctno",         :limit => 25,                                                 :null => false
    t.string  "fcglacct",         :limit => 25,                                                 :null => false
    t.integer "fnnextchkn",                                                                     :null => false
    t.integer "fncheckdtl",       :limit => nil, :precision => 2, :scale => 0,                  :null => false
    t.integer "fnchkstub",        :limit => nil, :precision => 2, :scale => 0,                  :null => false
    t.string  "fccurid",          :limit => 3,                                                  :null => false
    t.string  "fccurlabel",       :limit => 35,                                :default => " ", :null => false
    t.binary  "timestamp_column"
    t.text    "fcchecklay",                                                    :default => " ", :null => false
  end

  add_index "apchac", ["fcacctno"], :name => "apchac_fcacctno", :unique => true
  add_index "apchac", ["fcglacct"], :name => "glacctno"
  add_index "apchac", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "apdist", :primary_key => "identity_column", :force => true do |t|
    t.string   "fcacctnum",        :limit => 25,                                                 :null => false
    t.string   "fccashid",         :limit => 35,                                :default => " ", :null => false
    t.string   "fcinvoice",        :limit => 20,                                                 :null => false
    t.string   "fcstatus",         :limit => 1,                                                  :null => false
    t.datetime "fctime_ts",                                                                      :null => false
    t.string   "fctype",           :limit => 1,                                                  :null => false
    t.string   "fcuserid",         :limit => 4,                                                  :null => false
    t.datetime "fddate",                                                                         :null => false
    t.decimal  "fnamount",                                                                       :null => false
    t.string   "fccurid",          :limit => 3,                                                  :null => false
    t.decimal  "fcfactor",                       :precision => 17, :scale => 5,                  :null => false
    t.decimal  "feurofctr",                      :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fneuroamt",                                                                      :null => false
    t.decimal  "fntxnamt",                                                                       :null => false
    t.string   "fccashnum",        :limit => 20,                                                 :null => false
    t.binary   "timestamp_column"
  end

  add_index "apdist", ["fcacctnum", "fddate"], :name => "ACCT_DATE"
  add_index "apdist", ["fccashid"], :name => "fccashid"
  add_index "apdist", ["fcinvoice"], :name => "fcinvoice"
  add_index "apdist", ["fcstatus"], :name => "fcstatus"
  add_index "apdist", ["fctime_ts"], :name => "timestamp"
  add_index "apdist", ["fctype", "fcinvoice", "fcacctnum", "fccashid", "fctime_ts"], :name => "DIST_KEY"
  add_index "apdist", ["fctype", "fcinvoice", "fccashid"], :name => "DISTUPDTE"
  add_index "apdist", ["fddate"], :name => "fddate"
  add_index "apdist", ["fnamount"], :name => "amount"
  add_index "apdist", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "apitem", :primary_key => "identity_column", :force => true do |t|
    t.string   "fapp_by",          :limit => 3,                                                  :null => false
    t.datetime "fapp_dt",                                                                        :null => false
    t.string   "fccredit",         :limit => 25,                                                 :null => false
    t.string   "fcdebit",          :limit => 25,                                                 :null => false
    t.string   "fcinvkey",         :limit => 26,                                :default => " ", :null => false
    t.string   "fcpocat",          :limit => 8,                                                  :null => false
    t.string   "fcprodcl",         :limit => 2,                                                  :null => false
    t.string   "fcsojokey",        :limit => 12,                                                 :null => false
    t.string   "fcsource",         :limit => 1,                                                  :null => false
    t.string   "fcstatus",         :limit => 1,                                                  :null => false
    t.string   "fctype",           :limit => 1,                                                  :null => false
    t.boolean  "flisvuom",                                                                       :null => false
    t.decimal  "finvqty",                        :precision => 17, :scale => 5,                  :null => false
    t.string   "fitemno",          :limit => 6,                                                  :null => false
    t.string   "fmeasure",         :limit => 3,                                                  :null => false
    t.decimal  "fndiscrate",                     :precision => 7,  :scale => 3,                  :null => false
    t.decimal  "fndisamt",                                                                       :null => false
    t.decimal  "fnexpcost",                      :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fnunit",                         :precision => 17, :scale => 5,                  :null => false
    t.string   "fpartno",          :limit => 25,                                                 :null => false
    t.string   "frev",             :limit => 3,                                                  :null => false
    t.string   "fpokey",           :limit => 12,                                                 :null => false
    t.decimal  "fprice",                                                                         :null => false
    t.string   "frecvkey",         :limit => 9,                                                  :null => false
    t.decimal  "fvconvfact",                     :precision => 11, :scale => 5,                  :null => false
    t.string   "fvmeasure",        :limit => 5,                                                  :null => false
    t.string   "fvpartno",         :limit => 25,                                                 :null => false
    t.decimal  "fvqtyinv",                       :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fvucost",                        :precision => 17, :scale => 5,                  :null => false
    t.string   "fcshipkey",        :limit => 12,                                                 :null => false
    t.decimal  "feuroprice",                                                                     :null => false
    t.decimal  "fneurdisamt",                                                                    :null => false
    t.decimal  "fneurounit",                     :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fnexpeurcost",                   :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fnexptxncost",                   :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fntxndisamt",                                                                    :null => false
    t.decimal  "fntxnunit",                      :precision => 17, :scale => 5,                  :null => false
    t.decimal  "ftxnprice",                                                                      :null => false
    t.decimal  "fvueurocost",                    :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fvutxncost",                     :precision => 17, :scale => 5,                  :null => false
    t.boolean  "fljrdif",                                                                        :null => false
    t.boolean  "flistaxabl",                                                                     :null => false
    t.string   "fctaxitemno",      :limit => 6,                                                  :null => false
    t.string   "fctaxcode",        :limit => 10,                                                 :null => false
    t.binary   "timestamp_column"
    t.text     "fmdescr",                                                       :default => " ", :null => false
    t.text     "fmnotes",                                                       :default => " ", :null => false
    t.text     "fvptdes",                                                       :default => " ", :null => false
    t.string   "fac",              :limit => 20,                                                 :null => false
    t.string   "fcudrev",          :limit => 3,                                 :default => " ", :null => false
  end

  add_index "apitem", ["fccredit"], :name => "credit"
  add_index "apitem", ["fcdebit"], :name => "debit"
  add_index "apitem", ["fcinvkey", "fitemno"], :name => "apitem_itemkey", :unique => true
  add_index "apitem", ["fcshipkey"], :name => "shipkey"
  add_index "apitem", ["fcsojokey"], :name => "sojokey"
  add_index "apitem", ["fcsource"], :name => "source"
  add_index "apitem", ["fcstatus"], :name => "status"
  add_index "apitem", ["fctype"], :name => "type"
  add_index "apitem", ["fpartno", "frev", "fac"], :name => "partno"
  add_index "apitem", ["fpokey"], :name => "pokey"
  add_index "apitem", ["frecvkey"], :name => "recvkey"
  add_index "apitem", ["fvpartno"], :name => "vpartno"
  add_index "apitem", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "apmast", :primary_key => "identity_column", :force => true do |t|
    t.string   "fcinvoice",        :limit => 20,                                                 :null => false
    t.string   "fvendno",          :limit => 6,                                                  :null => false
    t.string   "fccompany",        :limit => 35,                                :default => " ", :null => false
    t.decimal  "fnamount",                                                                       :null => false
    t.decimal  "fpaid",                                                                          :null => false
    t.string   "fccity",           :limit => 20,                                                 :null => false
    t.string   "fcstate",          :limit => 20,                                                 :null => false
    t.decimal  "fadjamt",                                                                        :null => false
    t.decimal  "fapppay",                                                                        :null => false
    t.decimal  "fnappadj",                                                                       :null => false
    t.decimal  "fnappdis",                                                                       :null => false
    t.string   "fccheckref",       :limit => 20,                                                 :null => false
    t.string   "fccountry",        :limit => 25,                                                 :null => false
    t.string   "fccurid",          :limit => 3,                                                  :null => false
    t.decimal  "fcfactor",                       :precision => 17, :scale => 5,                  :null => false
    t.string   "fcsource",         :limit => 1,                                                  :null => false
    t.string   "fcstatus",         :limit => 1,                                                  :null => false
    t.string   "fctermsid",        :limit => 4,                                                  :null => false
    t.string   "fczip",            :limit => 10,                                                 :null => false
    t.decimal  "fdebit",                                                                         :null => false
    t.datetime "fdfactdate",                                                                     :null => false
    t.decimal  "fdiscamt",                                                                       :null => false
    t.datetime "fdiscdate",                                                                      :null => false
    t.decimal  "fdisctake",                                                                      :null => false
    t.datetime "fduedate",                                                                       :null => false
    t.decimal  "ffreight",                                                                       :null => false
    t.datetime "fgldisdate",                                                                     :null => false
    t.datetime "finvdate",                                                                       :null => false
    t.string   "finvtype",         :limit => 2,                                                  :null => false
    t.datetime "flpaydate",                                                                      :null => false
    t.decimal  "flpayment",                                                                      :null => false
    t.decimal  "fltxnpaymt",                                                                     :null => false
    t.decimal  "fleurpaymt",                                                                     :null => false
    t.boolean  "flisprint",                                                                      :null => false
    t.boolean  "flpostnow",                                                                      :null => false
    t.decimal  "fncredits",                                                                      :null => false
    t.decimal  "fncurex",                                                                        :null => false
    t.decimal  "fngoodsamt",                                                                     :null => false
    t.decimal  "fnondisc",                                                                       :null => false
    t.integer  "fnpaytype",                                                                      :null => false
    t.string   "fpono",            :limit => 6,                                                  :null => false
    t.string   "freceiver",        :limit => 6,                                                  :null => false
    t.string   "freturn",          :limit => 1,                                                  :null => false
    t.string   "frmpono",          :limit => 6,                                                  :null => false
    t.decimal  "ftaxamt",                                                                        :null => false
    t.integer  "furgency",                                                                       :null => false
    t.decimal  "fappeurpay",                                                                     :null => false
    t.decimal  "fapptxnpay",                                                                     :null => false
    t.datetime "fdeurodate",                                                                     :null => false
    t.decimal  "feurofctr",                      :precision => 17, :scale => 5,                  :null => false
    t.decimal  "feuradjamt",                                                                     :null => false
    t.decimal  "feurapadj",                                                                      :null => false
    t.decimal  "feurapdis",                                                                      :null => false
    t.decimal  "feurdistk",                                                                      :null => false
    t.decimal  "feuropaid",                                                                      :null => false
    t.decimal  "ftxnadjamt",                                                                     :null => false
    t.decimal  "ftxnapadj",                                                                      :null => false
    t.decimal  "ftxnapdis",                                                                      :null => false
    t.decimal  "ftxndistk",                                                                      :null => false
    t.decimal  "ftxnpaid",                                                                       :null => false
    t.string   "fcurrpaid",        :limit => 1,                                                  :null => false
    t.datetime "fdvoiddate",                                                                     :null => false
    t.boolean  "flduechng",                                                                      :null => false
    t.boolean  "flpremcv",                                                                       :null => false
    t.datetime "fdtaxpoint",                                                                     :null => false
    t.binary   "timestamp_column"
    t.text     "fmnotes",                                                       :default => " ", :null => false
    t.text     "fmstreet",                                                      :default => " ", :null => false
  end

  add_index "apmast", ["fccompany"], :name => "company"
  add_index "apmast", ["fcinvoice", "fvendno"], :name => "apmast_vend_inv", :unique => true
  add_index "apmast", ["fcsource"], :name => "source"
  add_index "apmast", ["fcstatus"], :name => "status"
  add_index "apmast", ["fdiscamt"], :name => "discamt"
  add_index "apmast", ["fdiscdate"], :name => "discdate"
  add_index "apmast", ["fduedate"], :name => "duedate"
  add_index "apmast", ["fgldisdate"], :name => "gldate"
  add_index "apmast", ["finvdate"], :name => "invdate"
  add_index "apmast", ["finvtype"], :name => "invtype"
  add_index "apmast", ["fnamount"], :name => "amount"
  add_index "apmast", ["furgency"], :name => "urgency"
  add_index "apmast", ["fvendno"], :name => "prepay"
  add_index "apmast", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "aptax", :primary_key => "identity_column", :force => true do |t|
    t.string  "fvendno",          :limit => 6,                                :null => false
    t.string  "fcinvoice",        :limit => 20,                               :null => false
    t.string  "fitemno",          :limit => 6,                                :null => false
    t.string  "fcjrdict",         :limit => 10,                               :null => false
    t.string  "fctaxcode",        :limit => 10,                               :null => false
    t.integer "fnorder",                                                      :null => false
    t.decimal "fnrate",                         :precision => 7, :scale => 3, :null => false
    t.binary  "timestamp_column"
  end

  add_index "aptax", ["fcinvoice"], :name => "INVNO"
  add_index "aptax", ["fvendno", "fcinvoice", "fitemno", "fnorder"], :name => "JRAPORDER"
  add_index "aptax", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "apvend", :primary_key => "identity_column", :force => true do |t|
    t.string   "fvendno",          :limit => 6,                                                  :null => false
    t.string   "fcompany",         :limit => 35,                                :default => " ", :null => false
    t.decimal  "fbal",                                                                           :null => false
    t.string   "fbuyer",           :limit => 3,                                                  :null => false
    t.string   "fcacctnum",        :limit => 25,                                                 :null => false
    t.string   "fccusno",          :limit => 20,                                                 :null => false
    t.string   "fcdefshpto",       :limit => 4,                                                  :null => false
    t.string   "fcity",            :limit => 20,                                                 :null => false
    t.string   "fcountry",         :limit => 25,                                                 :null => false
    t.string   "fcfname",          :limit => 15,                                                 :null => false
    t.string   "fcontact",         :limit => 20,                                                 :null => false
    t.string   "fcshipvia",        :limit => 20,                                                 :null => false
    t.string   "fcterms",          :limit => 4,                                                  :null => false
    t.string   "fccurid",          :limit => 3,                                                  :null => false
    t.string   "fcuser1",          :limit => 40,                                :default => " ", :null => false
    t.string   "fcuser2",          :limit => 40,                                :default => " ", :null => false
    t.string   "fcuser3",          :limit => 40,                                :default => " ", :null => false
    t.datetime "fduser1",                                                                        :null => false
    t.datetime "fdsince",                                                                        :null => false
    t.string   "ffax",             :limit => 20,                                                 :null => false
    t.boolean  "fiso9000",                                                                       :null => false
    t.decimal  "flimit",                                                                         :null => false
    t.boolean  "fllongdist",                                                                     :null => false
    t.datetime "flpaydate",                                                                      :null => false
    t.decimal  "flpayment",                                                                      :null => false
    t.decimal  "fnminamt",                                                                       :null => false
    t.decimal  "fnuser1",                        :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fnuser2",                        :precision => 17, :scale => 5,                  :null => false
    t.string   "fphone",           :limit => 20,                                                 :null => false
    t.decimal  "fprepaid",                                                                       :null => false
    t.decimal  "fsalestax",                      :precision => 7,  :scale => 3,                  :null => false
    t.string   "fstate",           :limit => 20,                                                 :null => false
    t.string   "fstatus",          :limit => 1,                                                  :null => false
    t.integer  "furgency",                                                                       :null => false
    t.decimal  "fdramt",                                                                         :null => false
    t.string   "fvtype",           :limit => 2,                                                  :null => false
    t.decimal  "fytdpur",                                                                        :null => false
    t.string   "fzip",             :limit => 10,                                                 :null => false
    t.boolean  "f1099",                                                                          :null => false
    t.string   "fcstatus",         :limit => 1,                                                  :null => false
    t.boolean  "flistaxabl",                                                                     :null => false
    t.string   "fcemail",          :limit => 60,                                :default => " ", :null => false
    t.binary   "timestamp_column"
    t.text     "fmstreet",                                                      :default => " ", :null => false
    t.text     "fmuser1",                                                       :default => " ", :null => false
  end

  add_index "apvend", ["fcity"], :name => "city"
  add_index "apvend", ["fcompany"], :name => "company"
  add_index "apvend", ["fdsince"], :name => "vensince"
  add_index "apvend", ["fphone"], :name => "phone"
  add_index "apvend", ["fstatus"], :name => "status"
  add_index "apvend", ["fvendno"], :name => "apvend_vendno", :unique => true
  add_index "apvend", ["fvtype"], :name => "vtype"
  add_index "apvend", ["fytdpur"], :name => "ytdpur"
  add_index "apvend", ["fzip"], :name => "zip"
  add_index "apvend", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "arcom", :primary_key => "identity_column", :force => true do |t|
    t.string  "fcinvoice",        :limit => 20,                               :default => "",    :null => false
    t.string  "finvitem",         :limit => 6,                                :default => "",    :null => false
    t.string  "fsono",            :limit => 6,                                :default => "",    :null => false
    t.string  "finumber",         :limit => 3,                                :default => "",    :null => false
    t.string  "frelease",         :limit => 3,                                :default => "",    :null => false
    t.string  "fsalespn",         :limit => 3,                                :default => "",    :null => false
    t.decimal "fnrate",                         :precision => 8, :scale => 3, :default => 0.0,   :null => false
    t.boolean "flrate2",                                                      :default => false, :null => false
    t.binary  "timestamp_column"
  end

  add_index "arcom", ["fcinvoice", "finvitem"], :name => "invoice"
  add_index "arcom", ["fsono", "finumber", "frelease", "fcinvoice", "fsalespn"], :name => "salespn"
  add_index "arcom", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "ardist", :primary_key => "identity_column", :force => true do |t|
    t.string   "fcacctnum",        :limit => 25,                                                 :null => false
    t.string   "fccashid",         :limit => 35,                                :default => " ", :null => false
    t.string   "fcstatus",         :limit => 1,                                                  :null => false
    t.string   "fcrefclass",       :limit => 1,                                                  :null => false
    t.string   "fcrefname",        :limit => 4,                                                  :null => false
    t.datetime "fctime_ts",                                                                      :null => false
    t.string   "fcuserid",         :limit => 4,                                                  :null => false
    t.datetime "fddate",                                                                         :null => false
    t.decimal  "fnamount",                                                                       :null => false
    t.string   "fccashnum",        :limit => 20,                                                 :null => false
    t.string   "fccurid",          :limit => 3,                                                  :null => false
    t.decimal  "fcfactor",                       :precision => 17, :scale => 5,                  :null => false
    t.decimal  "feurofctr",                      :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fneuroamt",                                                                      :null => false
    t.decimal  "fntxnamt",                                                                       :null => false
    t.binary   "timestamp_column"
  end

  add_index "ardist", ["fcacctnum", "fddate"], :name => "ACCT_DATE"
  add_index "ardist", ["fccashid", "fccashnum"], :name => "ID_NO"
  add_index "ardist", ["fccashnum"], :name => "fccashnum"
  add_index "ardist", ["fcrefclass", "fcrefname", "fcacctnum", "fccashid", "fctime_ts"], :name => "DISTKEY"
  add_index "ardist", ["fcrefclass", "fcrefname", "fcacctnum", "fccashid", "fddate"], :name => "DISTLOOKUP"
  add_index "ardist", ["fcrefclass", "fcrefname", "fccashid", "fddate"], :name => "distupdte"
  add_index "ardist", ["fcrefname"], :name => "refname"
  add_index "ardist", ["fcstatus"], :name => "fcstatus"
  add_index "ardist", ["fctime_ts"], :name => "timestamp"
  add_index "ardist", ["fcuserid"], :name => "userid"
  add_index "ardist", ["fddate"], :name => "fddate"
  add_index "ardist", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "arfinchg", :primary_key => "identity_column", :force => true do |t|
    t.string   "fccredit",         :limit => 25,                               :null => false
    t.string   "fcdebit",          :limit => 25,                               :null => false
    t.string   "fcfreq",           :limit => 1,                                :null => false
    t.datetime "fdlastdate",                                                   :null => false
    t.datetime "fdnextdate",                                                   :null => false
    t.integer  "fndays",                                                       :null => false
    t.decimal  "fnrate",                         :precision => 7, :scale => 3, :null => false
    t.binary   "timestamp_column"
  end

  add_index "arfinchg", ["fdlastdate"], :name => "lastdate"
  add_index "arfinchg", ["fdnextdate"], :name => "nextdate"
  add_index "arfinchg", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "aritem", :primary_key => "identity_column", :force => true do |t|
    t.decimal "fbkordqty",                      :precision => 15, :scale => 5,                    :null => false
    t.string  "fcinvoice",        :limit => 20,                                                   :null => false
    t.decimal "fcost",                                                                            :null => false
    t.string  "fctype",           :limit => 1,                                                    :null => false
    t.string  "fcustno",          :limit => 6,                                                    :null => false
    t.string  "fctaxcode",        :limit => 10,                                                   :null => false
    t.string  "fcuserline",       :limit => 10,                                                   :null => false
    t.decimal "fdiscamt",                                                                         :null => false
    t.decimal "fdisrate",                       :precision => 7,  :scale => 2,                    :null => false
    t.string  "fincacc",          :limit => 25,                                                   :null => false
    t.string  "fitem",            :limit => 6,                                                    :null => false
    t.boolean "flcomm",                                                                           :null => false
    t.boolean "flistaxabl",                                                                       :null => false
    t.string  "fmeasure",         :limit => 3,                                                    :null => false
    t.decimal "fordqty",                        :precision => 15, :scale => 5,                    :null => false
    t.string  "fpartno",          :limit => 25,                                                   :null => false
    t.string  "frev",             :limit => 3,                                                    :null => false
    t.decimal "fprice",                         :precision => 17, :scale => 5,                    :null => false
    t.string  "fprodcl",          :limit => 2,                                                    :null => false
    t.string  "frecvkey",         :limit => 9,                                                    :null => false
    t.string  "fsalesacc",        :limit => 25,                                                   :null => false
    t.string  "fshipkey",         :limit => 12,                                                   :null => false
    t.decimal "fshipqty",                       :precision => 15, :scale => 5,                    :null => false
    t.string  "fsokey",           :limit => 12,                                                   :null => false
    t.string  "fsoldby",          :limit => 3,                                                    :null => false
    t.decimal "ftotprice",                                                                        :null => false
    t.decimal "fdisceuramt",                                                                      :null => false
    t.decimal "fdisctxnamt",                                                                      :null => false
    t.decimal "feuroprice",                     :precision => 17, :scale => 5,                    :null => false
    t.decimal "ftoteurprice",                                                                     :null => false
    t.decimal "ftottxnprice",                                                                     :null => false
    t.decimal "ftxnprice",                      :precision => 17, :scale => 5,                    :null => false
    t.boolean "fljrdif",                                                                          :null => false
    t.decimal "fncompct",                       :precision => 8,  :scale => 3,                    :null => false
    t.binary  "timestamp_column"
    t.text    "fmdescript",                                                    :default => " ",   :null => false
    t.string  "fac",              :limit => 20,                                                   :null => false
    t.string  "fpbitem",          :limit => 3,                                 :default => "",    :null => false
    t.boolean "fpbfinal",                                                      :default => false, :null => false
    t.string  "fcudrev",          :limit => 3,                                 :default => " ",   :null => false
  end

  add_index "aritem", ["fcinvoice", "fcuserline"], :name => "USERLINE"
  add_index "aritem", ["fcinvoice", "fitem"], :name => "aritem_inv_item", :unique => true
  add_index "aritem", ["fctaxcode", "frecvkey"], :name => "taxitem"
  add_index "aritem", ["fctype"], :name => "fctype"
  add_index "aritem", ["fcustno"], :name => "customer"
  add_index "aritem", ["fincacc"], :name => "debit"
  add_index "aritem", ["fpartno", "frev", "fac"], :name => "PartNo"
  add_index "aritem", ["frecvkey"], :name => "rcvrkey"
  add_index "aritem", ["fsalesacc"], :name => "fsalesacc"
  add_index "aritem", ["fshipkey"], :name => "shipkey"
  add_index "aritem", ["fsokey", "fpbitem"], :name => "pbdtl"
  add_index "aritem", ["ftotprice"], :name => "totprice"
  add_index "aritem", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "armast", :primary_key => "identity_column", :force => true do |t|
    t.string   "fbcity",           :limit => 20,                                                   :null => false
    t.string   "fbcompany",        :limit => 35,                                :default => " ",   :null => false
    t.string   "fbcountry",        :limit => 25,                                                   :null => false
    t.string   "fbstate",          :limit => 20,                                                   :null => false
    t.string   "fbzip",            :limit => 10,                                                   :null => false
    t.string   "fccity",           :limit => 20,                                                   :null => false
    t.string   "fccompany",        :limit => 35,                                :default => " ",   :null => false
    t.string   "fccountry",        :limit => 25,                                                   :null => false
    t.string   "fcstate",          :limit => 20,                                                   :null => false
    t.string   "fczip",            :limit => 10,                                                   :null => false
    t.string   "fccurid",          :limit => 3,                                                    :null => false
    t.decimal  "fcfactor",                       :precision => 17, :scale => 5,                    :null => false
    t.string   "fcinvoice",        :limit => 20,                                                   :null => false
    t.string   "fcsource",         :limit => 1,                                                    :null => false
    t.string   "fcstatus",         :limit => 1,                                                    :null => false
    t.string   "fctermsid",        :limit => 4,                                                    :null => false
    t.datetime "fctime_ts",                                                                        :null => false
    t.string   "fcustno",          :limit => 6,                                                    :null => false
    t.datetime "fdfactdate",                                                                       :null => false
    t.datetime "fdgldate",                                                                         :null => false
    t.datetime "fduedate",                                                                         :null => false
    t.decimal  "ffreight",                                                                         :null => false
    t.string   "ffob",             :limit => 20,                                                   :null => false
    t.datetime "finvdate",                                                                         :null => false
    t.boolean  "fliscod",                                                                          :null => false
    t.boolean  "flishand",                                                                         :null => false
    t.boolean  "flisprint",                                                                        :null => false
    t.boolean  "flpostnow",                                                                        :null => false
    t.string   "finvtype",         :limit => 1,                                                    :null => false
    t.decimal  "fnamount",                                                                         :null => false
    t.decimal  "fngoodsamt",                                                                       :null => false
    t.decimal  "fncredits",                                                                        :null => false
    t.decimal  "fncurex",                                                                          :null => false
    t.decimal  "fninvdisrt",                     :precision => 11, :scale => 5,                    :null => false
    t.decimal  "fnfinchg",                                                                         :null => false
    t.integer  "fnpaytype",                                                                        :null => false
    t.decimal  "fntotalwt",                      :precision => 12, :scale => 4,                    :null => false
    t.string   "fnumber",          :limit => 6,                                                    :null => false
    t.string   "fpaidref",         :limit => 20,                                                   :null => false
    t.string   "fpono",            :limit => 20,                                                   :null => false
    t.datetime "fretrndate",                                                                       :null => false
    t.string   "fsalespn",         :limit => 3,                                                    :null => false
    t.datetime "fshipdate",                                                                        :null => false
    t.string   "fshipvia",         :limit => 10,                                                   :null => false
    t.string   "fsono",            :limit => 6,                                                    :null => false
    t.decimal  "ftaxamt",                                                                          :null => false
    t.string   "ftaxcode",         :limit => 3,                                                    :null => false
    t.decimal  "fsalcompct",                     :precision => 8,  :scale => 3,                    :null => false
    t.datetime "fdeurodate",                                                                       :null => false
    t.decimal  "feurofctr",                      :precision => 17, :scale => 5,                    :null => false
    t.datetime "fdvoiddate",                                                                       :null => false
    t.boolean  "flpremcv",                                                                         :null => false
    t.datetime "fdtaxpoint",                                                                       :null => false
    t.boolean  "fldifmsg",                                                                         :null => false
    t.binary   "timestamp_column"
    t.text     "fmbstreet",                                                     :default => " ",   :null => false
    t.text     "fmnotes",                                                       :default => " ",   :null => false
    t.text     "fmremarks",                                                     :default => " ",   :null => false
    t.text     "fmstreet",                                                      :default => " ",   :null => false
    t.text     "fmtermsmsg",                                                    :default => " ",   :null => false
    t.string   "fccontkey",        :limit => 10,                                :default => " ",   :null => false
    t.boolean  "flcontract",                                                    :default => false, :null => false
    t.boolean  "flduechng",                                                                        :null => false
  end

  add_index "armast", ["fcinvoice"], :name => "armast_invoice", :unique => true
  add_index "armast", ["fcstatus"], :name => "status"
  add_index "armast", ["fcustno"], :name => "custno"
  add_index "armast", ["fdgldate"], :name => "gldate"
  add_index "armast", ["fduedate"], :name => "duedate"
  add_index "armast", ["finvdate"], :name => "inv_date"
  add_index "armast", ["finvtype"], :name => "typeinv"
  add_index "armast", ["fnumber"], :name => "sourcekey"
  add_index "armast", ["fpaidref"], :name => "paidref"
  add_index "armast", ["fpono"], :name => "cust_po"
  add_index "armast", ["fsono"], :name => "sono"
  add_index "armast", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "arstax", :primary_key => "identity_column", :force => true do |t|
    t.string   "fcacctnum",        :limit => 25,                                                :null => false
    t.string   "fcdescr",          :limit => 35,                               :default => " ", :null => false
    t.string   "fcformula",        :limit => 10,                                                :null => false
    t.string   "fcparent",         :limit => 3,                                                 :null => false
    t.string   "fctaxtype",        :limit => 1,                                                 :null => false
    t.string   "fctaxcode",        :limit => 10,                                                :null => false
    t.boolean  "flismarkup",                                                                    :null => false
    t.decimal  "fnrate",                         :precision => 7, :scale => 3,                  :null => false
    t.datetime "fdstartdt",                                                                     :null => false
    t.datetime "fdenddt",                                                                       :null => false
    t.string   "fccalctype",       :limit => 1,                                                 :null => false
    t.string   "fcapacctno",       :limit => 25,                                                :null => false
    t.binary   "timestamp_column"
  end

  add_index "arstax", ["fcacctnum"], :name => "fcacctnum"
  add_index "arstax", ["fcdescr"], :name => "fcdescr"
  add_index "arstax", ["fcparent"], :name => "parent"
  add_index "arstax", ["fctaxcode", "fdstartdt", "fdenddt"], :name => "taxeffect"
  add_index "arstax", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "artax", :primary_key => "identity_column", :force => true do |t|
    t.string  "fcinvoice",        :limit => 20,                               :null => false
    t.string  "fitem",            :limit => 6,                                :null => false
    t.string  "fcjrdict",         :limit => 10,                               :null => false
    t.string  "fctaxcode",        :limit => 10,                               :null => false
    t.integer "fnorder",                                                      :null => false
    t.decimal "fnrate",                         :precision => 7, :scale => 3, :null => false
    t.binary  "timestamp_column"
  end

  add_index "artax", ["fcinvoice", "fitem", "fnorder"], :name => "JRARORDER"
  add_index "artax", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "bcautobk", :primary_key => "identity_column", :force => true do |t|
    t.string "ftype",            :limit => 1, :null => false
    t.string "fempno",           :limit => 9, :null => false
    t.string "fdept",            :limit => 2, :null => false
    t.string "fbrk_days",        :limit => 7, :null => false
    t.string "fbrk_strt",        :limit => 5, :null => false
    t.string "fbrk_end",         :limit => 5, :null => false
    t.binary "timestamp_column"
  end

  add_index "bcautobk", ["fbrk_strt"], :name => "brkstart"
  add_index "bcautobk", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "bcclk", :primary_key => "identity_column", :force => true do |t|
    t.string  "ftype",            :limit => 1,                                 :null => false
    t.string  "fempno",           :limit => 9,                                 :null => false
    t.string  "fdept",            :limit => 2,                                 :null => false
    t.string  "ffunc",            :limit => 3,                                 :null => false
    t.integer "ffrom",            :limit => nil, :precision => 5, :scale => 0, :null => false
    t.integer "fthru",            :limit => nil, :precision => 5, :scale => 0, :null => false
    t.integer "fsetto",           :limit => nil, :precision => 5, :scale => 0, :null => false
    t.binary  "timestamp_column"
  end

  add_index "bcclk", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "bcerr", :primary_key => "identity_column", :force => true do |t|
    t.string   "fbcnum",           :limit => 2,                                                   :null => false
    t.string   "fnetaddr",         :limit => 3,                                                   :null => false
    t.string   "frecstat",         :limit => 4,                                                   :null => false
    t.string   "fnction",          :limit => 3,                                                   :null => false
    t.string   "fempno",           :limit => 10,                                                  :null => false
    t.string   "fjobno",           :limit => 11,                                                  :null => false
    t.string   "foperno",          :limit => 5,                                                   :null => false
    t.string   "fpro_id",          :limit => 29,                                 :default => " ", :null => false
    t.string   "flead",            :limit => 1,                                                   :null => false
    t.string   "fsetup",           :limit => 1,                                                   :null => false
    t.string   "frework",          :limit => 1,                                                   :null => false
    t.decimal  "fcompqty",                        :precision => 13, :scale => 5,                  :null => false
    t.decimal  "fscrpqty",                        :precision => 13, :scale => 5,                  :null => false
    t.string   "fpartno",          :limit => 29,                                 :default => " ", :null => false
    t.string   "ftojob",           :limit => 29,                                 :default => " ", :null => false
    t.string   "fseriesend",       :limit => 1,                                                   :null => false
    t.datetime "frdate",                                                                          :null => false
    t.string   "fdate",            :limit => 8,                                                   :null => false
    t.string   "ftime",            :limit => 5,                                                   :null => false
    t.string   "forg_date",        :limit => 8,                                                   :null => false
    t.string   "forg_time",        :limit => 5,                                                   :null => false
    t.datetime "fshftdt",                                                                         :null => false
    t.integer  "fshfttm",          :limit => nil, :precision => 4,  :scale => 0,                  :null => false
    t.string   "fsub",             :limit => 1,                                                   :null => false
    t.string   "fship",            :limit => 1,                                                   :null => false
    t.integer  "flast",            :limit => nil, :precision => 4,  :scale => 0,                  :null => false
    t.string   "ferrormsg",        :limit => 60,                                 :default => " ", :null => false
    t.string   "fclot",            :limit => 20,                                                  :null => false
    t.datetime "fdlotexp",                                                                        :null => false
    t.binary   "timestamp_column"
  end

  add_index "bcerr", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "bcinonhd", :primary_key => "identity_column", :force => true do |t|
    t.string   "fpartno",          :limit => 25,                                                 :null => false
    t.string   "fcpartrev",        :limit => 3,                                                  :null => false
    t.string   "fbinno",           :limit => 14,                                                 :null => false
    t.string   "flocation",        :limit => 14,                                                 :null => false
    t.decimal  "fonhand",                        :precision => 15, :scale => 5,                  :null => false
    t.datetime "fdate",                                                                          :null => false
    t.string   "ftime",            :limit => 5,                                                  :null => false
    t.string   "fdescription",     :limit => 35,                                :default => " ", :null => false
    t.decimal  "fionhand",                       :precision => 15, :scale => 5,                  :null => false
    t.string   "fclot",            :limit => 20,                                                 :null => false
    t.datetime "fdlotexp",                                                                       :null => false
    t.binary   "timestamp_column"
    t.string   "fac",              :limit => 20,                                                 :null => false
    t.string   "fcudrev",          :limit => 3,                                                  :null => false
  end

  add_index "bcinonhd", ["fpartno", "fcpartrev", "fac"], :name => "PARTNO"
  add_index "bcinonhd", ["fpartno", "flocation", "fbinno", "fclot", "fac"], :name => "PARTLOCA"
  add_index "bcinonhd", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "bcinv", :primary_key => "identity_column", :force => true do |t|
    t.string   "fnction",          :limit => 3,                                                   :null => false
    t.string   "fnetaddr",         :limit => 3,                                                   :null => false
    t.string   "fbcnum",           :limit => 2,                                                   :null => false
    t.string   "fjobno",           :limit => 11,                                                  :null => false
    t.datetime "frdate",                                                                          :null => false
    t.string   "fdate",            :limit => 8,                                                   :null => false
    t.string   "ftime",            :limit => 5,                                                   :null => false
    t.string   "forg_date",        :limit => 8,                                                   :null => false
    t.string   "forg_time",        :limit => 5,                                                   :null => false
    t.string   "fempno",           :limit => 10,                                                  :null => false
    t.string   "foperno",          :limit => 5,                                                   :null => false
    t.string   "fpro_id",          :limit => 29,                                 :default => " ", :null => false
    t.decimal  "fcompqty",                        :precision => 10, :scale => 2,                  :null => false
    t.decimal  "fscrpqty",                        :precision => 10, :scale => 2,                  :null => false
    t.string   "fsetup",           :limit => 1,                                                   :null => false
    t.string   "frework",          :limit => 1,                                                   :null => false
    t.string   "flead",            :limit => 1,                                                   :null => false
    t.string   "fsub",             :limit => 1,                                                   :null => false
    t.string   "fship",            :limit => 1,                                                   :null => false
    t.string   "fpartno",          :limit => 29,                                 :default => " ", :null => false
    t.string   "ftojob",           :limit => 29,                                 :default => " ", :null => false
    t.datetime "fshftdt",                                                                         :null => false
    t.integer  "fshfttm",          :limit => nil, :precision => 4,  :scale => 0,                  :null => false
    t.integer  "flast",            :limit => nil, :precision => 4,  :scale => 0,                  :null => false
    t.string   "ftrandesc",        :limit => 40,                                 :default => " ", :null => false
    t.string   "ftrantype",        :limit => 1,                                                   :null => false
    t.string   "fclot",            :limit => 20,                                                  :null => false
    t.datetime "fdlotexp",                                                                        :null => false
    t.binary   "timestamp_column"
  end

  add_index "bcinv", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "bclocbin", :primary_key => "identity_column", :force => true do |t|
    t.string "fcbinno",          :limit => 14, :null => false
    t.string "fclocation",       :limit => 14, :null => false
    t.binary "timestamp_column"
    t.string "fac",              :limit => 20, :null => false
  end

  add_index "bclocbin", ["fclocation", "fcbinno", "fac"], :name => "LOCBIN"
  add_index "bclocbin", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "bcraw", :primary_key => "identity_column", :force => true do |t|
    t.string   "fnction",          :limit => 3,                                                  :null => false
    t.string   "fnetaddr",         :limit => 3,                                                  :null => false
    t.string   "fbcnum",           :limit => 2,                                                  :null => false
    t.string   "fjobno",           :limit => 11,                                                 :null => false
    t.string   "fnjobno",          :limit => 11,                                                 :null => false
    t.datetime "frdate",                                                                         :null => false
    t.string   "fdate",            :limit => 8,                                                  :null => false
    t.string   "ftime",            :limit => 5,                                                  :null => false
    t.string   "forg_date",        :limit => 8,                                                  :null => false
    t.string   "forg_time",        :limit => 5,                                                  :null => false
    t.string   "fempno",           :limit => 10,                                                 :null => false
    t.string   "foperno",          :limit => 5,                                                  :null => false
    t.string   "fnoperno",         :limit => 5,                                                  :null => false
    t.string   "fpro_id",          :limit => 29,                                :default => " ", :null => false
    t.decimal  "fcompqty",                       :precision => 10, :scale => 2,                  :null => false
    t.decimal  "fscrpqty",                       :precision => 10, :scale => 2,                  :null => false
    t.string   "fsetup",           :limit => 1,                                                  :null => false
    t.string   "frework",          :limit => 1,                                                  :null => false
    t.string   "flead",            :limit => 1,                                                  :null => false
    t.string   "fsub",             :limit => 1,                                                  :null => false
    t.string   "fship",            :limit => 1,                                                  :null => false
    t.string   "fpartno",          :limit => 29,                                :default => " ", :null => false
    t.string   "ftojob",           :limit => 11,                                                 :null => false
    t.string   "ferrmsg",          :limit => 10,                                                 :null => false
    t.string   "fclockout",        :limit => 1,                                                  :null => false
    t.string   "fseriesend",       :limit => 1,                                                  :null => false
    t.string   "fclot",            :limit => 20,                                                 :null => false
    t.datetime "fdlotexp",                                                                       :null => false
    t.boolean  "flreposted",                                                                     :null => false
    t.binary   "timestamp_column"
  end

  add_index "bcraw", ["fempno", "frdate", "ftime"], :name => "EMPDATE"
  add_index "bcraw", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "bin", :primary_key => "identity_column", :force => true do |t|
    t.string "fcfacility",       :limit => 20, :null => false
    t.string "fcloc",            :limit => 14, :null => false
    t.string "fcbin",            :limit => 14, :null => false
    t.string "fcbindesc",        :limit => 30
    t.binary "timestamp_column"
  end

  add_index "bin", ["fcloc", "fcbin", "fcfacility"], :name => "IX_bin"
  add_index "bin", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "bkup", :primary_key => "identity_column", :force => true do |t|
    t.string   "cversname",        :limit => 25,                                :default => "",                    :null => false
    t.datetime "ddate",                                                         :default => '1900-01-01 00:00:00'
    t.string   "ctime",            :limit => 5,                                 :default => "",                    :null => false
    t.integer  "rec_no",           :limit => nil, :precision => 3, :scale => 0, :default => 0,                     :null => false
    t.binary   "timestamp_column"
  end

  add_index "bkup", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "blqoc", :primary_key => "identity_column", :force => true do |t|
    t.string  "fccompany",        :limit => 35,                                :default => " ", :null => false
    t.decimal "fnblprice",                      :precision => 15, :scale => 5,                  :null => false
    t.decimal "fnblprofit",                     :precision => 15, :scale => 5,                  :null => false
    t.decimal "fnblmanhr",                      :precision => 15, :scale => 5,                  :null => false
    t.decimal "fnblcap",                        :precision => 15, :scale => 5,                  :null => false
    t.decimal "fnquprice",                      :precision => 15, :scale => 5,                  :null => false
    t.decimal "fnquprofit",                     :precision => 15, :scale => 5,                  :null => false
    t.decimal "fnqumanhr",                      :precision => 15, :scale => 5,                  :null => false
    t.decimal "fnqucap",                        :precision => 15, :scale => 5,                  :null => false
    t.binary  "timestamp_column"
  end

  add_index "blqoc", ["fccompany"], :name => "company"
  add_index "blqoc", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "blqop", :primary_key => "identity_column", :force => true do |t|
    t.string  "fcprodclass",      :limit => 2,                                 :null => false
    t.decimal "fnblprice",                      :precision => 15, :scale => 5, :null => false
    t.decimal "fnblprofit",                     :precision => 15, :scale => 5, :null => false
    t.decimal "fnblmanhr",                      :precision => 15, :scale => 5, :null => false
    t.decimal "fnblcap",                        :precision => 15, :scale => 5, :null => false
    t.decimal "fnquprice",                      :precision => 15, :scale => 5, :null => false
    t.decimal "fnquprofit",                     :precision => 15, :scale => 5, :null => false
    t.decimal "fnqumanhr",                      :precision => 15, :scale => 5, :null => false
    t.decimal "fnqucap",                        :precision => 15, :scale => 5, :null => false
    t.binary  "timestamp_column"
    t.string  "fac",              :limit => 20,                                :null => false
  end

  add_index "blqop", ["fcprodclass", "fac"], :name => "prodclass"
  add_index "blqop", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "bolitem", :primary_key => "identity_column", :force => true do |t|
    t.string  "fcbolno",          :limit => 20,                                                 :null => false
    t.string  "fcitemno",         :limit => 3,                                                  :null => false
    t.string  "fcclass",          :limit => 10,                                                 :null => false
    t.decimal "fnunits",                        :precision => 12, :scale => 5,                  :null => false
    t.decimal "fnweight",                       :precision => 12, :scale => 4,                  :null => false
    t.decimal "fncube",                         :precision => 12, :scale => 4,                  :null => false
    t.boolean "flhzdmtrl",                                                                      :null => false
    t.string  "fnpack",           :limit => 10,                                                 :null => false
    t.string  "fcpono",           :limit => 20,                                                 :null => false
    t.string  "fcshipno",         :limit => 6,                                                  :null => false
    t.decimal "fnweight2",                      :precision => 12, :scale => 4,                  :null => false
    t.binary  "timestamp_column"
    t.text    "fcnmfcdesc",                                                    :default => " ", :null => false
  end

  add_index "bolitem", ["fcbolno", "fcitemno"], :name => "ITEMNO"
  add_index "bolitem", ["fcbolno", "fcpono"], :name => "pono"
  add_index "bolitem", ["fcbolno", "fcshipno"], :name => "SHIPNO"
  add_index "bolitem", ["fcclass"], :name => "freight"
  add_index "bolitem", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "bolmast", :primary_key => "identity_column", :force => true do |t|
    t.string   "fcbolno",          :limit => 20,                                                  :null => false
    t.string   "fccarrier",        :limit => 10,                                                  :null => false
    t.string   "fcprono",          :limit => 35,                                 :default => " ", :null => false
    t.datetime "fdshpdate",                                                                       :null => false
    t.integer  "fnnumprinted",     :limit => nil, :precision => 3,  :scale => 0,                  :null => false
    t.string   "fcshppoint",       :limit => 10,                                                  :null => false
    t.string   "fcapptno",         :limit => 8,                                                   :null => false
    t.string   "fctrlrno",         :limit => 8,                                                   :null => false
    t.string   "fcsealno",         :limit => 8,                                                   :null => false
    t.datetime "ftappt",                                                                          :null => false
    t.datetime "ftarrival",                                                                       :null => false
    t.datetime "ftleave",                                                                         :null => false
    t.string   "fcshipno",         :limit => 6,                                                   :null => false
    t.boolean  "flprepaid",                                                                       :null => false
    t.boolean  "flshipment",                                                                      :null => false
    t.string   "fcper",            :limit => 15,                                                  :null => false
    t.decimal  "fnvalue",                         :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fncollect",                       :precision => 17, :scale => 5,                  :null => false
    t.boolean  "flcharge",                                                                        :null => false
    t.boolean  "flcalc",                                                                          :null => false
    t.boolean  "flprinted",                                                                       :null => false
    t.decimal  "fnfreight",                       :precision => 17, :scale => 5,                  :null => false
    t.binary   "timestamp_column"
    t.text     "fmcomment",                                                      :default => " ", :null => false
    t.text     "fmreceived",                                                     :default => " ", :null => false
  end

  add_index "bolmast", ["fcbolno"], :name => "bolno"
  add_index "bolmast", ["fcshipno"], :name => "shipno"
  add_index "bolmast", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "bomref", :primary_key => "identity_column", :force => true do |t|
    t.string   "Fcpfac",           :limit => 20,                                 :default => "",  :null => false
    t.string   "Fcparent",         :limit => 25,                                 :default => "",  :null => false
    t.string   "Fcparrev",         :limit => 3,                                  :default => "",  :null => false
    t.string   "Fcomponent",       :limit => 25,                                 :default => "",  :null => false
    t.string   "Fccomprev",        :limit => 3,                                  :default => "",  :null => false
    t.string   "Fcitem",           :limit => 6,                                  :default => "",  :null => false
    t.integer  "Fncompid",                                                       :default => 0,   :null => false
    t.string   "Fcrefdes",         :limit => 15,                                 :default => "",  :null => false
    t.integer  "Fnsubref",                                                       :default => 0,   :null => false
    t.integer  "Fnoperused",       :limit => nil, :precision => 4,  :scale => 0, :default => 0,   :null => false
    t.decimal  "Fnquantity",                      :precision => 15, :scale => 5, :default => 0.0, :null => false
    t.datetime "Fdfrom",                                                                          :null => false
    t.string   "Fcecofrom",        :limit => 25,                                 :default => "",  :null => false
    t.datetime "Fdto",                                                                            :null => false
    t.string   "Fcecoto",          :limit => 25,                                 :default => "",  :null => false
    t.string   "Fcrevision",       :limit => 3,                                  :default => "",  :null => false
    t.datetime "Ftasof",                                                                          :null => false
    t.text     "Fmnotes",                                                        :default => "",  :null => false
    t.binary   "timestamp_column"
  end

  add_index "bomref", ["Fcomponent", "Fccomprev", "Fcpfac"], :name => "component"
  add_index "bomref", ["Fcparent", "Fcparrev", "Fcpfac"], :name => "bom"
  add_index "bomref", ["Fcrefdes", "Fnsubref", "Fncompid"], :name => "compidref", :unique => true
  add_index "bomref", ["Fncompid"], :name => "compid"
  add_index "bomref", ["identity_column"], :name => "idcolumn", :unique => true

  create_table "btch", :primary_key => "identity_column", :force => true do |t|
    t.string  "cfunc",            :limit => 3,                                 :default => " ", :null => false
    t.string  "cbatchname",       :limit => 15,                                :default => " ", :null => false
    t.integer "daily",            :limit => nil, :precision => 2, :scale => 0, :default => 0,   :null => false
    t.integer "weekly",           :limit => nil, :precision => 2, :scale => 0, :default => 0,   :null => false
    t.integer "monthly",          :limit => nil, :precision => 2, :scale => 0, :default => 0,   :null => false
    t.integer "adhoc",            :limit => nil, :precision => 2, :scale => 0, :default => 0,   :null => false
    t.string  "capplname",        :limit => 30,                                :default => " ", :null => false
    t.string  "cprodcode",        :limit => 3,                                 :default => " ", :null => false
    t.string  "i_or_g",           :limit => 1,                                 :default => " ", :null => false
    t.binary  "timestamp_column"
  end

  add_index "btch", ["cprodcode", "capplname", "cbatchname"], :name => "BYAPPLNAME"
  add_index "btch", ["cprodcode", "cfunc", "cbatchname"], :name => "btch1"
  add_index "btch", ["cprodcode", "cfunc", "cbatchname"], :name => "byfunc"
  add_index "btch", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "commpay", :primary_key => "identity_column", :force => true do |t|
    t.string   "fcarinv",          :limit => 20,                               :default => "",  :null => false
    t.string   "fitem",            :limit => 6,                                :default => "",  :null => false
    t.string   "fsorel",           :limit => 3,                                :default => "",  :null => false
    t.string   "fpartno",          :limit => 25,                               :default => "",  :null => false
    t.text     "fmdescript",                                                   :default => "",  :null => false
    t.string   "frev",             :limit => 3,                                :default => "",  :null => false
    t.string   "fac",              :limit => 20,                                                :null => false
    t.string   "fcstatus",         :limit => 1,                                :default => "",  :null => false
    t.string   "fcdesc",           :limit => 50,                               :default => "",  :null => false
    t.string   "fcprodcl",         :limit => 2,                                :default => "",  :null => false
    t.datetime "fdarpost",                                                                      :null => false
    t.decimal  "fnamount",                                                     :default => 0.0, :null => false
    t.string   "fsono",            :limit => 6,                                :default => "",  :null => false
    t.string   "fcustno",          :limit => 6,                                :default => "",  :null => false
    t.string   "fshiptoaddr",      :limit => 4,                                :default => "",  :null => false
    t.string   "fsalespn",         :limit => 3,                                :default => "",  :null => false
    t.string   "fcterr",           :limit => 10,                               :default => "",  :null => false
    t.string   "fcvendor",         :limit => 6,                                :default => "",  :null => false
    t.string   "fcInvoice",        :limit => 20,                               :default => "",  :null => false
    t.decimal  "fnCalcComm",                                                   :default => 0.0, :null => false
    t.decimal  "fnrate",                         :precision => 8, :scale => 3,                  :null => false
    t.binary   "timestamp_column"
  end

  add_index "commpay", ["fcarinv"], :name => "invoice"
  add_index "commpay", ["fcustno"], :name => "custno"
  add_index "commpay", ["fcvendor", "fsalespn", "fcarinv"], :name => "postorder"
  add_index "commpay", ["fsalespn"], :name => "salesman"
  add_index "commpay", ["fsono"], :name => "salesord"
  add_index "commpay", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "crhead", :primary_key => "identity_column", :force => true do |t|
    t.integer  "crheadid",                                                                      :null => false
    t.datetime "fcdatetime",                                                                    :null => false
    t.string   "fcdescr",          :limit => 40,                               :default => " ", :null => false
    t.string   "fchday",           :limit => 3,                                                 :null => false
    t.string   "fcsday",           :limit => 3,                                                 :null => false
    t.string   "fctday",           :limit => 3,                                                 :null => false
    t.string   "fcuserid",         :limit => 4,                                                 :null => false
    t.datetime "fdardate",                                                                      :null => false
    t.datetime "fdfromdate",                                                                    :null => false
    t.datetime "fdtodate",                                                                      :null => false
    t.boolean  "flpayrlset",                                                                    :null => false
    t.boolean  "flrecalc",                                                                      :null => false
    t.decimal  "fnapdays",                       :precision => 7, :scale => 2,                  :null => false
    t.decimal  "fnapdis",                        :precision => 7, :scale => 2,                  :null => false
    t.integer  "fnapsource",                                                                    :null => false
    t.decimal  "fnardays",                       :precision => 7, :scale => 2,                  :null => false
    t.integer  "fnarsource",                                                                    :null => false
    t.decimal  "fnavehrw",                       :precision => 8, :scale => 4,                  :null => false
    t.decimal  "fnavesal",                       :precision => 8, :scale => 4,                  :null => false
    t.decimal  "fnavewage",                      :precision => 8, :scale => 4,                  :null => false
    t.integer  "fncalcar",                                                                      :null => false
    t.integer  "fndisplay",                                                                     :null => false
    t.decimal  "fnhfringe",                      :precision => 7, :scale => 2,                  :null => false
    t.integer  "fnhpeople",                                                                     :null => false
    t.integer  "fninvcnt",                                                                      :null => false
    t.integer  "fnnomos",                                                                       :null => false
    t.integer  "fnprsource",                                                                    :null => false
    t.decimal  "fnsfringe",                      :precision => 7, :scale => 2,                  :null => false
    t.integer  "fnspeople",                                                                     :null => false
    t.decimal  "fntfringe",                      :precision => 7, :scale => 2,                  :null => false
    t.integer  "fntpeople",                                                                     :null => false
    t.integer  "fnuncol",                                                                       :null => false
    t.binary   "timestamp_column"
    t.text     "fmtrend",                                                      :default => " ", :null => false
  end

  add_index "crhead", ["crheadid"], :name => "crhead_crheadid", :unique => true
  add_index "crhead", ["crheadid"], :name => "crhead_joinchild", :unique => true
  add_index "crhead", ["fcdescr"], :name => "descr"
  add_index "crhead", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "critem", :primary_key => "identity_column", :force => true do |t|
    t.integer  "crheadid",                                        :null => false
    t.integer  "crmastid",                                        :null => false
    t.datetime "fclastchg",                                       :null => false
    t.string   "fcnameid",         :limit => 6,                   :null => false
    t.string   "fcsource",         :limit => 30, :default => " ", :null => false
    t.string   "fctype",           :limit => 1,                   :null => false
    t.datetime "fddate",                                          :null => false
    t.boolean  "flissource",                                      :null => false
    t.decimal  "fnamount",                                        :null => false
    t.binary   "timestamp_column"
    t.text     "fmnotes",                        :default => " ", :null => false
  end

  add_index "critem", ["crheadid", "crmastid", "fctype", "fddate"], :name => "report"
  add_index "critem", ["crmastid"], :name => "crmastid"
  add_index "critem", ["fcnameid"], :name => "name"
  add_index "critem", ["fcsource"], :name => "source"
  add_index "critem", ["fctype"], :name => "type"
  add_index "critem", ["fddate"], :name => "fddate"
  add_index "critem", ["fnamount"], :name => "amount"
  add_index "critem", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "crmast", :primary_key => "identity_column", :force => true do |t|
    t.integer  "crmastid",                                                                      :null => false
    t.integer  "crheadid",                                                                      :null => false
    t.string   "fccalcper",        :limit => 1,                                                 :null => false
    t.string   "fcchgper",         :limit => 1,                                                 :null => false
    t.string   "fcstepper",        :limit => 1,                                                 :null => false
    t.string   "fcdescr",          :limit => 40,                               :default => " ", :null => false
    t.string   "fctype",           :limit => 1,                                                 :null => false
    t.datetime "fdendon",                                                                       :null => false
    t.boolean  "flnouser",                                                                      :null => false
    t.decimal  "fnbaseamt",                                                                     :null => false
    t.integer  "fncalc",                                                                        :null => false
    t.integer  "fnlineno",                                                                      :null => false
    t.decimal  "fnpercent",                      :precision => 7, :scale => 2,                  :null => false
    t.integer  "fnplusdays",                                                                    :null => false
    t.decimal  "fnstepamt",                                                                     :null => false
    t.datetime "fdglfrom",                                                                      :null => false
    t.binary   "timestamp_column"
    t.text     "fmglarray",                                                    :default => " ", :null => false
  end

  add_index "crmast", ["crheadid", "fnlineno"], :name => "report"
  add_index "crmast", ["crmastid"], :name => "crmast_crmastid", :unique => true
  add_index "crmast", ["fcdescr"], :name => "descr"
  add_index "crmast", ["fctype", "fnlineno"], :name => "LINENOIDX"
  add_index "crmast", ["fncalc"], :name => "calcmeth"
  add_index "crmast", ["fnlineno", "fctype"], :name => "lineno_"
  add_index "crmast", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "crup", :primary_key => "identity_column", :force => true do |t|
    t.string   "fpartno",          :limit => 25,                                                 :null => false
    t.string   "frev",             :limit => 3,                                                  :null => false
    t.decimal  "fmatlcosto",                     :precision => 17, :scale => 5,                  :null => false
    t.decimal  "flabcosto",                      :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fovhdcosto",                     :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fmatlcostn",                     :precision => 17, :scale => 5,                  :null => false
    t.decimal  "flabcostn",                      :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fovhdcostn",                     :precision => 17, :scale => 5,                  :null => false
    t.string   "fcosttype",        :limit => 1,                                                  :null => false
    t.decimal  "fonhand",                        :precision => 15, :scale => 5,                  :null => false
    t.datetime "fdatetime",                                                                      :null => false
    t.string   "fcusername",       :limit => 10,                                                 :null => false
    t.binary   "timestamp_column"
    t.string   "Fac",              :limit => 20,                                                 :null => false
    t.string   "fcudrev",          :limit => 3,                                 :default => " ", :null => false
  end

  add_index "crup", ["fdatetime"], :name => "date"
  add_index "crup", ["fpartno", "frev", "fdatetime", "Fac"], :name => "partno"
  add_index "crup", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "csapay", :primary_key => "identity_column", :force => true do |t|
    t.string  "fapaccno",         :limit => 25,                                :null => false
    t.string  "fglapadj",         :limit => 25,                                :null => false
    t.string  "fgldiscnt",        :limit => 25,                                :null => false
    t.string  "fglfreight",       :limit => 25,                                :null => false
    t.string  "fglpriceva",       :limit => 25,                                :null => false
    t.string  "fglrcvg",          :limit => 25,                                :null => false
    t.string  "fgltaxamt",        :limit => 25,                                :null => false
    t.decimal "fholdpramt",                                                    :null => false
    t.decimal "fholdprpct",                      :precision => 6, :scale => 2, :null => false
    t.decimal "fholdmax",                        :precision => 6, :scale => 2, :null => false
    t.decimal "fholdmin",                        :precision => 6, :scale => 2, :null => false
    t.boolean "flconfirm",                                                     :null => false
    t.boolean "fllupvend",                                                     :null => false
    t.boolean "flisnohold",                                                    :null => false
    t.integer "fmthno",           :limit => nil, :precision => 2, :scale => 0, :null => false
    t.integer "fnforover1",       :limit => nil, :precision => 3, :scale => 0, :null => false
    t.integer "fnforover2",       :limit => nil, :precision => 3, :scale => 0, :null => false
    t.integer "fnforover3",       :limit => nil, :precision => 3, :scale => 0, :null => false
    t.integer "fnforover4",       :limit => nil, :precision => 3, :scale => 0, :null => false
    t.integer "fnpdover1",        :limit => nil, :precision => 3, :scale => 0, :null => false
    t.integer "fnpdover2",        :limit => nil, :precision => 3, :scale => 0, :null => false
    t.integer "fnpdover3",        :limit => nil, :precision => 3, :scale => 0, :null => false
    t.integer "fnpdover4",        :limit => nil, :precision => 3, :scale => 0, :null => false
    t.boolean "fldisctship",                                                   :null => false
    t.boolean "flvrpost",                                                      :null => false
    t.boolean "fldsctax",                                                      :null => false
    t.binary  "timestamp_column"
  end

  add_index "csapay", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "csarch", :primary_key => "identity_column", :force => true do |t|
    t.datetime "fdarchdate",                        :null => false
    t.datetime "fdgldate",                          :null => false
    t.binary   "timestamp_column"
    t.text     "fmgenlinfo",       :default => " ", :null => false
  end

  add_index "csarch", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "csarcv", :primary_key => "identity_column", :force => true do |t|
    t.string   "faraccno",         :limit => 25,                                                   :null => false
    t.string   "fccurrex",         :limit => 25,                                                   :null => false
    t.integer  "fcperiod",         :limit => nil, :precision => 3, :scale => 0,                    :null => false
    t.boolean  "fdisctrinv",                                                                       :null => false
    t.integer  "fdueoffset",       :limit => nil, :precision => 2, :scale => 0,                    :null => false
    t.string   "fexptax",          :limit => 1,                                                    :null => false
    t.datetime "ffindate",                                                                         :null => false
    t.decimal  "ffinrate",                        :precision => 5, :scale => 1,                    :null => false
    t.string   "fgladjust",        :limit => 25,                                                   :null => false
    t.string   "fglcashact",       :limit => 25,                                                   :null => false
    t.string   "fgldiscnt",        :limit => 25,                                                   :null => false
    t.string   "fglfinchge",       :limit => 25,                                                   :null => false
    t.string   "fglfreight",       :limit => 25,                                                   :null => false
    t.string   "fglsales",         :limit => 25,                                                   :null => false
    t.boolean  "finsomemo",                                                                        :null => false
    t.boolean  "flconfirm",                                                                        :null => false
    t.decimal  "fmarkup",                         :precision => 8, :scale => 3,                    :null => false
    t.string   "fcfyear",          :limit => 20,                                                   :null => false
    t.integer  "fmthno",           :limit => nil, :precision => 2, :scale => 0,                    :null => false
    t.integer  "fnover1",          :limit => nil, :precision => 3, :scale => 0,                    :null => false
    t.integer  "fnover2",          :limit => nil, :precision => 3, :scale => 0,                    :null => false
    t.integer  "fnover3",          :limit => nil, :precision => 3, :scale => 0,                    :null => false
    t.integer  "fnover4",          :limit => nil, :precision => 3, :scale => 0,                    :null => false
    t.string   "fprtcomp",         :limit => 1,                                                    :null => false
    t.string   "fupsno",           :limit => 15,                                                   :null => false
    t.string   "fccustcred",       :limit => 25,                                                   :null => false
    t.boolean  "ftaxfrt",                                                                          :null => false
    t.boolean  "flnewarfct",                                                                       :null => false
    t.datetime "fdvatdate",                                                                        :null => false
    t.boolean  "fltaxdisct",                                                                       :null => false
    t.boolean  "flvrpost",                                                                         :null => false
    t.binary   "timestamp_column"
    t.text     "finvmemo",                                                      :default => " ",   :null => false
    t.string   "fglunrev",         :limit => 25,                                :default => "",    :null => false
    t.boolean  "flunrev",                                                       :default => false, :null => false
    t.boolean  "flaskfirst",                                                    :default => false, :null => false
    t.string   "fcexppath",        :limit => 254,                               :default => "",    :null => false
  end

  add_index "csarcv", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "csbyfac", :primary_key => "identity_column", :force => true do |t|
    t.string   "fac",              :limit => 20,                                                             :null => false
    t.string   "fcltque",          :limit => 2,                                  :default => "QA",           :null => false
    t.string   "fcmsplevel",       :limit => 1,                                  :default => "M",            :null => false
    t.string   "fcschdmatl",       :limit => 1,                                  :default => "N",            :null => false
    t.string   "fcschdpct",        :limit => 1,                                  :default => "U",            :null => false
    t.integer  "fnselschd",        :limit => 1,                                  :default => 0,              :null => false
    t.integer  "fCurSched",        :limit => 1,                                  :default => 0,              :null => false
    t.boolean  "flmspcaln",                                                      :default => false,          :null => false
    t.boolean  "flschdcops",                                                     :default => false,          :null => false
    t.boolean  "flupdmsp",                                                       :default => false,          :null => false
    t.integer  "fmaxmin_sh",       :limit => 2,                                  :default => 0,              :null => false
    t.integer  "fmin_shift",       :limit => 2,                                  :default => 0,              :null => false
    t.decimal  "fnoffset",                        :precision => 6,  :scale => 2, :default => 0.0,            :null => false
    t.integer  "fq",               :limit => 2,                                  :default => 0,              :null => false
    t.integer  "fs1",              :limit => 2,                                  :default => 0,              :null => false
    t.integer  "fs2",              :limit => 2,                                  :default => 0,              :null => false
    t.integer  "fs3",              :limit => 2,                                  :default => 0,              :null => false
    t.integer  "fschdbckt",        :limit => 1,                                  :default => 10,             :null => false
    t.integer  "fschdspan",        :limit => 2,                                  :default => 90,             :null => false
    t.string   "fschdtypes",       :limit => 12,                                 :default => "NNNNNNNNNNNN", :null => false
    t.integer  "fshifts",          :limit => 1,                                  :default => 0,              :null => false
    t.string   "fshift_1",         :limit => 5,                                  :default => "00:00",        :null => false
    t.string   "fshift_2",         :limit => 5,                                  :default => "00:00",        :null => false
    t.string   "fshift_3",         :limit => 5,                                  :default => "00:00",        :null => false
    t.integer  "fstdmin",          :limit => 2,                                  :default => 0,              :null => false
    t.binary   "timestamp_column"
    t.decimal  "fnlatefact",                      :precision => 12, :scale => 5,                             :null => false
    t.decimal  "fnholdfact",                      :precision => 12, :scale => 5,                             :null => false
    t.decimal  "fnsafefact",                      :precision => 12, :scale => 5,                             :null => false
    t.decimal  "fnirr",                           :precision => 12, :scale => 5,                             :null => false
    t.string   "fccpctbukt",       :limit => 3,                                                              :null => false
    t.integer  "fnDBRMod",         :limit => 1
    t.datetime "fdCCRDate"
    t.datetime "fSchdStrt"
    t.integer  "fnPlanSpan",       :limit => nil, :precision => 4,  :scale => 0
    t.string   "fcFcstBukt",       :limit => 3
    t.string   "fcCCR",            :limit => 7
    t.integer  "fnConstBuf",       :limit => nil, :precision => 2,  :scale => 0
    t.integer  "fnAssemBuf",       :limit => nil, :precision => 2,  :scale => 0
    t.integer  "fnSOBuf",          :limit => nil, :precision => 2,  :scale => 0
    t.integer  "fnFcstBuf",        :limit => nil, :precision => 2,  :scale => 0
    t.boolean  "flCnstrPur"
    t.string   "fcGoal",           :limit => 45
    t.integer  "fnSOPr",           :limit => nil, :precision => 1,  :scale => 0
    t.integer  "fnFcstPr",         :limit => nil, :precision => 1,  :scale => 0
    t.integer  "fnSSPr",           :limit => nil, :precision => 1,  :scale => 0
    t.boolean  "flSODmnd"
    t.boolean  "flFcstDmnd"
    t.boolean  "flSSDmnd"
    t.decimal  "fnAssembly",                      :precision => 7,  :scale => 2
    t.decimal  "fnConstrnt",                      :precision => 7,  :scale => 2
    t.decimal  "fnShipping",                      :precision => 7,  :scale => 2
    t.datetime "fPlanStrt"
    t.integer  "fnRelBuf",         :limit => nil, :precision => 2,  :scale => 0
    t.integer  "fnPurchBuf"
    t.boolean  "flSetupOpt"
    t.integer  "fndaypers",        :limit => nil, :precision => 3,  :scale => 0,                             :null => false
    t.integer  "fnwekpers",        :limit => nil, :precision => 3,  :scale => 0,                             :null => false
    t.integer  "fnmonpers",        :limit => nil, :precision => 3,  :scale => 0,                             :null => false
    t.decimal  "fnmaxcapload",                    :precision => 4,  :scale => 1,                             :null => false
    t.integer  "fnqtrpers",        :limit => nil, :precision => 3,  :scale => 0,                             :null => false
    t.integer  "fnsyncmisc1",      :limit => nil, :precision => 5,  :scale => 0,                             :null => false
    t.integer  "fnsyncmisc2",      :limit => nil, :precision => 5,  :scale => 0,                             :null => false
    t.string   "fcsyncmisc1",      :limit => 20,                                                             :null => false
    t.string   "fcsyncmisc2",      :limit => 20,                                                             :null => false
    t.boolean  "flsyncmisc1",                                                                                :null => false
    t.boolean  "flsyncmisc2",                                                                                :null => false
    t.datetime "fdsyncmisc1",                                                                                :null => false
    t.datetime "fdsyncmisc2",                                                                                :null => false
    t.boolean  "flcrewschd",                                                     :default => true,           :null => false
    t.string   "PlanGoal",         :limit => 45,                                                             :null => false
    t.boolean  "AdjPur2Sch",                                                                                 :null => false
    t.boolean  "FcstdepDem",                                                                                 :null => false
    t.boolean  "SingleSupp",                                                                                 :null => false
    t.boolean  "Build2Up",                                                                                   :null => false
    t.boolean  "MinEarly",                                                                                   :null => false
    t.boolean  "SchedInRel",                                                                                 :null => false
    t.integer  "TimeFence",        :limit => nil, :precision => 2,  :scale => 0,                             :null => false
  end

  add_index "csbyfac", ["fac"], :name => "byfac"
  add_index "csbyfac", ["identity_column"], :name => "identity_column_idx1"

  create_table "cscavg", :primary_key => "identity_column", :force => true do |t|
    t.string  "fctoid",           :limit => 3,                                 :null => false
    t.string  "fcacctyr",         :limit => 20,                                :null => false
    t.string  "fcfromid",         :limit => 3,                                 :null => false
    t.integer "fiacctpd",                                                      :null => false
    t.decimal "fnavgrt",                        :precision => 17, :scale => 5, :null => false
    t.boolean "flfrozen",                                                      :null => false
    t.binary  "timestamp_column"
  end

  add_index "cscavg", ["fcfromid", "fctoid", "fcacctyr", "fiacctpd"], :name => "FACTOR_ID"
  add_index "cscavg", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "cscodes", :primary_key => "identity_column", :force => true do |t|
    t.string  "fcearncode",       :limit => 4,                                 :null => false
    t.string  "fccodedesc",       :limit => 25,                                :null => false
    t.string  "fccodetype",       :limit => 1,                                 :null => false
    t.decimal "fnratefact",                     :precision => 12, :scale => 5, :null => false
    t.decimal "fnflatamnt",                     :precision => 9,  :scale => 2, :null => false
    t.boolean "flchrtojob",                                                    :null => false
    t.binary  "timestamp_column"
  end

  add_index "cscodes", ["fcearncode"], :name => "ecode"
  add_index "cscodes", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "cscrm", :primary_key => "identity_column", :force => true do |t|
    t.string   "fcSLXSrv",         :limit => 128, :default => "",                    :null => false
    t.string   "fcSLXDB",          :limit => 128, :default => "",                    :null => false
    t.string   "fcSLXAls",         :limit => 128, :default => "",                    :null => false
    t.string   "fcSQLUser",        :limit => 128, :default => "",                    :null => false
    t.string   "fcSQLPass",        :limit => 254, :default => "",                    :null => false
    t.string   "fcRWPass",         :limit => 254, :default => "",                    :null => false
    t.string   "fcSLXPort",        :limit => 5,   :default => "1706",                :null => false
    t.string   "SLXVipId",         :limit => 36,  :default => "",                    :null => false
    t.boolean  "flCRMOn",                         :default => false,                 :null => false
    t.boolean  "flCRMCust",                       :default => false,                 :null => false
    t.boolean  "flCRMItem",                       :default => false,                 :null => false
    t.boolean  "flCRMPurge",                      :default => false,                 :null => false
    t.integer  "fnCRMDays",                       :default => 0,                     :null => false
    t.datetime "ftM2MSlx",                        :default => '1900-01-01 00:00:00', :null => false
    t.datetime "ftM2MItem",                       :default => '1900-01-01 00:00:00', :null => false
    t.binary   "timestamp_column"
  end

  create_table "cscurr", :primary_key => "identity_column", :force => true do |t|
    t.string "fcashacc",         :limit => 25, :null => false
    t.string "fccurid",          :limit => 3,  :null => false
    t.string "fgnlsacc",         :limit => 25, :null => false
    t.binary "timestamp_column"
  end

  add_index "cscurr", ["fccurid"], :name => "curid"
  add_index "cscurr", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "csfo", :primary_key => "identity_column", :force => true do |t|
    t.string  "fccsbmppth",       :limit => 75, :default => " ",  :null => false
    t.string  "fccsdocpth",       :limit => 75, :default => " ",  :null => false
    t.string  "fccsxrupth",       :limit => 75, :default => " ",  :null => false
    t.string  "fccssprepl",       :limit => 1,                    :null => false
    t.string  "fccsspmask",       :limit => 1,                    :null => false
    t.string  "fccsruleid",       :limit => 5,                    :null => false
    t.string  "fccsprefix",       :limit => 1,                    :null => false
    t.string  "fccslang",         :limit => 10,                   :null => false
    t.binary  "timestamp_column"
    t.boolean "flShowPrc",                      :default => true, :null => false
    t.boolean "flShowCalc",                     :default => true, :null => false
  end

  add_index "csfo", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "csfsitm", :primary_key => "identity_column", :force => true do |t|
    t.string  "fctype",           :limit => 3, :default => "",    :null => false
    t.string  "fprodcl",          :limit => 2, :default => "",    :null => false
    t.string  "fgroup",           :limit => 6, :default => "",    :null => false
    t.string  "fmeasure",         :limit => 3, :default => "",    :null => false
    t.boolean "flbillflag",                    :default => false, :null => false
    t.boolean "fltaxflag",                     :default => false, :null => false
    t.binary  "timestamp_column"
  end

  add_index "csfsitm", ["identity_column"], :name => "idcolumn", :unique => true

  create_table "csfsm", :primary_key => "identity_column", :force => true do |t|
    t.decimal "fsdbversion",                    :precision => 10, :scale => 4, :default => 0.0,   :null => false
    t.string  "fclabel",          :limit => 25,                                :default => "",    :null => false
    t.string  "fcsoprefix",       :limit => 1,                                 :default => "",    :null => false
    t.string  "fcwarntype",       :limit => 4,                                 :default => "",    :null => false
    t.integer "fnlevels",                                                      :default => 0,     :null => false
    t.integer "fnwarndays",                                                    :default => 0,     :null => false
    t.string  "fac",              :limit => 20,                                                   :null => false
    t.string  "sfac",             :limit => 20,                                                   :null => false
    t.string  "fcinsploc",        :limit => 14,                                :default => "",    :null => false
    t.string  "fcintran",         :limit => 14,                                :default => "",    :null => false
    t.boolean "flpost",                                                        :default => false, :null => false
    t.boolean "flsoopen",                                                      :default => false, :null => false
    t.boolean "flwarnamtr",                                                    :default => false, :null => false
    t.boolean "flwarndate",                                                    :default => false, :null => false
    t.boolean "fluseint",                                                      :default => false, :null => false
    t.boolean "flusefac",                                                      :default => false, :null => false
    t.boolean "flsetsvc",                                                      :default => true,  :null => false
    t.string  "fcglairrai",       :limit => 25,                                :default => "",    :null => false
    t.string  "fcglautore",       :limit => 25,                                :default => "",    :null => false
    t.string  "fcglcredit",       :limit => 25,                                :default => "",    :null => false
    t.string  "fcglentert",       :limit => 25,                                :default => "",    :null => false
    t.string  "fcglforpar",       :limit => 25,                                :default => "",    :null => false
    t.string  "fcglforsal",       :limit => 25,                                :default => "",    :null => false
    t.string  "fcglforuse",       :limit => 25,                                :default => "",    :null => false
    t.string  "fcglfreigh",       :limit => 25,                                :default => "",    :null => false
    t.string  "fcglfuel",         :limit => 25,                                :default => "",    :null => false
    t.string  "fcglintran",       :limit => 25,                                :default => "",    :null => false
    t.string  "fcgllabcs",        :limit => 25,                                :default => "",    :null => false
    t.string  "fcgllabkit",       :limit => 25,                                :default => "",    :null => false
    t.string  "fcgllabpm",        :limit => 25,                                :default => "",    :null => false
    t.string  "fcgllabsc",        :limit => 25,                                :default => "",    :null => false
    t.string  "fcgllodge",        :limit => 25,                                :default => "",    :null => false
    t.string  "fcglmargin",       :limit => 25,                                :default => "",    :null => false
    t.string  "fcglmeal",         :limit => 25,                                :default => "",    :null => false
    t.string  "fcglmile",         :limit => 25,                                :default => "",    :null => false
    t.string  "fcglother",        :limit => 25,                                :default => "",    :null => false
    t.string  "fcglpark",         :limit => 25,                                :default => "",    :null => false
    t.string  "fcglphone",        :limit => 25,                                :default => "",    :null => false
    t.string  "fcglpostag",       :limit => 25,                                :default => "",    :null => false
    t.string  "fcglsoftwa",       :limit => 25,                                :default => "",    :null => false
    t.string  "fcglsupp",         :limit => 25,                                :default => "",    :null => false
    t.string  "fcgltaxes",        :limit => 25,                                :default => "",    :null => false
    t.string  "fcgltaxi",         :limit => 25,                                :default => "",    :null => false
    t.string  "fcgltolls",        :limit => 25,                                :default => "",    :null => false
    t.string  "fcgltoolin",       :limit => 25,                                :default => "",    :null => false
    t.string  "fcgltrav",         :limit => 25,                                :default => "",    :null => false
    t.boolean "flrepwar",                                                      :default => false, :null => false
    t.string  "fcrepwar",         :limit => 4,                                 :default => "",    :null => false
    t.integer "fnrepday",                                                      :default => 0,     :null => false
    t.binary  "timestamp_column"
    t.integer "fncovday",                                                                         :null => false
    t.boolean "flshpwar",                                                                         :null => false
    t.integer "fnqtdays",                                                                         :null => false
    t.boolean "flusecomm",                                                     :default => true,  :null => false
  end

  create_table "csgenl", :primary_key => "identity_column", :force => true do |t|
    t.string   "fccurid",          :limit => 3,                                                    :null => false
    t.string   "fceracct",         :limit => 25,                                                   :null => false
    t.string   "fcglmask",         :limit => 35,                                :default => " ",   :null => false
    t.string   "fcreacct",         :limit => 25,                                                   :null => false
    t.string   "fcformat",         :limit => 35,                                :default => " ",   :null => false
    t.string   "fcurpernm",        :limit => 20,                                                   :null => false
    t.integer  "fncurperno",                                                                       :null => false
    t.integer  "fnlencom",         :limit => nil, :precision => 2, :scale => 0,                    :null => false
    t.integer  "fnlenctr",         :limit => nil, :precision => 2, :scale => 0,                    :null => false
    t.integer  "fnlendiv",         :limit => nil, :precision => 2, :scale => 0,                    :null => false
    t.integer  "fnlenloc",         :limit => nil, :precision => 2, :scale => 0,                    :null => false
    t.integer  "fnloccom",         :limit => nil, :precision => 2, :scale => 0,                    :null => false
    t.integer  "fnlocctr",         :limit => nil, :precision => 2, :scale => 0,                    :null => false
    t.integer  "fnlocdiv",         :limit => nil, :precision => 2, :scale => 0,                    :null => false
    t.integer  "fnlocloc",         :limit => nil, :precision => 2, :scale => 0,                    :null => false
    t.string   "fpostap",          :limit => 1,                                                    :null => false
    t.string   "fpostar",          :limit => 1,                                                    :null => false
    t.string   "fpostoc",          :limit => 1,                                                    :null => false
    t.string   "fpostpr",          :limit => 1,                                                    :null => false
    t.string   "fcurradjacc",      :limit => 25,                                                   :null => false
    t.boolean  "fleuro",                                                                           :null => false
    t.boolean  "fmulticurr",                                                                       :null => false
    t.datetime "fdadjdate",                                                                        :null => false
    t.boolean  "fleurotax",                                                                        :null => false
    t.boolean  "flchkobal",                                                                        :null => false
    t.string   "fccta",            :limit => 35,                                :default => " ",   :null => false
    t.datetime "fdbankrec",                                                                        :null => false
    t.binary   "timestamp_column"
    t.boolean  "flFRx",                                                         :default => false, :null => false
  end

  add_index "csgenl", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "csmemo", :primary_key => "identity_column", :force => true do |t|
    t.string "fckey",            :limit => 20,                  :null => false
    t.string "fcmnemonic",       :limit => 8,                   :null => false
    t.binary "timestamp_column"
    t.text   "fmmemotext",                     :default => " ", :null => false
  end

  add_index "csmemo", ["fckey"], :name => "armemos"
  add_index "csmemo", ["fcmnemonic", "fckey"], :name => "memokey"
  add_index "csmemo", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "cspayr", :primary_key => "identity_column", :force => true do |t|
    t.string  "fcftype",          :limit => 3,                                                  :null => false
    t.decimal "fovrate1",                        :precision => 6, :scale => 2,                  :null => false
    t.decimal "fovrate2",                        :precision => 6, :scale => 2,                  :null => false
    t.string  "fclocenvoy",       :limit => 254,                               :default => " ", :null => false
    t.string  "fcloctc",          :limit => 254,                               :default => " ", :null => false
    t.string  "fclocgl",          :limit => 254,                               :default => " ", :null => false
    t.string  "fclocemp",         :limit => 254,                               :default => " ", :null => false
    t.string  "fclocexe",         :limit => 254,                               :default => " ", :null => false
    t.integer "fncpch",           :limit => nil, :precision => 1, :scale => 0,                  :null => false
    t.integer "fnuseenvoy",       :limit => nil, :precision => 1, :scale => 0,                  :null => false
    t.string  "fccompeq",         :limit => 3,                                                  :null => false
    t.string  "fcotheq",          :limit => 4,                                                  :null => false
    t.string  "fcholeq",          :limit => 4,                                                  :null => false
    t.string  "fcsickeq",         :limit => 4,                                                  :null => false
    t.string  "fcvaceq",          :limit => 4,                                                  :null => false
    t.string  "fcstate",          :limit => 2,                                                  :null => false
    t.string  "fcovreq",          :limit => 4,                                                  :null => false
    t.string  "fcregeq",          :limit => 4,                                                  :null => false
    t.integer "fntcmethod",       :limit => nil, :precision => 1, :scale => 0,                  :null => false
    t.integer "fndeptlen",        :limit => nil, :precision => 1, :scale => 0,                  :null => false
    t.decimal "fovrate3",                        :precision => 6, :scale => 2,                  :null => false
    t.decimal "fovrate4",                        :precision => 6, :scale => 2,                  :null => false
    t.decimal "fovrate5",                        :precision => 6, :scale => 2,                  :null => false
    t.string  "fcregecode",       :limit => 4,                                                  :null => false
    t.string  "fcotecode",        :limit => 4,                                                  :null => false
    t.integer "fnadptrans",       :limit => nil, :precision => 1, :scale => 0,                  :null => false
    t.binary  "timestamp_column"
  end

  add_index "cspayr", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "cspopup", :primary_key => "identity_column", :force => true do |t|
    t.string  "fcpopkey",         :limit => 20,                                                 :null => false
    t.string  "fcpoptext",        :limit => 80,                                :default => " ", :null => false
    t.string  "fcpopval",         :limit => 10,                                                 :null => false
    t.integer "fnorder",          :limit => nil, :precision => 3, :scale => 0,                  :null => false
    t.string  "fcpopacces",       :limit => 1,                                                  :null => false
    t.binary  "timestamp_column"
  end

  add_index "cspopup", ["fcpopkey", "fcpopval"], :name => "keyvalue"
  add_index "cspopup", ["fcpopkey", "fnorder", "fcpoptext"], :name => "POPUPKEY"
  add_index "cspopup", ["fcpoptext"], :name => "fcpoptex"
  add_index "cspopup", ["fcpopval"], :name => "fcpopval"
  add_index "cspopup", ["fnorder"], :name => "fnorder"
  add_index "cspopup", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "csprod", :primary_key => "identity_column", :force => true do |t|
    t.string   "fdefstatus",       :limit => 1,                                                                    :null => false
    t.boolean  "fbccanpost",                                                                                       :null => false
    t.string   "fbcnetname",       :limit => 30,                                :default => " ",                   :null => false
    t.string   "fchkqty",          :limit => 1,                                                                    :null => false
    t.string   "fclflushqty",      :limit => 1,                                                                    :null => false
    t.string   "fclflushwhen",     :limit => 1,                                                                    :null => false
    t.datetime "fdjoqrdate",                                                                                       :null => false
    t.datetime "fdmpsrg",                                                                                          :null => false
    t.datetime "fdmrprg",                                                                                          :null => false
    t.datetime "fdqrdate",                                                                                         :null => false
    t.integer  "fentdbckt",        :limit => nil, :precision => 3, :scale => 0,                                    :null => false
    t.string   "fflush",           :limit => 3,                                                                    :null => false
    t.string   "fflushqty",        :limit => 1,                                                                    :null => false
    t.string   "fflushscrp",       :limit => 1,                                                                    :null => false
    t.string   "fflushwhen",       :limit => 1,                                                                    :null => false
    t.boolean  "fgeitemno",                                                                                        :null => false
    t.boolean  "filflushscrp",                                                                                     :null => false
    t.string   "fissuedef",        :limit => 1,                                                                    :null => false
    t.string   "fjobdetail",       :limit => 1,                                                                    :null => false
    t.boolean  "fladtjo",                                                                                          :null => false
    t.boolean  "fladtpo",                                                                                          :null => false
    t.boolean  "fladtqt",                                                                                          :null => false
    t.boolean  "fladtso",                                                                                          :null => false
    t.boolean  "fladtstd",                                                                                         :null => false
    t.boolean  "flallowmov",                                                                                       :null => false
    t.boolean  "flhaslot",                                                                                         :null => false
    t.boolean  "flitmmst",                                                                                         :null => false
    t.boolean  "flitmover",                                                                                        :null => false
    t.boolean  "fljbom",                                                                                           :null => false
    t.boolean  "flmsgeml",                                                                                         :null => false
    t.boolean  "flmsgntf",                                                                                         :null => false
    t.boolean  "flsbom",                                                                                           :null => false
    t.boolean  "flstdbom",                                                                                         :null => false
    t.boolean  "flstdrtg",                                                                                         :null => false
    t.integer  "fmaxmin",          :limit => nil, :precision => 6, :scale => 0,                                    :null => false
    t.string   "fpricetype",       :limit => 1,                                                                    :null => false
    t.string   "fschedtime",       :limit => 1,                                                                    :null => false
    t.string   "fschshfton",       :limit => 5,                                                                    :null => false
    t.integer  "fschshifts",       :limit => nil, :precision => 1, :scale => 0,                                    :null => false
    t.boolean  "fshsomemo",                                                                                        :null => false
    t.string   "fsomemo",          :limit => 1,                                                                    :null => false
    t.datetime "fstop_cal",                                                                                        :null => false
    t.datetime "fstrt_cal",                                                                                        :null => false
    t.string   "ftimetype",        :limit => 1,                                                                    :null => false
    t.string   "fusebomitm",       :limit => 1,                                                                    :null => false
    t.string   "fweek",            :limit => 7,                                                                    :null => false
    t.boolean  "flecmctrl",                                                                                        :null => false
    t.string   "fclndcst1",        :limit => 15,                                                                   :null => false
    t.string   "fclndcst2",        :limit => 15,                                                                   :null => false
    t.string   "fclndcst3",        :limit => 15,                                                                   :null => false
    t.string   "fclndcst4",        :limit => 15,                                                                   :null => false
    t.string   "fclndcst5",        :limit => 15,                                                                   :null => false
    t.string   "fclndcst6",        :limit => 15,                                                                   :null => false
    t.boolean  "fljomtomst",                                                                                       :null => false
    t.boolean  "fljomtobom",                                                                                       :null => false
    t.boolean  "fljomtortg",                                                                                       :null => false
    t.boolean  "fljomtsmst",                                                                                       :null => false
    t.boolean  "fljomtsbom",                                                                                       :null => false
    t.boolean  "fljomtsrtg",                                                                                       :null => false
    t.boolean  "flmtoover",                                                                                        :null => false
    t.boolean  "flmtsover",                                                                                        :null => false
    t.boolean  "flsomst",                                                                                          :null => false
    t.boolean  "flsobom",                                                                                          :null => false
    t.boolean  "flsortg",                                                                                          :null => false
    t.boolean  "flsoover",                                                                                         :null => false
    t.boolean  "flpodesc",                                                                                         :null => false
    t.boolean  "flhasmdi",                                                                                         :null => false
    t.boolean  "flerbadqty",                                                                                       :null => false
    t.binary   "timestamp_column"
    t.text     "fmrfq",                                                         :default => " ",                   :null => false
    t.text     "fpoclmemo",                                                     :default => " ",                   :null => false
    t.boolean  "PostAtRecv",                                                    :default => true
    t.boolean  "fldbrisup",                                                     :default => false,                 :null => false
    t.boolean  "fluseudrev",                                                    :default => false,                 :null => false
    t.boolean  "flTrueBOMQty",                                                  :default => false,                 :null => false
    t.datetime "fdISOQdate",                                                    :default => '1900-01-01 00:00:00', :null => false
    t.boolean  "flAdjBOMQty",                                                                                      :null => false
    t.boolean  "flUpdBatch",                                                                                       :null => false
    t.boolean  "flSpParOvd",                                                                                       :null => false
    t.boolean  "flNoBOMSPQ",                                                    :default => false,                 :null => false
  end

  add_index "csprod", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "cspwset", :primary_key => "identity_column", :force => true do |t|
    t.boolean "flartifact",       :null => false
    t.boolean "flrpqte",          :null => false
    t.boolean "flrpdqte",         :null => false
    t.boolean "flrpso",           :null => false
    t.boolean "flrpdso",          :null => false
    t.boolean "flrpjpik",         :null => false
    t.boolean "flrpjrou",         :null => false
    t.boolean "fldrawings",       :null => false
    t.boolean "flrppo",           :null => false
    t.boolean "flrpship",         :null => false
    t.boolean "flrpinv",          :null => false
    t.boolean "flrpbol",          :null => false
    t.boolean "flrpecsm",         :null => false
    t.boolean "flrpaptl",         :null => false
    t.binary  "timestamp_column"
  end

  add_index "cspwset", ["flartifact"], :name => "ARTIFACT"
  add_index "cspwset", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "cssale", :primary_key => "identity_column", :force => true do |t|
    t.string  "fcstprtxrf",       :limit => 1,                                                  :null => false
    t.integer "fgstrate",         :limit => nil, :precision => 2, :scale => 0,                  :null => false
    t.string  "fintdrive",        :limit => 1,                                                  :null => false
    t.string  "fintpath",         :limit => 45,                                :default => " ", :null => false
    t.boolean "fintrface",                                                                      :null => false
    t.string  "finttype",         :limit => 1,                                                  :null => false
    t.string  "fqtautopr",        :limit => 1,                                                  :null => false
    t.string  "frestricpc",       :limit => 30,                                :default => " ", :null => false
    t.string  "frestricus",       :limit => 30,                                :default => " ", :null => false
    t.string  "fsalecom",         :limit => 1,                                                  :null => false
    t.string  "fsoandays",        :limit => 21,                                                 :null => false
    t.string  "fccredithtyp",     :limit => 1,                                                  :null => false
    t.boolean "fprtqttax",                                                                      :null => false
    t.string  "fcdfudef",         :limit => 1,                                                  :null => false
    t.binary  "timestamp_column"
    t.text    "fqclos",                                                        :default => " ", :null => false
    t.text    "fqsalu",                                                        :default => " ", :null => false
    t.text    "fsalesmemo",                                                    :default => " ", :null => false
    t.integer "fnstatus",         :limit => nil, :precision => 1, :scale => 0, :default => 0,   :null => false
    t.string  "fcctpsetup",       :limit => 1,                                 :default => "D", :null => false
    t.integer "fncalcparm",       :limit => nil, :precision => 1, :scale => 0, :default => 0,   :null => false
  end

  add_index "cssale", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "dbrcbrp", :primary_key => "identity_column", :force => true do |t|
    t.string  "userid",           :limit => 30,                                :null => false
    t.string  "Facility",         :limit => 20,                                :null => false
    t.string  "DueDate",          :limit => 10,                                :null => false
    t.string  "SchedDate",        :limit => 10,                                :null => false
    t.string  "OrderNo",          :limit => 14,                                :null => false
    t.string  "PartNumber",       :limit => 29,                                :null => false
    t.string  "Source",           :limit => 10,                                :null => false
    t.string  "Status",           :limit => 10,                                :null => false
    t.decimal "Qty",                            :precision => 14, :scale => 5, :null => false
    t.string  "Sort",             :limit => 29,                                :null => false
    t.binary  "timestamp_column"
  end

  add_index "dbrcbrp", ["identity_column"], :name => "identity_column_idx1", :unique => true
  add_index "dbrcbrp", ["userid", "Facility"], :name => "byuserid"

  create_table "dbrcocrp", :primary_key => "identity_column", :force => true do |t|
    t.string  "userid",           :limit => 30,                                :null => false
    t.string  "Facility",         :limit => 20,                                :null => false
    t.string  "SoNo",             :limit => 6,                                 :null => false
    t.string  "Customer",         :limit => 35,                                :null => false
    t.string  "INumber",          :limit => 3,                                 :null => false
    t.string  "PartNumber",       :limit => 29,                                :null => false
    t.string  "Source",           :limit => 10,                                :null => false
    t.string  "ReleaseNo",        :limit => 3,                                 :null => false
    t.string  "RelDueDate",       :limit => 10,                                :null => false
    t.decimal "ReleaseQty",                     :precision => 14, :scale => 5, :null => false
    t.string  "AvailDate",        :limit => 10,                                :null => false
    t.decimal "TotSupQty",                      :precision => 14, :scale => 5, :null => false
    t.binary  "timestamp_column"
  end

  add_index "dbrcocrp", ["identity_column"], :name => "identity_column_idx1", :unique => true
  add_index "dbrcocrp", ["userid", "Facility"], :name => "byuserid"

  create_table "dbrcodrp", :primary_key => "identity_column", :force => true do |t|
    t.string   "userid",           :limit => 30,                                 :null => false
    t.string   "Facility",         :limit => 20,                                 :null => false
    t.string   "SoNo",             :limit => 60,                                 :null => false
    t.string   "SOItem",           :limit => 120,                                :null => false
    t.string   "Release",          :limit => 140,                                :null => false
    t.string   "SupSchedDate",     :limit => 10,                                 :null => false
    t.string   "SupDueDate",       :limit => 10,                                 :null => false
    t.string   "SupOrderNo",       :limit => 14,                                 :null => false
    t.decimal  "SupQty",                          :precision => 14, :scale => 5, :null => false
    t.string   "SupType",          :limit => 4,                                  :null => false
    t.string   "SupStatus",        :limit => 10,                                 :null => false
    t.decimal  "SupPab",                          :precision => 14, :scale => 5, :null => false
    t.datetime "SortDate",                                                       :null => false
    t.binary   "timestamp_column"
  end

  add_index "dbrcodrp", ["identity_column"], :name => "identity_column_idx1", :unique => true
  add_index "dbrcodrp", ["userid", "Facility"], :name => "byuserid"

  create_table "dbrcs", :primary_key => "identity_column", :force => true do |t|
    t.string  "cbatchname",       :limit => 15,                                :default => " ",   :null => false
    t.boolean "flaudit",                                                       :default => false, :null => false
    t.string  "userid",           :limit => 30,                                :default => " ",   :null => false
    t.string  "viewoption",       :limit => 1,                                 :default => " ",   :null => false
    t.boolean "flcalcload",                                                    :default => false, :null => false
    t.boolean "flautoccr",                                                     :default => false, :null => false
    t.string  "fcgoal",           :limit => 45,                                :default => " ",   :null => false
    t.boolean "flsetupopt",                                                    :default => false, :null => false
    t.binary  "timestamp_column"
    t.string  "fcAlign",          :limit => 1,                                 :default => "",    :null => false
    t.boolean "fljit",                                                                            :null => false
    t.integer "nFenceDays",       :limit => nil, :precision => 2, :scale => 0,                    :null => false
  end

  add_index "dbrcs", ["cbatchname"], :name => "bybtchname"
  add_index "dbrcs", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "dbrfc", :primary_key => "identity_column", :force => true do |t|
    t.string  "cbatchname",       :limit => 15,  :null => false
    t.string  "userid",           :limit => 30,  :null => false
    t.string  "viewoption",       :limit => 1,   :null => false
    t.boolean "flaudit",                         :null => false
    t.string  "processType",      :limit => 1,   :null => false
    t.string  "cOutpDest",        :limit => 1,   :null => false
    t.string  "cFiltExpr",        :limit => 160, :null => false
    t.binary  "timestamp_column"
  end

  add_index "dbrfc", ["cbatchname"], :name => "bybtchname"
  add_index "dbrfc", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "dbrfcarp", :primary_key => "identity_column", :force => true do |t|
    t.string  "cbatchname",       :limit => 15,                                :null => false
    t.string  "userid",           :limit => 30,                                :null => false
    t.string  "Section",          :limit => 80,                                :null => false
    t.string  "SubSection",       :limit => 80,                                :null => false
    t.integer "RecNo",            :limit => nil, :precision => 7, :scale => 0, :null => false
    t.string  "TxtString",        :limit => 110,                               :null => false
    t.binary  "timestamp_column"
    t.string  "fcfac",            :limit => 20
  end

  add_index "dbrfcarp", ["cbatchname", "userid"], :name => "bybtchname"
  add_index "dbrfcarp", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "dbrfccrp", :primary_key => "identity_column", :force => true do |t|
    t.string  "cbatchname",       :limit => 15,                                :null => false
    t.string  "userid",           :limit => 30,                                :null => false
    t.string  "partno",           :limit => 25,                                :null => false
    t.string  "rev",              :limit => 3,                                 :null => false
    t.string  "partdescr",        :limit => 35,                                :null => false
    t.decimal "cost",                           :precision => 17, :scale => 5, :null => false
    t.binary  "timestamp_column"
    t.string  "fcfac",            :limit => 20
  end

  add_index "dbrfccrp", ["cbatchname", "userid"], :name => "bybtchname"
  add_index "dbrfccrp", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "dbrfcmrp", :primary_key => "identity_column", :force => true do |t|
    t.string  "cbatchname",       :limit => 15,                                :null => false
    t.string  "userid",           :limit => 30,                                :null => false
    t.string  "partno",           :limit => 25,                                :null => false
    t.string  "rev",              :limit => 3,                                 :null => false
    t.string  "partdescr",        :limit => 35,                                :null => false
    t.decimal "price",                          :precision => 17, :scale => 5, :null => false
    t.binary  "timestamp_column"
    t.string  "fcfac",            :limit => 20
  end

  add_index "dbrfcmrp", ["cbatchname", "userid"], :name => "bybtchname"
  add_index "dbrfcmrp", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "dbrfcorp", :primary_key => "identity_column", :force => true do |t|
    t.string  "cbatchname",       :limit => 15,                                :null => false
    t.string  "userid",           :limit => 30,                                :null => false
    t.string  "partno",           :limit => 25,                                :null => false
    t.string  "rev",              :limit => 3,                                 :null => false
    t.string  "partdescr",        :limit => 35,                                :null => false
    t.boolean "lMaxQty",                                                       :null => false
    t.decimal "nMaxQty",                        :precision => 11, :scale => 4, :null => false
    t.binary  "timestamp_column"
    t.string  "fcfac",            :limit => 20
  end

  add_index "dbrfcorp", ["cbatchname", "userid"], :name => "bybtchname"
  add_index "dbrfcorp", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "dbrfcprp", :primary_key => "identity_column", :force => true do |t|
    t.string  "cbatchname",       :limit => 15,                                :null => false
    t.string  "userid",           :limit => 30,                                :null => false
    t.string  "partno",           :limit => 25,                                :null => false
    t.string  "rev",              :limit => 3,                                 :null => false
    t.string  "partdescr",        :limit => 35,                                :null => false
    t.decimal "price",                          :precision => 17, :scale => 5, :null => false
    t.binary  "timestamp_column"
    t.string  "fcfac",            :limit => 20
  end

  add_index "dbrfcprp", ["cbatchname", "userid"], :name => "bybtchname"
  add_index "dbrfcprp", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "dbrfcqrp", :primary_key => "identity_column", :force => true do |t|
    t.string  "cbatchname",       :limit => 15,                                :null => false
    t.string  "userid",           :limit => 30,                                :null => false
    t.string  "partno",           :limit => 25,                                :null => false
    t.string  "rev",              :limit => 3,                                 :null => false
    t.string  "partdescr",        :limit => 35,                                :null => false
    t.boolean "lMaxQty",                                                       :null => false
    t.decimal "nMaxQty",                        :precision => 11, :scale => 4, :null => false
    t.binary  "timestamp_column"
    t.string  "fcfac",            :limit => 20
  end

  add_index "dbrfcqrp", ["cbatchname", "userid"], :name => "bybtchname"
  add_index "dbrfcqrp", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "dbrfctrp", :primary_key => "identity_column", :force => true do |t|
    t.string  "cbatchname",       :limit => 15,                                  :null => false
    t.string  "userid",           :limit => 30,                                  :null => false
    t.string  "JobNo",            :limit => 10,                                  :null => false
    t.integer "OperNo",           :limit => nil, :precision => 4,  :scale => 0,  :null => false
    t.string  "PartNo",           :limit => 25,                                  :null => false
    t.string  "Rev",              :limit => 3,                                   :null => false
    t.decimal "Qty",                             :precision => 15, :scale => 5,  :null => false
    t.decimal "UnitProdTime",                    :precision => 16, :scale => 10, :null => false
    t.decimal "TotProdTime",                     :precision => 15, :scale => 2,  :null => false
    t.string  "WorkCenter",       :limit => 7,                                   :null => false
    t.binary  "timestamp_column"
    t.string  "fcfac",            :limit => 20
    t.boolean "flSched"
  end

  add_index "dbrfctrp", ["cbatchname", "userid"], :name => "bybtchname"
  add_index "dbrfctrp", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "dbrpl", :primary_key => "identity_column", :force => true do |t|
    t.string  "cbatchname",       :limit => 15, :null => false
    t.string  "userid",           :limit => 30, :null => false
    t.string  "viewoption",       :limit => 1,  :null => false
    t.boolean "flaudit",                        :null => false
    t.boolean "flsodmnd",                       :null => false
    t.boolean "flfcstdmnd",                     :null => false
    t.boolean "flssdmnd",                       :null => false
    t.boolean "fldelete",                       :null => false
    t.boolean "flautoccr",                      :null => false
    t.binary  "timestamp_column"
    t.boolean "flFreeze",                       :null => false
  end

  add_index "dbrpl", ["cbatchname"], :name => "bybtchname"
  add_index "dbrpl", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "dbrpliRp", :primary_key => "identity_column", :force => true do |t|
    t.string "CTEXT",            :limit => 80, :null => false
    t.binary "timestamp_column"
  end

  add_index "dbrpliRp", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "dbrpljrp", :primary_key => "identity_column", :force => true do |t|
    t.string  "PARTNO",           :limit => 25,                                :null => false
    t.string  "REV",              :limit => 3,                                 :null => false
    t.string  "JOBNO",            :limit => 10,                                :null => false
    t.string  "CSTATUS",          :limit => 10,                                :null => false
    t.string  "SONO",             :limit => 6,                                 :null => false
    t.string  "ENUMBER",          :limit => 3,                                 :null => false
    t.string  "RELEASENO",        :limit => 3,                                 :null => false
    t.string  "SOURCE",           :limit => 1,                                 :null => false
    t.decimal "QTY",                            :precision => 14, :scale => 5, :null => false
    t.string  "DUEDATE",          :limit => 10,                                :null => false
    t.binary  "timestamp_column"
    t.string  "ExceptType",       :limit => 15,                                :null => false
  end

  add_index "dbrpljrp", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "dbrplnrp", :primary_key => "identity_column", :force => true do |t|
    t.string "SOItemKey",        :limit => 14, :null => false
    t.string "PartKey",          :limit => 29, :null => false
    t.string "PARTNO",           :limit => 25, :null => false
    t.string "REV",              :limit => 3,  :null => false
    t.string "DESCRIPTION",      :limit => 35, :null => false
    t.binary "timestamp_column"
  end

  add_index "dbrplnrp", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "dbrrjd", :primary_key => "identity_column", :force => true do |t|
    t.string  "cbatchname",       :limit => 15,                                :null => false
    t.boolean "lexclusive",                                                    :null => false
    t.boolean "lSummary",                                                      :null => false
    t.string  "viewoption",       :limit => 1,                                 :null => false
    t.string  "coutpdest",        :limit => 1,                                 :null => false
    t.string  "userid",           :limit => 30,                                :null => false
    t.string  "fStatus",          :limit => 10,                                :null => false
    t.string  "fJobNo",           :limit => 10,                                :null => false
    t.string  "fPartNo",          :limit => 25,                                :null => false
    t.string  "fPartRev",         :limit => 3,                                 :null => false
    t.string  "fcSort",           :limit => 1,                                 :null => false
    t.integer "fnbegofset",       :limit => nil, :precision => 5, :scale => 0, :null => false
    t.integer "fndays",           :limit => nil, :precision => 5, :scale => 0, :null => false
    t.string  "cfiltexpr",        :limit => 160,                               :null => false
    t.binary  "timestamp_column"
  end

  add_index "dbrrjd", ["cbatchname"], :name => "bybtchname"
  add_index "dbrrjd", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "dbrrjdrp", :primary_key => "identity_column", :force => true do |t|
    t.string   "cbatchname",       :limit => 15,                                 :null => false
    t.string   "userid",           :limit => 30,                                 :null => false
    t.string   "fcproID",          :limit => 7,                                  :null => false
    t.string   "fcfac",            :limit => 20,                                 :null => false
    t.datetime "fFnshDate",                                                      :null => false
    t.integer  "fShift",           :limit => nil, :precision => 1,  :scale => 0, :null => false
    t.integer  "fFnshTime",        :limit => nil, :precision => 6,  :scale => 0, :null => false
    t.string   "fStatus",          :limit => 10,                                 :null => false
    t.string   "fJobNo",           :limit => 10,                                 :null => false
    t.integer  "fOperNo",          :limit => nil, :precision => 4,  :scale => 0, :null => false
    t.string   "fPartNo",          :limit => 25,                                 :null => false
    t.string   "fPartRev",         :limit => 3,                                  :null => false
    t.string   "fDept",            :limit => 2,                                  :null => false
    t.string   "fCharCode",        :limit => 10,                                 :null => false
    t.string   "fcproIDPrev",      :limit => 7,                                  :null => false
    t.decimal  "fnQty_Comp",                      :precision => 14, :scale => 5, :null => false
    t.string   "fcproIDNext",      :limit => 7,                                  :null => false
    t.decimal  "fnQty_ToGo",                      :precision => 14, :scale => 5, :null => false
    t.decimal  "fnSetupTime",                     :precision => 7,  :scale => 2, :null => false
    t.decimal  "fnTotal",                         :precision => 7,  :scale => 2, :null => false
    t.decimal  "fnTimeToGo",                      :precision => 7,  :scale => 2, :null => false
    t.string   "fcAddRes",         :limit => 160,                                :null => false
    t.decimal  "fnRequired",                      :precision => 14, :scale => 5, :null => false
    t.decimal  "fnSchedule",                      :precision => 7,  :scale => 2, :null => false
    t.string   "fCompany",         :limit => 35,                                 :null => false
    t.string   "fSoNo",            :limit => 6,                                  :null => false
    t.integer  "fnSimulOps",       :limit => nil, :precision => 3,  :scale => 0, :null => false
    t.binary   "timestamp_column"
    t.datetime "fdactdate",                                                      :null => false
    t.string   "Additional1",      :limit => 7,                                  :null => false
    t.string   "Additional2",      :limit => 7,                                  :null => false
    t.boolean  "IsPrimary",                                                      :null => false
  end

  add_index "dbrrjdrp", ["cbatchname", "userid"], :name => "bybtchname"
  add_index "dbrrjdrp", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "dbrrl", :primary_key => "identity_column", :force => true do |t|
    t.string  "cbatchname",       :limit => 15,                                :default => " ",   :null => false
    t.string  "viewoption",       :limit => 1,                                 :default => " ",   :null => false
    t.string  "coutpdest",        :limit => 1,                                 :default => " ",   :null => false
    t.string  "userid",           :limit => 30,                                :default => " ",   :null => false
    t.string  "fcpro_id",         :limit => 7,                                 :default => " ",   :null => false
    t.string  "fdept",            :limit => 2,                                 :default => " ",   :null => false
    t.string  "ccalid",           :limit => 3,                                 :default => " ",   :null => false
    t.string  "cfiltexpr",        :limit => 160,                               :default => " ",   :null => false
    t.integer "fndays",           :limit => nil, :precision => 5, :scale => 0, :default => 0,     :null => false
    t.binary  "timestamp_column"
    t.boolean "lexclusive",                                                    :default => false, :null => false
    t.integer "fnbegofset",       :limit => nil, :precision => 5, :scale => 0, :default => 0,     :null => false
    t.string  "cOutpType",        :limit => 1,                                                    :null => false
    t.string  "CalcBased",        :limit => 1,                                                    :null => false
    t.string  "SortOrder",        :limit => 1,                                                    :null => false
    t.string  "fcUOM",            :limit => 1,                                                    :null => false
  end

  add_index "dbrrl", ["cbatchname"], :name => "bybtchname"
  add_index "dbrrl", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "dbrrlrp", :primary_key => "identity_column", :force => true do |t|
    t.string   "fcpro_id",         :limit => 7,                                  :default => " ",                   :null => false
    t.string   "perdname",         :limit => 10,                                 :default => " ",                   :null => false
    t.decimal  "req_load",                        :precision => 18, :scale => 3, :default => 0.0,                   :null => false
    t.decimal  "capacity",                        :precision => 17, :scale => 1, :default => 0.0,                   :null => false
    t.decimal  "nloadprcnt",                      :precision => 8,  :scale => 1, :default => 0.0,                   :null => false
    t.decimal  "noutstacap",                      :precision => 18, :scale => 3, :default => 0.0,                   :null => false
    t.decimal  "ncumcapprc",                      :precision => 8,  :scale => 1, :default => 0.0,                   :null => false
    t.decimal  "noutstacum",                      :precision => 18, :scale => 3, :default => 0.0,                   :null => false
    t.string   "cbatchname",       :limit => 15,                                 :default => " ",                   :null => false
    t.string   "userid",           :limit => 30,                                 :default => " ",                   :null => false
    t.integer  "seqno",            :limit => nil, :precision => 8,  :scale => 0, :default => 0,                     :null => false
    t.binary   "timestamp_column"
    t.string   "fcfac",            :limit => 20,                                 :default => " "
    t.datetime "sortdate",                                                       :default => '1900-01-01 00:00:00', :null => false
    t.string   "SortDateString",   :limit => 23,                                                                    :null => false
  end

  add_index "dbrrlrp", ["cbatchname", "userid"], :name => "bybtchname"
  add_index "dbrrlrp", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "dbrrn", :primary_key => "identity_column", :force => true do |t|
    t.string  "cbatchname",       :limit => 15,                                :default => " ",   :null => false
    t.string  "coutpdest",        :limit => 1,                                 :default => " ",   :null => false
    t.string  "viewoption",       :limit => 1,                                 :default => " ",   :null => false
    t.string  "fpartno",          :limit => 25,                                :default => " ",   :null => false
    t.string  "frev",             :limit => 3,                                 :default => " ",   :null => false
    t.string  "fabccode",         :limit => 1,                                 :default => " ",   :null => false
    t.string  "fgroup",           :limit => 6,                                 :default => " ",   :null => false
    t.string  "fbuyer",           :limit => 3,                                 :default => " ",   :null => false
    t.string  "fprodcl",          :limit => 2,                                 :default => " ",   :null => false
    t.string  "fsource",          :limit => 1,                                 :default => " ",   :null => false
    t.string  "ccalid",           :limit => 3,                                 :default => " ",   :null => false
    t.string  "fcmsdcol1",        :limit => 1,                                 :default => " ",   :null => false
    t.string  "fcmsdcol2",        :limit => 1,                                 :default => " ",   :null => false
    t.string  "fcssdcol1",        :limit => 1,                                 :default => " ",   :null => false
    t.string  "fcssdcol2",        :limit => 1,                                 :default => " ",   :null => false
    t.string  "cfiltexpr",        :limit => 160,                               :default => " ",   :null => false
    t.integer "fndays",           :limit => nil, :precision => 5, :scale => 0, :default => 0,     :null => false
    t.string  "userid",           :limit => 30,                                :default => " ",   :null => false
    t.binary  "timestamp_column"
    t.boolean "lexclusive",                                                    :default => false, :null => false
    t.integer "fnbegofset",       :limit => nil, :precision => 5, :scale => 0, :default => 0,     :null => false
    t.string  "DateOption",       :limit => 1,                                                    :null => false
    t.boolean "lMake",                                                                            :null => false
    t.boolean "lStock",                                                                           :null => false
    t.boolean "lPurchased",                                                                       :null => false
    t.boolean "lInterFac",                                                                        :null => false
    t.string  "fac",              :limit => 20
    t.integer "fnpabexcpt",       :limit => nil, :precision => 5, :scale => 0,                    :null => false
  end

  add_index "dbrrn", ["cbatchname"], :name => "bybtchname"
  add_index "dbrrn", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "dbrrnrp", :primary_key => "identity_column", :force => true do |t|
    t.string   "fpartno",          :limit => 25,                                 :default => " ",                   :null => false
    t.string   "frev",             :limit => 3,                                  :default => " ",                   :null => false
    t.datetime "fddue_date",                                                     :default => '1900-01-01 00:00:00', :null => false
    t.string   "fctype",           :limit => 4,                                  :default => " ",                   :null => false
    t.string   "fjobno",           :limit => 15,                                 :default => " ",                   :null => false
    t.string   "fstatus",          :limit => 10,                                 :default => " ",                   :null => false
    t.string   "ftype",            :limit => 1,                                  :default => " ",                   :null => false
    t.decimal  "fquantity",                       :precision => 16, :scale => 5, :default => 0.0,                   :null => false
    t.decimal  "ncol1quant",                      :precision => 16, :scale => 5, :default => 0.0,                   :null => false
    t.decimal  "ncol2quant",                      :precision => 16, :scale => 5, :default => 0.0,                   :null => false
    t.string   "cbatchname",       :limit => 15,                                 :default => " ",                   :null => false
    t.string   "userid",           :limit => 30,                                 :default => " ",                   :null => false
    t.integer  "seqno",            :limit => nil, :precision => 8,  :scale => 0, :default => 0,                     :null => false
    t.binary   "timestamp_column"
    t.string   "fcfac",            :limit => 20,                                 :default => " "
  end

  add_index "dbrrnrp", ["cbatchname", "userid"], :name => "bybtchname"
  add_index "dbrrnrp", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "dbrrs", :primary_key => "identity_column", :force => true do |t|
    t.string  "cbatchname",       :limit => 15,                                :default => " ",   :null => false
    t.integer "fnpabexcpt",       :limit => nil, :precision => 1, :scale => 0, :default => 0,     :null => false
    t.string  "fcaggregat",       :limit => 1,                                 :default => " ",   :null => false
    t.string  "viewoption",       :limit => 1,                                 :default => " ",   :null => false
    t.string  "coutpdest",        :limit => 1,                                 :default => " ",   :null => false
    t.string  "userid",           :limit => 30,                                :default => " ",   :null => false
    t.string  "fcssdln01",        :limit => 1,                                 :default => " ",   :null => false
    t.string  "fcssdln02",        :limit => 1,                                 :default => " ",   :null => false
    t.string  "fcssdln03",        :limit => 1,                                 :default => " ",   :null => false
    t.string  "fcssdln04",        :limit => 1,                                 :default => " ",   :null => false
    t.string  "fcssdln05",        :limit => 1,                                 :default => " ",   :null => false
    t.string  "fcssdln06",        :limit => 1,                                 :default => " ",   :null => false
    t.string  "fcssdln07",        :limit => 1,                                 :default => " ",   :null => false
    t.string  "fcssdln08",        :limit => 1,                                 :default => " ",   :null => false
    t.string  "fcssdln09",        :limit => 1,                                 :default => " ",   :null => false
    t.string  "fcssdln10",        :limit => 1,                                 :default => " ",   :null => false
    t.string  "fcmsdln01",        :limit => 1,                                 :default => " ",   :null => false
    t.string  "fcmsdln02",        :limit => 1,                                 :default => " ",   :null => false
    t.string  "fcmsdln03",        :limit => 1,                                 :default => " ",   :null => false
    t.string  "fcmsdln04",        :limit => 1,                                 :default => " ",   :null => false
    t.string  "fcmsdln05",        :limit => 1,                                 :default => " ",   :null => false
    t.string  "fcmsdln06",        :limit => 1,                                 :default => " ",   :null => false
    t.string  "fcmsdln07",        :limit => 1,                                 :default => " ",   :null => false
    t.string  "fcmsdln08",        :limit => 1,                                 :default => " ",   :null => false
    t.string  "fcmsdln09",        :limit => 1,                                 :default => " ",   :null => false
    t.string  "fcmsdln10",        :limit => 1,                                 :default => " ",   :null => false
    t.string  "fpartno",          :limit => 25,                                :default => " ",   :null => false
    t.string  "frev",             :limit => 3,                                 :default => " ",   :null => false
    t.string  "fabccode",         :limit => 1,                                 :default => " ",   :null => false
    t.string  "fgroup",           :limit => 6,                                 :default => " ",   :null => false
    t.string  "fbuyer",           :limit => 3,                                 :default => " ",   :null => false
    t.string  "fprodcl",          :limit => 2,                                 :default => " ",   :null => false
    t.string  "fsource",          :limit => 1,                                 :default => " ",   :null => false
    t.string  "ccalid",           :limit => 3,                                 :default => " ",   :null => false
    t.string  "cfiltexpr",        :limit => 160,                               :default => " ",   :null => false
    t.integer "fndays",           :limit => nil, :precision => 5, :scale => 0, :default => 0,     :null => false
    t.binary  "timestamp_column"
    t.boolean "lexclusive",                                                    :default => false, :null => false
    t.integer "fnbegofset",       :limit => nil, :precision => 5, :scale => 0, :default => 0,     :null => false
    t.string  "DateOption",       :limit => 1,                                                    :null => false
    t.string  "DispCol",          :limit => 1,                                                    :null => false
    t.boolean "lMake",                                                                            :null => false
    t.boolean "lStock",                                                                           :null => false
    t.boolean "lPurchased",                                                                       :null => false
    t.boolean "lInterFac",                                                                        :null => false
    t.string  "fac",              :limit => 20
    t.boolean "lLongMode",                                                                        :null => false
    t.integer "fnPerLine",        :limit => nil, :precision => 2, :scale => 0,                    :null => false
  end

  add_index "dbrrs", ["cbatchname"], :name => "bybtchname"
  add_index "dbrrs", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "dbrrsrp", :primary_key => "identity_column", :force => true do |t|
    t.string  "fpartno",          :limit => 25,                                 :default => " ",   :null => false
    t.string  "frev",             :limit => 3,                                  :default => " ",   :null => false
    t.string  "ccaption",         :limit => 10,                                 :default => " ",   :null => false
    t.string  "period1",          :limit => 12,                                 :default => " ",   :null => false
    t.string  "period2",          :limit => 12,                                 :default => " ",   :null => false
    t.string  "period3",          :limit => 12,                                 :default => " ",   :null => false
    t.string  "period4",          :limit => 12,                                 :default => " ",   :null => false
    t.string  "period5",          :limit => 12,                                 :default => " ",   :null => false
    t.string  "period6",          :limit => 12,                                 :default => " ",   :null => false
    t.string  "period7",          :limit => 12,                                 :default => " ",   :null => false
    t.string  "period8",          :limit => 12,                                 :default => " ",   :null => false
    t.string  "period9",          :limit => 12,                                 :default => " ",   :null => false
    t.string  "cbatchname",       :limit => 15,                                 :default => " ",   :null => false
    t.string  "fprodcl",          :limit => 2,                                  :default => " ",   :null => false
    t.string  "fgroup",           :limit => 6,                                  :default => " ",   :null => false
    t.string  "fabccode",         :limit => 1,                                  :default => " ",   :null => false
    t.string  "fbuyer",           :limit => 3,                                  :default => " ",   :null => false
    t.string  "userid",           :limit => 30,                                 :default => " ",   :null => false
    t.decimal "fonhand",                         :precision => 17, :scale => 4, :default => 0.0,   :null => false
    t.decimal "fsafety",                         :precision => 17, :scale => 4, :default => 0.0,   :null => false
    t.boolean "lpagebreak",                                                     :default => false, :null => false
    t.integer "seqno",            :limit => nil, :precision => 8,  :scale => 0, :default => 0,     :null => false
    t.binary  "timestamp_column"
    t.string  "fcfac",            :limit => 20,                                 :default => " "
    t.string  "cAggregate",       :limit => 1,                                                     :null => false
  end

  add_index "dbrrsrp", ["cbatchname", "userid"], :name => "bybtchname"
  add_index "dbrrsrp", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "dbrrwd", :primary_key => "identity_column", :force => true do |t|
    t.string  "cbatchname",       :limit => 15,                                :null => false
    t.boolean "lexclusive",                                                    :null => false
    t.boolean "lSummary",                                                      :null => false
    t.string  "viewoption",       :limit => 1,                                 :null => false
    t.string  "coutpdest",        :limit => 1,                                 :null => false
    t.string  "userid",           :limit => 30,                                :null => false
    t.string  "fcpro_id",         :limit => 7,                                 :null => false
    t.string  "fDept",            :limit => 2,                                 :null => false
    t.string  "fcSelection",      :limit => 1,                                 :null => false
    t.string  "fcSort",           :limit => 1,                                 :null => false
    t.integer "fnbegofset",       :limit => nil, :precision => 5, :scale => 0, :null => false
    t.integer "fndays",           :limit => nil, :precision => 5, :scale => 0, :null => false
    t.string  "cfiltexpr",        :limit => 160,                               :null => false
    t.binary  "timestamp_column"
  end

  add_index "dbrrwd", ["cbatchname"], :name => "bybtchname"
  add_index "dbrrwd", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "dbrrwdrp", :primary_key => "identity_column", :force => true do |t|
    t.string   "cbatchname",       :limit => 15,                                 :null => false
    t.string   "userid",           :limit => 30,                                 :null => false
    t.string   "fcproID",          :limit => 7,                                  :null => false
    t.string   "fcfac",            :limit => 20,                                 :null => false
    t.datetime "fFnshDate",                                                      :null => false
    t.integer  "fShift",           :limit => nil, :precision => 1,  :scale => 0, :null => false
    t.integer  "fFnshTime",        :limit => nil, :precision => 6,  :scale => 0, :null => false
    t.string   "fStatus",          :limit => 10,                                 :null => false
    t.string   "fJobNo",           :limit => 10,                                 :null => false
    t.integer  "fOperNo",          :limit => nil, :precision => 4,  :scale => 0, :null => false
    t.string   "fPartNo",          :limit => 25,                                 :null => false
    t.string   "fPartRev",         :limit => 3,                                  :null => false
    t.string   "fDept",            :limit => 2,                                  :null => false
    t.string   "fcproIDPrev",      :limit => 7,                                  :null => false
    t.decimal  "fnQty_Comp",                      :precision => 14, :scale => 5, :null => false
    t.string   "fcproIDNext",      :limit => 7,                                  :null => false
    t.decimal  "fnQty_ToGo",                      :precision => 14, :scale => 5, :null => false
    t.decimal  "fnSetupTime",                     :precision => 7,  :scale => 2, :null => false
    t.decimal  "fnTotal",                         :precision => 7,  :scale => 2, :null => false
    t.decimal  "fnTimeToGo",                      :precision => 7,  :scale => 2, :null => false
    t.string   "fcAddRes",         :limit => 160,                                :null => false
    t.decimal  "fnRequired",                      :precision => 14, :scale => 5, :null => false
    t.decimal  "fnSchedule",                      :precision => 7,  :scale => 2, :null => false
    t.string   "fCharCode",        :limit => 10,                                 :null => false
    t.string   "fSoNo",            :limit => 6,                                  :null => false
    t.string   "fCompany",         :limit => 35,                                 :null => false
    t.integer  "fnSimulOps",       :limit => nil, :precision => 3,  :scale => 0, :null => false
    t.binary   "timestamp_column"
    t.datetime "fdactdate",                                                      :null => false
    t.datetime "NextOpStartDate",                                                :null => false
    t.string   "Additional1",      :limit => 7,                                  :null => false
    t.string   "Additional2",      :limit => 7,                                  :null => false
    t.boolean  "IsPrimary",                                                      :null => false
  end

  add_index "dbrrwdrp", ["cbatchname", "userid"], :name => "bybtchname"
  add_index "dbrrwdrp", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "eafire", :primary_key => "identity_column", :force => true do |t|
    t.string   "finitials",        :limit => 80
    t.string   "ftable",           :limit => 12
    t.integer  "frecno"
    t.boolean  "ffired"
    t.string   "facttype",         :limit => 10
    t.string   "fckey",            :limit => 10
    t.boolean  "fnotified"
    t.string   "fcpersresp",       :limit => 10
    t.string   "fnotikey",         :limit => 10
    t.integer  "fpriority",        :limit => 2
    t.datetime "fddate"
    t.binary   "timestamp_column"
    t.text     "faction"
    t.text     "fmessage"
    t.string   "fcdeleted",        :limit => 3000
  end

  add_index "eafire", ["fcpersresp"], :name => "persresp"
  add_index "eafire", ["finitials"], :name => "initials"
  add_index "eafire", ["fnotikey"], :name => "notikey"
  add_index "eafire", ["frecno", "fckey"], :name => "keyrec"
  add_index "eafire", ["frecno", "ftable"], :name => "rectable"
  add_index "eafire", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "eanoti", :primary_key => "identity_column", :force => true do |t|
    t.string  "fckey",            :limit => 10
    t.string  "ftable",           :limit => 12
    t.string  "fdesc",            :limit => 40
    t.integer "forder"
    t.boolean "finsert"
    t.boolean "fupdate"
    t.boolean "fdelete"
    t.integer "fstatus"
    t.string  "facttype",         :limit => 10
    t.boolean "fcontinue"
    t.integer "fpriority"
    t.string  "fcpersresp",       :limit => 10
    t.string  "fcpersfrom",       :limit => 10
    t.string  "fcrectype",        :limit => 10
    t.integer "ffireonly"
    t.string  "frecgroup",        :limit => 10
    t.boolean "flcuruser"
    t.string  "fcemail",          :limit => 100
    t.binary  "timestamp_column"
    t.text    "faction"
    t.text    "fcmessage"
    t.text    "fcondition"
    t.boolean "flnotified"
  end

  add_index "eanoti", ["fckey"], :name => "bykey"
  add_index "eanoti", ["ftable", "forder"], :name => "bytable"
  add_index "eanoti", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "eaprac", :primary_key => "identity_column", :force => true do |t|
    t.string "fname",            :limit => 40
    t.string "facttype",         :limit => 10
    t.binary "timestamp_column"
    t.text   "faction"
    t.text   "fcmessage"
    t.text   "fdesc"
  end

  add_index "eaprac", ["fname"], :name => "byname"
  add_index "eaprac", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "eaprev", :primary_key => "identity_column", :force => true do |t|
    t.string  "fname",            :limit => 40
    t.string  "ftable",           :limit => 12
    t.boolean "fcreate"
    t.boolean "fupdate"
    t.boolean "fdelete"
    t.boolean "fcontinue"
    t.integer "ffireonly"
    t.binary  "timestamp_column"
    t.text    "fcriteria"
    t.text    "fdesc"
    t.text    "fmessage"
  end

  add_index "eaprev", ["fname"], :name => "byname"
  add_index "eaprev", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "eatrig", :primary_key => "identity_column", :force => true do |t|
    t.string "trigname",         :limit => 254
    t.binary "timestamp_column"
  end

  create_table "ecmctl", :primary_key => "identity_column", :force => true do |t|
    t.string  "fcrecid",          :limit => 25,                        :null => false
    t.string  "fctype",           :limit => 1,                         :null => false
    t.boolean "flbomcntrl",                                            :null => false
    t.boolean "flmstcntrl",                                            :null => false
    t.boolean "flrtgcntrl",                                            :null => false
    t.string  "fcjobno",          :limit => 10,                        :null => false
    t.string  "fcsono",           :limit => 6,                         :null => false
    t.binary  "timestamp_column"
    t.string  "fac",              :limit => 20, :default => "Default", :null => false
  end

  add_index "ecmctl", ["fcjobno"], :name => "jobnum"
  add_index "ecmctl", ["fcrecid"], :name => "recid"
  add_index "ecmctl", ["fcsono"], :name => "sono"
  add_index "ecmctl", ["fctype", "fac", "fcrecid"], :name => "TYPEREC"
  add_index "ecmctl", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "ecmlog", :primary_key => "identity_column", :force => true do |t|
    t.datetime "ftdate",                                          :null => false
    t.string   "fcmsgid",          :limit => 35, :default => " ", :null => false
    t.string   "fcuser",           :limit => 10,                  :null => false
    t.binary   "timestamp_column"
    t.text     "fmmessage",                      :default => " ", :null => false
  end

  add_index "ecmlog", ["fcmsgid"], :name => "msgid"
  add_index "ecmlog", ["fcuser"], :name => "user_"
  add_index "ecmlog", ["ftdate"], :name => "date"
  add_index "ecmlog", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "ecobdl", :primary_key => "identity_column", :force => true do |t|
    t.string "fceco",            :limit => 25, :null => false
    t.string "fcrecid",          :limit => 10, :null => false
    t.string "fctype",           :limit => 1,  :null => false
    t.binary "timestamp_column"
  end

  add_index "ecobdl", ["fceco", "fctype", "fcrecid"], :name => "ECOTYPEID"
  add_index "ecobdl", ["fcrecid"], :name => "recid"
  add_index "ecobdl", ["fctype"], :name => "type"
  add_index "ecobdl", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "ecomast", :primary_key => "identity_column", :force => true do |t|
    t.string   "fcauthor",         :limit => 10,                                                 :null => false
    t.string   "fceco",            :limit => 25,                                                 :null => false
    t.string   "fcjobno",          :limit => 10,                                                 :null => false
    t.string   "fcpart",           :limit => 25,                                                 :null => false
    t.string   "fcpartrev",        :limit => 3,                                                  :null => false
    t.string   "fcreason",         :limit => 10,                                                 :null => false
    t.string   "fcsono",           :limit => 6,                                                  :null => false
    t.string   "fcstscode",        :limit => 1,                                                  :null => false
    t.string   "fctemplate",       :limit => 50,                                :default => " ", :null => false
    t.string   "fcusrchr1",        :limit => 20,                                                 :null => false
    t.string   "fcusrchr2",        :limit => 40,                                :default => " ", :null => false
    t.string   "fcusrchr3",        :limit => 40,                                :default => " ", :null => false
    t.datetime "fdeffectiv",                                                                     :null => false
    t.datetime "fdusrdate1",                                                                     :null => false
    t.decimal  "fnusrcur1",                      :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fnusrqty1",                      :precision => 15, :scale => 5,                  :null => false
    t.datetime "ftapproved",                                                                     :null => false
    t.datetime "ftcomplete",                                                                     :null => false
    t.datetime "ftstarted",                                                                      :null => false
    t.boolean  "fltemplt",                                                                       :null => false
    t.binary   "timestamp_column"
    t.text     "fmchginfo",                                                     :default => " ", :null => false
    t.text     "fmusrmemo1",                                                    :default => " ", :null => false
    t.string   "fac",              :limit => 20,                                                 :null => false
    t.string   "fcudrev",          :limit => 3,                                 :default => " "
  end

  add_index "ecomast", ["fcauthor"], :name => "author"
  add_index "ecomast", ["fceco"], :name => "eco"
  add_index "ecomast", ["fcjobno"], :name => "jobno"
  add_index "ecomast", ["fcpart", "fcpartrev", "fac"], :name => "PARTREV"
  add_index "ecomast", ["fcreason"], :name => "reason"
  add_index "ecomast", ["fcsono"], :name => "sono"
  add_index "ecomast", ["fcstscode"], :name => "status"
  add_index "ecomast", ["fctemplate"], :name => "template"
  add_index "ecomast", ["fdeffectiv"], :name => "effectiv"
  add_index "ecomast", ["ftcomplete"], :name => "complete"
  add_index "ecomast", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "ecosth", :primary_key => "identity_column", :force => true do |t|
    t.string   "fceco",            :limit => 25,                  :null => false
    t.string   "fcnewval",         :limit => 1,                   :null => false
    t.string   "fcoldval",         :limit => 1,                   :null => false
    t.string   "fcuser",           :limit => 10,                  :null => false
    t.datetime "ftdate",                                          :null => false
    t.binary   "timestamp_column"
    t.text     "fmcmnts",                        :default => " ", :null => false
  end

  add_index "ecosth", ["fceco"], :name => "eco"
  add_index "ecosth", ["fcuser"], :name => "user_"
  add_index "ecosth", ["ftdate"], :name => "date"
  add_index "ecosth", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "ecosts", :primary_key => "identity_column", :force => true do |t|
    t.string "fcstscode",        :limit => 1,  :null => false
    t.string "fcstsnm",          :limit => 25, :null => false
    t.binary "timestamp_column"
  end

  add_index "ecosts", ["fcstscode"], :name => "stscode"
  add_index "ecosts", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "explorer", :primary_key => "identity_column", :force => true do |t|
    t.string  "fcinitials",       :limit => 3,                    :null => false
    t.string  "fctype",           :limit => 1,                    :null => false
    t.string  "fcnodetype",       :limit => 10,                   :null => false
    t.integer "fiorder",                                          :null => false
    t.string  "fclabel",          :limit => 30,  :default => " ", :null => false
    t.string  "fcexpr",           :limit => 254, :default => " ", :null => false
    t.integer "filo",                                             :null => false
    t.integer "fihi",                                             :null => false
    t.boolean "flinvtherm",                                       :null => false
    t.binary  "timestamp_column"
  end

  add_index "explorer", ["fcinitials", "fctype", "fcnodetype", "fiorder"], :name => "NODETYPE"
  add_index "explorer", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "facility", :primary_key => "identity_column", :force => true do |t|
    t.string  "fcfacility",       :limit => 20,  :null => false
    t.string  "fcdesc",           :limit => 35,  :null => false
    t.boolean "fldc"
    t.boolean "flmfg"
    t.boolean "flstores"
    t.text    "fmstreet"
    t.string  "fccity",           :limit => 20
    t.string  "fcstate",          :limit => 20
    t.string  "fczip",            :limit => 10
    t.string  "fccountry",        :limit => 25
    t.string  "fcfname",          :limit => 15
    t.string  "fclname",          :limit => 20
    t.string  "fcphone",          :limit => 20
    t.string  "fcfax",            :limit => 20
    t.string  "fcemail",          :limit => 128
    t.binary  "timestamp_column"
    t.integer "fndbrmod",         :limit => 1,   :null => false
  end

  add_index "facility", ["fcdesc"], :name => "IX_Description"
  add_index "facility", ["fcfacility"], :name => "IX_PRIMARY"
  add_index "facility", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "fb", :primary_key => "identity_column", :force => true do |t|
    t.string  "cbatchname",       :limit => 15,                                :default => "", :null => false
    t.string  "coperation",       :limit => 1,                                 :default => "", :null => false
    t.integer "nversion",         :limit => nil, :precision => 3, :scale => 0, :default => 0,  :null => false
    t.binary  "timestamp_column"
  end

  add_index "fb", ["cbatchname"], :name => "bybtchname"
  add_index "fb", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "ficons", :primary_key => "identity_column", :force => true do |t|
    t.string   "fcacctnum",        :limit => 25, :null => false
    t.string   "fcrecid",          :limit => 2,  :null => false
    t.string   "fccurid",          :limit => 3,  :null => false
    t.decimal  "famount",                        :null => false
    t.string   "fcstartyr",        :limit => 20, :null => false
    t.integer  "fistartpd",                      :null => false
    t.string   "fcendyr",          :limit => 20, :null => false
    t.integer  "fiendpd",                        :null => false
    t.datetime "fddate",                         :null => false
    t.datetime "fttimets",                       :null => false
    t.binary   "timestamp_column"
  end

  add_index "ficons", ["fttimets", "fcrecid", "fcacctnum"], :name => "COCONSID"
  add_index "ficons", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "foactvty", :primary_key => "identity_column", :force => true do |t|
    t.string   "fcavinsid",        :limit => 6,                  :null => false
    t.string   "fcavtype",         :limit => 2,                  :null => false
    t.datetime "fdavwhen",                                       :null => false
    t.boolean  "flavupload",                                     :null => false
    t.binary   "timestamp_column"
    t.text     "fmavinfo",                      :default => " ", :null => false
  end

  add_index "foactvty", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "fofeatur", :primary_key => "identity_column", :force => true do |t|
    t.string  "fcftid",           :limit => 6,                                                  :null => false
    t.string  "fcftdesc",         :limit => 80,                                :default => " ", :null => false
    t.string  "fcftprompt",       :limit => 30,                                :default => " ", :null => false
    t.string  "fcftwizbmp",       :limit => 8,                                                  :null => false
    t.string  "fcftdoc",          :limit => 12,                                                 :null => false
    t.string  "fcftexrule",       :limit => 12,                                                 :null => false
    t.integer "fnftmin",          :limit => nil, :precision => 4, :scale => 0,                  :null => false
    t.integer "fnftmax",          :limit => nil, :precision => 4, :scale => 0,                  :null => false
    t.string  "fcftoptdef",       :limit => 6,                                                  :null => false
    t.integer "fnftlstwid",       :limit => nil, :precision => 3, :scale => 0,                  :null => false
    t.integer "fnftspstrt",       :limit => nil, :precision => 2, :scale => 0,                  :null => false
    t.integer "fnftsplen",        :limit => nil, :precision => 2, :scale => 0,                  :null => false
    t.boolean "flftcalc",                                                                       :null => false
    t.binary  "timestamp_column"
    t.text    "fmfthlp",                                                       :default => " ", :null => false
  end

  add_index "fofeatur", ["fcftdesc"], :name => "fofeatur_desc_", :unique => true
  add_index "fofeatur", ["fcftid"], :name => "fofeatur_id", :unique => true
  add_index "fofeatur", ["fcftprompt"], :name => "fcftprompt"
  add_index "fofeatur", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "fooptgrp", :primary_key => "identity_column", :force => true do |t|
    t.string "foogfeatid",       :limit => 6, :null => false
    t.string "foogoptid",        :limit => 6, :null => false
    t.string "foogord",          :limit => 4, :null => false
    t.binary "timestamp_column"
  end

  add_index "fooptgrp", ["foogfeatid", "foogoptid", "foogord"], :name => "featopt"
  add_index "fooptgrp", ["foogfeatid", "foogord"], :name => "featord"
  add_index "fooptgrp", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "fooption", :primary_key => "identity_column", :force => true do |t|
    t.string  "fcopid",           :limit => 6,                                                   :null => false
    t.string  "fcoptext",         :limit => 30,                                 :default => " ", :null => false
    t.string  "fcopdesc",         :limit => 80,                                 :default => " ", :null => false
    t.string  "fcoptype",         :limit => 1,                                                   :null => false
    t.string  "fcopdoc",          :limit => 12,                                                  :null => false
    t.string  "fcopsmsect",       :limit => 10,                                                  :null => false
    t.string  "fcopexrule",       :limit => 12,                                                  :null => false
    t.integer "fnopspstrt",       :limit => nil, :precision => 2,  :scale => 0,                  :null => false
    t.integer "fnopsplen",        :limit => nil, :precision => 2,  :scale => 0,                  :null => false
    t.decimal "fnopmin",                         :precision => 15, :scale => 5,                  :null => false
    t.decimal "fnopmax",                         :precision => 15, :scale => 5,                  :null => false
    t.boolean "flallparts",                                                                      :null => false
    t.decimal "fndefqty",                        :precision => 15, :scale => 5,                  :null => false
    t.boolean "flopcalc",                                                                        :null => false
    t.binary  "timestamp_column"
    t.text    "fmopcalc",                                                       :default => " ", :null => false
    t.text    "fmophelp",                                                       :default => " ", :null => false
  end

  add_index "fooption", ["fcopdesc"], :name => "fooption_desc_", :unique => true
  add_index "fooption", ["fcopid"], :name => "fooption_id", :unique => true
  add_index "fooption", ["fcoptext"], :name => "fcoptext"
  add_index "fooption", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "foprinsa", :primary_key => "identity_column", :force => true do |t|
    t.string  "fcipid",           :limit => 15,                  :null => false
    t.string  "fcipprid",         :limit => 6,                   :null => false
    t.string  "fcipcust",         :limit => 6,                   :null => false
    t.string  "fcipsndtyp",       :limit => 1,                   :null => false
    t.string  "fcipsndto",        :limit => 6,                   :null => false
    t.string  "fcipsmpart",       :limit => 25,                  :null => false
    t.boolean "flipgenmst",                                      :null => false
    t.binary  "timestamp_column"
    t.text    "fmipdesc",                       :default => " ", :null => false
  end

  add_index "foprinsa", ["fcipcust"], :name => "cust"
  add_index "foprinsa", ["fcipid"], :name => "foprinsa_id", :unique => true
  add_index "foprinsa", ["fcipprid"], :name => "prod"
  add_index "foprinsa", ["fcipsndtyp", "fcipsndto"], :name => "send"
  add_index "foprinsa", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "foprinsb", :primary_key => "identity_column", :force => true do |t|
    t.string  "fcicid",           :limit => 15,                                :null => false
    t.string  "fcickey",          :limit => 24,                                :null => false
    t.string  "fcicobjid",        :limit => 6,                                 :null => false
    t.decimal "fnicqty",                        :precision => 15, :scale => 5, :null => false
    t.binary  "timestamp_column"
  end

  add_index "foprinsb", ["fcicid", "fcicobjid"], :name => "BYOBJ"
  add_index "foprinsb", ["fcickey", "fcicobjid"], :name => "OBJTYPE"
  add_index "foprinsb", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "foproduc", :primary_key => "identity_column", :force => true do |t|
    t.string  "fcprid",           :limit => 6,                   :null => false
    t.string  "fcprdesc",         :limit => 35, :default => " ", :null => false
    t.string  "fcprdoc",          :limit => 12,                  :null => false
    t.string  "fcprexrule",       :limit => 12,                  :null => false
    t.string  "fcprclass",        :limit => 2,                   :null => false
    t.string  "fcprgroup",        :limit => 6,                   :null => false
    t.string  "fcprabc",          :limit => 1,                   :null => false
    t.string  "fcprmeas",         :limit => 3,                   :null => false
    t.string  "fcprloc",          :limit => 14,                  :null => false
    t.string  "fcprrule2",        :limit => 12,                  :null => false
    t.string  "fctoppart",        :limit => 25,                  :null => false
    t.string  "fctoprev",         :limit => 3,                   :null => false
    t.boolean "flcalcost",                                       :null => false
    t.binary  "timestamp_column"
    t.text    "fmprinfo",                       :default => " ", :null => false
    t.string  "fctopudrev",       :limit => 3,  :default => " ", :null => false
    t.string  "topfac",           :limit => 20,                  :null => false
    t.string  "prfac",            :limit => 20,                  :null => false
    t.string  "prsfac",           :limit => 20,                  :null => false
    t.string  "prclsfac",         :limit => 20,                  :null => false
    t.text    "fmdyndesc",                      :default => "",  :null => false
  end

  add_index "foproduc", ["fcprdesc"], :name => "foproduc_desc_", :unique => true
  add_index "foproduc", ["fcprid"], :name => "foproduc_id", :unique => true
  add_index "foproduc", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "foproutl", :primary_key => "identity_column", :force => true do |t|
    t.string  "fcdfprid",         :limit => 6,                                                  :null => false
    t.string  "fcdford",          :limit => 4,                                                  :null => false
    t.string  "fcdfobjtyp",       :limit => 1,                                                  :null => false
    t.string  "fcdfobjid",        :limit => 6,                                                  :null => false
    t.string  "fcdfkey",          :limit => 24,                                                 :null => false
    t.string  "fcdfparkey",       :limit => 24,                                                 :null => false
    t.string  "fcdfimgid",        :limit => 1,                                                  :null => false
    t.string  "fcdfprompt",       :limit => 30,                                :default => " ", :null => false
    t.string  "fcdfbmp",          :limit => 8,                                                  :null => false
    t.string  "fcdfdoc",          :limit => 12,                                                 :null => false
    t.string  "fcdfexrule",       :limit => 12,                                                 :null => false
    t.integer "fndfmin",          :limit => nil, :precision => 4, :scale => 0,                  :null => false
    t.integer "fndfmax",          :limit => nil, :precision => 4, :scale => 0,                  :null => false
    t.integer "fndflstwid",       :limit => nil, :precision => 3, :scale => 0,                  :null => false
    t.string  "fcdfoptdef",       :limit => 6,                                                  :null => false
    t.integer "fndfspstrt",       :limit => nil, :precision => 2, :scale => 0,                  :null => false
    t.integer "fndfsplen",        :limit => nil, :precision => 2, :scale => 0,                  :null => false
    t.string  "fcdfsmsect",       :limit => 10,                                                 :null => false
    t.binary  "timestamp_column"
    t.text    "fmdfhlp",                                                       :default => " ", :null => false
  end

  add_index "foproutl", ["fcdfobjid"], :name => "byobj"
  add_index "foproutl", ["fcdfprid", "fcdfkey"], :name => "keyord"
  add_index "foproutl", ["fcdfprid", "fcdfobjid"], :name => "PRODOBJ"
  add_index "foproutl", ["fcdfprid", "fcdford"], :name => "objord"
  add_index "foproutl", ["fcdfprid", "fcdfparkey", "fcdford"], :name => "PARENT"
  add_index "foproutl", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "foprtqty", :primary_key => "identity_column", :force => true do |t|
    t.string  "fcpqtype",         :limit => 1,                                                  :null => false
    t.string  "fcpqopid",         :limit => 6,                                                  :null => false
    t.string  "fcpqpart",         :limit => 25,                                                 :null => false
    t.string  "fcpartrev",        :limit => 3,                                                  :null => false
    t.decimal "fnpqqty",                        :precision => 15, :scale => 5,                  :null => false
    t.string  "fcpqprid",         :limit => 6,                                                  :null => false
    t.string  "fcpqoutkey",       :limit => 24,                                                 :null => false
    t.string  "fcpqid",           :limit => 6,                                                  :null => false
    t.string  "fcrtgpart",        :limit => 25,                                                 :null => false
    t.string  "fcrtgrev",         :limit => 3,                                                  :null => false
    t.decimal "fnestcost",                      :precision => 17, :scale => 5,                  :null => false
    t.string  "fcsource",         :limit => 1,                                                  :null => false
    t.binary  "timestamp_column"
    t.string  "fcrtgudrev",       :limit => 3,                                 :default => " ", :null => false
    t.string  "fcudrev",          :limit => 3,                                 :default => " ", :null => false
    t.string  "pqfac",            :limit => 20,                                                 :null => false
    t.string  "pqsfac",           :limit => 20,                                                 :null => false
    t.string  "rtgfac",           :limit => 20,                                                 :null => false
    t.string  "fdescript",        :limit => 35,                                                 :null => false
    t.string  "fmeasure",         :limit => 3,                                                  :null => false
  end

  add_index "foprtqty", ["fcpqid"], :name => "foprtqty_id", :unique => true
  add_index "foprtqty", ["fcpqtype", "fcpqopid", "pqfac", "fcpqpart", "fcpartrev"], :name => "MAIN"
  add_index "foprtqty", ["fcpqtype", "fcpqprid", "fcpqoutkey", "pqfac", "fcpqpart", "fcpartrev"], :name => "PRODUCT"
  add_index "foprtqty", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "fovirule", :primary_key => "identity_column", :force => true do |t|
    t.string "fcvrprid",         :limit => 6,                  :null => false
    t.string "fcvrtype",         :limit => 1,                  :null => false
    t.string "fcvrlink",         :limit => 6,                  :null => false
    t.string "fcvrobj1",         :limit => 6,                  :null => false
    t.string "fcvroper",         :limit => 1,                  :null => false
    t.string "fcvrobj2",         :limit => 6,                  :null => false
    t.binary "timestamp_column"
    t.text   "fmvrdesc",                      :default => " ", :null => false
    t.text   "fmvrelse",                      :default => " ", :null => false
    t.text   "fmvroplst",                     :default => " ", :null => false
    t.text   "fmvrthen",                      :default => " ", :null => false
  end

  add_index "fovirule", ["fcvrlink"], :name => "link"
  add_index "fovirule", ["fcvrprid", "fcvrobj1"], :name => "prodifobj"
  add_index "fovirule", ["fcvrprid", "fcvrobj2"], :name => "acton"
  add_index "fovirule", ["fcvrprid", "fcvrtype", "fcvrobj1"], :name => "trigobj"
  add_index "fovirule", ["fcvrprid", "fcvrtype", "fcvrobj2"], :name => "prodtype"
  add_index "fovirule", ["fcvrtype", "fcvrprid", "fcvrobj1"], :name => "BYTYPE"
  add_index "fovirule", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "frxtemp", :primary_key => "identity_column", :force => true do |t|
    t.string  "fcuserid",         :limit => 10, :null => false
    t.integer "fnrow",                          :null => false
    t.integer "fnnegsign",                      :null => false
    t.string  "acct_code",        :limit => 25, :null => false
    t.string  "fcurid",           :limit => 3,  :null => false
    t.binary  "timestamp_column"
  end

  add_index "frxtemp", ["acct_code", "fnrow"], :name => "acctrow"
  add_index "frxtemp", ["fcuserid"], :name => "fcuserid"
  add_index "frxtemp", ["fnrow"], :name => "fnrow"
  add_index "frxtemp", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "frxtrans", :primary_key => "identity_column", :force => true do |t|
    t.string   "acctcode",         :limit => 25,                                                  :null => false
    t.datetime "applydate",                                                                       :null => false
    t.decimal  "functlamt",                                                                       :null => false
    t.string   "trandesc",         :limit => 2,                                                   :null => false
    t.integer  "year",             :limit => nil, :precision => 5,  :scale => 0,                  :null => false
    t.integer  "period",                                                                          :null => false
    t.decimal  "origamt",                                                                         :null => false
    t.string   "currcode",         :limit => 3,                                                   :null => false
    t.decimal  "convrate",                        :precision => 17, :scale => 5,                  :null => false
    t.string   "bookcode",         :limit => 20,                                                  :null => false
    t.datetime "entrydate",                                                                       :null => false
    t.string   "sourceid",         :limit => 6,                                                   :null => false
    t.string   "sourcedoci",       :limit => 35,                                 :default => " ", :null => false
    t.string   "sourcedocc",       :limit => 20,                                                  :null => false
    t.string   "sourcebatc",       :limit => 4,                                                   :null => false
    t.string   "trantype",         :limit => 2,                                                   :null => false
    t.string   "status",           :limit => 1,                                                   :null => false
    t.integer  "fnacctid",         :limit => nil, :precision => 10, :scale => 0,                  :null => false
    t.binary   "timestamp_column"
  end

  add_index "frxtrans", ["acctcode"], :name => "acctcode"
  add_index "frxtrans", ["applydate"], :name => "applydate"
  add_index "frxtrans", ["fnacctid"], :name => "acctid"
  add_index "frxtrans", ["identity_column"], :name => "identity_column_idx1", :unique => true
  add_index "frxtrans", ["period"], :name => "period"
  add_index "frxtrans", ["year"], :name => "year"

  create_table "fsactlog", :primary_key => "identity_column", :force => true do |t|
    t.string   "fccustid",         :limit => 6,  :default => "", :null => false
    t.string   "fcevent",          :limit => 2,  :default => "", :null => false
    t.string   "fcmachid",         :limit => 10, :default => "", :null => false
    t.string   "fccontactf",       :limit => 15, :default => "", :null => false
    t.string   "fccontactl",       :limit => 20, :default => "", :null => false
    t.datetime "fcdatetime",                                     :null => false
    t.string   "fcuserid",         :limit => 3,  :default => "", :null => false
    t.text     "fmnotes",                        :default => "", :null => false
    t.binary   "timestamp_column"
  end

  add_index "fsactlog", ["fccustid"], :name => "custno"

  create_table "fscodes", :primary_key => "identity_column", :force => true do |t|
    t.string  "fctype",           :limit => 4,                                 :default => "",  :null => false
    t.string  "fcdesc",           :limit => 25,                                :default => "",  :null => false
    t.decimal "fnbfact",                        :precision => 12, :scale => 5, :default => 0.0, :null => false
    t.decimal "fncfact",                        :precision => 12, :scale => 5, :default => 0.0, :null => false
    t.binary  "timestamp_column"
  end

  add_index "fscodes", ["identity_column"], :name => "idcolumn", :unique => true

  create_table "fskitfor", :primary_key => "identity_column", :force => true do |t|
    t.string   "fckitforid",       :limit => 10, :default => "", :null => false
    t.string   "fcparentid",       :limit => 10, :default => "", :null => false
    t.string   "fcmachid",         :limit => 10, :default => "", :null => false
    t.string   "fccustid",         :limit => 6,  :default => "", :null => false
    t.string   "fcsite",           :limit => 4,  :default => "", :null => false
    t.string   "fcsitetype",       :limit => 1,  :default => "", :null => false
    t.string   "fcstatus",         :limit => 1,  :default => "", :null => false
    t.datetime "fctimestam",                                     :null => false
    t.string   "fcuserid",         :limit => 3,  :default => "", :null => false
    t.datetime "fdinstalle",                                     :null => false
    t.datetime "fdmailed",                                       :null => false
    t.binary   "timestamp_column"
  end

  add_index "fskitfor", ["fcmachid"], :name => "machineid"
  add_index "fskitfor", ["fcparentid", "identity_column"], :name => "serkitid", :unique => true
  add_index "fskitfor", ["identity_column"], :name => "idcolumn", :unique => true

  create_table "fskittbl", :primary_key => "identity_column", :force => true do |t|
    t.string   "fckitid",          :limit => 10,                                :default => "",    :null => false
    t.string   "fac",              :limit => 20,                                                   :null => false
    t.string   "fcpartno",         :limit => 25,                                :default => "",    :null => false
    t.string   "fcpartrev",        :limit => 3,                                 :default => "",    :null => false
    t.string   "fcstatus",         :limit => 1,                                 :default => "",    :null => false
    t.string   "fckitdescr",       :limit => 40,                                :default => "",    :null => false
    t.string   "fcpriority",       :limit => 1,                                 :default => "",    :null => false
    t.string   "fctypekit",        :limit => 1,                                 :default => "",    :null => false
    t.string   "fcwarntype",       :limit => 4,                                 :default => "",    :null => false
    t.datetime "fdinstall",                                                                        :null => false
    t.datetime "fdmailby",                                                                         :null => false
    t.boolean  "fllabor",                                                       :default => false, :null => false
    t.boolean  "flparts",                                                       :default => false, :null => false
    t.text     "fmnotes",                                                       :default => "",    :null => false
    t.decimal  "fnesthrs",                       :precision => 16, :scale => 5, :default => 0.0,   :null => false
    t.decimal  "fnneedqty",                      :precision => 16, :scale => 5, :default => 0.0,   :null => false
    t.string   "udrev",            :limit => 3,                                 :default => "",    :null => false
    t.binary   "timestamp_column"
  end

  add_index "fskittbl", ["fcpartno", "fcpartrev", "fac"], :name => "partrev"
  add_index "fskittbl", ["identity_column"], :name => "idcolumn", :unique => true

  create_table "fsmachcf", :primary_key => "identity_column", :force => true do |t|
    t.string   "fcmcfgid",         :limit => 10,                                :default => "",  :null => false
    t.string   "fcmachid",         :limit => 10,                                :default => "",  :null => false
    t.string   "fac",              :limit => 20,                                                 :null => false
    t.string   "fcbompart",        :limit => 25,                                :default => "",  :null => false
    t.string   "fcbomrev",         :limit => 3,                                 :default => "",  :null => false
    t.string   "fcserno",          :limit => 20,                                :default => "",  :null => false
    t.string   "fcstatus",         :limit => 1,                                 :default => "",  :null => false
    t.string   "fcitemref",        :limit => 6,                                 :default => "",  :null => false
    t.string   "fcbomuom",         :limit => 3,                                 :default => "",  :null => false
    t.string   "fcecoref",         :limit => 25,                                :default => "",  :null => false
    t.string   "fctypeitem",       :limit => 1,                                 :default => "",  :null => false
    t.string   "fcvendno",         :limit => 6,                                 :default => "",  :null => false
    t.datetime "fdinstalle",                                                                     :null => false
    t.datetime "fdremoved",                                                                      :null => false
    t.text     "fmfailcode",                                                    :default => "",  :null => false
    t.text     "fmpartdesc",                                                    :default => "",  :null => false
    t.text     "fmproblem",                                                     :default => "",  :null => false
    t.text     "fmrepair",                                                      :default => "",  :null => false
    t.decimal  "fnqtyused",                      :precision => 16, :scale => 5, :default => 0.0, :null => false
    t.string   "udrev",            :limit => 3,                                 :default => "",  :null => false
    t.integer  "fnlevel",                                                       :default => 0,   :null => false
    t.string   "fcparent",         :limit => 25,                                :default => "",  :null => false
    t.string   "fcparrev",         :limit => 3,                                 :default => "",  :null => false
    t.string   "fcparfac",         :limit => 20,                                                 :null => false
    t.string   "fcparid",          :limit => 10,                                :default => "",  :null => false
    t.binary   "timestamp_column"
  end

  add_index "fsmachcf", ["fcbompart", "fcbomrev", "fac"], :name => "partrev"
  add_index "fsmachcf", ["fcmachid", "identity_column"], :name => "machineid", :unique => true
  add_index "fsmachcf", ["fcparid"], :name => "parentid"
  add_index "fsmachcf", ["fcserno"], :name => "serialno"
  add_index "fsmachcf", ["identity_column"], :name => "idcolumn", :unique => true

  create_table "fsmachin", :primary_key => "identity_column", :force => true do |t|
    t.string   "fcmachinid",       :limit => 10, :default => "", :null => false
    t.string   "fac",              :limit => 20,                 :null => false
    t.string   "fcpartno",         :limit => 25, :default => "", :null => false
    t.string   "fcpartrev",        :limit => 3,  :default => "", :null => false
    t.string   "fcserno",          :limit => 20, :default => "", :null => false
    t.string   "fcstatus",         :limit => 1,  :default => "", :null => false
    t.string   "fcatcompan",       :limit => 35, :default => "", :null => false
    t.string   "fccurcust",        :limit => 6,  :default => "", :null => false
    t.text     "fmatstreet",                     :default => "", :null => false
    t.string   "fcattype",         :limit => 1,  :default => "", :null => false
    t.string   "fcataddr",         :limit => 4,  :default => "", :null => false
    t.string   "fcatcity",         :limit => 25, :default => "", :null => false
    t.string   "fcatstate",        :limit => 20, :default => "", :null => false
    t.string   "fcatzip",          :limit => 10, :default => "", :null => false
    t.string   "fcatcountr",       :limit => 25, :default => "", :null => false
    t.string   "fccusporef",       :limit => 20, :default => "", :null => false
    t.string   "fcjoborder",       :limit => 10, :default => "", :null => false
    t.string   "fcorgcust",        :limit => 6,  :default => "", :null => false
    t.string   "fcsalesno",        :limit => 6,  :default => "", :null => false
    t.string   "fcshipper",        :limit => 6,  :default => "", :null => false
    t.datetime "fdinstalle",                                     :null => false
    t.datetime "fdshipped",                                      :null => false
    t.text     "fmdescript",                     :default => "", :null => false
    t.text     "fmnotes",                        :default => "", :null => false
    t.string   "udrev",            :limit => 3,  :default => "", :null => false
    t.binary   "timestamp_column"
  end

  add_index "fsmachin", ["fccurcust"], :name => "curcust"
  add_index "fsmachin", ["fcpartno", "fcpartrev", "fac"], :name => "partrev"
  add_index "fsmachin", ["fcserno"], :name => "serialno"
  add_index "fsmachin", ["identity_column"], :name => "idcolumn", :unique => true

  create_table "fsoinput", :primary_key => "identity_column", :force => true do |t|
    t.string  "fccustid",         :limit => 6,                                 :default => "",  :null => false
    t.string  "fcmachid",         :limit => 10,                                :default => "",  :null => false
    t.string  "fctype",           :limit => 1,                                 :default => "",  :null => false
    t.string  "fclineno",         :limit => 6,                                 :default => "",  :null => false
    t.string  "fac",              :limit => 20,                                                 :null => false
    t.string  "fcpartno",         :limit => 25,                                :default => "",  :null => false
    t.string  "fcpartrev",        :limit => 3,                                 :default => "",  :null => false
    t.string  "fcserno",          :limit => 20,                                :default => "",  :null => false
    t.string  "fccustpo",         :limit => 20,                                :default => "",  :null => false
    t.string  "fcdescr",          :limit => 35,                                :default => "",  :null => false
    t.string  "fcprodcl",         :limit => 3,                                 :default => "",  :null => false
    t.string  "fcrgano",          :limit => 20,                                :default => "",  :null => false
    t.string  "fcuom",            :limit => 3,                                 :default => "",  :null => false
    t.string  "fcvendorid",       :limit => 6,                                 :default => "",  :null => false
    t.decimal "fnamount",                       :precision => 15, :scale => 4, :default => 0.0, :null => false
    t.integer "fnmileage",                                                     :default => 0,   :null => false
    t.decimal "fnquantity",                     :precision => 16, :scale => 5, :default => 0.0, :null => false
    t.integer "fntypeap",                                                      :default => 0,   :null => false
    t.integer "fntypear",                                                      :default => 0,   :null => false
    t.string  "sfac",             :limit => 20,                                                 :null => false
    t.string  "udrev",            :limit => 3,                                 :default => "",  :null => false
    t.string  "fcmcfg_id",        :limit => 10,                                :default => "",  :null => false
    t.binary  "timestamp_column"
  end

  add_index "fsoinput", ["fccustid", "identity_column"], :name => "custid", :unique => true
  add_index "fsoinput", ["fcmachid"], :name => "machineid"

  create_table "fspmshed", :primary_key => "identity_column", :force => true do |t|
    t.string   "fcpmshedid",       :limit => 10, :default => "", :null => false
    t.string   "fcmachid",         :limit => 10, :default => "", :null => false
    t.string   "fcpartno",         :limit => 25, :default => "", :null => false
    t.string   "fcpartrev",        :limit => 3,  :default => "", :null => false
    t.string   "fcstatus",         :limit => 1,  :default => "", :null => false
    t.string   "fcfreq",           :limit => 1,  :default => "", :null => false
    t.datetime "fdend",                                          :null => false
    t.datetime "fdlast",                                         :null => false
    t.datetime "fdnext",                                         :null => false
    t.datetime "fdstart",                                        :null => false
    t.text     "fmnotes",                        :default => "", :null => false
    t.integer  "fnacttimes",                     :default => 0,  :null => false
    t.integer  "fnendevent",                     :default => 0,  :null => false
    t.integer  "fnschtimes",                     :default => 0,  :null => false
    t.string   "fac",              :limit => 20,                 :null => false
    t.string   "udrev",            :limit => 3,  :default => "", :null => false
    t.binary   "timestamp_column"
  end

  add_index "fspmshed", ["fcmachid", "identity_column"], :name => "machineid", :unique => true
  add_index "fspmshed", ["fdnext"], :name => "nextdate"
  add_index "fspmshed", ["identity_column"], :name => "idcolumn", :unique => true

  create_table "fsseract", :primary_key => "identity_column", :force => true do |t|
    t.string   "fcseractid",       :limit => 10, :default => "", :null => false
    t.string   "fcsoid",           :limit => 20, :default => "", :null => false
    t.string   "fctechid",         :limit => 10, :default => "", :null => false
    t.datetime "fcdatetime",                                     :null => false
    t.datetime "fdsvcdate",                                      :null => false
    t.text     "fmaction",                       :default => "", :null => false
    t.text     "fmnextstep",                     :default => "", :null => false
    t.text     "fmresults",                      :default => "", :null => false
    t.binary   "timestamp_column"
  end

  add_index "fsseract", ["fcsoid", "fdsvcdate"], :name => "soid"
  add_index "fsseract", ["identity_column"], :name => "idcolumn", :unique => true

  create_table "fsserdoc", :primary_key => "identity_column", :force => true do |t|
    t.datetime "fcdatetime",                                     :null => false
    t.string   "fcdockey",         :limit => 20, :default => "", :null => false
    t.string   "fcdoctype",        :limit => 2,  :default => "", :null => false
    t.string   "fcsoid",           :limit => 20, :default => "", :null => false
    t.datetime "fddateref1",                                     :null => false
    t.datetime "fddateref2",                                     :null => false
    t.binary   "timestamp_column"
  end

  add_index "fsserdoc", ["fcsoid"], :name => "soid"
  add_index "fsserdoc", ["identity_column"], :name => "idcolumn", :unique => true

  create_table "fsserest", :primary_key => "identity_column", :force => true do |t|
    t.string   "fcsoid",           :limit => 20,                                :default => "",    :null => false
    t.string   "fcstatus",         :limit => 1,                                 :default => "",    :null => false
    t.string   "fctechid",         :limit => 10,                                :default => "",    :null => false
    t.string   "fccurid",          :limit => 3,                                 :default => "",    :null => false
    t.datetime "fcdatetime",                                                                       :null => false
    t.datetime "fdeurodate",                                                                       :null => false
    t.datetime "fdfactdate",                                                                       :null => false
    t.boolean  "flbillkit",                                                     :default => false, :null => false
    t.boolean  "flbillpm",                                                      :default => false, :null => false
    t.boolean  "flbillsc",                                                      :default => false, :null => false
    t.decimal  "fncurrfact",                     :precision => 16, :scale => 5, :default => 0.0,   :null => false
    t.decimal  "fnekitlabo",                     :precision => 15, :scale => 4, :default => 0.0,   :null => false
    t.decimal  "fnemargina",                     :precision => 15, :scale => 4, :default => 0.0,   :null => false
    t.decimal  "fneotherco",                     :precision => 15, :scale => 4, :default => 0.0,   :null => false
    t.decimal  "fnepartcos",                     :precision => 15, :scale => 4, :default => 0.0,   :null => false
    t.decimal  "fnepmlabo",                      :precision => 15, :scale => 4, :default => 0.0,   :null => false
    t.decimal  "fnesclabo",                      :precision => 15, :scale => 4, :default => 0.0,   :null => false
    t.decimal  "fnesoftcos",                     :precision => 15, :scale => 4, :default => 0.0,   :null => false
    t.decimal  "fnetaxcos",                      :precision => 15, :scale => 4, :default => 0.0,   :null => false
    t.decimal  "fnetrvcos",                      :precision => 15, :scale => 4, :default => 0.0,   :null => false
    t.decimal  "fneurofact",                     :precision => 16, :scale => 5, :default => 0.0,   :null => false
    t.decimal  "fnfrtcost",                      :precision => 15, :scale => 4, :default => 0.0,   :null => false
    t.decimal  "fnkithrs",                       :precision => 9,  :scale => 2, :default => 0.0,   :null => false
    t.decimal  "fnkitlabor",                     :precision => 15, :scale => 4, :default => 0.0,   :null => false
    t.decimal  "fnkitrate",                      :precision => 16, :scale => 5, :default => 0.0,   :null => false
    t.decimal  "fnmargin",                       :precision => 6,  :scale => 3, :default => 0.0,   :null => false
    t.decimal  "fnmarginam",                     :precision => 15, :scale => 4, :default => 0.0,   :null => false
    t.decimal  "fnothercos",                     :precision => 15, :scale => 4, :default => 0.0,   :null => false
    t.decimal  "fnpartcost",                     :precision => 15, :scale => 4, :default => 0.0,   :null => false
    t.decimal  "fnpmhrs",                        :precision => 9,  :scale => 2, :default => 0.0,   :null => false
    t.decimal  "fnpmlabor",                      :precision => 15, :scale => 4, :default => 0.0,   :null => false
    t.decimal  "fnpmrate",                       :precision => 16, :scale => 5, :default => 0.0,   :null => false
    t.decimal  "fnschrs",                        :precision => 9,  :scale => 2, :default => 0.0,   :null => false
    t.decimal  "fnsclabor",                      :precision => 15, :scale => 4, :default => 0.0,   :null => false
    t.decimal  "fnscrate",                       :precision => 16, :scale => 5, :default => 0.0,   :null => false
    t.decimal  "fnsoftcost",                     :precision => 15, :scale => 4, :default => 0.0,   :null => false
    t.decimal  "fntaxcost",                      :precision => 15, :scale => 4, :default => 0.0,   :null => false
    t.decimal  "fntrvcost",                      :precision => 15, :scale => 4, :default => 0.0,   :null => false
    t.binary   "timestamp_column"
  end

  add_index "fsserest", ["identity_column"], :name => "idcolumn", :unique => true

  create_table "fsseritm", :primary_key => "identity_column", :force => true do |t|
    t.string   "fcseritmid",       :limit => 10,                                :default => "",    :null => false
    t.string   "fcsoid",           :limit => 20,                                :default => "",    :null => false
    t.string   "fclineitm",        :limit => 3,                                 :default => "",    :null => false
    t.string   "fcmcfg_id",        :limit => 10,                                :default => "",    :null => false
    t.string   "fac",              :limit => 20,                                                   :null => false
    t.string   "fcpartno",         :limit => 25,                                :default => "",    :null => false
    t.string   "fcpartrev",        :limit => 3,                                 :default => "",    :null => false
    t.string   "fcserialno",       :limit => 20,                                :default => "",    :null => false
    t.string   "fcstatus",         :limit => 1,                                 :default => "",    :null => false
    t.string   "fcpartuom",        :limit => 3,                                 :default => "",    :null => false
    t.string   "fcpmkey",          :limit => 10,                                :default => "",    :null => false
    t.string   "fcreceipt",        :limit => 12,                                :default => "",    :null => false
    t.string   "fckitid",          :limit => 10,                                :default => "",    :null => false
    t.string   "fcshipref",        :limit => 12,                                :default => "",    :null => false
    t.string   "fctaxcode",        :limit => 10,                                :default => "",    :null => false
    t.string   "fctypeitem",       :limit => 1,                                 :default => "",    :null => false
    t.datetime "fdlship",                                                                          :null => false
    t.boolean  "flbillflag",                                                    :default => false, :null => false
    t.text     "fmdescr",                                                       :default => "",    :null => false
    t.text     "fmnotes",                                                       :default => "",    :null => false
    t.decimal  "fnqtyrecv",                      :precision => 16, :scale => 5, :default => 0.0,   :null => false
    t.decimal  "fnqtyship",                      :precision => 16, :scale => 5, :default => 0.0,   :null => false
    t.decimal  "fnquantity",                     :precision => 16, :scale => 5, :default => 0.0,   :null => false
    t.decimal  "fnprice",                        :precision => 16, :scale => 5, :default => 0.0,   :null => false
    t.string   "fcShpToKey",       :limit => 4,                                 :default => "",    :null => false
    t.string   "fcSOKey",          :limit => 12,                                :default => "",    :null => false
    t.string   "udrev",            :limit => 3,                                 :default => "",    :null => false
    t.binary   "timestamp_column"
    t.string   "forgcfg",          :limit => 10,                                                   :null => false
    t.string   "fprodcl",          :limit => 2,                                                    :null => false
    t.string   "fcloc",            :limit => 14,                                :default => "",    :null => false
    t.string   "fcbin",            :limit => 14,                                :default => "",    :null => false
  end

  add_index "fsseritm", ["fcSOKey"], :name => "sokey"
  add_index "fsseritm", ["fcmcfg_id"], :name => "mcfgid"
  add_index "fsseritm", ["fcpartno", "fcpartrev", "fac"], :name => "partrev"
  add_index "fsseritm", ["fcserialno"], :name => "serialno"
  add_index "fsseritm", ["fcsoid", "identity_column"], :name => "soid", :unique => true
  add_index "fsseritm", ["identity_column"], :name => "idcolumn", :unique => true

  create_table "fsserord", :primary_key => "identity_column", :force => true do |t|
    t.string   "fcsvcno",          :limit => 20,                                :default => "",    :null => false
    t.string   "fctype",           :limit => 1,                                 :default => "",    :null => false
    t.string   "fcmachinid",       :limit => 10,                                :default => "",    :null => false
    t.string   "fac",              :limit => 20,                                                   :null => false
    t.string   "fcpartnum",        :limit => 25,                                :default => "",    :null => false
    t.string   "fcpartrev",        :limit => 3,                                 :default => "",    :null => false
    t.string   "fcmserno",         :limit => 20,                                :default => "",    :null => false
    t.string   "fcstatus",         :limit => 1,                                 :default => "",    :null => false
    t.string   "fccustid",         :limit => 6,                                 :default => "",    :null => false
    t.string   "fccustpo",         :limit => 20,                                :default => "",    :null => false
    t.string   "fccustsvc",        :limit => 10,                                :default => "",    :null => false
    t.string   "fcfieldsvc",       :limit => 10,                                :default => "",    :null => false
    t.string   "fcapproval",       :limit => 3,                                 :default => "",    :null => false
    t.string   "fccurid",          :limit => 3,                                 :default => "",    :null => false
    t.datetime "fcdatetime",                                                                       :null => false
    t.string   "fcpriority",       :limit => 1,                                 :default => "",    :null => false
    t.string   "fcrganumbe",       :limit => 20,                                :default => "",    :null => false
    t.string   "fcshptokey",       :limit => 4,                                 :default => "",    :null => false
    t.string   "fcwarnid",         :limit => 10,                                :default => "",    :null => false
    t.datetime "fdapproved",                                                                       :null => false
    t.datetime "fdclosed",                                                                         :null => false
    t.datetime "fdeurodate",                                                                       :null => false
    t.datetime "fdfactdate",                                                                       :null => false
    t.datetime "fdorderdat",                                                                       :null => false
    t.datetime "fdparonsit",                                                                       :null => false
    t.datetime "fdpromise",                                                                        :null => false
    t.datetime "fdusrdate1",                                                                       :null => false
    t.boolean  "flmgrappro",                                                    :default => false, :null => false
    t.boolean  "flwarranty",                                                    :default => false, :null => false
    t.text     "fminternal",                                                    :default => "",    :null => false
    t.text     "fmproblem",                                                     :default => "",    :null => false
    t.text     "fmresolved",                                                    :default => "",    :null => false
    t.decimal  "fnactkthrs",                     :precision => 16, :scale => 5, :default => 0.0,   :null => false
    t.decimal  "fnactpmhrs",                     :precision => 16, :scale => 5, :default => 0.0,   :null => false
    t.decimal  "fnactschrs",                     :precision => 16, :scale => 5, :default => 0.0,   :null => false
    t.decimal  "fnacttrv",                       :precision => 16, :scale => 5, :default => 0.0,   :null => false
    t.decimal  "fncurrfact",                     :precision => 16, :scale => 5, :default => 0.0,   :null => false
    t.decimal  "fneurofact",                     :precision => 16, :scale => 5, :default => 0.0,   :null => false
    t.integer  "fnnxtitm",                                                      :default => 0,     :null => false
    t.string   "fcAtCompan",       :limit => 35,                                :default => "",    :null => false
    t.string   "fcAtCity",         :limit => 25,                                :default => "",    :null => false
    t.string   "fcAtState",        :limit => 20,                                :default => "",    :null => false
    t.string   "fcAtCountr",       :limit => 25,                                :default => "",    :null => false
    t.string   "fcAtZip",          :limit => 10,                                :default => "",    :null => false
    t.string   "fcAtPhone",        :limit => 20,                                :default => "",    :null => false
    t.string   "fcAtFax",          :limit => 20,                                :default => "",    :null => false
    t.text     "fmAtStreet",                                                    :default => "",    :null => false
    t.string   "udrev",            :limit => 3,                                 :default => "",    :null => false
    t.string   "fcusrchr1",        :limit => 20,                                :default => "",    :null => false
    t.string   "fcusrchr2",        :limit => 40,                                :default => "",    :null => false
    t.string   "fcusrchr3",        :limit => 40,                                :default => "",    :null => false
    t.decimal  "fnusrcur1",                      :precision => 15, :scale => 4, :default => 0.0,   :null => false
    t.decimal  "fnusrqty1",                      :precision => 14, :scale => 5, :default => 0.0,   :null => false
    t.text     "fmusrmemo1",                                                    :default => "",    :null => false
    t.decimal  "fnduratn",                       :precision => 6,  :scale => 2, :default => 0.0,   :null => false
    t.binary   "timestamp_column"
    t.datetime "fdexpires",                                                                        :null => false
    t.string   "fshipvia",         :limit => 20,                                :default => "",    :null => false
    t.string   "fccommcode",       :limit => 10,                                :default => "",    :null => false
  end

  add_index "fsserord", ["fcmachinid"], :name => "machineid"
  add_index "fsserord", ["identity_column"], :name => "idcolumn", :unique => true

  create_table "fsserpit", :primary_key => "identity_column", :force => true do |t|
    t.string "fcserpitm",        :limit => 10, :default => "", :null => false
    t.string "fcsoid",           :limit => 20, :default => "", :null => false
    t.string "fcserprbid",       :limit => 10, :default => "", :null => false
    t.string "fcmcfg_id",        :limit => 10, :default => "", :null => false
    t.string "fac",              :limit => 20,                 :null => false
    t.string "fcpartno",         :limit => 25, :default => "", :null => false
    t.string "fcpartrev",        :limit => 3,  :default => "", :null => false
    t.string "fcserialno",       :limit => 20, :default => "", :null => false
    t.string "fcfailclas",       :limit => 3,  :default => "", :null => false
    t.string "fcfailcode",       :limit => 3,  :default => "", :null => false
    t.text   "fmfailure",                      :default => "", :null => false
    t.string "udrev",            :limit => 3,  :default => "", :null => false
    t.binary "timestamp_column"
  end

  add_index "fsserpit", ["fcmcfg_id", "identity_column"], :name => "mcfgid", :unique => true
  add_index "fsserpit", ["fcserprbid"], :name => "serprbid"
  add_index "fsserpit", ["identity_column"], :name => "idcolumn", :unique => true

  create_table "fsserprb", :primary_key => "identity_column", :force => true do |t|
    t.string "fcserprbid",       :limit => 10, :default => "", :null => false
    t.string "fcsoid",           :limit => 20, :default => "", :null => false
    t.string "fcstatus",         :limit => 1,  :default => "", :null => false
    t.string "fcarea",           :limit => 3,  :default => "", :null => false
    t.string "fcprobtype",       :limit => 3,  :default => "", :null => false
    t.text   "fmkitproc",                      :default => "", :null => false
    t.text   "fmpmproc",                       :default => "", :null => false
    t.binary "timestamp_column"
  end

  add_index "fsserprb", ["fcsoid", "identity_column"], :name => "soid", :unique => true
  add_index "fsserprb", ["identity_column"], :name => "idcolumn", :unique => true

  create_table "fssertec", :primary_key => "identity_column", :force => true do |t|
    t.string  "fctechid",         :limit => 10,                                :default => "",  :null => false
    t.string  "fcinitials",       :limit => 3,                                 :default => "",  :null => false
    t.string  "fclastname",       :limit => 30,                                :default => "",  :null => false
    t.string  "fcfirstnam",       :limit => 15,                                :default => "",  :null => false
    t.string  "fcmiddle",         :limit => 1,                                 :default => "",  :null => false
    t.string  "fcusernm",         :limit => 10,                                :default => "",  :null => false
    t.string  "fctype",           :limit => 1,                                 :default => "",  :null => false
    t.string  "fcterr",           :limit => 3,                                 :default => "",  :null => false
    t.text    "fmstreet",                                                      :default => "",  :null => false
    t.string  "fccity",           :limit => 25,                                :default => "",  :null => false
    t.string  "fcstate",          :limit => 10,                                :default => "",  :null => false
    t.string  "fczip",            :limit => 10,                                :default => "",  :null => false
    t.string  "fccountry",        :limit => 25,                                :default => "",  :null => false
    t.string  "fcemail",          :limit => 40,                                :default => "",  :null => false
    t.string  "fcphone1",         :limit => 20,                                :default => "",  :null => false
    t.string  "fcphone2",         :limit => 20,                                :default => "",  :null => false
    t.string  "fcphone3",         :limit => 20,                                :default => "",  :null => false
    t.string  "fcphone4",         :limit => 20,                                :default => "",  :null => false
    t.string  "fcstatus",         :limit => 1,                                 :default => "",  :null => false
    t.string  "fctaxcode",        :limit => 10,                                :default => "",  :null => false
    t.string  "fcwhse",           :limit => 14,                                :default => "",  :null => false
    t.text    "fmnotes",                                                       :default => "",  :null => false
    t.decimal "fncostrate",                     :precision => 15, :scale => 4, :default => 0.0, :null => false
    t.decimal "fnhrrate",                       :precision => 15, :scale => 4, :default => 0.0, :null => false
    t.binary  "timestamp_column"
  end

  add_index "fssertec", ["fcinitials"], :name => "initials"
  add_index "fssertec", ["fclastname", "fcfirstnam", "fcmiddle"], :name => "name"
  add_index "fssertec", ["identity_column"], :name => "idcolumn", :unique => true

  create_table "fssertoo", :primary_key => "identity_column", :force => true do |t|
    t.string   "fctoolid",         :limit => 10,                                :default => "",  :null => false
    t.string   "fctoolname",       :limit => 25,                                :default => "",  :null => false
    t.string   "fcvendor",         :limit => 6,                                 :default => "",  :null => false
    t.string   "fac",              :limit => 20,                                                 :null => false
    t.string   "fcvpart",          :limit => 25,                                :default => "",  :null => false
    t.string   "fccurid",          :limit => 3,                                 :default => "",  :null => false
    t.string   "fcgroup",          :limit => 6,                                 :default => "",  :null => false
    t.string   "fclocation",       :limit => 14,                                :default => "",  :null => false
    t.string   "fcprodcl",         :limit => 2,                                 :default => "",  :null => false
    t.string   "fcpurchcat",       :limit => 8,                                 :default => "",  :null => false
    t.string   "fctoolgl",         :limit => 25,                                :default => "",  :null => false
    t.string   "fcuom",            :limit => 3,                                 :default => "",  :null => false
    t.string   "fcwhse",           :limit => 14,                                :default => "",  :null => false
    t.datetime "fdeurodate",                                                                     :null => false
    t.datetime "fdfactdate",                                                                     :null => false
    t.text     "fmdescr",                                                       :default => "",  :null => false
    t.decimal  "fncurrfact",                     :precision => 16, :scale => 5, :default => 0.0, :null => false
    t.decimal  "fneurocost",                     :precision => 16, :scale => 5, :default => 0.0, :null => false
    t.decimal  "fneurofact",                     :precision => 16, :scale => 5, :default => 0.0, :null => false
    t.decimal  "fnunitcost",                     :precision => 16, :scale => 5, :default => 0.0, :null => false
    t.binary   "timestamp_column"
  end

  add_index "fssertoo", ["fctoolname"], :name => "toolname", :unique => true
  add_index "fssertoo", ["identity_column"], :name => "idcolumn", :unique => true

  create_table "fssertrn", :primary_key => "identity_column", :force => true do |t|
    t.string   "fctranid",         :limit => 10,                                :default => "",    :null => false
    t.string   "fctype",           :limit => 3,                                 :default => "",    :null => false
    t.string   "fcsoid",           :limit => 20,                                :default => "",    :null => false
    t.string   "fcstatus",         :limit => 1,                                 :default => "",    :null => false
    t.string   "fctechid",         :limit => 10,                                :default => "",    :null => false
    t.datetime "fcdatetime",                                                                       :null => false
    t.string   "fcglcredit",       :limit => 25,                                :default => "",    :null => false
    t.string   "fcgldebit",        :limit => 25,                                :default => "",    :null => false
    t.string   "fcrecvkey",        :limit => 9,                                 :default => "",    :null => false
    t.string   "fcshipkey",        :limit => 12,                                :default => "",    :null => false
    t.string   "fctechwk",         :limit => 10,                                :default => "",    :null => false
    t.string   "fccurid",          :limit => 3,                                 :default => "",    :null => false
    t.datetime "fctimeend",                                                                        :null => false
    t.datetime "fctimestar",                                                                       :null => false
    t.datetime "fddatepost",                                                                       :null => false
    t.datetime "fdeurodate",                                                                       :null => false
    t.datetime "fdfactdate",                                                                       :null => false
    t.boolean  "flbillflag",                                                    :default => false, :null => false
    t.boolean  "flcomplete",                                                    :default => false, :null => false
    t.boolean  "flkit",                                                         :default => false, :null => false
    t.boolean  "flpm",                                                          :default => false, :null => false
    t.boolean  "flsc",                                                          :default => false, :null => false
    t.decimal  "fnamount",                       :precision => 15, :scale => 4, :default => 0.0,   :null => false
    t.decimal  "fncurrfact",                     :precision => 16, :scale => 5, :default => 0.0,   :null => false
    t.decimal  "fneuroamt",                      :precision => 15, :scale => 4, :default => 0.0,   :null => false
    t.decimal  "fneurofact",                     :precision => 16, :scale => 5, :default => 0.0,   :null => false
    t.decimal  "fnhours",                        :precision => 16, :scale => 5, :default => 0.0,   :null => false
    t.decimal  "fnrate",                         :precision => 16, :scale => 5, :default => 0.0,   :null => false
    t.string   "flabtype",         :limit => 4,                                 :default => "",    :null => false
    t.binary   "timestamp_column"
  end

  add_index "fssertrn", ["fcsoid", "fctype"], :name => "soid"
  add_index "fssertrn", ["identity_column"], :name => "idcolumn", :unique => true

  create_table "fstechwk", :primary_key => "identity_column", :force => true do |t|
    t.string   "fctechwkid",       :limit => 10,                                 :default => "",  :null => false
    t.string   "fctype",           :limit => 1,                                  :default => "",  :null => false
    t.string   "fcsoid",           :limit => 20,                                 :default => "",  :null => false
    t.string   "fctechid",         :limit => 10,                                 :default => "",  :null => false
    t.datetime "fdfromdate",                                                                      :null => false
    t.datetime "fdtodate",                                                                        :null => false
    t.datetime "fdcurrdate",                                                                      :null => false
    t.datetime "fdeurodate",                                                                      :null => false
    t.string   "fccurid",          :limit => 3,                                  :default => "",  :null => false
    t.string   "fctaxcode",        :limit => 10,                                 :default => "",  :null => false
    t.binary   "fgexcelhoo"
    t.text     "fmnotes",                                                        :default => "",  :null => false
    t.text     "fmother",                                                        :default => "",  :null => false
    t.decimal  "fnairrail",                       :precision => 15, :scale => 4, :default => 0.0, :null => false
    t.decimal  "fnautorent",                      :precision => 15, :scale => 4, :default => 0.0, :null => false
    t.decimal  "fncurrfact",                      :precision => 16, :scale => 5, :default => 0.0, :null => false
    t.decimal  "fnentertai",                      :precision => 15, :scale => 4, :default => 0.0, :null => false
    t.decimal  "fneuroair",                       :precision => 15, :scale => 4, :default => 0.0, :null => false
    t.decimal  "fneuroauto",                      :precision => 15, :scale => 4, :default => 0.0, :null => false
    t.decimal  "fneuroente",                      :precision => 15, :scale => 4, :default => 0.0, :null => false
    t.decimal  "fneurofact",                      :precision => 15, :scale => 4, :default => 0.0, :null => false
    t.decimal  "fneurofuel",                      :precision => 15, :scale => 4, :default => 0.0, :null => false
    t.decimal  "fneurolodg",                      :precision => 15, :scale => 4, :default => 0.0, :null => false
    t.decimal  "fneuromeal",                      :precision => 15, :scale => 4, :default => 0.0, :null => false
    t.decimal  "fneuromile",                      :precision => 15, :scale => 4, :default => 0.0, :null => false
    t.decimal  "fneuroothe",                      :precision => 15, :scale => 4, :default => 0.0, :null => false
    t.decimal  "fneuropark",                      :precision => 15, :scale => 4, :default => 0.0, :null => false
    t.decimal  "fneurophon",                      :precision => 15, :scale => 4, :default => 0.0, :null => false
    t.decimal  "fneuropost",                      :precision => 15, :scale => 4, :default => 0.0, :null => false
    t.decimal  "fneurosoft",                      :precision => 15, :scale => 4, :default => 0.0, :null => false
    t.decimal  "fneurosupp",                      :precision => 15, :scale => 4, :default => 0.0, :null => false
    t.decimal  "fneurotax",                       :precision => 15, :scale => 4, :default => 0.0, :null => false
    t.decimal  "fneurotaxi",                      :precision => 15, :scale => 4, :default => 0.0, :null => false
    t.decimal  "fneurotoll",                      :precision => 15, :scale => 4, :default => 0.0, :null => false
    t.decimal  "fneurotrav",                      :precision => 15, :scale => 4, :default => 0.0, :null => false
    t.decimal  "fnfuel",                          :precision => 15, :scale => 4, :default => 0.0, :null => false
    t.decimal  "fnlodge",                         :precision => 15, :scale => 4, :default => 0.0, :null => false
    t.decimal  "fnmeal",                          :precision => 15, :scale => 4, :default => 0.0, :null => false
    t.decimal  "fnmile",                          :precision => 15, :scale => 4, :default => 0.0, :null => false
    t.decimal  "fnother",                         :precision => 15, :scale => 4, :default => 0.0, :null => false
    t.decimal  "fnpark",                          :precision => 15, :scale => 4, :default => 0.0, :null => false
    t.decimal  "fnphone",                         :precision => 15, :scale => 4, :default => 0.0, :null => false
    t.decimal  "fnpost",                          :precision => 15, :scale => 4, :default => 0.0, :null => false
    t.decimal  "fnsupp",                          :precision => 15, :scale => 4, :default => 0.0, :null => false
    t.decimal  "fntaxes",                         :precision => 15, :scale => 4, :default => 0.0, :null => false
    t.decimal  "fntaxi",                          :precision => 15, :scale => 4, :default => 0.0, :null => false
    t.decimal  "fntolls",                         :precision => 15, :scale => 4, :default => 0.0, :null => false
    t.decimal  "fntrav",                          :precision => 15, :scale => 4, :default => 0.0, :null => false
    t.decimal  "fnsoft",                          :precision => 15, :scale => 4, :default => 0.0, :null => false
    t.binary   "timestamp_column"
    t.string   "fxlsfile",         :limit => 500,                                                 :null => false
  end

  add_index "fstechwk", ["fcsoid", "identity_column"], :name => "soid", :unique => true
  add_index "fstechwk", ["fctechid"], :name => "techid"
  add_index "fstechwk", ["identity_column"], :name => "idcolumn", :unique => true

  create_table "fsvpshis", :primary_key => "identity_column", :force => true do |t|
    t.string   "fcvenserid",       :limit => 10, :default => "", :null => false
    t.string   "fcvendorid",       :limit => 6,  :default => "", :null => false
    t.string   "fac",              :limit => 20,                 :null => false
    t.string   "fcpartno",         :limit => 25, :default => "", :null => false
    t.string   "fcpartrev",        :limit => 3,  :default => "", :null => false
    t.string   "fcserialno",       :limit => 20, :default => "", :null => false
    t.string   "fcporef",          :limit => 6,  :default => "", :null => false
    t.string   "fcsvceid",         :limit => 20, :default => "", :null => false
    t.string   "fcvendptno",       :limit => 40, :default => "", :null => false
    t.datetime "fdinspect",                                      :null => false
    t.datetime "fdreturned",                                     :null => false
    t.datetime "fdscrapped",                                     :null => false
    t.datetime "fdtostock",                                      :null => false
    t.datetime "fdwarnexp",                                      :null => false
    t.text     "fmnotes",                        :default => "", :null => false
    t.integer  "fnwarnmo",                       :default => 0,  :null => false
    t.integer  "fnwarnyrs",                      :default => 0,  :null => false
    t.string   "udrev",            :limit => 3,  :default => "", :null => false
    t.binary   "timestamp_column"
  end

  add_index "fsvpshis", ["fcpartno", "fcpartrev", "fac"], :name => "partrev"
  add_index "fsvpshis", ["fcvendorid"], :name => "vendor"
  add_index "fsvpshis", ["identity_column"], :name => "idcolumn", :unique => true

  create_table "fswardef", :primary_key => "identity_column", :force => true do |t|
    t.string  "fcwarntyid",       :limit => 10, :default => "",    :null => false
    t.string  "fcwarntype",       :limit => 4,  :default => "",    :null => false
    t.string  "fcdescr",          :limit => 35, :default => "",    :null => false
    t.string  "fac",              :limit => 20,                    :null => false
    t.string  "fcpartno",         :limit => 25, :default => "",    :null => false
    t.string  "fcpartrev",        :limit => 3,  :default => "",    :null => false
    t.boolean "flinclexp",                      :default => false, :null => false
    t.boolean "flincllabo",                     :default => false, :null => false
    t.boolean "flinclpart",                     :default => false, :null => false
    t.boolean "flinclsw",                       :default => false, :null => false
    t.text    "fmnotes",                        :default => "",    :null => false
    t.string  "udrev",            :limit => 3,  :default => "",    :null => false
    t.binary  "timestamp_column"
  end

  add_index "fswardef", ["fcwarntype"], :name => "warntype"
  add_index "fswardef", ["identity_column"], :name => "idcolumn", :unique => true

  create_table "fswarnty", :primary_key => "identity_column", :force => true do |t|
    t.string   "fcwarntyid",       :limit => 10,                                :default => "",    :null => false
    t.string   "fcmachid",         :limit => 10,                                :default => "",    :null => false
    t.string   "fcwarntype",       :limit => 4,                                 :default => "",    :null => false
    t.string   "fcstatus",         :limit => 1,                                 :default => "",    :null => false
    t.boolean  "flinclexp",                                                     :default => false, :null => false
    t.boolean  "flincllabo",                                                    :default => false, :null => false
    t.boolean  "flinclpart",                                                    :default => false, :null => false
    t.boolean  "flinclsw",                                                      :default => false, :null => false
    t.string   "fccurid",          :limit => 3,                                 :default => "",    :null => false
    t.string   "fccustpo",         :limit => 20,                                :default => "",    :null => false
    t.string   "fcinvoice",        :limit => 20,                                :default => "",    :null => false
    t.string   "fcpayfreq",        :limit => 1,                                 :default => "",    :null => false
    t.string   "fctaxcode",        :limit => 10,                                :default => "",    :null => false
    t.datetime "fdeurodate",                                                                       :null => false
    t.datetime "fdfactdate",                                                                       :null => false
    t.binary   "fgcalcpay"
    t.text     "fmnotes",                                                       :default => "",    :null => false
    t.decimal  "fncurrfact",                     :precision => 16, :scale => 5, :default => 0.0,   :null => false
    t.decimal  "fneurofact",                     :precision => 16, :scale => 5, :default => 0.0,   :null => false
    t.decimal  "fnpayamt",                       :precision => 15, :scale => 4, :default => 0.0,   :null => false
    t.decimal  "fnpayeuro",                      :precision => 16, :scale => 5, :default => 0.0,   :null => false
    t.decimal  "fntotalamt",                     :precision => 15, :scale => 4, :default => 0.0,   :null => false
    t.decimal  "fntotaleur",                     :precision => 16, :scale => 5, :default => 0.0,   :null => false
    t.datetime "fdwarndate",                                                                       :null => false
    t.datetime "fdexpires",                                                                        :null => false
    t.datetime "fdexpbeg",                                                                         :null => false
    t.datetime "fdexpend",                                                                         :null => false
    t.datetime "fdsofbeg",                                                                         :null => false
    t.datetime "fdsofend",                                                                         :null => false
    t.datetime "fdparbeg",                                                                         :null => false
    t.datetime "fdparend",                                                                         :null => false
    t.datetime "fdlabbeg",                                                                         :null => false
    t.datetime "fdlabend",                                                                         :null => false
    t.string   "fcmcfgid",         :limit => 10,                                :default => "",    :null => false
    t.binary   "timestamp_column"
  end

  add_index "fswarnty", ["fcmachid", "identity_column"], :name => "machineid", :unique => true
  add_index "fswarnty", ["fdexpend"], :name => "expexpire"
  add_index "fswarnty", ["fdexpires"], :name => "expiredate"
  add_index "fswarnty", ["fdlabend"], :name => "labexpire"
  add_index "fswarnty", ["fdparend"], :name => "parexpire"
  add_index "fswarnty", ["fdsofend"], :name => "sofexpire"
  add_index "fswarnty", ["fdwarndate"], :name => "warndate"
  add_index "fswarnty", ["identity_column"], :name => "idcolumn", :unique => true

  create_table "glauto", :primary_key => "identity_column", :force => true do |t|
    t.string "fcacctnum",        :limit => 25,                  :null => false
    t.string "fcstatus",         :limit => 1,                   :null => false
    t.binary "timestamp_column"
    t.text   "fmarray",                        :default => " ", :null => false
  end

  add_index "glauto", ["fcacctnum"], :name => "account"
  add_index "glauto", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "glchecks", :primary_key => "identity_column", :force => true do |t|
    t.string   "fcchecka",         :limit => 25, :null => false
    t.string   "fcpaidtoid",       :limit => 6,  :null => false
    t.string   "fcpayref",         :limit => 20, :null => false
    t.string   "fcstatus",         :limit => 1,  :null => false
    t.string   "fctype",           :limit => 1,  :null => false
    t.string   "fcuserid",         :limit => 4,  :null => false
    t.datetime "fdckdate",                       :null => false
    t.datetime "fdstmt",                         :null => false
    t.datetime "fdvoided",                       :null => false
    t.boolean  "flisrcvd",                       :null => false
    t.decimal  "fnamount",                       :null => false
    t.integer  "fnrefid",                        :null => false
    t.integer  "fnnumber",                       :null => false
    t.binary   "timestamp_column"
  end

  add_index "glchecks", ["fcchecka", "fdstmt", "fnnumber"], :name => "BANKSTMT"
  add_index "glchecks", ["fcchecka", "fnnumber", "fnrefid"], :name => "chkrefkey"
  add_index "glchecks", ["fcpaidtoid"], :name => "paidto"
  add_index "glchecks", ["fcstatus"], :name => "status"
  add_index "glchecks", ["fctype"], :name => "type"
  add_index "glchecks", ["fdckdate"], :name => "checkdate"
  add_index "glchecks", ["fnamount"], :name => "amount"
  add_index "glchecks", ["fnnumber"], :name => "number"
  add_index "glchecks", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "glcshi", :primary_key => "identity_column", :force => true do |t|
    t.string   "fccashid",         :limit => 35, :default => " ", :null => false
    t.string   "fccashnum",        :limit => 20,                  :null => false
    t.string   "fcchecka",         :limit => 25,                  :null => false
    t.string   "fcinvoice",        :limit => 20,                  :null => false
    t.string   "fcnameid",         :limit => 6,                   :null => false
    t.string   "fcpayclass",       :limit => 1,                   :null => false
    t.string   "fcreferenc",       :limit => 20,                  :null => false
    t.string   "fcstatus",         :limit => 1,                   :null => false
    t.string   "fctype",           :limit => 1,                   :null => false
    t.datetime "fdpaiddate",                                      :null => false
    t.decimal  "fnadjamt",                                        :null => false
    t.decimal  "fncashamt",                                       :null => false
    t.decimal  "fndiscount",                                      :null => false
    t.decimal  "fneuradjamt",                                     :null => false
    t.decimal  "fneurcshamt",                                     :null => false
    t.decimal  "fneurdsct",                                       :null => false
    t.decimal  "fngainloss",                                      :null => false
    t.decimal  "fnpyadjamt",                                      :null => false
    t.decimal  "fnpycshamt",                                      :null => false
    t.decimal  "fnpaydsct",                                       :null => false
    t.integer  "fnrefid",                                         :null => false
    t.integer  "fnnumber",                                        :null => false
    t.decimal  "fntxnadjamt",                                     :null => false
    t.decimal  "fntxncshamt",                                     :null => false
    t.decimal  "fntxndsct",                                       :null => false
    t.binary   "timestamp_column"
  end

  add_index "glcshi", ["fccashid", "fcinvoice", "fctype"], :name => "CSHITEMID"
  add_index "glcshi", ["fccashnum", "fcinvoice", "fctype"], :name => "cnmitemid"
  add_index "glcshi", ["fcchecka", "fnnumber", "fnrefid", "fcinvoice"], :name => "CHKNUM"
  add_index "glcshi", ["fcinvoice"], :name => "fcinvoice"
  add_index "glcshi", ["fcnameid", "fcinvoice"], :name => "APINVKEY"
  add_index "glcshi", ["fcpayclass"], :name => "invtype"
  add_index "glcshi", ["fcstatus"], :name => "status"
  add_index "glcshi", ["fctype"], :name => "fctype"
  add_index "glcshi", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "glcshm", :primary_key => "identity_column", :force => true do |t|
    t.string   "fcacctnum",        :limit => 25,                                                 :null => false
    t.string   "fccashnum",        :limit => 20,                                                 :null => false
    t.string   "fcchecka",         :limit => 25,                                                 :null => false
    t.string   "fccurid",          :limit => 3,                                                  :null => false
    t.string   "fcnameid",         :limit => 6,                                                  :null => false
    t.string   "fcpaidby",         :limit => 1,                                                  :null => false
    t.string   "fcpayclass",       :limit => 1,                                                  :null => false
    t.string   "fcreferenc",       :limit => 20,                                                 :null => false
    t.string   "fcstatus",         :limit => 1,                                                  :null => false
    t.string   "fctype",           :limit => 1,                                                  :null => false
    t.datetime "fdpaiddate",                                                                     :null => false
    t.decimal  "fnamount",                                                                       :null => false
    t.decimal  "fneuroamt",                                                                      :null => false
    t.integer  "fnrefid",                                                                        :null => false
    t.integer  "fnnumber",                                                                       :null => false
    t.decimal  "fntxnamt",                                                                       :null => false
    t.decimal  "fcfactor",                       :precision => 17, :scale => 5,                  :null => false
    t.datetime "fdfactdate",                                                                     :null => false
    t.decimal  "feurofctr",                      :precision => 17, :scale => 5,                  :null => false
    t.datetime "fdeurodate",                                                                     :null => false
    t.string   "fccashacc",        :limit => 25,                                                 :null => false
    t.string   "fcgnlsacc",        :limit => 25,                                                 :null => false
    t.binary   "timestamp_column"
    t.text     "fmdetail",                                                      :default => " ", :null => false
  end

  add_index "glcshm", ["fccashnum"], :name => "fccashnum"
  add_index "glcshm", ["fcchecka", "fnnumber", "fnrefid"], :name => "chknum"
  add_index "glcshm", ["fccurid"], :name => "fccurid"
  add_index "glcshm", ["fcnameid", "fcreferenc"], :name => "NAMEREF"
  add_index "glcshm", ["fcpaidby"], :name => "fcpaidby"
  add_index "glcshm", ["fcpayclass", "fcnameid", "fcreferenc", "fdpaiddate"], :name => "CASHID"
  add_index "glcshm", ["fcreferenc"], :name => "fcreferenc"
  add_index "glcshm", ["fcstatus"], :name => "fcstatus"
  add_index "glcshm", ["fdpaiddate"], :name => "fdpaiddate"
  add_index "glcshm", ["fnamount"], :name => "fnamount"
  add_index "glcshm", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "gldepitm", :primary_key => "identity_column", :force => true do |t|
    t.string  "fcdepno",          :limit => 10, :null => false
    t.string  "fccashnum",        :limit => 20, :null => false
    t.decimal "fytxnamt",                       :null => false
    t.decimal "fyeuroamt",                      :null => false
    t.decimal "fychkamt",                       :null => false
    t.decimal "fyamt",                          :null => false
    t.binary  "timestamp_column"
  end

  add_index "gldepitm", ["fccashnum"], :name => "receipt"
  add_index "gldepitm", ["fcdepno", "fccashnum"], :name => "DEPRCPT"
  add_index "gldepitm", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "gldepmst", :primary_key => "identity_column", :force => true do |t|
    t.string   "fcacctno",         :limit => 25,                                                :null => false
    t.string   "fccurid",          :limit => 3,                                                 :null => false
    t.string   "fcdepno",          :limit => 10,                                                :null => false
    t.string   "fcrefid",          :limit => 20,                                                :null => false
    t.string   "fcstatus",         :limit => 1,                                                 :null => false
    t.datetime "fdconvdate",                                                                    :null => false
    t.datetime "fddepdt",                                                                       :null => false
    t.datetime "fdeurodate",                                                                    :null => false
    t.datetime "fdstmt",                                                                        :null => false
    t.decimal  "fnconvfact",                     :precision => 16, :scale => 5,                 :null => false
    t.decimal  "fneurofact",                     :precision => 16, :scale => 5,                 :null => false
    t.decimal  "fydepamt",                                                                      :null => false
    t.binary   "timestamp_column"
    t.string   "fccashacct",       :limit => 25,                                :default => "", :null => false
  end

  add_index "gldepmst", ["fcacctno", "fcdepno"], :name => "acctdep"
  add_index "gldepmst", ["fcacctno", "fddepdt"], :name => "ACCTDATE"
  add_index "gldepmst", ["fcacctno", "fdstmt"], :name => "bankstmt"
  add_index "gldepmst", ["fcdepno"], :name => "deposit"
  add_index "gldepmst", ["fcrefid"], :name => "refid"
  add_index "gldepmst", ["fddepdt"], :name => "depdate"
  add_index "gldepmst", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "glhead", :primary_key => "identity_column", :force => true do |t|
    t.string  "fcacctnum",        :limit => 25,                  :null => false
    t.string  "fcclass",          :limit => 1,                   :null => false
    t.string  "fccode",           :limit => 1,                   :null => false
    t.string  "fcdescr",          :limit => 40, :default => " ", :null => false
    t.string  "fcformat",         :limit => 35, :default => " ", :null => false
    t.boolean "flconsol",                                        :null => false
    t.binary  "timestamp_column"
  end

  add_index "glhead", ["fcacctnum"], :name => "acctnum"
  add_index "glhead", ["fcclass"], :name => "class"
  add_index "glhead", ["fccode"], :name => "glhead_code", :unique => true
  add_index "glhead", ["fcdescr"], :name => "descr"
  add_index "glhead", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "glitem", :primary_key => "identity_column", :force => true do |t|
    t.string   "fcacctnum",        :limit => 25, :null => false
    t.string   "fcclass",          :limit => 1,  :null => false
    t.string   "fcdescr",          :limit => 20, :null => false
    t.datetime "fctime_ts",                      :null => false
    t.string   "fcuserid",         :limit => 4,  :null => false
    t.datetime "fddate",                         :null => false
    t.decimal  "fnamount",                       :null => false
    t.binary   "timestamp_column"
  end

  add_index "glitem", ["fcacctnum", "fcclass", "fddate"], :name => "glitem_acct_bal", :unique => true
  add_index "glitem", ["fcclass"], :name => "class"
  add_index "glitem", ["fcdescr", "fcacctnum"], :name => "BUDGETKEY"
  add_index "glitem", ["fcuserid"], :name => "userid"
  add_index "glitem", ["fddate"], :name => "asofdate"
  add_index "glitem", ["fnamount"], :name => "amount"
  add_index "glitem", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "gljeitem", :primary_key => "identity_column", :force => true do |t|
    t.string   "fcentry",          :limit => 10,                                                  :null => false
    t.datetime "fddate",                                                                          :null => false
    t.integer  "fnorder",          :limit => nil, :precision => 4,  :scale => 0,                  :null => false
    t.string   "fcacctno",         :limit => 25,                                                  :null => false
    t.string   "fctrsdes",         :limit => 30,                                 :default => " ", :null => false
    t.decimal  "fndebit",                         :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fncredit",                        :precision => 17, :scale => 5,                  :null => false
    t.binary   "timestamp_column"
  end

  add_index "gljeitem", ["fcacctno"], :name => "acctno"
  add_index "gljeitem", ["fcentry", "fddate", "fnorder"], :name => "ENTRYORDER"
  add_index "gljeitem", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "gljemast", :primary_key => "identity_column", :force => true do |t|
    t.string   "fcentry",          :limit => 10, :null => false
    t.datetime "fddate",                         :null => false
    t.boolean  "flreverse",                      :null => false
    t.string   "fcstatus",         :limit => 1,  :null => false
    t.boolean  "flrecur",                        :null => false
    t.boolean  "flreventry",                     :null => false
    t.binary   "timestamp_column"
  end

  add_index "gljemast", ["fcentry", "fddate"], :name => "entrydate"
  add_index "gljemast", ["fcstatus"], :name => "status"
  add_index "gljemast", ["fddate"], :name => "date"
  add_index "gljemast", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "glmast", :primary_key => "identity_column", :force => true do |t|
    t.string  "fcacctnum",        :limit => 25,                                                   :null => false
    t.string  "fcclass",          :limit => 1,                                                    :null => false
    t.string  "fccode",           :limit => 1,                                                    :null => false
    t.string  "fcdescr",          :limit => 40,                                :default => " ",   :null => false
    t.string  "fcparentid",       :limit => 25,                                                   :null => false
    t.string  "fctype",           :limit => 3,                                                    :null => false
    t.boolean "flfunds",                                                                          :null => false
    t.boolean "flconsol",                                                                         :null => false
    t.boolean "flinactive",                                                                       :null => false
    t.integer "fnorder",          :limit => nil, :precision => 5, :scale => 0,                    :null => false
    t.boolean "flrevlcurr",                                                                       :null => false
    t.binary  "timestamp_column"
    t.text    "fmnote",                                                        :default => " ",   :null => false
    t.string  "fcactcat",         :limit => 1,                                 :default => " ",   :null => false
    t.boolean "flcash",                                                        :default => false, :null => false
  end

  add_index "glmast", ["fcacctnum"], :name => "glmast_fcacctnum", :unique => true
  add_index "glmast", ["fcclass"], :name => "class"
  add_index "glmast", ["fccode", "fcacctnum"], :name => "CODEACCT"
  add_index "glmast", ["fccode", "fcdescr"], :name => "CODEDESC"
  add_index "glmast", ["fcdescr"], :name => "descr"
  add_index "glmast", ["fcparentid", "fnorder"], :name => "parentline"
  add_index "glmast", ["fctype"], :name => "type"
  add_index "glmast", ["fnorder"], :name => "order_"
  add_index "glmast", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "glremast", :primary_key => "identity_column", :force => true do |t|
    t.string   "fcacctid",         :limit => 6,                   :null => false
    t.string   "fcfreq",           :limit => 1,                   :null => false
    t.string   "fcjournal",        :limit => 3,                   :null => false
    t.string   "fcrecurid",        :limit => 6,                   :null => false
    t.string   "fcref",            :limit => 20,                  :null => false
    t.string   "fcstatus",         :limit => 1,                   :null => false
    t.string   "fctype",           :limit => 1,                   :null => false
    t.datetime "fdend",                                           :null => false
    t.datetime "fdnext",                                          :null => false
    t.datetime "fdlast",                                          :null => false
    t.datetime "fdrefdate",                                       :null => false
    t.datetime "fdstart",                                         :null => false
    t.boolean  "flbatch",                                         :null => false
    t.decimal  "fnamount",                                        :null => false
    t.decimal  "fnapplied",                                       :null => false
    t.integer  "fnatimes",                                        :null => false
    t.integer  "fnendrep",                                        :null => false
    t.integer  "fntimes",                                         :null => false
    t.decimal  "fntotalamt",                                      :null => false
    t.string   "fcurrpaid",        :limit => 1,                   :null => false
    t.binary   "timestamp_column"
    t.text     "fmnotes",                        :default => " ", :null => false
  end

  add_index "glremast", ["fcacctid", "fcref", "fdrefdate"], :name => "EVENTKEY"
  add_index "glremast", ["fcjournal"], :name => "journal"
  add_index "glremast", ["fcrecurid"], :name => "recurid"
  add_index "glremast", ["fcref"], :name => "refkey"
  add_index "glremast", ["fcstatus"], :name => "status"
  add_index "glremast", ["fctype"], :name => "type"
  add_index "glremast", ["fdend"], :name => "end_"
  add_index "glremast", ["fdlast"], :name => "last"
  add_index "glremast", ["fdnext"], :name => "next"
  add_index "glremast", ["fdstart"], :name => "start"
  add_index "glremast", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "glrpti", :primary_key => "identity_column", :force => true do |t|
    t.string  "fcband",           :limit => 8,                   :null => false
    t.string  "fcclass",          :limit => 1,                   :null => false
    t.string  "fccode",           :limit => 1,                   :null => false
    t.string  "fcdescr",          :limit => 40, :default => " ", :null => false
    t.string  "fcpctwhat",        :limit => 1,                   :null => false
    t.string  "fcreport",         :limit => 10,                  :null => false
    t.string  "fctype",           :limit => 1,                   :null => false
    t.string  "fcunits",          :limit => 10,                  :null => false
    t.boolean "flfunds",                                         :null => false
    t.boolean "fllexclude",                                      :null => false
    t.boolean "flshowdet",                                       :null => false
    t.boolean "flshowpct",                                       :null => false
    t.integer "fnindent",                                        :null => false
    t.integer "fnrow",                                           :null => false
    t.string  "fcacctnum",        :limit => 25,                  :null => false
    t.string  "fcparent",         :limit => 25,                  :null => false
    t.binary  "timestamp_column"
    t.text    "fmcalc",                         :default => " ", :null => false
    t.text    "fmlaaccts",                      :default => " ", :null => false
  end

  add_index "glrpti", ["fccode", "fcband"], :name => "BAND"
  add_index "glrpti", ["fcdescr"], :name => "descr"
  add_index "glrpti", ["fcreport", "fnrow"], :name => "linekey"
  add_index "glrpti", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "glrptm", :primary_key => "identity_column", :force => true do |t|
    t.string   "fccolumn",         :limit => 2,                   :null => false
    t.string   "fccreate",         :limit => 3,                   :null => false
    t.string   "fcreport",         :limit => 10,                  :null => false
    t.string   "fcsubtitle",       :limit => 60, :default => " ", :null => false
    t.string   "fctitle",          :limit => 40, :default => " ", :null => false
    t.string   "fctype",           :limit => 1,                   :null => false
    t.datetime "fdasof",                                          :null => false
    t.boolean  "flbudget",                                        :null => false
    t.boolean  "flhistory",                                       :null => false
    t.boolean  "flisconsol",                                      :null => false
    t.boolean  "flsurpress",                                      :null => false
    t.integer  "fnnegno",                                         :null => false
    t.integer  "fnround",                                         :null => false
    t.binary   "timestamp_column"
    t.text     "fmcomp",                         :default => " ", :null => false
    t.text     "fmdescr",                        :default => " ", :null => false
    t.text     "fmfilter",                       :default => " ", :null => false
  end

  add_index "glrptm", ["fcreport"], :name => "glrptm_reportkey", :unique => true
  add_index "glrptm", ["fctitle"], :name => "title"
  add_index "glrptm", ["fctype"], :name => "type"
  add_index "glrptm", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "glrule", :primary_key => "identity_column", :force => true do |t|
    t.string   "fcbasis",          :limit => 1,                                 :null => false
    t.string   "fcname",           :limit => 20,                                :null => false
    t.string   "fcstatus",         :limit => 1,                                 :null => false
    t.datetime "fdend",                                                         :null => false
    t.datetime "fdstart",                                                       :null => false
    t.boolean  "flisadjust",                                                    :null => false
    t.boolean  "flisaudit",                                                     :null => false
    t.integer  "fnnumber",                                                      :null => false
    t.boolean  "freval",                                                        :null => false
    t.integer  "fnfrxyr",          :limit => nil, :precision => 4, :scale => 0, :null => false
    t.binary   "timestamp_column"
  end

  add_index "glrule", ["fcname", "fnnumber"], :name => "YRPERIOD"
  add_index "glrule", ["fcstatus"], :name => "status"
  add_index "glrule", ["fdend"], :name => "enddate"
  add_index "glrule", ["fdstart"], :name => "startdate"
  add_index "glrule", ["fnnumber"], :name => "period"
  add_index "glrule", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "glstmt", :primary_key => "identity_column", :force => true do |t|
    t.string   "fcacctno",         :limit => 25,                                                 :null => false
    t.datetime "fdstmt",                                                                         :null => false
    t.decimal  "fnamount",                                                                       :null => false
    t.boolean  "flcleared",                                                                      :null => false
    t.string   "fccashacct",       :limit => 25,                                                 :null => false
    t.datetime "fdenddt",                                                                        :null => false
    t.datetime "fdstartdt",                                                                      :null => false
    t.decimal  "fybegbal",                                                                       :null => false
    t.decimal  "fyendbal",                                                                       :null => false
    t.decimal  "fydeptot",                                                                       :null => false
    t.decimal  "fyothtot",                                                                       :null => false
    t.decimal  "fychkclr",                                                                       :null => false
    t.decimal  "fydepclr",                                                                       :null => false
    t.decimal  "fyothclr",                                                                       :null => false
    t.decimal  "fyjetot",                                                                        :null => false
    t.string   "fccurid",          :limit => 3,                                                  :null => false
    t.decimal  "fnconvfact",                     :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fneurofact",                     :precision => 17, :scale => 5,                  :null => false
    t.datetime "fdconvdate",                                                                     :null => false
    t.datetime "fdeurodate",                                                                     :null => false
    t.string   "fcusrchr1",        :limit => 20,                                                 :null => false
    t.string   "fcusrchr2",        :limit => 40,                                :default => " ", :null => false
    t.string   "fcusrchr3",        :limit => 40,                                :default => " ", :null => false
    t.decimal  "fnusrqty1",                      :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fyusrcur1",                                                                      :null => false
    t.datetime "fdusrdate1",                                                                     :null => false
    t.binary   "timestamp_column"
    t.text     "fmusrmemo1",                                                    :default => " ", :null => false
    t.decimal  "fytxnjetot",                                                    :default => 0.0, :null => false
    t.decimal  "fyeurjetot",                                                    :default => 0.0, :null => false
  end

  add_index "glstmt", ["fcacctno", "fdstmt"], :name => "acctdate"
  add_index "glstmt", ["fdstmt"], :name => "stmtdate"
  add_index "glstmt", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "glstmtje", :primary_key => "identity_column", :force => true do |t|
    t.string   "fcacctno",         :limit => 25,                                                 :null => false
    t.string   "fccurid",          :limit => 3,                                                  :null => false
    t.string   "fcentry",          :limit => 10,                                                 :null => false
    t.string   "fcglacct",         :limit => 25,                                                 :null => false
    t.string   "fctrandesc",       :limit => 30,                                :default => " ", :null => false
    t.datetime "fdconvdate",                                                                     :null => false
    t.datetime "fdeurodate",                                                                     :null => false
    t.datetime "fdstmt",                                                                         :null => false
    t.datetime "fdtrandate",                                                                     :null => false
    t.decimal  "fnconvfact",                     :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fneurofact",                     :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fyamt",                                                                          :null => false
    t.decimal  "fyeuroamt",                                                                      :null => false
    t.decimal  "fytxnamt",                                                                       :null => false
    t.binary   "timestamp_column"
  end

  add_index "glstmtje", ["fcacctno", "fcentry"], :name => "acctentry"
  add_index "glstmtje", ["fcacctno", "fdstmt"], :name => "bankstmt"
  add_index "glstmtje", ["fcentry"], :name => "entry"
  add_index "glstmtje", ["fcglacct"], :name => "glacct"
  add_index "glstmtje", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "gltran", :primary_key => "identity_column", :force => true do |t|
    t.string   "fcacctnum",        :limit => 25,                                                 :null => false
    t.string   "fcrefclass",       :limit => 2,                                                  :null => false
    t.datetime "fctime_ts",                                                                      :null => false
    t.string   "fcuserid",         :limit => 4,                                                  :null => false
    t.datetime "fddate",                                                                         :null => false
    t.decimal  "ftrsamt",                                                                        :null => false
    t.string   "ftrsdes",          :limit => 30,                                :default => " ", :null => false
    t.string   "ftrsref",          :limit => 10,                                                 :null => false
    t.datetime "ftrsdate",                                                                       :null => false
    t.string   "fccurid",          :limit => 3,                                                  :null => false
    t.decimal  "fcfactor",                       :precision => 17, :scale => 5,                  :null => false
    t.decimal  "feurofctr",                      :precision => 17, :scale => 5,                  :null => false
    t.decimal  "feurotrsamt",                                                                    :null => false
    t.decimal  "ftxntrsamt",                                                                     :null => false
    t.boolean  "flreverse",                                                                      :null => false
    t.binary   "timestamp_column"
    t.text     "fmcocons",                                                      :default => " ", :null => false
  end

  add_index "gltran", ["fcacctnum", "fddate"], :name => "acct_date"
  add_index "gltran", ["fcrefclass", "fcacctnum", "fddate", "ftrsref", "fccurid"], :name => "TRNCURRKEY"
  add_index "gltran", ["fcrefclass", "ftrsref", "fddate"], :name => "reference"
  add_index "gltran", ["fctime_ts"], :name => "timestamp"
  add_index "gltran", ["fcuserid"], :name => "userid"
  add_index "gltran", ["fddate"], :name => "fddate"
  add_index "gltran", ["ftrsamt"], :name => "amount"
  add_index "gltran", ["ftrsdes"], :name => "descr"
  add_index "gltran", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "glxref", :primary_key => "identity_column", :force => true do |t|
    t.string "fcacctext",        :limit => 80, :default => " ", :null => false
    t.string "fcacctm2m",        :limit => 25,                  :null => false
    t.binary "timestamp_column"
  end

  add_index "glxref", ["fcacctext"], :name => "acctext"
  add_index "glxref", ["fcacctm2m"], :name => "acctm2m"
  add_index "glxref", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "ido", :primary_key => "identity_column", :force => true do |t|
    t.string   "idono",            :limit => 10
    t.string   "isono",            :limit => 10
    t.string   "dfac",             :limit => 20
    t.string   "sfac",             :limit => 20
    t.string   "status",           :limit => 25
    t.string   "partno",           :limit => 25
    t.string   "partrev",          :limit => 3
    t.datetime "duedate"
    t.decimal  "quantity",                       :precision => 15, :scale => 5
    t.decimal  "qtyshipped",                     :precision => 15, :scale => 5
    t.binary   "timestamp_column"
    t.string   "jobno",            :limit => 10
    t.string   "sono",             :limit => 6
    t.string   "jo_bominum",       :limit => 4,                                 :default => "",  :null => false
    t.string   "so_itemno",        :limit => 3,                                 :default => "",  :null => false
    t.string   "so_rel",           :limit => 3,                                 :default => "",  :null => false
    t.decimal  "makeqty",                        :precision => 15, :scale => 5,                  :null => false
    t.decimal  "buyqty",                         :precision => 15, :scale => 5,                  :null => false
    t.string   "source",           :limit => 1,                                 :default => " ", :null => false
    t.string   "fcudrev",          :limit => 3,                                 :default => "",  :null => false
    t.string   "pono",             :limit => 6,                                 :default => " "
    t.string   "sjobno",           :limit => 10,                                :default => " "
    t.integer  "fndbrmod",         :limit => 1,                                                  :null => false
    t.datetime "SchedDate",                                                                      :null => false
  end

  add_index "ido", ["identity_column"], :name => "identity_column_idx1", :unique => true
  add_index "ido", ["idono"], :name => "IX_idono"
  add_index "ido", ["isono"], :name => "isono"
  add_index "ido", ["jobno", "jo_bominum"], :name => "jobitem"
  add_index "ido", ["pono"], :name => "pono"
  add_index "ido", ["sjobno"], :name => "sjobnum"
  add_index "ido", ["sono", "so_itemno", "so_rel"], :name => "sorelease"

  create_table "inbomm", :primary_key => "identity_column", :force => true do |t|
    t.string   "fpartno",          :limit => 25,                                                 :null => false
    t.string   "fcpartrev",        :limit => 3,                                                  :null => false
    t.integer  "fnbommax",         :limit => nil, :precision => 3, :scale => 0,                  :null => false
    t.integer  "fnbommin",         :limit => nil, :precision => 3, :scale => 0,                  :null => false
    t.datetime "fdlastrev",                                                                      :null => false
    t.binary   "timestamp_column"
    t.string   "facilityid",       :limit => 20,                                                 :null => false
    t.string   "fcudrev",          :limit => 3,                                 :default => " ", :null => false
  end

  add_index "inbomm", ["fpartno", "fcpartrev", "facilityid"], :name => "PARTNO"
  add_index "inbomm", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "inboms", :primary_key => "identity_column", :force => true do |t|
    t.string   "fcomponent",       :limit => 25,                                                  :null => false
    t.string   "fcomprev",         :limit => 3,                                                   :null => false
    t.string   "fitem",            :limit => 6,                                                   :null => false
    t.string   "fparent",          :limit => 25,                                                  :null => false
    t.string   "fparentrev",       :limit => 3,                                                   :null => false
    t.datetime "fend_ef_dt",                                                                      :null => false
    t.string   "fmemoexist",       :limit => 1,                                                   :null => false
    t.decimal  "fqty",                            :precision => 15, :scale => 5,                  :null => false
    t.string   "freqd",            :limit => 1,                                                   :null => false
    t.datetime "fst_ef_dt",                                                                       :null => false
    t.boolean  "flextend",                                                                        :null => false
    t.boolean  "fltooling",                                                                       :null => false
    t.integer  "fnoperno",         :limit => nil, :precision => 4,  :scale => 0,                  :null => false
    t.binary   "timestamp_column"
    t.text     "fbommemo",                                                       :default => " ", :null => false
    t.string   "cfacilityid",      :limit => 20,                                                  :null => false
    t.string   "pfacilityid",      :limit => 20,                                                  :null => false
    t.string   "fcompudrev",       :limit => 3,                                  :default => " ", :null => false
    t.string   "fcparudrev",       :limit => 3,                                  :default => " ", :null => false
    t.integer  "fndbrmod",         :limit => nil, :precision => 1,  :scale => 0, :default => 0,   :null => false
    t.boolean  "flFSSvc",                                                                         :null => false
    t.decimal  "fOrigQty",                        :precision => 15, :scale => 5,                  :null => false
  end

  add_index "inboms", ["fcomponent", "fcomprev", "pfacilityid", "fparent", "fparentrev", "cfacilityid"], :name => "COMPPAR"
  add_index "inboms", ["fparent", "fparentrev", "cfacilityid", "fcomponent", "fcomprev", "fitem", "pfacilityid"], :name => "PARCOMP"
  add_index "inboms", ["fparent", "fparentrev", "fitem", "cfacilityid", "fcomponent", "pfacilityid"], :name => "PARITEMC"
  add_index "inboms", ["fparent", "fparentrev", "fnoperno", "cfacilityid", "fcomponent", "fcomprev", "pfacilityid"], :name => "byparcomp"
  add_index "inboms", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "inbomsdl", :primary_key => "identity_column", :force => true do |t|
    t.integer "finbomsid",                                       :null => false
    t.integer "fitype",                                          :null => false
    t.integer "ficount",                                         :null => false
    t.integer "fium1"
    t.decimal "fnsize1",          :precision => 18, :scale => 5
    t.integer "fium2"
    t.decimal "fnsize2",          :precision => 18, :scale => 5
    t.integer "fium3"
    t.decimal "fnsize3",          :precision => 18, :scale => 5
    t.integer "fium4"
    t.decimal "fnsize4",          :precision => 18, :scale => 5
    t.integer "fium5"
    t.decimal "fnsize5",          :precision => 18, :scale => 5
    t.integer "fiqty",                                           :null => false
    t.binary  "timestamp_column"
  end

  add_index "inbomsdl", ["finbomsid", "fitype"], :name => "InBOMSID"
  add_index "inbomsdl", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "inclsc", :primary_key => "identity_column", :force => true do |t|
    t.string "fcplnclass",       :limit => 1, :null => false
    t.string "fcplnclsto",       :limit => 1, :null => false
    t.string "fcexplode",        :limit => 4, :null => false
    t.string "fcstorein",        :limit => 4, :null => false
    t.binary "timestamp_column"
  end

  add_index "inclsc", ["fcplnclass", "fcplnclsto"], :name => "fromto"
  add_index "inclsc", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "inclsm", :primary_key => "identity_column", :force => true do |t|
    t.string "fcplnclass",       :limit => 1,                   :null => false
    t.string "fcpcdescr",        :limit => 35, :default => " ", :null => false
    t.binary "timestamp_column"
  end

  add_index "inclsm", ["fcplnclass"], :name => "plnclass"
  add_index "inclsm", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "incntpt", :primary_key => "identity_column", :force => true do |t|
    t.string  "fccontkey",        :limit => 10,                                 :default => " ", :null => false
    t.string  "fpartno",          :limit => 25,                                 :default => " ", :null => false
    t.string  "frev",             :limit => 3,                                  :default => " ", :null => false
    t.integer "fipricetype",                                                    :default => 0,   :null => false
    t.integer "fnquant1",         :limit => nil, :precision => 8,  :scale => 0, :default => 0,   :null => false
    t.integer "fnquant2",         :limit => nil, :precision => 8,  :scale => 0, :default => 0,   :null => false
    t.integer "fnquant3",         :limit => nil, :precision => 8,  :scale => 0, :default => 0,   :null => false
    t.integer "fnquant4",         :limit => nil, :precision => 8,  :scale => 0, :default => 0,   :null => false
    t.integer "fnquant5",         :limit => nil, :precision => 8,  :scale => 0, :default => 0,   :null => false
    t.integer "fnquant6",         :limit => nil, :precision => 8,  :scale => 0, :default => 0,   :null => false
    t.integer "fnquant7",         :limit => nil, :precision => 8,  :scale => 0, :default => 0,   :null => false
    t.integer "fnquant8",         :limit => nil, :precision => 8,  :scale => 0, :default => 0,   :null => false
    t.integer "fnquant9",         :limit => nil, :precision => 8,  :scale => 0, :default => 0,   :null => false
    t.decimal "fnprice1",                        :precision => 10, :scale => 5, :default => 0.0, :null => false
    t.decimal "fnprice2",                        :precision => 10, :scale => 5, :default => 0.0, :null => false
    t.decimal "fnprice3",                        :precision => 10, :scale => 5, :default => 0.0, :null => false
    t.decimal "fnprice4",                        :precision => 10, :scale => 5, :default => 0.0, :null => false
    t.decimal "fnprice5",                        :precision => 10, :scale => 5, :default => 0.0, :null => false
    t.decimal "fnprice6",                        :precision => 10, :scale => 5, :default => 0.0, :null => false
    t.decimal "fnprice7",                        :precision => 10, :scale => 5, :default => 0.0, :null => false
    t.decimal "fnprice8",                        :precision => 10, :scale => 5, :default => 0.0, :null => false
    t.decimal "fnprice9",                        :precision => 10, :scale => 5, :default => 0.0, :null => false
    t.decimal "fntxprice1",                      :precision => 10, :scale => 5, :default => 0.0, :null => false
    t.decimal "fntxprice2",                      :precision => 10, :scale => 5, :default => 0.0, :null => false
    t.decimal "fntxprice3",                      :precision => 10, :scale => 5, :default => 0.0, :null => false
    t.decimal "fntxprice4",                      :precision => 10, :scale => 5, :default => 0.0, :null => false
    t.decimal "fntxprice5",                      :precision => 10, :scale => 5, :default => 0.0, :null => false
    t.decimal "fntxprice6",                      :precision => 10, :scale => 5, :default => 0.0, :null => false
    t.decimal "fntxprice7",                      :precision => 10, :scale => 5, :default => 0.0, :null => false
    t.decimal "fntxprice8",                      :precision => 10, :scale => 5, :default => 0.0, :null => false
    t.decimal "fntxprice9",                      :precision => 10, :scale => 5, :default => 0.0, :null => false
    t.decimal "fneuprice1",                      :precision => 10, :scale => 5, :default => 0.0, :null => false
    t.decimal "fneuprice2",                      :precision => 10, :scale => 5, :default => 0.0, :null => false
    t.decimal "fneuprice3",                      :precision => 10, :scale => 5, :default => 0.0, :null => false
    t.decimal "fneuprice4",                      :precision => 10, :scale => 5, :default => 0.0, :null => false
    t.decimal "fneuprice5",                      :precision => 10, :scale => 5, :default => 0.0, :null => false
    t.decimal "fneuprice6",                      :precision => 10, :scale => 5, :default => 0.0, :null => false
    t.decimal "fneuprice7",                      :precision => 10, :scale => 5, :default => 0.0, :null => false
    t.decimal "fneuprice8",                      :precision => 10, :scale => 5, :default => 0.0, :null => false
    t.decimal "fneuprice9",                      :precision => 10, :scale => 5, :default => 0.0, :null => false
    t.string  "fcdescript",       :limit => 35,                                 :default => " ", :null => false
    t.binary  "timestamp_column"
    t.string  "fac",              :limit => 20,                                 :default => " ", :null => false
  end

  add_index "incntpt", ["fccontkey", "fpartno", "frev", "fac"], :name => "contpartno"
  add_index "incntpt", ["fpartno", "frev", "fac"], :name => "partno"
  add_index "incntpt", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "incntr", :primary_key => "identity_column", :force => true do |t|
    t.string   "fccontkey",        :limit => 10,                                :default => " ",                   :null => false
    t.string   "fcdesc",           :limit => 25,                                :default => " ",                   :null => false
    t.string   "fcustno",          :limit => 6,                                 :default => " ",                   :null => false
    t.datetime "fdcreatedt",                                                    :default => '1900-01-01 00:00:00', :null => false
    t.datetime "fdeffdate",                                                     :default => '1900-01-01 00:00:00', :null => false
    t.datetime "fdexpdate",                                                     :default => '1900-01-01 00:00:00', :null => false
    t.string   "fccurid",          :limit => 3,                                 :default => " ",                   :null => false
    t.decimal  "fnfactor",                       :precision => 17, :scale => 5, :default => 0.0,                   :null => false
    t.datetime "fdfactdate",                                                    :default => '1900-01-01 00:00:00', :null => false
    t.datetime "fdeurodate",                                                    :default => '1900-01-01 00:00:00', :null => false
    t.string   "fcentered",        :limit => 3,                                 :default => " ",                   :null => false
    t.string   "fcompany",         :limit => 35,                                :default => " ",                   :null => false
    t.binary   "timestamp_column"
    t.decimal  "FEUROFCTR",                      :precision => 18, :scale => 5, :default => 0.0,                   :null => false
  end

  add_index "incntr", ["fccontkey"], :name => "fccontkey"
  add_index "incntr", ["fcustno"], :name => "fcustno"
  add_index "incntr", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "incros", :primary_key => "identity_column", :force => true do |t|
    t.string "fcrosspart",       :limit => 25,                  :null => false
    t.string "fcrossrev",        :limit => 3,                   :null => false
    t.string "fnumber",          :limit => 6,                   :null => false
    t.string "fpartno",          :limit => 25,                  :null => false
    t.string "fcpartrev",        :limit => 3,                   :null => false
    t.string "fctype",           :limit => 1,                   :null => false
    t.binary "timestamp_column"
    t.string "fac",              :limit => 20,                  :null => false
    t.string "crossfac",         :limit => 20,                  :null => false
    t.string "fcudrev",          :limit => 3,  :default => " ", :null => false
    t.string "fcrossudrv",       :limit => 3
  end

  add_index "incros", ["fac", "fpartno", "fcpartrev", "fctype", "fnumber", "crossfac", "fcrosspart"], :name => "PARTNO"
  add_index "incros", ["fctype", "fnumber", "crossfac", "fcrosspart", "fcrossrev"], :name => "TYPE"
  add_index "incros", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "incyccnt", :primary_key => "identity_column", :force => true do |t|
    t.string  "fcabc",            :limit => 1,                                                   :null => false
    t.string  "fcbinmax",         :limit => 14,                                                  :null => false
    t.string  "fcbinmin",         :limit => 14,                                                  :null => false
    t.string  "fcdatefreq",       :limit => 1,                                                   :null => false
    t.string  "fcdescr",          :limit => 30,                               :default => " ",   :null => false
    t.string  "fcgroup",          :limit => 6,                                                   :null => false
    t.string  "fclocation",       :limit => 14,                                                  :null => false
    t.string  "fcmaxmindf",       :limit => 1,                                                   :null => false
    t.string  "fcprodcl",         :limit => 2,                                                   :null => false
    t.string  "fcrule",           :limit => 10,                                                  :null => false
    t.string  "fcsource",         :limit => 1,                                                   :null => false
    t.string  "fcstatus",         :limit => 1,                                                   :null => false
    t.boolean "flabc",                                                                           :null => false
    t.boolean "flgroup",                                                                         :null => false
    t.boolean "fllocation",                                                                      :null => false
    t.boolean "fllot",                                                                           :null => false
    t.boolean "flmaxcount",                                                                      :null => false
    t.boolean "flnegbal",                                                                        :null => false
    t.boolean "flprodcl",                                                                        :null => false
    t.boolean "flsafety",                                                                        :null => false
    t.boolean "flsource",                                                                        :null => false
    t.boolean "flvalue",                                                                         :null => false
    t.integer "fnbasedon",                                                                       :null => false
    t.integer "fncountmax",                                                                      :null => false
    t.integer "fnmaxmin",                                                                        :null => false
    t.decimal "fnminvalue",                                                                      :null => false
    t.decimal "fnsamerror",                     :precision => 7, :scale => 3,                    :null => false
    t.binary  "timestamp_column"
    t.string  "fac",              :limit => 20,                                                  :null => false
    t.string  "fcpartmin",        :limit => 25,                               :default => " ",   :null => false
    t.string  "fcpartmax",        :limit => 25,                               :default => " ",   :null => false
    t.string  "fcrevmax",         :limit => 3,                                :default => " ",   :null => false
    t.string  "fcrevmin",         :limit => 3,                                :default => " ",   :null => false
    t.boolean "flpartno",                                                     :default => false, :null => false
  end

  add_index "incyccnt", ["fcdescr"], :name => "descript"
  add_index "incyccnt", ["fcrule", "fac"], :name => "rule", :unique => true
  add_index "incyccnt", ["fcstatus"], :name => "status"
  add_index "incyccnt", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "indetl", :primary_key => "identity_column", :force => true do |t|
    t.string   "fcpartno",         :limit => 25,                                :default => " ",                   :null => false
    t.string   "fcpartrev",        :limit => 3,                                 :default => " ",                   :null => false
    t.string   "fclocation",       :limit => 14,                                :default => " ",                   :null => false
    t.string   "fcbinno",          :limit => 14,                                :default => " ",                   :null => false
    t.string   "fclot",            :limit => 20,                                :default => " ",                   :null => false
    t.datetime "fdtrdate",                                                      :default => '1900-01-01 00:00:00', :null => false
    t.decimal  "fnmatlcost",                     :precision => 17, :scale => 5, :default => 0.0,                   :null => false
    t.decimal  "fnlabcost",                      :precision => 17, :scale => 5, :default => 0.0,                   :null => false
    t.decimal  "fnovhdcost",                     :precision => 17, :scale => 5, :default => 0.0,                   :null => false
    t.decimal  "fndctax",                        :precision => 17, :scale => 5, :default => 0.0,                   :null => false
    t.decimal  "fndcduty",                       :precision => 17, :scale => 5, :default => 0.0,                   :null => false
    t.decimal  "fndcfreight",                    :precision => 17, :scale => 5, :default => 0.0,                   :null => false
    t.decimal  "fndcmisc",                       :precision => 17, :scale => 5, :default => 0.0,                   :null => false
    t.binary   "timestamp_column"
    t.string   "fac",              :limit => 20,                                                                   :null => false
    t.string   "fcudrev",          :limit => 3,                                 :default => " ",                   :null => false
  end

  add_index "indetl", ["fcpartno", "fcpartrev", "fclocation", "fcbinno", "fclot", "fdtrdate", "fac"], :name => "LOCADATE"
  add_index "indetl", ["fcpartno", "fcpartrev", "fdtrdate", "fac"], :name => "PARTDATE"
  add_index "indetl", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "ingrpc", :primary_key => "identity_column", :force => true do |t|
    t.string  "fgc_number",       :limit => 6,                                                 :null => false
    t.string  "fgc_desc",         :limit => 65,                               :default => " ", :null => false
    t.string  "fpc_desc",         :limit => 65,                               :default => " ", :null => false
    t.decimal "sc01",                           :precision => 7, :scale => 3,                  :null => false
    t.decimal "sc02",                           :precision => 7, :scale => 3,                  :null => false
    t.decimal "sc03",                           :precision => 7, :scale => 3,                  :null => false
    t.decimal "sc04",                           :precision => 7, :scale => 3,                  :null => false
    t.decimal "sc05",                           :precision => 7, :scale => 3,                  :null => false
    t.decimal "sc06",                           :precision => 7, :scale => 3,                  :null => false
    t.decimal "sc07",                           :precision => 7, :scale => 3,                  :null => false
    t.decimal "sc08",                           :precision => 7, :scale => 3,                  :null => false
    t.decimal "sc09",                           :precision => 7, :scale => 3,                  :null => false
    t.decimal "sc10",                           :precision => 7, :scale => 3,                  :null => false
    t.decimal "sc11",                           :precision => 7, :scale => 3,                  :null => false
    t.decimal "sc12",                           :precision => 7, :scale => 3,                  :null => false
    t.decimal "sc13",                           :precision => 7, :scale => 3,                  :null => false
    t.decimal "sc14",                           :precision => 7, :scale => 3,                  :null => false
    t.decimal "sc15",                           :precision => 7, :scale => 3,                  :null => false
    t.decimal "sc16",                           :precision => 7, :scale => 3,                  :null => false
    t.decimal "sc17",                           :precision => 7, :scale => 3,                  :null => false
    t.decimal "sc18",                           :precision => 7, :scale => 3,                  :null => false
    t.decimal "sc19",                           :precision => 7, :scale => 3,                  :null => false
    t.decimal "sc20",                           :precision => 7, :scale => 3,                  :null => false
    t.decimal "sc21",                           :precision => 7, :scale => 3,                  :null => false
    t.decimal "sc22",                           :precision => 7, :scale => 3,                  :null => false
    t.decimal "sc23",                           :precision => 7, :scale => 3,                  :null => false
    t.decimal "sc24",                           :precision => 7, :scale => 3,                  :null => false
    t.decimal "sc25",                           :precision => 7, :scale => 3,                  :null => false
    t.decimal "sc26",                           :precision => 7, :scale => 3,                  :null => false
    t.decimal "sc27",                           :precision => 7, :scale => 3,                  :null => false
    t.decimal "sc28",                           :precision => 7, :scale => 3,                  :null => false
    t.decimal "sc29",                           :precision => 7, :scale => 3,                  :null => false
    t.decimal "sc30",                           :precision => 7, :scale => 3,                  :null => false
    t.decimal "sc31",                           :precision => 7, :scale => 3,                  :null => false
    t.decimal "sc32",                           :precision => 7, :scale => 3,                  :null => false
    t.binary  "timestamp_column"
  end

  add_index "ingrpc", ["fgc_number"], :name => "group_"
  add_index "ingrpc", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "inland", :primary_key => "identity_column", :force => true do |t|
    t.string  "fpartno",          :limit => 25,                                                 :null => false
    t.string  "frev",             :limit => 3,                                                  :null => false
    t.string  "fvendno",          :limit => 6,                                                  :null => false
    t.decimal "fnfobamt",                       :precision => 17, :scale => 5,                  :null => false
    t.decimal "fnfreight",                      :precision => 17, :scale => 5,                  :null => false
    t.decimal "fnpfreight",                     :precision => 7,  :scale => 1,                  :null => false
    t.decimal "fnothcst1",                      :precision => 17, :scale => 5,                  :null => false
    t.decimal "fnpothcst1",                     :precision => 7,  :scale => 1,                  :null => false
    t.decimal "fnothcst2",                      :precision => 17, :scale => 5,                  :null => false
    t.decimal "fnpothcst2",                     :precision => 7,  :scale => 1,                  :null => false
    t.decimal "fnothcst3",                      :precision => 17, :scale => 5,                  :null => false
    t.decimal "fnpothcst3",                     :precision => 7,  :scale => 1,                  :null => false
    t.decimal "fnothcst4",                      :precision => 17, :scale => 5,                  :null => false
    t.decimal "fnpothcst4",                     :precision => 7,  :scale => 1,                  :null => false
    t.decimal "fnothcst5",                      :precision => 17, :scale => 5,                  :null => false
    t.decimal "fnpothcst5",                     :precision => 7,  :scale => 1,                  :null => false
    t.decimal "fnothcst6",                      :precision => 17, :scale => 5,                  :null => false
    t.decimal "fnpothcst6",                     :precision => 7,  :scale => 1,                  :null => false
    t.binary  "timestamp_column"
    t.string  "fac",              :limit => 20,                                                 :null => false
    t.string  "fcudrev",          :limit => 3,                                 :default => " ", :null => false
  end

  add_index "inland", ["fpartno", "frev", "fvendno", "fac"], :name => "inland"
  add_index "inland", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "inmast", :primary_key => "identity_column", :force => true do |t|
    t.string   "fpartno",          :limit => 25,                                                    :null => false
    t.string   "frev",             :limit => 3,                                                     :null => false
    t.string   "fcstscode",        :limit => 1,                                                     :null => false
    t.string   "fdescript",        :limit => 35,                                 :default => " ",   :null => false
    t.boolean  "flchgpnd",                                                                          :null => false
    t.string   "fmeasure",         :limit => 3,                                                     :null => false
    t.string   "fsource",          :limit => 1,                                                     :null => false
    t.decimal  "fonhand",                         :precision => 15, :scale => 5,                    :null => false
    t.decimal  "fleadtime",                       :precision => 7,  :scale => 1,                    :null => false
    t.decimal  "fprice",                          :precision => 17, :scale => 5,                    :null => false
    t.decimal  "fstdcost",                        :precision => 17, :scale => 5,                    :null => false
    t.decimal  "f2totcost",                       :precision => 17, :scale => 5,                    :null => false
    t.decimal  "flastcost",                       :precision => 17, :scale => 5,                    :null => false
    t.string   "flocate1",         :limit => 14,                                                    :null => false
    t.string   "fbin1",            :limit => 14,                                                    :null => false
    t.string   "f2costcode",       :limit => 1,                                                     :null => false
    t.decimal  "f2displcst",                      :precision => 17, :scale => 5,                    :null => false
    t.decimal  "f2dispmcst",                      :precision => 17, :scale => 5,                    :null => false
    t.decimal  "f2dispocst",                      :precision => 17, :scale => 5,                    :null => false
    t.decimal  "f2disptcst",                      :precision => 17, :scale => 5,                    :null => false
    t.decimal  "f2labcost",                       :precision => 17, :scale => 5,                    :null => false
    t.decimal  "f2matlcost",                      :precision => 17, :scale => 5,                    :null => false
    t.decimal  "f2ovhdcost",                      :precision => 17, :scale => 5,                    :null => false
    t.decimal  "favgcost",                        :precision => 17, :scale => 5,                    :null => false
    t.decimal  "fbook",                           :precision => 15, :scale => 5,                    :null => false
    t.string   "fbulkissue",       :limit => 1,                                                     :null => false
    t.string   "fbuyer",           :limit => 3,                                                     :null => false
    t.string   "fcalc_lead",       :limit => 1,                                                     :null => false
    t.string   "fcbackflsh",       :limit => 1,                                                     :null => false
    t.integer  "fcnts",            :limit => nil, :precision => 2,  :scale => 0,                    :null => false
    t.string   "fcopymemo",        :limit => 1,                                                     :null => false
    t.string   "fcostcode",        :limit => 1,                                                     :null => false
    t.string   "fcpurchase",       :limit => 1,                                                     :null => false
    t.decimal  "fcstperinv",                      :precision => 13, :scale => 9,                    :null => false
    t.decimal  "fdisplcost",                      :precision => 17, :scale => 5,                    :null => false
    t.decimal  "fdispmcost",                      :precision => 17, :scale => 5,                    :null => false
    t.decimal  "fdispocost",                      :precision => 17, :scale => 5,                    :null => false
    t.decimal  "fdispprice",                      :precision => 17, :scale => 5,                    :null => false
    t.decimal  "fdisptcost",                      :precision => 17, :scale => 5,                    :null => false
    t.string   "fdrawno",          :limit => 25,                                                    :null => false
    t.string   "fdrawsize",        :limit => 2,                                                     :null => false
    t.decimal  "fendqty1",                        :precision => 15, :scale => 5,                    :null => false
    t.decimal  "fendqty10",                       :precision => 17, :scale => 5,                    :null => false
    t.decimal  "fendqty11",                       :precision => 17, :scale => 5,                    :null => false
    t.decimal  "fendqty12",                       :precision => 17, :scale => 5,                    :null => false
    t.decimal  "fendqty2",                        :precision => 17, :scale => 5,                    :null => false
    t.decimal  "fendqty3",                        :precision => 17, :scale => 5,                    :null => false
    t.decimal  "fendqty4",                        :precision => 17, :scale => 5,                    :null => false
    t.decimal  "fendqty5",                        :precision => 17, :scale => 5,                    :null => false
    t.decimal  "fendqty6",                        :precision => 17, :scale => 5,                    :null => false
    t.decimal  "fendqty7",                        :precision => 17, :scale => 5,                    :null => false
    t.decimal  "fendqty8",                        :precision => 17, :scale => 5,                    :null => false
    t.decimal  "fendqty9",                        :precision => 17, :scale => 5,                    :null => false
    t.string   "fgroup",           :limit => 6,                                                     :null => false
    t.string   "finspect",         :limit => 1,                                                     :null => false
    t.decimal  "flabcost",                        :precision => 17, :scale => 5,                    :null => false
    t.string   "flasteoc",         :limit => 25,                                                    :null => false
    t.datetime "flastiss",                                                                          :null => false
    t.datetime "flastrcpt",                                                                         :null => false
    t.datetime "flct",                                                                              :null => false
    t.boolean  "fllotreqd",                                                                         :null => false
    t.decimal  "fmatlcost",                       :precision => 17, :scale => 5,                    :null => false
    t.string   "fmeasure2",        :limit => 3,                                                     :null => false
    t.decimal  "fmtdiss",                         :precision => 15, :scale => 5,                    :null => false
    t.decimal  "fmtdrcpt",                        :precision => 15, :scale => 5,                    :null => false
    t.decimal  "fnweight",                        :precision => 10, :scale => 3,                    :null => false
    t.decimal  "fonorder",                        :precision => 15, :scale => 5,                    :null => false
    t.decimal  "fovhdcost",                       :precision => 17, :scale => 5,                    :null => false
    t.string   "fprodcl",          :limit => 2,                                                     :null => false
    t.decimal  "fproqty",                         :precision => 15, :scale => 5,                    :null => false
    t.decimal  "fqtyinspec",                      :precision => 15, :scale => 5,                    :null => false
    t.decimal  "freordqty",                       :precision => 15, :scale => 5,                    :null => false
    t.datetime "frevdt",                                                                            :null => false
    t.string   "frolledup",        :limit => 1,                                                     :null => false
    t.decimal  "fsafety",                         :precision => 15, :scale => 5,                    :null => false
    t.string   "fschecode",        :limit => 6,                                                     :null => false
    t.decimal  "fuprodtime",                      :precision => 9,  :scale => 3,                    :null => false
    t.decimal  "fyield",                          :precision => 8,  :scale => 3,                    :null => false
    t.decimal  "fytdiss",                         :precision => 15, :scale => 5,                    :null => false
    t.decimal  "fytdrcpt",                        :precision => 15, :scale => 5,                    :null => false
    t.string   "fabccode",         :limit => 1,                                                     :null => false
    t.boolean  "ftaxable",                                                                          :null => false
    t.string   "fcusrchr1",        :limit => 20,                                                    :null => false
    t.string   "fcusrchr2",        :limit => 40,                                 :default => " ",   :null => false
    t.string   "fcusrchr3",        :limit => 40,                                 :default => " ",   :null => false
    t.decimal  "fnusrqty1",                       :precision => 15, :scale => 5,                    :null => false
    t.decimal  "fnusrcur1",                       :precision => 17, :scale => 5,                    :null => false
    t.datetime "fdusrdate1",                                                                        :null => false
    t.string   "fcdncfile",        :limit => 80,                                 :default => " ",   :null => false
    t.string   "fccadfile1",       :limit => 250,                                                   :null => false
    t.string   "fccadfile2",       :limit => 250,                                                   :null => false
    t.string   "fccadfile3",       :limit => 250,                                                   :null => false
    t.string   "fclotext",         :limit => 1,                                                     :null => false
    t.boolean  "flexpreqd",                                                                         :null => false
    t.datetime "fdlastpc",                                                                          :null => false
    t.string   "fschedtype",       :limit => 1,                                                     :null => false
    t.boolean  "fldctracke",                                                                        :null => false
    t.datetime "fddcrefdat",                                                                        :null => false
    t.decimal  "fndctax",                         :precision => 17, :scale => 5,                    :null => false
    t.decimal  "fndcduty",                        :precision => 17, :scale => 5,                    :null => false
    t.decimal  "fndcfreigh",                      :precision => 17, :scale => 5,                    :null => false
    t.decimal  "fndcmisc",                        :precision => 17, :scale => 5,                    :null => false
    t.string   "fcratedisc",       :limit => 1,                                                     :null => false
    t.boolean  "flconstrnt",                                                                        :null => false
    t.boolean  "flistaxabl",                                                                        :null => false
    t.string   "fcjrdict",         :limit => 10,                                                    :null => false
    t.boolean  "flaplpart",                                                                         :null => false
    t.boolean  "flfanpart",                                                                         :null => false
    t.integer  "fnfanaglvl",       :limit => nil, :precision => 5,  :scale => 0,                    :null => false
    t.string   "fcplnclass",       :limit => 1,                                                     :null => false
    t.string   "fcclass",          :limit => 12,                                                    :null => false
    t.integer  "fidims",                                                                            :null => false
    t.binary   "timestamp_column"
    t.text     "fcomment",                                                       :default => " ",   :null => false
    t.binary   "fgimage",                                                        :default => "0x",  :null => false
    t.text     "fmusrmemo1",                                                     :default => " ",   :null => false
    t.text     "fstdmemo",                                                       :default => " ",   :null => false
    t.string   "fac",              :limit => 20
    t.string   "sfac",             :limit => 20
    t.decimal  "itcfixed",                        :precision => 17, :scale => 5
    t.decimal  "itcunit",                         :precision => 17, :scale => 5
    t.decimal  "fnPOnHand",                       :precision => 16, :scale => 5, :default => 0.0,   :null => false
    t.decimal  "fnLndToMfg",                      :precision => 16, :scale => 5, :default => 0.0,   :null => false
    t.string   "fcudrev",          :limit => 3,                                  :default => " ",   :null => false
    t.boolean  "fluseudrev",                                                     :default => false, :null => false
    t.integer  "fndbrmod",         :limit => nil, :precision => 1,  :scale => 0, :default => 0,     :null => false
    t.integer  "fiPcsOnHd",                                                      :default => 0,     :null => false
    t.boolean  "flSendSLX",                                                                         :null => false
    t.string   "fcSLXProd",        :limit => 12,                                                    :null => false
    t.boolean  "flFSRtn",                                                                           :null => false
    t.decimal  "fnonnetqty",                      :precision => 15, :scale => 5, :default => 0.0,   :null => false
    t.decimal  "fnlatefact",                      :precision => 4,  :scale => 2,                    :null => false
    t.integer  "fnsobuf",          :limit => nil, :precision => 2,  :scale => 0,                    :null => false
    t.integer  "fnpurbuf",         :limit => nil, :precision => 2,  :scale => 0,                    :null => false
    t.boolean  "flcnstrpur",                                                                        :null => false
    t.datetime "fdvenfence",                                                                        :null => false
    t.boolean  "flLatefact",                                                                        :null => false
    t.boolean  "flSOBuf",                                                                           :null => false
    t.boolean  "flPurBuf",                                                                          :null => false
    t.boolean  "flHoldStoc",                                                                        :null => false
    t.decimal  "fnHoldStoc",                      :precision => 4,  :scale => 2,                    :null => false
    t.boolean  "ManualPlan",                                                                        :null => false
  end

  add_index "inmast", ["fbuyer"], :name => "buyer"
  add_index "inmast", ["fcstscode", "fac", "fpartno", "frev"], :name => "stscode"
  add_index "inmast", ["fdescript", "fac", "fpartno", "frev"], :name => "descpart"
  add_index "inmast", ["fgroup"], :name => "group_"
  add_index "inmast", ["fidims"], :name => "fiDims"
  add_index "inmast", ["fonhand"], :name => "onhand"
  add_index "inmast", ["fpartno", "frev", "fbuyer", "fac"], :name => "PLANNER"
  add_index "inmast", ["fprodcl"], :name => "prodclass"
  add_index "inmast", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "inmastar", :primary_key => "identity_column", :force => true do |t|
    t.string   "fac",              :limit => 20,                                :null => false
    t.string   "fpartno",          :limit => 25,                                :null => false
    t.string   "frev",             :limit => 3,                                 :null => false
    t.string   "fprodcl",          :limit => 2,                                 :null => false
    t.string   "fgroup",           :limit => 6,                                 :null => false
    t.string   "fmeasure",         :limit => 3,                                 :null => false
    t.string   "fcstscode",        :limit => 1,                                 :null => false
    t.decimal  "fleadtime",                      :precision => 7,  :scale => 1, :null => false
    t.string   "fdescript",        :limit => 35,                                :null => false
    t.string   "fsource",          :limit => 1,                                 :null => false
    t.string   "sfac",             :limit => 20,                                :null => false
    t.boolean  "flistaxabl",                                                    :null => false
    t.decimal  "fnweight",                       :precision => 10, :scale => 3, :null => false
    t.decimal  "fprice",                         :precision => 17, :scale => 5, :null => false
    t.boolean  "flSendSLX",                                                     :null => false
    t.string   "fcSLXProd",        :limit => 12,                                :null => false
    t.string   "fcchange",         :limit => 1,                                 :null => false
    t.integer  "fnkey",                                                         :null => false
    t.binary   "timestamp_column"
    t.datetime "fdarchive",                                                     :null => false
  end

  create_table "inmastdm", :primary_key => "identity_column", :force => true do |t|
    t.integer "fiinmastid",                                                     :default => 0,     :null => false
    t.integer "fium1"
    t.decimal "fnstdsize1",                      :precision => 18, :scale => 5
    t.decimal "fnminsize1",                      :precision => 18, :scale => 5
    t.integer "fium2"
    t.decimal "fnstdsize2",                      :precision => 18, :scale => 5
    t.decimal "fnminsize2",                      :precision => 18, :scale => 5
    t.integer "fium3"
    t.decimal "fnstdsize3",                      :precision => 18, :scale => 5
    t.decimal "fnminsize3",                      :precision => 18, :scale => 5
    t.integer "fium4"
    t.decimal "fnstdsize4",                      :precision => 18, :scale => 5
    t.decimal "fnminsize4",                      :precision => 18, :scale => 5
    t.integer "fium5"
    t.decimal "fnstdsize5",                      :precision => 18, :scale => 5
    t.decimal "fnminsize5",                      :precision => 18, :scale => 5
    t.boolean "flformula",                                                      :default => false, :null => false
    t.string  "fcformula",        :limit => 254,                                :default => " ",   :null => false
    t.boolean "flusemdi",                                                       :default => false, :null => false
    t.decimal "fnminqty",                        :precision => 18, :scale => 5, :default => 0.0,   :null => false
    t.decimal "fnmaxqty",                        :precision => 18, :scale => 5, :default => 0.0,   :null => false
    t.integer "filocation"
    t.string  "fcbin",            :limit => 14,                                 :default => " ",   :null => false
    t.boolean "flnocntptls",                                                    :default => false, :null => false
    t.integer "fiunitcntum",                                                    :default => 0,     :null => false
    t.binary  "timestamp_column"
  end

  add_index "inmastdm", ["identity_column"], :name => "identity_column_idx", :unique => true

  create_table "inmastsx", :primary_key => "identity_column", :force => true do |t|
    t.string  "fac",              :limit => 20,                 :null => false
    t.string  "fpartno",          :limit => 25, :default => "", :null => false
    t.string  "frev",             :limit => 3,  :default => "", :null => false
    t.string  "fcchange",         :limit => 1,  :default => "", :null => false
    t.integer "fnkey",                          :default => 0,  :null => false
    t.string  "fcSLXProd",        :limit => 12, :default => "", :null => false
    t.binary  "timestamp_column"
  end

  add_index "inmastsx", ["fpartno", "frev", "fac"], :name => "lookupkey"
  add_index "inmastsx", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "inonhd", :primary_key => "identity_column", :force => true do |t|
    t.string   "fpartno",          :limit => 25,                                                 :null => false
    t.string   "fpartrev",         :limit => 3,                                                  :null => false
    t.string   "fbinno",           :limit => 14,                                                 :null => false
    t.string   "flocation",        :limit => 14,                                                 :null => false
    t.datetime "fexpdate",                                                                       :null => false
    t.string   "flot",             :limit => 20,                                                 :null => false
    t.decimal  "fonhand",                        :precision => 15, :scale => 5,                  :null => false
    t.binary   "timestamp_column"
    t.string   "fac",              :limit => 20,                                                 :null => false
    t.string   "fcudrev",          :limit => 3,                                 :default => " ", :null => false
  end

  add_index "inonhd", ["fpartno", "fpartrev", "flocation", "fbinno", "flot", "fac"], :name => "PARTLOCA", :unique => true
  add_index "inonhd", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "inopds", :primary_key => "identity_column", :force => true do |t|
    t.string  "fdescnum",         :limit => 4,                                                  :null => false
    t.string  "fcpro_id",         :limit => 7,                                                  :null => false
    t.decimal "fnstd_prod",                     :precision => 11, :scale => 6,                  :null => false
    t.decimal "fnstd_set",                      :precision => 7,  :scale => 2,                  :null => false
    t.binary  "timestamp_column"
    t.text    "fopmemo",                                                       :default => " ", :null => false
    t.string  "fac",              :limit => 20,                                                 :null => false
  end

  add_index "inopds", ["fdescnum"], :name => "descnum"
  add_index "inopds", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "inphindl", :primary_key => "identity_column", :force => true do |t|
    t.integer "fitype",                                                                        :null => false
    t.integer "fiqty",                                                                         :null => false
    t.boolean "flpartial",                                                                     :null => false
    t.integer "fium1"
    t.decimal "fnsize1",                        :precision => 18, :scale => 5
    t.integer "fium2"
    t.decimal "fnsize2",                        :precision => 18, :scale => 5
    t.integer "fium3"
    t.decimal "fnsize3",                        :precision => 18, :scale => 5
    t.integer "fium4"
    t.decimal "fnsize4",                        :precision => 18, :scale => 5
    t.integer "fium5"
    t.decimal "fnsize5",                        :precision => 18, :scale => 5
    t.binary  "timestamp_column"
    t.integer "fiTagNo",                                                       :default => 0,  :null => false
    t.string  "fac",              :limit => 20,                                :default => "", :null => false
    t.integer "fiphyinvid",                                                    :default => 0,  :null => false
  end

  add_index "inphindl", ["fiTagNo", "fitype"], :name => "TagType"
  add_index "inphindl", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "inphyinv", :primary_key => "identity_column", :force => true do |t|
    t.string   "fcappby",          :limit => 3,                                                   :null => false
    t.string   "fcarea",           :limit => 20,                                                  :null => false
    t.string   "fcbin",            :limit => 14,                                                  :null => false
    t.string   "fccountby",        :limit => 3,                                                   :null => false
    t.string   "fcdescr",          :limit => 35,                                 :default => " ", :null => false
    t.string   "fcentby",          :limit => 3,                                                   :null => false
    t.string   "fcissuedto",       :limit => 3,                                                   :null => false
    t.string   "fcjobno",          :limit => 10,                                                  :null => false
    t.string   "fcloc",            :limit => 14,                                                  :null => false
    t.string   "fclot",            :limit => 20,                                                  :null => false
    t.string   "fcpartno",         :limit => 25,                                                  :null => false
    t.string   "fcrev",            :limit => 3,                                                   :null => false
    t.string   "fcprodcl",         :limit => 2,                                                   :null => false
    t.string   "fcsite",           :limit => 10,                                                  :null => false
    t.string   "fcstatus",         :limit => 1,                                                   :null => false
    t.string   "fcstkuom",         :limit => 3,                                                   :null => false
    t.string   "fcuom",            :limit => 3,                                                   :null => false
    t.datetime "fddate",                                                                          :null => false
    t.datetime "fdexpdate",                                                                       :null => false
    t.boolean  "fliserror",                                                                       :null => false
    t.boolean  "fliswip",                                                                         :null => false
    t.decimal  "fnconvrate",                      :precision => 11, :scale => 5,                  :null => false
    t.decimal  "fncount",                         :precision => 17, :scale => 5,                  :null => false
    t.integer  "fnoperno",         :limit => nil, :precision => 4,  :scale => 0,                  :null => false
    t.decimal  "fnonhand",                        :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fnpcnt",                          :precision => 7,  :scale => 2,                  :null => false
    t.decimal  "fnqtyapp",                        :precision => 17, :scale => 5,                  :null => false
    t.integer  "fntag",                                                                           :null => false
    t.decimal  "fnunitcost",                      :precision => 17, :scale => 5,                  :null => false
    t.boolean  "flisprepop",                                                                      :null => false
    t.boolean  "flisprinted",                                                                     :null => false
    t.datetime "fdfinish",                                                                        :null => false
    t.binary   "timestamp_column"
    t.text     "fmdescr",                                                        :default => " ", :null => false
    t.string   "fac",              :limit => 20,                                                  :null => false
    t.string   "fcudrev",          :limit => 3,                                  :default => " ", :null => false
  end

  add_index "inphyinv", ["fcarea"], :name => "area"
  add_index "inphyinv", ["fcissuedto"], :name => "issuedto"
  add_index "inphyinv", ["fcjobno", "fnoperno"], :name => "JOBORDER"
  add_index "inphyinv", ["fcloc", "fcbin", "fclot"], :name => "LOCATION"
  add_index "inphyinv", ["fcpartno", "fcrev", "fntag", "fac"], :name => "parttag"
  add_index "inphyinv", ["fcstatus"], :name => "status"
  add_index "inphyinv", ["fntag", "fac"], :name => "tagno", :unique => true
  add_index "inphyinv", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "inphyset", :primary_key => "identity_column", :force => true do |t|
    t.string   "fcarmethod",       :limit => 1,  :null => false
    t.string   "fchowabc",         :limit => 1,  :null => false
    t.string   "fcmethod",         :limit => 1,  :null => false
    t.string   "fcnotcount",       :limit => 1,  :null => false
    t.datetime "fdfreeze",                       :null => false
    t.datetime "fdpostgl",                       :null => false
    t.datetime "fdunfreeze",                     :null => false
    t.boolean  "fladdlots",                      :null => false
    t.boolean  "flupabc",                        :null => false
    t.decimal  "fnaamt",                         :null => false
    t.decimal  "fnbamt",                         :null => false
    t.integer  "fnatimes",                       :null => false
    t.integer  "fnbtimes",                       :null => false
    t.boolean  "flinv",                          :null => false
    t.boolean  "flinvstock",                     :null => false
    t.boolean  "flinvnoobs",                     :null => false
    t.boolean  "flloc",                          :null => false
    t.boolean  "fllocstock",                     :null => false
    t.boolean  "fllocnoobs",                     :null => false
    t.binary   "timestamp_column"
    t.string   "fac",              :limit => 20, :null => false
  end

  add_index "inphyset", ["fac"], :name => "facility"
  add_index "inphyset", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "inphytag", :primary_key => "identity_column", :force => true do |t|
    t.string   "fcarea",           :limit => 20, :null => false
    t.string   "fcissuedto",       :limit => 3,  :null => false
    t.string   "fcsite",           :limit => 10, :null => false
    t.string   "fcstatus",         :limit => 1,  :null => false
    t.string   "fctype",           :limit => 1,  :null => false
    t.datetime "fdphydate",                      :null => false
    t.boolean  "fladdtags",                      :null => false
    t.integer  "fnmintag",                       :null => false
    t.integer  "fnmaxtag",                       :null => false
    t.binary   "timestamp_column"
    t.string   "fac",              :limit => 20, :null => false
  end

  add_index "inphytag", ["fcissuedto"], :name => "issuedto"
  add_index "inphytag", ["fcsite"], :name => "site"
  add_index "inphytag", ["fcstatus"], :name => "status"
  add_index "inphytag", ["fctype"], :name => "type"
  add_index "inphytag", ["fdphydate"], :name => "datefreeze"
  add_index "inphytag", ["fnmintag", "fac"], :name => "tagnos", :unique => true
  add_index "inphytag", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "inprod", :primary_key => "identity_column", :force => true do |t|
    t.string "fpc_number",       :limit => 2,                   :null => false
    t.string "fcinvadj",         :limit => 25,                  :null => false
    t.string "fcogslab",         :limit => 25,                  :null => false
    t.string "fcogsmatl",        :limit => 25,                  :null => false
    t.string "fcogsothr",        :limit => 25,                  :null => false
    t.string "fcogsovhd",        :limit => 25,                  :null => false
    t.string "finvacc",          :limit => 25,                  :null => false
    t.string "flabacc",          :limit => 25,                  :null => false
    t.string "flabrvarac",       :limit => 25,                  :null => false
    t.string "fmatlacc",         :limit => 25,                  :null => false
    t.string "fmatlvarac",       :limit => 25,                  :null => false
    t.string "fothracc",         :limit => 25,                  :null => false
    t.string "fothrvarac",       :limit => 25,                  :null => false
    t.string "fovhdacc",         :limit => 25,                  :null => false
    t.string "fovhdvarac",       :limit => 25,                  :null => false
    t.string "fpc_desc",         :limit => 55, :default => " ", :null => false
    t.string "fpc_name",         :limit => 12,                  :null => false
    t.string "fpurcvarac",       :limit => 25,                  :null => false
    t.string "frevalacc",        :limit => 25,                  :null => false
    t.string "frevenue",         :limit => 25,                  :null => false
    t.string "fschecode",        :limit => 6,                   :null => false
    t.string "fschedtype",       :limit => 1,                   :null => false
    t.binary "timestamp_column"
    t.string "fInvTrans",        :limit => 25, :default => " ", :null => false
    t.string "fac",              :limit => 20,                  :null => false
    t.string "fintracc",         :limit => 25, :default => "",  :null => false
    t.string "fcogscomms",       :limit => 25, :default => "",  :null => false
  end

  add_index "inprod", ["finvacc"], :name => "invacct"
  add_index "inprod", ["fpc_name"], :name => "name"
  add_index "inprod", ["fpc_number", "fac"], :name => "ProdCl"
  add_index "inprod", ["fschecode"], :name => "sched"
  add_index "inprod", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "inprsc", :primary_key => "identity_column", :force => true do |t|
    t.string  "fschecode",        :limit => 25,                                                 :null => false
    t.string  "fcpartrev",        :limit => 3,                                                  :null => false
    t.string  "fadjust",          :limit => 1,                                                  :null => false
    t.decimal "fadjust1",                       :precision => 17, :scale => 5,                  :null => false
    t.decimal "fadjust2",                       :precision => 17, :scale => 5,                  :null => false
    t.decimal "fadjust3",                       :precision => 17, :scale => 5,                  :null => false
    t.decimal "fadjust4",                       :precision => 17, :scale => 5,                  :null => false
    t.decimal "fadjust5",                       :precision => 17, :scale => 5,                  :null => false
    t.decimal "fadjust6",                       :precision => 17, :scale => 5,                  :null => false
    t.decimal "fadjust7",                       :precision => 17, :scale => 5,                  :null => false
    t.decimal "fadjust8",                       :precision => 17, :scale => 5,                  :null => false
    t.decimal "fadjust9",                       :precision => 17, :scale => 5,                  :null => false
    t.string  "fpricmeth",        :limit => 1,                                                  :null => false
    t.string  "frange",           :limit => 1,                                                  :null => false
    t.decimal "frange1",                        :precision => 15, :scale => 5,                  :null => false
    t.decimal "frange2",                        :precision => 15, :scale => 5,                  :null => false
    t.decimal "frange3",                        :precision => 15, :scale => 5,                  :null => false
    t.decimal "frange4",                        :precision => 15, :scale => 5,                  :null => false
    t.decimal "frange5",                        :precision => 15, :scale => 5,                  :null => false
    t.decimal "frange6",                        :precision => 15, :scale => 5,                  :null => false
    t.decimal "frange7",                        :precision => 15, :scale => 5,                  :null => false
    t.decimal "frange8",                        :precision => 15, :scale => 5,                  :null => false
    t.decimal "frange9",                        :precision => 15, :scale => 5,                  :null => false
    t.string  "fschename",        :limit => 35,                                :default => " ", :null => false
    t.string  "fsalescode",       :limit => 7,                                                  :null => false
    t.string  "fschedtype",       :limit => 1,                                                  :null => false
    t.binary  "timestamp_column"
    t.string  "fac",              :limit => 20,                                                 :null => false
    t.string  "fcudrev",          :limit => 3,                                 :default => " ", :null => false
  end

  add_index "inprsc", ["fsalescode", "fac", "fschecode", "fcpartrev"], :name => "partcode"
  add_index "inprsc", ["fschecode", "fcpartrev", "fac"], :name => "schecode"
  add_index "inprsc", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "inresc", :primary_key => "identity_column", :force => true do |t|
    t.string  "fcres_name",       :limit => 16,                                :null => false
    t.string  "fcres_id",         :limit => 7,                                 :null => false
    t.string  "fcres_type",       :limit => 25,                                :null => false
    t.integer "fnmaxops",         :limit => nil, :precision => 3, :scale => 0, :null => false
    t.binary  "timestamp_column"
    t.string  "fac",              :limit => 20,                                :null => false
  end

  add_index "inresc", ["fcres_id", "fac"], :name => "res_id"
  add_index "inresc", ["fcres_name", "fac"], :name => "res_name"
  add_index "inresc", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "inrtga", :primary_key => "identity_column", :force => true do |t|
    t.string  "fpartno",          :limit => 25,                                                   :null => false
    t.string  "fcpartrev",        :limit => 3,                                                    :null => false
    t.integer "foperno",          :limit => nil, :precision => 4,  :scale => 0,                   :null => false
    t.string  "fcres_id",         :limit => 7,                                                    :null => false
    t.integer "fnsimulops",                                                                       :null => false
    t.decimal "fsetuptime",                      :precision => 7,  :scale => 2,                   :null => false
    t.decimal "fprodtime",                       :precision => 16, :scale => 10,                  :null => false
    t.string  "fac",              :limit => 20,                                                   :null => false
    t.string  "fcudrev",          :limit => 3,                                                    :null => false
    t.integer "fndbrmod",         :limit => nil, :precision => 1,  :scale => 0,                   :null => false
    t.binary  "timestamp_column"
    t.decimal "fmovetime",                       :precision => 8,  :scale => 2,  :default => 0.0, :null => false
    t.decimal "felpstime",                       :precision => 12, :scale => 5,  :default => 0.0, :null => false
  end

  add_index "inrtga", ["fpartno", "fcpartrev", "fac"], :name => "PARTOPER"
  add_index "inrtga", ["fpartno", "fcpartrev", "foperno", "fcres_id", "fac"], :name => "PARTOPID"
  add_index "inrtga", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "inrtgc", :primary_key => "identity_column", :force => true do |t|
    t.string   "fpartno",          :limit => 25,                                                  :null => false
    t.string   "fcpartrev",        :limit => 3,                                                   :null => false
    t.integer  "fbatch01",         :limit => nil, :precision => 6,  :scale => 0,                  :null => false
    t.integer  "fbatch02",         :limit => nil, :precision => 6,  :scale => 0,                  :null => false
    t.integer  "fbatch03",         :limit => nil, :precision => 6,  :scale => 0,                  :null => false
    t.integer  "fbatch04",         :limit => nil, :precision => 6,  :scale => 0,                  :null => false
    t.integer  "fbatch05",         :limit => nil, :precision => 6,  :scale => 0,                  :null => false
    t.integer  "fbatch06",         :limit => nil, :precision => 6,  :scale => 0,                  :null => false
    t.integer  "fbatch07",         :limit => nil, :precision => 6,  :scale => 0,                  :null => false
    t.integer  "fbatch08",         :limit => nil, :precision => 6,  :scale => 0,                  :null => false
    t.integer  "fbatch09",         :limit => nil, :precision => 6,  :scale => 0,                  :null => false
    t.integer  "fbatch10",         :limit => nil, :precision => 6,  :scale => 0,                  :null => false
    t.integer  "fbatch11",         :limit => nil, :precision => 6,  :scale => 0,                  :null => false
    t.integer  "fbatch12",         :limit => nil, :precision => 6,  :scale => 0,                  :null => false
    t.decimal  "ffixcost",                        :precision => 17, :scale => 5,                  :null => false
    t.decimal  "flabcost",                        :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fmax01",                          :precision => 15, :scale => 5,                  :null => false
    t.decimal  "fmax02",                          :precision => 15, :scale => 5,                  :null => false
    t.decimal  "fmax03",                          :precision => 15, :scale => 5,                  :null => false
    t.decimal  "fmax04",                          :precision => 15, :scale => 5,                  :null => false
    t.decimal  "fmax05",                          :precision => 15, :scale => 5,                  :null => false
    t.decimal  "fmax06",                          :precision => 15, :scale => 5,                  :null => false
    t.decimal  "fmax07",                          :precision => 15, :scale => 5,                  :null => false
    t.decimal  "fmax08",                          :precision => 15, :scale => 5,                  :null => false
    t.decimal  "fmax09",                          :precision => 15, :scale => 5,                  :null => false
    t.decimal  "fmax10",                          :precision => 15, :scale => 5,                  :null => false
    t.decimal  "fmax11",                          :precision => 15, :scale => 5,                  :null => false
    t.decimal  "fmax12",                          :precision => 15, :scale => 5,                  :null => false
    t.decimal  "fothrcost",                       :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fovrhdcos",                       :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fqty01",                          :precision => 15, :scale => 5,                  :null => false
    t.decimal  "fqty02",                          :precision => 15, :scale => 5,                  :null => false
    t.decimal  "fqty03",                          :precision => 15, :scale => 5,                  :null => false
    t.decimal  "fqty04",                          :precision => 15, :scale => 5,                  :null => false
    t.decimal  "fqty05",                          :precision => 15, :scale => 5,                  :null => false
    t.decimal  "fqty06",                          :precision => 15, :scale => 5,                  :null => false
    t.decimal  "fqty07",                          :precision => 15, :scale => 5,                  :null => false
    t.decimal  "fqty08",                          :precision => 15, :scale => 5,                  :null => false
    t.decimal  "fqty09",                          :precision => 15, :scale => 5,                  :null => false
    t.decimal  "fqty10",                          :precision => 15, :scale => 5,                  :null => false
    t.decimal  "fqty11",                          :precision => 15, :scale => 5,                  :null => false
    t.decimal  "fqty12",                          :precision => 15, :scale => 5,                  :null => false
    t.datetime "frev_date",                                                                       :null => false
    t.decimal  "fsetuplabc",                      :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fsetupovrc",                      :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fsetuptime",                      :precision => 14, :scale => 5,                  :null => false
    t.decimal  "fspq",                            :precision => 15, :scale => 5,                  :null => false
    t.string   "fstdrtg",          :limit => 1,                                                   :null => false
    t.decimal  "fsubcost",                        :precision => 17, :scale => 5,                  :null => false
    t.decimal  "ftottime",                        :precision => 14, :scale => 5,                  :null => false
    t.binary   "timestamp_column"
    t.string   "fac",              :limit => 20,                                                  :null => false
    t.string   "fcudrev",          :limit => 3,                                  :default => " ", :null => false
    t.integer  "fndbrmod",         :limit => nil, :precision => 1,  :scale => 0, :default => 0,   :null => false
  end

  add_index "inrtgc", ["fpartno", "fcpartrev", "fac"], :name => "PARTNO"
  add_index "inrtgc", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "inrtgr", :primary_key => "identity_column", :force => true do |t|
    t.string  "fpartno",          :limit => 25,                                                 :null => false
    t.string  "fcpartrev",        :limit => 3,                                                  :null => false
    t.integer "foperno",          :limit => nil, :precision => 4, :scale => 0,                  :null => false
    t.string  "fcres_id",         :limit => 7,                                                  :null => false
    t.integer "fnsimulops",       :limit => nil, :precision => 3, :scale => 0,                  :null => false
    t.binary  "timestamp_column"
    t.string  "fac",              :limit => 20,                                                 :null => false
    t.string  "fcudrev",          :limit => 3,                                 :default => " ", :null => false
    t.integer "fndbrmod",         :limit => nil, :precision => 1, :scale => 0, :default => 0,   :null => false
  end

  add_index "inrtgr", ["fpartno", "fcpartrev", "foperno", "fcres_id", "fac"], :name => "PARTOPID"
  add_index "inrtgr", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "inrtgs", :primary_key => "identity_column", :force => true do |t|
    t.string  "fpartno",          :limit => 25,                                                     :null => false
    t.string  "fcpartrev",        :limit => 3,                                                      :null => false
    t.integer "foperno",          :limit => nil, :precision => 4,  :scale => 0,                     :null => false
    t.string  "fchngrates",       :limit => 1,                                                      :null => false
    t.string  "fcstddesc",        :limit => 4,                                                      :null => false
    t.decimal "felpstime",                       :precision => 12, :scale => 5,                     :null => false
    t.decimal "ffixcost",                        :precision => 17, :scale => 5,                     :null => false
    t.boolean "flschedule",                                                                         :null => false
    t.decimal "fmovetime",                       :precision => 8,  :scale => 2,                     :null => false
    t.decimal "foperqty",                        :precision => 15, :scale => 5,                     :null => false
    t.decimal "fothrcost",                       :precision => 17, :scale => 5,                     :null => false
    t.string  "fpro_id",          :limit => 7,                                                      :null => false
    t.decimal "fsetuptime",                      :precision => 7,  :scale => 2,                     :null => false
    t.decimal "fsubcost",                        :precision => 17, :scale => 5,                     :null => false
    t.decimal "fulabcost",                       :precision => 7,  :scale => 2,                     :null => false
    t.decimal "fuovrhdcos",                      :precision => 7,  :scale => 2,                     :null => false
    t.decimal "fuprodtime",                      :precision => 16, :scale => 10,                    :null => false
    t.decimal "fusubcost",                       :precision => 17, :scale => 5,                     :null => false
    t.boolean "fllotreqd",                                                                          :null => false
    t.string  "fccharcode",       :limit => 10,                                                     :null => false
    t.binary  "timestamp_column"
    t.text    "fopermemo",                                                       :default => " ",   :null => false
    t.string  "fac",              :limit => 20,                                                     :null => false
    t.string  "fcudrev",          :limit => 3,                                   :default => " ",   :null => false
    t.integer "fndbrmod",         :limit => nil, :precision => 1,  :scale => 0,  :default => 0,     :null => false
    t.integer "fnsimulops",                                                      :default => 0,     :null => false
    t.decimal "fyield",                          :precision => 12, :scale => 5,  :default => 100.0, :null => false
    t.decimal "fsetyield",                       :precision => 8,  :scale => 2,  :default => 0.0,   :null => false
  end

  add_index "inrtgs", ["fpartno", "fcpartrev", "foperno", "fac"], :name => "PARTOPER"
  add_index "inrtgs", ["fpartno", "fcpartrev", "fpro_id", "fac"], :name => "PARTWORK"
  add_index "inrtgs", ["fpro_id", "fac"], :name => "work"
  add_index "inrtgs", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "intran", :primary_key => "identity_column", :force => true do |t|
    t.datetime "fdate",                                                                           :null => false
    t.string   "fpartno",          :limit => 25,                                                  :null => false
    t.string   "fcpartrev",        :limit => 3,                                                   :null => false
    t.string   "ftype",            :limit => 1,                                                   :null => false
    t.string   "faccno",           :limit => 25,                                                  :null => false
    t.string   "fcode",            :limit => 4,                                                   :null => false
    t.decimal  "fcost",                           :precision => 17, :scale => 5,                  :null => false
    t.string   "ffrombin",         :limit => 14,                                                  :null => false
    t.datetime "ffromexpdt",                                                                      :null => false
    t.string   "ffromjob",         :limit => 10,                                                  :null => false
    t.string   "ffromloc",         :limit => 14,                                                  :null => false
    t.string   "ffromlot",         :limit => 20,                                                  :null => false
    t.string   "finspect",         :limit => 3,                                                   :null => false
    t.decimal  "flabor",                          :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fmatl",                           :precision => 17, :scale => 5,                  :null => false
    t.integer  "fnumber",          :limit => nil, :precision => 6,  :scale => 0,                  :null => false
    t.decimal  "fovrhd",                          :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fqty",                            :precision => 15, :scale => 5,                  :null => false
    t.string   "ftobin",           :limit => 14,                                                  :null => false
    t.datetime "ftoexpdt",                                                                        :null => false
    t.string   "ftojob",           :limit => 10,                                                  :null => false
    t.string   "ftoloc",           :limit => 14,                                                  :null => false
    t.string   "ftolot",           :limit => 20,                                                  :null => false
    t.string   "ftoso",            :limit => 12,                                                  :null => false
    t.datetime "fctime_ts",                                                                       :null => false
    t.decimal  "fnnewonhd",                       :precision => 17, :scale => 5,                  :null => false
    t.binary   "timestamp_column"
    t.text     "fcomment",                                                       :default => " ", :null => false
    t.string   "fac",              :limit => 20,                                                  :null => false
    t.string   "ffromfac",         :limit => 20,                                                  :null => false
    t.string   "ftofac",           :limit => 20,                                                  :null => false
    t.string   "fcudrev",          :limit => 3,                                  :default => " ", :null => false
    t.integer  "fiorigum",                                                       :default => 0,   :null => false
    t.integer  "fium1",                                                          :default => 0,   :null => false
    t.integer  "fium2",                                                          :default => 0,   :null => false
    t.integer  "fium3",                                                          :default => 0,   :null => false
    t.integer  "fium4",                                                          :default => 0,   :null => false
    t.integer  "fium5",                                                          :default => 0,   :null => false
    t.integer  "fiunitcnt",                                                      :default => 0,   :null => false
    t.decimal  "fnorigqty",                       :precision => 17, :scale => 5, :default => 0.0, :null => false
    t.decimal  "fnqty1",                          :precision => 17, :scale => 5, :default => 0.0, :null => false
    t.decimal  "fnqty2",                          :precision => 17, :scale => 5, :default => 0.0, :null => false
    t.decimal  "fnqty3",                          :precision => 17, :scale => 5, :default => 0.0, :null => false
    t.decimal  "fnqty4",                          :precision => 17, :scale => 5, :default => 0.0, :null => false
    t.decimal  "fnqty5",                          :precision => 17, :scale => 5, :default => 0.0, :null => false
  end

  add_index "intran", ["fcpartrev"], :name => "rev"
  add_index "intran", ["fdate"], :name => "trandate"
  add_index "intran", ["ffromjob"], :name => "fromjob"
  add_index "intran", ["ffromlot"], :name => "fromlot"
  add_index "intran", ["fnumber"], :name => "number"
  add_index "intran", ["fpartno", "fcpartrev", "fdate", "fac"], :name => "PARTDATE"
  add_index "intran", ["fpartno", "fcpartrev", "ftype", "fdate", "fac"], :name => "PRTTYPDT"
  add_index "intran", ["ftojob"], :name => "tojob"
  add_index "intran", ["ftolot"], :name => "tolot"
  add_index "intran", ["ftoso"], :name => "toso"
  add_index "intran", ["ftype", "fdate", "fac", "fpartno", "fcpartrev"], :name => "TYPEDATE"
  add_index "intran", ["ftype", "fpartno", "fac", "fdate", "fcpartrev"], :name => "TYPEPART"
  add_index "intran", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "invcur", :primary_key => "identity_column", :force => true do |t|
    t.string  "fcpartno",         :limit => 25,                  :null => false
    t.string  "fcpartrev",        :limit => 3,                   :null => false
    t.boolean "flanycur",                                        :null => false
    t.binary  "timestamp_column"
    t.string  "fac",              :limit => 20,                  :null => false
    t.string  "fcudrev",          :limit => 3,  :default => " ", :null => false
  end

  add_index "invcur", ["fcpartno", "fcpartrev", "fac"], :name => "PARTREV"
  add_index "invcur", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "invend", :primary_key => "identity_column", :force => true do |t|
    t.string   "fpartno",          :limit => 25,                                                 :null => false
    t.string   "fpartrev",         :limit => 3,                                                  :null => false
    t.string   "fpriority",        :limit => 1,                                                  :null => false
    t.string   "fvendno",          :limit => 6,                                                  :null => false
    t.decimal  "fvconvfact",                     :precision => 13, :scale => 9,                  :null => false
    t.decimal  "fvlastpc",                       :precision => 17, :scale => 5,                  :null => false
    t.datetime "fvlastpd",                                                                       :null => false
    t.decimal  "fvlastpq",                       :precision => 15, :scale => 5,                  :null => false
    t.decimal  "fvleadtime",                     :precision => 7,  :scale => 1,                  :null => false
    t.string   "fvmeasure",        :limit => 3,                                                  :null => false
    t.string   "fvpartno",         :limit => 25,                                                 :null => false
    t.string   "fvptdes",          :limit => 35,                                :default => " ", :null => false
    t.string   "fclastpono",       :limit => 6,                                                  :null => false
    t.string   "fcjrdict",         :limit => 10,                                                 :null => false
    t.binary   "timestamp_column"
    t.text     "fvcomment",                                                     :default => " ", :null => false
    t.string   "fac",              :limit => 20,                                                 :null => false
    t.string   "fcudrev",          :limit => 3,                                 :default => " ", :null => false
  end

  add_index "invend", ["fpartno", "fpartrev", "fpriority", "fac"], :name => "PARTPRI"
  add_index "invend", ["fpartno", "fpartrev", "fvendno", "fac"], :name => "PARTVEND"
  add_index "invend", ["fvendno", "fac", "fpartno", "fpartrev"], :name => "VENDNO"
  add_index "invend", ["fvendno", "fac", "fvpartno"], :name => "VENVPART"
  add_index "invend", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "invsth", :primary_key => "identity_column", :force => true do |t|
    t.string   "fcnewval",         :limit => 1,  :default => " ",                   :null => false
    t.string   "fcoldval",         :limit => 1,  :default => " ",                   :null => false
    t.string   "fcpartno",         :limit => 25, :default => " ",                   :null => false
    t.string   "fcpartrev",        :limit => 3,  :default => " ",                   :null => false
    t.string   "fcuser",           :limit => 10, :default => " ",                   :null => false
    t.datetime "ftdate",                         :default => '1900-01-01 00:00:00', :null => false
    t.binary   "timestamp_column"
    t.text     "fmcmnts",                        :default => " ",                   :null => false
    t.string   "fac",              :limit => 20,                                    :null => false
    t.string   "fcudrev",          :limit => 3,  :default => " ",                   :null => false
  end

  add_index "invsth", ["fcpartno", "fcpartrev", "fac"], :name => "PARTREV"
  add_index "invsth", ["fcuser"], :name => "user_"
  add_index "invsth", ["ftdate"], :name => "date"
  add_index "invsth", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "invsts", :primary_key => "identity_column", :force => true do |t|
    t.string "fcstscode",        :limit => 1,  :null => false
    t.string "fcstsnm",          :limit => 25, :null => false
    t.binary "timestamp_column"
  end

  add_index "invsts", ["fcstscode"], :name => "stscode"
  add_index "invsts", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "inwork", :primary_key => "identity_column", :force => true do |t|
    t.decimal "fnavgwkhrs",                      :precision => 6,  :scale => 2,                  :null => false
    t.string  "fcpro_id",         :limit => 7,                                                   :null => false
    t.string  "fcpro_name",       :limit => 16,                                                  :null => false
    t.string  "fccomments",       :limit => 54,                                 :default => " ", :null => false
    t.string  "fdept",            :limit => 2,                                                   :null => false
    t.decimal "flabcost",                        :precision => 7,  :scale => 2,                  :null => false
    t.decimal "fnavgque",                        :precision => 7,  :scale => 1,                  :null => false
    t.boolean "flschedule",                                                                      :null => false
    t.integer "fnmax1",           :limit => nil, :precision => 3,  :scale => 0,                  :null => false
    t.integer "fnmax2",           :limit => nil, :precision => 3,  :scale => 0,                  :null => false
    t.integer "fnmax3",           :limit => nil, :precision => 3,  :scale => 0,                  :null => false
    t.decimal "fnmaxque",                        :precision => 7,  :scale => 1,                  :null => false
    t.decimal "fnpctutil",                       :precision => 6,  :scale => 1,                  :null => false
    t.decimal "fnqueallow",                      :precision => 8,  :scale => 2,                  :null => false
    t.integer "fnstd1",           :limit => nil, :precision => 3,  :scale => 0,                  :null => false
    t.integer "fnstd2",           :limit => nil, :precision => 3,  :scale => 0,                  :null => false
    t.integer "fnstd3",           :limit => nil, :precision => 3,  :scale => 0,                  :null => false
    t.decimal "fnstd_prod",                      :precision => 11, :scale => 6,                  :null => false
    t.decimal "fnstd_set",                       :precision => 7,  :scale => 2,                  :null => false
    t.decimal "fnsumdur",                        :precision => 9,  :scale => 1,                  :null => false
    t.decimal "fovrhdcost",                      :precision => 7,  :scale => 2,                  :null => false
    t.string  "fscheduled",       :limit => 1,                                                   :null => false
    t.integer "fspandays",        :limit => nil, :precision => 4,  :scale => 0,                  :null => false
    t.decimal "fnpque",                          :precision => 7,  :scale => 1,                  :null => false
    t.boolean "flconstrnt",                                                                      :null => false
    t.binary  "timestamp_column"
    t.string  "fac",              :limit => 20,                                                  :null => false
    t.string  "fcstdormax",       :limit => 8,                                  :default => " ", :null => false
    t.integer "fndbrmod",         :limit => nil, :precision => 1,  :scale => 0, :default => 0,   :null => false
    t.decimal "fnloadcapc",                      :precision => 6,  :scale => 2, :default => 0.0, :null => false
    t.decimal "fnmaxcapload",                    :precision => 4,  :scale => 1,                  :null => false
    t.boolean "flaltset",                                                                        :null => false
    t.string  "fcsyncmisc",       :limit => 20,                                                  :null => false
  end

  add_index "inwork", ["fcpro_id", "fac"], :name => "pro_id"
  add_index "inwork", ["fcpro_name", "fac"], :name => "pro_name"
  add_index "inwork", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "isoqdetl", :primary_key => "identity_column", :force => true do |t|
    t.string   "fcavendno",        :limit => 6,                                  :default => " ",                   :null => false
    t.string   "fcdocno",          :limit => 25,                                 :default => " ",                   :null => false
    t.string   "fcjono",           :limit => 10,                                 :default => " ",                   :null => false
    t.string   "fcpoitm",          :limit => 3,                                  :default => " ",                   :null => false
    t.string   "fcsoitm",          :limit => 3,                                  :default => " ",                   :null => false
    t.string   "fcsorls",          :limit => 3,                                  :default => " ",                   :null => false
    t.string   "fcsupdem",         :limit => 1,                                  :default => " ",                   :null => false
    t.datetime "fdactdate",                                                      :default => '1900-01-01 00:00:00', :null => false
    t.datetime "fdduedate",                                                      :default => '1900-01-01 00:00:00', :null => false
    t.boolean  "flactsel",                                                       :default => false,                 :null => false
    t.integer  "fnjoopno",         :limit => nil, :precision => 4,  :scale => 0, :default => 0,                     :null => false
    t.decimal  "fntxnqty",                        :precision => 17, :scale => 5, :default => 0.0,                   :null => false
    t.decimal  "fnunitcost",                      :precision => 17, :scale => 5, :default => 0.0,                   :null => false
    t.binary   "timestamp_column",                                                                                  :null => false
    t.string   "fcsono",           :limit => 6,                                  :default => " ",                   :null => false
    t.string   "sfac",             :limit => 20,                                 :default => " ",                   :null => false
    t.string   "fcPurchase",       :limit => 1,                                                                     :null => false
    t.string   "fccomment",        :limit => 20,                                 :default => " ",                   :null => false
    t.string   "fclineno",         :limit => 3,                                  :default => " ",                   :null => false
    t.string   "fcpartrev",        :limit => 3,                                  :default => " ",                   :null => false
    t.string   "fcpono",           :limit => 6,                                  :default => " ",                   :null => false
    t.boolean  "flactreqd",                                                      :default => false,                 :null => false
    t.decimal  "fnordqty",                        :precision => 17, :scale => 5, :default => 0.0,                   :null => false
    t.decimal  "fnnetavail",                      :precision => 17, :scale => 5, :default => 0.0,                   :null => false
    t.string   "fcudrev",          :limit => 3,                                                                     :null => false
    t.string   "fcpartno",         :limit => 25,                                 :default => " ",                   :null => false
    t.string   "fcporls",          :limit => 3,                                  :default => " ",                   :null => false
    t.string   "fcsource",         :limit => 5,                                  :default => " ",                   :null => false
    t.string   "fcstatus",         :limit => 10,                                 :default => " ",                   :null => false
    t.string   "fctype",           :limit => 2,                                  :default => " ",                   :null => false
    t.string   "fcwcid",           :limit => 7,                                  :default => " ",                   :null => false
    t.boolean  "flvendsel",                                                      :default => false,                 :null => false
    t.decimal  "fnextcost",                       :precision => 17, :scale => 5, :default => 0.0,                   :null => false
    t.decimal  "fnqtyavail",                      :precision => 17, :scale => 5, :default => 0.0,                   :null => false
    t.string   "fcjodbomno",       :limit => 4,                                  :default => " ",                   :null => false
    t.string   "fac",              :limit => 20,                                 :default => " ",                   :null => false
    t.string   "fcrecsrc",         :limit => 1,                                  :default => " ",                   :null => false
  end

  add_index "isoqdetl", ["fcpartno", "fcpartrev", "fclineno", "fac"], :name => "isoqdetl"
  add_index "isoqdetl", ["fcpartno", "fcpartrev", "fdactdate", "fac"], :name => "actdate"
  add_index "isoqdetl", ["fcpartno", "fcpartrev", "fdduedate", "fcsupdem", "fac"], :name => "duedate"
  add_index "isoqdetl", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "isoqsumm", :primary_key => "identity_column", :force => true do |t|
    t.string   "fcabc",            :limit => 1,                                   :default => " ",                   :null => false
    t.string   "fcavendno",        :limit => 6,                                   :default => " ",                   :null => false
    t.string   "fcavname",         :limit => 35,                                  :default => " ",                   :null => false
    t.string   "fcpartdesc",       :limit => 35,                                  :default => " ",                   :null => false
    t.string   "fcpvname",         :limit => 35,                                  :default => " ",                   :null => false
    t.string   "fcpvuom",          :limit => 3,                                   :default => " ",                   :null => false
    t.string   "fcucsrc",          :limit => 1,                                   :default => " ",                   :null => false
    t.string   "fcuom",            :limit => 3,                                   :default => " ",                   :null => false
    t.datetime "fdactdate",                                                       :default => '1900-01-01 00:00:00', :null => false
    t.datetime "fdgentime",                                                       :default => '1900-01-01 00:00:00', :null => false
    t.decimal  "fnonord",                         :precision => 17, :scale => 5,  :default => 0.0,                   :null => false
    t.decimal  "fnreord",                         :precision => 17, :scale => 5,  :default => 0.0,                   :null => false
    t.decimal  "fnsafety",                        :precision => 17, :scale => 5,  :default => 0.0,                   :null => false
    t.decimal  "fnunitcost",                      :precision => 17, :scale => 5,  :default => 0.0,                   :null => false
    t.string   "fcpartno",         :limit => 25,                                  :default => " ",                   :null => false
    t.datetime "fdduedate",                                                       :default => '1900-01-01 00:00:00', :null => false
    t.boolean  "flactreqd",                                                       :default => false,                 :null => false
    t.decimal  "fnonhand",                        :precision => 17, :scale => 5,  :default => 0.0,                   :null => false
    t.binary   "timestamp_column",                                                                                   :null => false
    t.string   "fac",              :limit => 20,                                  :default => " ",                   :null => false
    t.string   "fcpvendno",        :limit => 6,                                   :default => " ",                   :null => false
    t.decimal  "fnordqty",                        :precision => 17, :scale => 5,  :default => 0.0,                   :null => false
    t.string   "fcavuom",          :limit => 3,                                   :default => " ",                   :null => false
    t.string   "fccomment",        :limit => 20,                                  :default => " ",                   :null => false
    t.string   "fcgroup",          :limit => 6,                                   :default => " ",                   :null => false
    t.string   "fcpartrev",        :limit => 3,                                   :default => " ",                   :null => false
    t.string   "fcplanner",        :limit => 3,                                   :default => " ",                   :null => false
    t.string   "fcprcl",           :limit => 2,                                   :default => " ",                   :null => false
    t.string   "fcucdoc",          :limit => 20,                                  :default => " ",                   :null => false
    t.boolean  "flstartpo",                                                       :default => false,                 :null => false
    t.boolean  "flvendsel",                                                       :default => false,                 :null => false
    t.decimal  "fnavconv",                        :precision => 17, :scale => 10, :default => 0.0,                   :null => false
    t.decimal  "fnininsp",                        :precision => 17, :scale => 5,  :default => 0.0,                   :null => false
    t.integer  "fnleadtime",       :limit => nil, :precision => 5,  :scale => 0,  :default => 0,                     :null => false
    t.decimal  "fnqtyavail",                      :precision => 17, :scale => 5,  :default => 0.0,                   :null => false
    t.decimal  "fnnetavail",                      :precision => 17, :scale => 5,  :default => 0.0,                   :null => false
    t.string   "fcudrev",          :limit => 3,                                                                      :null => false
    t.boolean  "flactsel",                                                        :default => false,                 :null => false
  end

  add_index "isoqsumm", ["fcpartno", "fcpartrev", "fac"], :name => "partno"
  add_index "isoqsumm", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "jocbom", :primary_key => "identity_column", :force => true do |t|
    t.string   "fjobno",           :limit => 10,                                                  :null => false
    t.string   "fseqno",           :limit => 3,                                                   :null => false
    t.string   "fbomdesc",         :limit => 130,                                :default => " ", :null => false
    t.decimal  "fbomqty",                         :precision => 17, :scale => 5,                  :null => false
    t.string   "finumber",         :limit => 3,                                                   :null => false
    t.decimal  "fmatlcost",                       :precision => 21, :scale => 6,                  :null => false
    t.datetime "fneed_dt",                                                                        :null => false
    t.string   "fresponse",        :limit => 1,                                                   :null => false
    t.binary   "timestamp_column"
  end

  add_index "jocbom", ["fjobno", "fseqno"], :name => "jobnoseq"
  add_index "jocbom", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "jodbom", :primary_key => "identity_column", :force => true do |t|
    t.string   "fitem",            :limit => 6,                                                                     :null => false
    t.string   "fbompart",         :limit => 25,                                                                    :null => false
    t.string   "fbomrev",          :limit => 3,                                                                     :null => false
    t.string   "fbomdesc",         :limit => 65,                                 :default => " ",                   :null => false
    t.string   "fparent",          :limit => 25,                                                                    :null => false
    t.string   "fparentrev",       :limit => 3,                                                                     :null => false
    t.decimal  "factqty",                         :precision => 15, :scale => 5,                                    :null => false
    t.decimal  "fbomlcost",                       :precision => 14, :scale => 5,                                    :null => false
    t.string   "fbommeas",         :limit => 3,                                                                     :null => false
    t.decimal  "fbomocost",                       :precision => 14, :scale => 5,                                    :null => false
    t.integer  "fbomrec",          :limit => nil, :precision => 6,  :scale => 0,                                    :null => false
    t.string   "fbomsource",       :limit => 1,                                                                     :null => false
    t.decimal  "fbook",                           :precision => 15, :scale => 5,                                    :null => false
    t.decimal  "ffixcost",                        :precision => 17, :scale => 5,                                    :null => false
    t.string   "finumber",         :limit => 3,                                                                     :null => false
    t.string   "fjobno",           :limit => 10,                                                                    :null => false
    t.decimal  "flabcost",                        :precision => 17, :scale => 5,                                    :null => false
    t.decimal  "flabsetcos",                      :precision => 17, :scale => 5,                                    :null => false
    t.integer  "flastoper",        :limit => nil, :precision => 4,  :scale => 0,                                    :null => false
    t.boolean  "flextend",                                                                                          :null => false
    t.boolean  "fltooling",                                                                                         :null => false
    t.decimal  "fmatlcost",                       :precision => 17, :scale => 5,                                    :null => false
    t.datetime "fneed_dt",                                                                                          :null => false
    t.integer  "fnumopers",        :limit => nil, :precision => 4,  :scale => 0,                                    :null => false
    t.string   "fbominum",         :limit => 4,                                                                     :null => false
    t.decimal  "fothrcost",                       :precision => 17, :scale => 5,                                    :null => false
    t.decimal  "fovrhdcost",                      :precision => 17, :scale => 5,                                    :null => false
    t.decimal  "fovrhdsetc",                      :precision => 17, :scale => 5,                                    :null => false
    t.string   "fpono",            :limit => 6,                                                                     :null => false
    t.decimal  "fpoqty",                          :precision => 15, :scale => 5,                                    :null => false
    t.decimal  "fqtytopurc",                      :precision => 15, :scale => 5,                                    :null => false
    t.decimal  "fqty_iss",                        :precision => 15, :scale => 5,                                    :null => false
    t.string   "fresponse",        :limit => 1,                                                                     :null => false
    t.decimal  "fsubcost",                        :precision => 17, :scale => 5,                                    :null => false
    t.string   "fsub_job",         :limit => 10,                                                                    :null => false
    t.boolean  "fsub_rel",                                                                                          :null => false
    t.decimal  "ftotptime",                       :precision => 9,  :scale => 2,                                    :null => false
    t.decimal  "ftotqty",                         :precision => 15, :scale => 5,                                    :null => false
    t.decimal  "ftotstime",                       :precision => 9,  :scale => 2,                                    :null => false
    t.decimal  "ftransinv",                       :precision => 15, :scale => 5,                                    :null => false
    t.string   "fvendno",          :limit => 6,                                                                     :null => false
    t.boolean  "fllotreqd",                                                                                         :null => false
    t.string   "fclotext",         :limit => 1,                                                                     :null => false
    t.decimal  "fnretpoqty",                      :precision => 15, :scale => 5,                                    :null => false
    t.integer  "fnoperno",         :limit => nil, :precision => 4,  :scale => 0,                                    :null => false
    t.decimal  "fnqtylnd",                        :precision => 17, :scale => 5,                                    :null => false
    t.integer  "fipopieces",                                                                                        :null => false
    t.integer  "fiissdpcs",                                                                                         :null => false
    t.binary   "timestamp_column"
    t.text     "fstdmemo",                                                       :default => " ",                   :null => false
    t.string   "Cfac",             :limit => 20,                                 :default => " ",                   :null => false
    t.string   "fcbomudrev",       :limit => 3,                                  :default => " ",                   :null => false
    t.string   "fcparudrev",       :limit => 3,                                  :default => " ",                   :null => false
    t.integer  "fndbrmod",         :limit => nil, :precision => 1,  :scale => 0, :default => 0,                     :null => false
    t.string   "Pfac",             :limit => 20,                                 :default => " ",                   :null => false
    t.datetime "fpneed_dt",                                                      :default => '1900-01-01 00:00:00', :null => false
    t.decimal  "fOrigQty",                        :precision => 15, :scale => 5,                                    :null => false
    t.datetime "SchedDate",                                                                                         :null => false
  end

  add_index "jodbom", ["fbompart", "fbomrev", "fjobno", "Cfac"], :name => "ptjobno"
  add_index "jodbom", ["fbomsource"], :name => "source"
  add_index "jodbom", ["fjobno", "Cfac", "fbompart", "fbomrev"], :name => "JOBNOPRT"
  add_index "jodbom", ["fjobno", "fbominum"], :name => "JOBINUM"
  add_index "jodbom", ["fjobno", "fbomsource", "Cfac", "fbompart", "fbomrev"], :name => "JOBSRCPT"
  add_index "jodbom", ["fjobno", "fitem"], :name => "jobnoitm"
  add_index "jodbom", ["fjobno", "fnoperno", "Cfac", "fbompart", "fbomrev"], :name => "BYJOBPRT"
  add_index "jodbom", ["fneed_dt"], :name => "needdate"
  add_index "jodbom", ["fqtytopurc", "Cfac", "fbompart", "fbomrev", "fjobno", "fpoqty"], :name => "ptjobnob"
  add_index "jodbom", ["fsub_job"], :name => "subjob"
  add_index "jodbom", ["fvendno", "Cfac", "fbompart", "fbomrev", "fjobno"], :name => "PTJOBNOA"
  add_index "jodbom", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "jodbomdl", :primary_key => "identity_column", :force => true do |t|
    t.integer "fijodbomid",                                      :null => false
    t.integer "fitype",                                          :null => false
    t.boolean "flpartial",                                       :null => false
    t.integer "fium1"
    t.decimal "fnsize1",          :precision => 18, :scale => 5
    t.integer "fium2"
    t.decimal "fnsize2",          :precision => 18, :scale => 5
    t.integer "fium3"
    t.decimal "fnsize3",          :precision => 18, :scale => 5
    t.integer "fium4"
    t.decimal "fnsize4",          :precision => 18, :scale => 5
    t.integer "fium5"
    t.decimal "fnsize5",          :precision => 18, :scale => 5
    t.integer "fnqty",                                           :null => false
    t.integer "ficount",                                         :null => false
    t.binary  "timestamp_column"
  end

  add_index "jodbomdl", ["fijodbomid", "fitype"], :name => "JODBOMID"
  add_index "jodbomdl", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "jodrtg", :primary_key => "identity_column", :force => true do |t|
    t.decimal  "fnlflushqty",                     :precision => 15, :scale => 5,                     :null => false
    t.string   "fjobno",           :limit => 10,                                                     :null => false
    t.integer  "foperno",          :limit => nil, :precision => 4,  :scale => 0,                     :null => false
    t.datetime "factschdfn",                                                                         :null => false
    t.datetime "factschdst",                                                                         :null => false
    t.string   "fbominum",         :limit => 4,                                                      :null => false
    t.string   "fchngrates",       :limit => 1,                                                      :null => false
    t.datetime "fcomp_date",                                                                         :null => false
    t.string   "fcstat",           :limit => 1,                                                      :null => false
    t.datetime "fstrtdate",                                                                          :null => false
    t.datetime "fddue_date",                                                                         :null => false
    t.string   "fdescnum",         :limit => 4,                                                      :null => false
    t.datetime "fdrel_date",                                                                         :null => false
    t.decimal  "felpstime",                       :precision => 8,  :scale => 2,                     :null => false
    t.decimal  "ffixcost",                        :precision => 17, :scale => 5,                     :null => false
    t.string   "fflushed",         :limit => 1,                                                      :null => false
    t.string   "finumber",         :limit => 3,                                                      :null => false
    t.datetime "flastlab",                                                                           :null => false
    t.boolean  "flschedule",                                                                         :null => false
    t.decimal  "fmovetime",                       :precision => 8,  :scale => 2,                     :null => false
    t.integer  "fndelay",          :limit => nil, :precision => 6,  :scale => 0,                     :null => false
    t.integer  "fndue_time",       :limit => nil, :precision => 6,  :scale => 0,                     :null => false
    t.datetime "fneed_dt",                                                                           :null => false
    t.integer  "fnnext_evt",       :limit => nil, :precision => 6,  :scale => 0,                     :null => false
    t.integer  "fnpct_comp",       :limit => nil, :precision => 4,  :scale => 0,                     :null => false
    t.decimal  "fnqty_comp",                      :precision => 15, :scale => 5,                     :null => false
    t.decimal  "fnqty_move",                      :precision => 15, :scale => 5,                     :null => false
    t.decimal  "fnqty_togo",                      :precision => 15, :scale => 5,                     :null => false
    t.integer  "fnque_time",       :limit => nil, :precision => 6,  :scale => 0,                     :null => false
    t.integer  "fnrel_time",       :limit => nil, :precision => 6,  :scale => 0,                     :null => false
    t.integer  "fnshft",           :limit => nil, :precision => 6,  :scale => 0,                     :null => false
    t.datetime "fnsh_date",                                                                          :null => false
    t.integer  "fnsh_time",        :limit => nil, :precision => 6,  :scale => 0,                     :null => false
    t.integer  "fnstrttime",       :limit => nil, :precision => 6,  :scale => 0,                     :null => false
    t.decimal  "foperqty",                        :precision => 15, :scale => 5,                     :null => false
    t.string   "foper_strt",       :limit => 1,                                                      :null => false
    t.decimal  "fothrcost",                       :precision => 17, :scale => 5,                     :null => false
    t.string   "fpono",            :limit => 6,                                                      :null => false
    t.decimal  "fpoqty",                          :precision => 17, :scale => 5,                     :null => false
    t.decimal  "fnretpoqty",                      :precision => 17, :scale => 5,                     :null => false
    t.decimal  "flead_tim",                       :precision => 8,  :scale => 2,                     :null => false
    t.decimal  "flead_stim",                      :precision => 8,  :scale => 2,                     :null => false
    t.decimal  "fprod_tim",                       :precision => 8,  :scale => 2,                     :null => false
    t.decimal  "fprod_val",                       :precision => 17, :scale => 5,                     :null => false
    t.string   "fpro_id",          :limit => 7,                                                      :null => false
    t.string   "fresponse",        :limit => 1,                                                      :null => false
    t.decimal  "fsetuptime",                      :precision => 7,  :scale => 2,                     :null => false
    t.decimal  "fsetup_tim",                      :precision => 8,  :scale => 2,                     :null => false
    t.decimal  "fsetup_val",                      :precision => 17, :scale => 5,                     :null => false
    t.string   "fshipmt",          :limit => 1,                                                      :null => false
    t.string   "fsource",          :limit => 1,                                                      :null => false
    t.boolean  "fsplit",                                                                             :null => false
    t.string   "fsubcont",         :limit => 1,                                                      :null => false
    t.datetime "ftduedate",                                                                          :null => false
    t.string   "ftfnshdate",       :limit => 15,                                                     :null => false
    t.integer  "ftfnshtime",       :limit => nil, :precision => 6,  :scale => 0,                     :null => false
    t.decimal  "ftimetogo",                       :precision => 10, :scale => 2,                     :null => false
    t.decimal  "ftot_app",                        :precision => 15, :scale => 5,                     :null => false
    t.decimal  "ftot_rew",                        :precision => 15, :scale => 5,                     :null => false
    t.decimal  "ftot_scr",                        :precision => 15, :scale => 5,                     :null => false
    t.integer  "ftquetime",        :limit => nil, :precision => 6,  :scale => 0,                     :null => false
    t.datetime "ftreldate",                                                                          :null => false
    t.string   "ftstrtdate",       :limit => 15,                                                     :null => false
    t.integer  "ftstrttime",       :limit => nil, :precision => 6,  :scale => 0,                     :null => false
    t.decimal  "fulabcost",                       :precision => 17, :scale => 5,                     :null => false
    t.decimal  "fuovrhdcos",                      :precision => 17, :scale => 5,                     :null => false
    t.decimal  "fuprodtime",                      :precision => 16, :scale => 10,                    :null => false
    t.decimal  "fusubcost",                       :precision => 17, :scale => 5,                     :null => false
    t.string   "fvendno",          :limit => 6,                                                      :null => false
    t.boolean  "fllotreqd",                                                                          :null => false
    t.string   "fcschdpct",        :limit => 1,                                                      :null => false
    t.boolean  "flfreeze",                                                                           :null => false
    t.integer  "fnsimulops",       :limit => nil, :precision => 3,  :scale => 0,                     :null => false
    t.string   "fccharcode",       :limit => 10,                                                     :null => false
    t.datetime "fdplanstdt",                                                                         :null => false
    t.binary   "timestamp_column"
    t.text     "fopermemo",                                                       :default => " ",   :null => false
    t.string   "fac",              :limit => 20,                                                     :null => false
    t.boolean  "flsaveprec",                                                      :default => false, :null => false
    t.boolean  "flusesetup",                                                      :default => false, :null => false
    t.integer  "fndbrmod",         :limit => nil, :precision => 1,  :scale => 0,  :default => 0,     :null => false
    t.integer  "fnlatestrt",       :limit => nil, :precision => 10, :scale => 0,  :default => 0,     :null => false
    t.integer  "fnmachine",        :limit => nil, :precision => 3,  :scale => 0,  :default => 0,     :null => false
    t.string   "fcfreezetype",     :limit => 15,                                                     :null => false
    t.string   "fcmachineuse",     :limit => 100,                                                    :null => false
    t.string   "fcsyncmisc",       :limit => 20,                                                     :null => false
  end

  add_index "jodrtg", ["fjobno", "fac", "fpro_id"], :name => "JOBNOPRO"
  add_index "jodrtg", ["fjobno", "foperno"], :name => "JOBNOOP"
  add_index "jodrtg", ["fneed_dt"], :name => "needdate"
  add_index "jodrtg", ["foperno"], :name => "operno"
  add_index "jodrtg", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "joitem", :primary_key => "identity_column", :force => true do |t|
    t.string   "fjobno",           :limit => 10,                                                 :null => false
    t.string   "fitem",            :limit => 3,                                                  :null => false
    t.string   "fpartno",          :limit => 25,                                                 :null => false
    t.string   "fpartrev",         :limit => 3,                                                  :null => false
    t.string   "fsono",            :limit => 6,                                                  :null => false
    t.string   "finumber",         :limit => 3,                                                  :null => false
    t.boolean  "fjob",                                                                           :null => false
    t.string   "fkey",             :limit => 3,                                                  :null => false
    t.decimal  "fbook",                          :precision => 15, :scale => 5,                  :null => false
    t.decimal  "fbqty",                          :precision => 15, :scale => 5,                  :null => false
    t.decimal  "fcost_est",                      :precision => 17, :scale => 5,                  :null => false
    t.string   "fcustpart",        :limit => 25,                                                 :null => false
    t.string   "fcustptrev",       :limit => 3,                                                  :null => false
    t.string   "fdelivery",        :limit => 69,                                :default => " ", :null => false
    t.datetime "fduedate",                                                                       :null => false
    t.string   "fgroup",           :limit => 6,                                                  :null => false
    t.decimal  "fhour_est",                      :precision => 9,  :scale => 2,                  :null => false
    t.datetime "flshipdate",                                                                     :null => false
    t.string   "fmeasure",         :limit => 3,                                                  :null => false
    t.decimal  "fmqty",                          :precision => 15, :scale => 5,                  :null => false
    t.string   "fmultiple",        :limit => 1,                                                  :null => false
    t.decimal  "forderqty",                      :precision => 15, :scale => 5,                  :null => false
    t.decimal  "fpartyld1",                      :precision => 8,  :scale => 3,                  :null => false
    t.string   "fprodcl",          :limit => 2,                                                  :null => false
    t.decimal  "frtgqty",                        :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fshipqty",                       :precision => 15, :scale => 5,                  :null => false
    t.string   "fsource",          :limit => 1,                                                  :null => false
    t.boolean  "fstandpart",                                                                     :null => false
    t.string   "fstatus",          :limit => 1,                                                  :null => false
    t.decimal  "fulabcost1",                     :precision => 7,  :scale => 2,                  :null => false
    t.decimal  "fuprice",                        :precision => 17, :scale => 5,                  :null => false
    t.binary   "timestamp_column"
    t.text     "fdesc",                                                         :default => " ", :null => false
    t.text     "fdescmemo",                                                     :default => " ", :null => false
    t.string   "fac",              :limit => 20,                                                 :null => false
    t.string   "fcudrev",          :limit => 3,                                 :default => " ", :null => false
    t.decimal  "fidoshpqty",                     :precision => 15, :scale => 5
    t.integer  "fndbrmod",         :limit => 1,                                                  :null => false
  end

  add_index "joitem", ["fjobno", "fitem", "fac", "fpartno", "fpartrev"], :name => "JOITPART"
  add_index "joitem", ["fpartno", "fpartrev", "fjobno", "fac"], :name => "PARTJOB"
  add_index "joitem", ["fsono", "finumber", "fkey"], :name => "SONOKEY"
  add_index "joitem", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "jolbck", :primary_key => "identity_column", :force => true do |t|
    t.string   "fctrans_id",       :limit => 10,                                 :null => false
    t.string   "fcjobno",          :limit => 10,                                 :null => false
    t.integer  "fnoperno",         :limit => nil, :precision => 4,  :scale => 0, :null => false
    t.string   "fcpro_id",         :limit => 7,                                  :null => false
    t.datetime "fddate",                                                         :null => false
    t.decimal  "fnsethrs",                        :precision => 11, :scale => 4, :null => false
    t.decimal  "fnprodhrs",                       :precision => 11, :scale => 4, :null => false
    t.decimal  "fnulabcost",                      :precision => 7,  :scale => 2, :null => false
    t.decimal  "fnuovhdcost",                     :precision => 7,  :scale => 2, :null => false
    t.binary   "timestamp_column"
    t.string   "fac",              :limit => 20
  end

  add_index "jolbck", ["fctrans_id"], :name => "transid"
  add_index "jolbck", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "jomast", :primary_key => "identity_column", :force => true do |t|
    t.string   "fjobno",           :limit => 10,                                                   :null => false
    t.string   "fpartno",          :limit => 25,                                                   :null => false
    t.string   "fpartrev",         :limit => 3,                                                    :null => false
    t.string   "fsono",            :limit => 6,                                                    :null => false
    t.string   "fstatus",          :limit => 10,                                                   :null => false
    t.datetime "factschdfn",                                                                       :null => false
    t.datetime "factschdst",                                                                       :null => false
    t.datetime "fact_rel",                                                                         :null => false
    t.integer  "fassy_comp",       :limit => nil, :precision => 2,  :scale => 0,                   :null => false
    t.integer  "fassy_req",        :limit => nil, :precision => 4,  :scale => 0,                   :null => false
    t.string   "fbilljob",         :limit => 8,                                                    :null => false
    t.string   "fbominum",         :limit => 4,                                                    :null => false
    t.integer  "fbomrec",          :limit => nil, :precision => 6,  :scale => 0,                   :null => false
    t.boolean  "fcas_bom",                                                                         :null => false
    t.string   "fckeyfield",       :limit => 20,                                                   :null => false
    t.string   "fcompany",         :limit => 35,                                 :default => " ",  :null => false
    t.boolean  "fcomp_schl",                                                                       :null => false
    t.boolean  "fconfirm",                                                                         :null => false
    t.string   "fcus_id",          :limit => 6,                                                    :null => false
    t.integer  "fdduedtime",       :limit => nil, :precision => 6,  :scale => 0,                   :null => false
    t.datetime "fddue_date",                                                                       :null => false
    t.boolean  "fdesc",                                                                            :null => false
    t.string   "fdescript",        :limit => 70,                                 :default => " ",  :null => false
    t.boolean  "fdet_bom",                                                                         :null => false
    t.boolean  "fdet_rtg",                                                                         :null => false
    t.datetime "fdstart",                                                                          :null => false
    t.datetime "fdfnshdate",                                                                       :null => false
    t.boolean  "ffst_job",                                                                         :null => false
    t.string   "fglacct",          :limit => 25,                                                   :null => false
    t.string   "fhold_by",         :limit => 23,                                                   :null => false
    t.datetime "fhold_dt",                                                                         :null => false
    t.integer  "fitems",           :limit => nil, :precision => 3,  :scale => 0,                   :null => false
    t.string   "fitype",           :limit => 1,                                                    :null => false
    t.string   "fjob_name",        :limit => 86,                                 :default => " ",  :null => false
    t.string   "fkey",             :limit => 6,                                                    :null => false
    t.datetime "flastlab",                                                                         :null => false
    t.integer  "fmatlpcnt",        :limit => nil, :precision => 3,  :scale => 0,                   :null => false
    t.string   "fmeasure",         :limit => 3,                                                    :null => false
    t.string   "fmethod",          :limit => 1,                                                    :null => false
    t.boolean  "fmultiple",                                                                        :null => false
    t.integer  "fnassy_com",       :limit => nil, :precision => 3,  :scale => 0,                   :null => false
    t.integer  "fnassy_req",       :limit => nil, :precision => 3,  :scale => 0,                   :null => false
    t.integer  "fnfnshtime",       :limit => nil, :precision => 6,  :scale => 0,                   :null => false
    t.integer  "fnontime",         :limit => nil, :precision => 1,  :scale => 0,                   :null => false
    t.decimal  "fnpct_comp",                      :precision => 6,  :scale => 1,                   :null => false
    t.decimal  "fnpct_idle",                      :precision => 6,  :scale => 1,                   :null => false
    t.integer  "fnrel_time",       :limit => nil, :precision => 6,  :scale => 0,                   :null => false
    t.integer  "fnshft",           :limit => nil, :precision => 6,  :scale => 0,                   :null => false
    t.datetime "fopen_dt",                                                                         :null => false
    t.string   "fpartdesc",        :limit => 40,                                 :default => " ",  :null => false
    t.datetime "fpick_dt",                                                                         :null => false
    t.boolean  "fpick_st",                                                                         :null => false
    t.string   "fpo_comp",         :limit => 1,                                                    :null => false
    t.datetime "ftrave_dt",                                                                        :null => false
    t.boolean  "ftrave_st",                                                                        :null => false
    t.string   "fpriority",        :limit => 11,                                                   :null => false
    t.string   "fprocessby",       :limit => 12,                                                   :null => false
    t.string   "fprodcl",          :limit => 2,                                                    :null => false
    t.boolean  "fpro_plan",                                                                        :null => false
    t.decimal  "fquantity",                       :precision => 15, :scale => 5,                   :null => false
    t.datetime "frel_dt",                                                                          :null => false
    t.integer  "fremtime",         :limit => nil, :precision => 6,  :scale => 0,                   :null => false
    t.string   "fresponse",        :limit => 1,                                                    :null => false
    t.string   "fresu_by",         :limit => 19,                                                   :null => false
    t.datetime "fresu_dt",                                                                         :null => false
    t.decimal  "frouting",                        :precision => 17, :scale => 5,                   :null => false
    t.datetime "fr_dt",                                                                            :null => false
    t.string   "fr_rev",           :limit => 2,                                                    :null => false
    t.string   "fr_type",          :limit => 1,                                                    :null => false
    t.string   "fschbefjob",       :limit => 10,                                                   :null => false
    t.string   "fschdflag",        :limit => 1,                                                    :null => false
    t.string   "fschdprior",       :limit => 1,                                                    :null => false
    t.datetime "fschresdt",                                                                        :null => false
    t.boolean  "fsign_off",                                                                        :null => false
    t.boolean  "fsplit",                                                                           :null => false
    t.string   "fsplitfrom",       :limit => 10,                                                   :null => false
    t.string   "fsplitinfo",       :limit => 12,                                                   :null => false
    t.boolean  "fstandpart",                                                                       :null => false
    t.boolean  "fstarted",                                                                         :null => false
    t.datetime "fstrt_date",                                                                       :null => false
    t.integer  "fstrt_time",       :limit => nil, :precision => 6,  :scale => 0,                   :null => false
    t.string   "fsub_from",        :limit => 10,                                                   :null => false
    t.boolean  "fsub_rel",                                                                         :null => false
    t.boolean  "fsummary",                                                                         :null => false
    t.datetime "ftduedate",                                                                        :null => false
    t.string   "ftfnshdate",       :limit => 15,                                                   :null => false
    t.integer  "ftfnshtime",       :limit => nil, :precision => 6,  :scale => 0,                   :null => false
    t.integer  "ftot_assy",        :limit => nil, :precision => 4,  :scale => 0,                   :null => false
    t.datetime "ftreldt",                                                                          :null => false
    t.datetime "ftschresdt",                                                                       :null => false
    t.string   "ftstrtdate",       :limit => 15,                                                   :null => false
    t.integer  "ftstrttime",       :limit => nil, :precision => 6,  :scale => 0,                   :null => false
    t.string   "ftype",            :limit => 1,                                                    :null => false
    t.string   "fcusrchr1",        :limit => 20,                                                   :null => false
    t.string   "fcusrchr2",        :limit => 40,                                 :default => " ",  :null => false
    t.string   "fcusrchr3",        :limit => 40,                                 :default => " ",  :null => false
    t.decimal  "fnusrqty1",                       :precision => 15, :scale => 5,                   :null => false
    t.decimal  "fnusrcur1",                       :precision => 17, :scale => 5,                   :null => false
    t.datetime "fdusrdate1",                                                                       :null => false
    t.integer  "fnlastopno",       :limit => nil, :precision => 4,  :scale => 0,                   :null => false
    t.string   "fcdncfile",        :limit => 80,                                 :default => " ",  :null => false
    t.string   "fccadfile1",       :limit => 250,                                                  :null => false
    t.string   "fccadfile2",       :limit => 250,                                                  :null => false
    t.string   "fccadfile3",       :limit => 250,                                                  :null => false
    t.boolean  "fllotreqd",                                                                        :null => false
    t.string   "fclotext",         :limit => 1,                                                    :null => false
    t.boolean  "flresync",                                                                         :null => false
    t.datetime "fdorgduedt",                                                                       :null => false
    t.boolean  "flquick",                                                                          :null => false
    t.boolean  "flfreeze",                                                                         :null => false
    t.boolean  "flchgpnd",                                                                         :null => false
    t.string   "fllasteco",        :limit => 25,                                                   :null => false
    t.boolean  "flisapl",                                                                          :null => false
    t.binary   "timestamp_column"
    t.binary   "fgimage",                                                        :default => "0x", :null => false
    t.text     "fjob_mem",                                                       :default => " ",  :null => false
    t.text     "fmusermemo",                                                     :default => " ",  :null => false
    t.string   "fac",              :limit => 20,                                                   :null => false
    t.string   "idono",            :limit => 10
    t.string   "sfac",             :limit => 20
    t.string   "fcudrev",          :limit => 3,                                  :default => " ",  :null => false
    t.integer  "fdmndrank",        :limit => nil, :precision => 1,  :scale => 0, :default => 0,    :null => false
    t.integer  "fndbrmod",         :limit => nil, :precision => 1,  :scale => 0, :default => 0,    :null => false
    t.integer  "fnrouteno",        :limit => nil, :precision => 5,  :scale => 0,                   :null => false
    t.boolean  "flplanfreeze",                                                                     :null => false
    t.string   "fcsyncmisc",       :limit => 20,                                                   :null => false
  end

  add_index "jomast", ["fddue_date"], :name => "duedate"
  add_index "jomast", ["fjobno", "fsono"], :name => "sojobnum1"
  add_index "jomast", ["fpartno", "fpartrev", "fjobno", "fac"], :name => "PARTJBNO"
  add_index "jomast", ["fsono", "fjobno"], :name => "SOJOBNUM"
  add_index "jomast", ["fsono", "fkey"], :name => "sokey"
  add_index "jomast", ["fstatus"], :name => "status"
  add_index "jomast", ["identity_column"], :name => "identity_column_idx1", :unique => true
  add_index "jomast", ["idono"], :name => "idono"

  create_table "jopact", :primary_key => "identity_column", :force => true do |t|
    t.string   "fjobno",           :limit => 10,                                                 :null => false
    t.decimal  "faddedocos",                     :precision => 17, :scale => 5,                  :null => false
    t.decimal  "faddedpcos",                     :precision => 17, :scale => 5,                  :null => false
    t.decimal  "faddedltim",                     :precision => 7,  :scale => 2,                  :null => false
    t.decimal  "faddedptim",                     :precision => 7,  :scale => 2,                  :null => false
    t.decimal  "faddedscos",                     :precision => 17, :scale => 5,                  :null => false
    t.decimal  "faddedstim",                     :precision => 7,  :scale => 2,                  :null => false
    t.string   "finumber",         :limit => 3,                                                  :null => false
    t.decimal  "flabact",                        :precision => 17, :scale => 5,                  :null => false
    t.decimal  "flabinv",                        :precision => 17, :scale => 5,                  :null => false
    t.datetime "flast_ent",                                                                      :null => false
    t.decimal  "fmatlact",                       :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fmatlinv",                       :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fothract",                       :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fothrinv",                       :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fovhdact",                       :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fovhdinv",                       :precision => 17, :scale => 5,                  :null => false
    t.decimal  "frtgsetupa",                     :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fsetupact",                      :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fsubact",                        :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fsubinv",                        :precision => 17, :scale => 5,                  :null => false
    t.decimal  "ftoolact",                       :precision => 17, :scale => 5,                  :null => false
    t.decimal  "ftotltime",                      :precision => 14, :scale => 5,                  :null => false
    t.decimal  "ftotptime",                      :precision => 14, :scale => 5,                  :null => false
    t.decimal  "ftotstime",                      :precision => 7,  :scale => 2,                  :null => false
    t.decimal  "faddedlsti",                     :precision => 7,  :scale => 2,                  :null => false
    t.decimal  "ftotlstime",                     :precision => 14, :scale => 5,                  :null => false
    t.binary   "timestamp_column"
    t.text     "fpmemo",                                                        :default => " ", :null => false
  end

  add_index "jopact", ["fjobno"], :name => "jobnum"
  add_index "jopact", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "jopest", :primary_key => "identity_column", :force => true do |t|
    t.string  "fjobno",           :limit => 10,                                 :null => false
    t.integer "fbuy_itm",         :limit => nil, :precision => 5,  :scale => 0, :null => false
    t.integer "fcus_itm",         :limit => nil, :precision => 5,  :scale => 0, :null => false
    t.decimal "ffixcost",                        :precision => 17, :scale => 5, :null => false
    t.integer "finoper",          :limit => nil, :precision => 4,  :scale => 0, :null => false
    t.string  "finumber",         :limit => 3,                                  :null => false
    t.decimal "flabcost",                        :precision => 17, :scale => 5, :null => false
    t.integer "flastoper",        :limit => nil, :precision => 4,  :scale => 0, :null => false
    t.decimal "fldhrs",                          :precision => 14, :scale => 5, :null => false
    t.integer "fmak_itm",         :limit => nil, :precision => 5,  :scale => 0, :null => false
    t.decimal "fmatlcost",                       :precision => 17, :scale => 5, :null => false
    t.decimal "fmovehrs",                        :precision => 8,  :scale => 2, :null => false
    t.boolean "fno_bom",                                                        :null => false
    t.boolean "fno_rtg",                                                        :null => false
    t.integer "fnumopers",        :limit => nil, :precision => 4,  :scale => 0, :null => false
    t.decimal "fothrcost",                       :precision => 17, :scale => 5, :null => false
    t.decimal "fovhdcost",                       :precision => 17, :scale => 5, :null => false
    t.decimal "fovhdsc",                         :precision => 17, :scale => 5, :null => false
    t.decimal "fprodhrs",                        :precision => 14, :scale => 5, :null => false
    t.decimal "fsetupcost",                      :precision => 17, :scale => 5, :null => false
    t.decimal "fsetuphrs",                       :precision => 7,  :scale => 2, :null => false
    t.integer "fstk_itm",         :limit => nil, :precision => 5,  :scale => 0, :null => false
    t.decimal "fsubcost",                        :precision => 17, :scale => 5, :null => false
    t.integer "fsubhrs",          :limit => nil, :precision => 4,  :scale => 0, :null => false
    t.integer "fsuboper",         :limit => nil, :precision => 3,  :scale => 0, :null => false
    t.decimal "ftoolcost",                       :precision => 17, :scale => 5, :null => false
    t.binary  "timestamp_column"
  end

  add_index "jopest", ["fjobno"], :name => "jobnum"
  add_index "jopest", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "joqmast", :primary_key => "identity_column", :force => true do |t|
    t.string   "fcabccd",          :limit => 1,                                                  :null => false
    t.string   "fccompna",         :limit => 35,                                :default => " ", :null => false
    t.string   "fcdocrev",         :limit => 2,                                                  :null => false
    t.string   "fcgrpcod",         :limit => 6,                                                  :null => false
    t.string   "fcjonum",          :limit => 10,                                                 :null => false
    t.string   "fcjoopno",         :limit => 4,                                                  :null => false
    t.string   "fcmeasure",        :limit => 3,                                                  :null => false
    t.string   "fcorderact",       :limit => 1,                                                  :null => false
    t.string   "fcpartno",         :limit => 25,                                                 :null => false
    t.string   "fcrev",            :limit => 3,                                                  :null => false
    t.string   "fcplanner",        :limit => 3,                                                  :null => false
    t.string   "fcponum",          :limit => 6,                                                  :null => false
    t.string   "fcprdcls",         :limit => 2,                                                  :null => false
    t.string   "fcqsource",        :limit => 1,                                                  :null => false
    t.string   "fcsoitm",          :limit => 3,                                                  :null => false
    t.string   "fcsonum",          :limit => 6,                                                  :null => false
    t.string   "fcsorls",          :limit => 3,                                                  :null => false
    t.string   "fcsource",         :limit => 5,                                                  :null => false
    t.string   "fcstatus",         :limit => 10,                                                 :null => false
    t.string   "fcsupdem",         :limit => 6,                                                  :null => false
    t.string   "fcvendna",         :limit => 35,                                :default => " ", :null => false
    t.string   "fcvendno",         :limit => 6,                                                  :null => false
    t.datetime "fdtxndate",                                                                      :null => false
    t.boolean  "flmaster",                                                                       :null => false
    t.boolean  "flautocr",                                                                       :null => false
    t.decimal  "fnbalqty",                       :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fntxnqty",                       :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fnucost",                        :precision => 17, :scale => 5,                  :null => false
    t.binary   "timestamp_column"
    t.text     "fmdesc",                                                        :default => " ", :null => false
    t.string   "fac",              :limit => 20,                                                 :null => false
    t.string   "fcudrev",          :limit => 3,                                 :default => " ", :null => false
    t.string   "fcIdoNo",          :limit => 10,                                :default => "",  :null => false
  end

  add_index "joqmast", ["fcjonum"], :name => "jo"
  add_index "joqmast", ["fcpartno", "fcrev", "fdtxndate", "fac"], :name => "QMAST"
  add_index "joqmast", ["fcsonum", "fcsoitm", "fcsorls"], :name => "SO"
  add_index "joqmast", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "joresc", :primary_key => "identity_column", :force => true do |t|
    t.string  "fjobno",           :limit => 10,                                               :null => false
    t.integer "foperno",          :limit => nil, :precision => 4, :scale => 0,                :null => false
    t.string  "fcres_id",         :limit => 7,                                                :null => false
    t.integer "fnsimulops",       :limit => nil, :precision => 3, :scale => 0,                :null => false
    t.binary  "timestamp_column"
    t.integer "fndbrmod",         :limit => nil, :precision => 1, :scale => 0, :default => 0, :null => false
    t.string  "fcmachineuse",     :limit => 100,                                              :null => false
  end

  add_index "joresc", ["fjobno", "foperno", "fcres_id"], :name => "JOBOPID"
  add_index "joresc", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "jrdict", :primary_key => "identity_column", :force => true do |t|
    t.string "fcjrdict",         :limit => 10,                  :null => false
    t.string "fcjrdesc",         :limit => 35, :default => " ", :null => false
    t.binary "timestamp_column"
  end

  add_index "jrdict", ["fcjrdict"], :name => "jrdict"
  add_index "jrdict", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "jrtax", :primary_key => "identity_column", :force => true do |t|
    t.string  "fcjrdict",         :limit => 10, :null => false
    t.string  "fctaxcode",        :limit => 10, :null => false
    t.integer "fnorder",                        :null => false
    t.binary  "timestamp_column"
  end

  add_index "jrtax", ["fcjrdict", "fnorder"], :name => "jrorder"
  add_index "jrtax", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "ladetail", :primary_key => "identity_column", :force => true do |t|
    t.string   "fcearncode",       :limit => 4,                                  :null => false
    t.decimal  "fchrglab",                        :precision => 10, :scale => 4, :null => false
    t.boolean  "fcmpl",                                                          :null => false
    t.string   "fcode1",           :limit => 1,                                  :null => false
    t.string   "fcode2",           :limit => 1,                                  :null => false
    t.decimal  "fcompqty",                        :precision => 15, :scale => 5, :null => false
    t.datetime "fdate",                                                          :null => false
    t.datetime "fedatetime",                                                     :null => false
    t.string   "fempno",           :limit => 9,                                  :null => false
    t.string   "fendseries",       :limit => 1,                                  :null => false
    t.integer  "ferrbc",           :limit => nil, :precision => 2,  :scale => 0, :null => false
    t.string   "ferrlist",         :limit => 20,                                 :null => false
    t.boolean  "ff1",                                                            :null => false
    t.decimal  "findcost",                        :precision => 17, :scale => 5, :null => false
    t.boolean  "fjoblocked",                                                     :null => false
    t.string   "fjobno",           :limit => 10,                                 :null => false
    t.string   "flabtype",         :limit => 1,                                  :null => false
    t.boolean  "fleadpersn",                                                     :null => false
    t.boolean  "fltrans",                                                        :null => false
    t.integer  "foperno",          :limit => nil, :precision => 4,  :scale => 0, :null => false
    t.boolean  "fovertime",                                                      :null => false
    t.decimal  "fovrate",                         :precision => 6,  :scale => 2, :null => false
    t.string   "fposted",          :limit => 1,                                  :null => false
    t.string   "fpro_id",          :limit => 7,                                  :null => false
    t.decimal  "fscrpqty",                        :precision => 15, :scale => 5, :null => false
    t.datetime "fsdatetime",                                                     :null => false
    t.integer  "fseries",          :limit => nil, :precision => 4,  :scale => 0, :null => false
    t.string   "fshift",           :limit => 1,                                  :null => false
    t.string   "fstatus",          :limit => 1,                                  :null => false
    t.string   "fsustate",         :limit => 2,                                  :null => false
    t.string   "ftimecode",        :limit => 1,                                  :null => false
    t.decimal  "ftotocost",                       :precision => 17, :scale => 5, :null => false
    t.decimal  "ftotpcost",                       :precision => 17, :scale => 5, :null => false
    t.string   "fwkclass",         :limit => 4,                                  :null => false
    t.string   "fwkstate",         :limit => 2,                                  :null => false
    t.decimal  "fnratefact",                      :precision => 12, :scale => 5, :null => false
    t.decimal  "fnflatamnt",                      :precision => 9,  :scale => 2, :null => false
    t.boolean  "flchrtojob",                                                     :null => false
    t.string   "fccustom",         :limit => 25,                                 :null => false
    t.string   "fcdept",           :limit => 2,                                  :null => false
    t.binary   "timestamp_column"
    t.string   "fac",              :limit => 20
  end

  add_index "ladetail", ["fdate"], :name => "labdate"
  add_index "ladetail", ["fempno", "fdate", "fsdatetime"], :name => "empdate"
  add_index "ladetail", ["fjobno", "foperno", "fdate", "fedatetime"], :name => "JOBOPDATE"
  add_index "ladetail", ["fstatus", "fempno"], :name => "erroremp"
  add_index "ladetail", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "lamast", :primary_key => "identity_column", :force => true do |t|
    t.string   "fempno",           :limit => 9, :null => false
    t.datetime "fdate",                         :null => false
    t.binary   "timestamp_column"
  end

  add_index "lamast", ["fdate", "fempno"], :name => "DATEEMP"
  add_index "lamast", ["fempno", "fdate"], :name => "empdate"
  add_index "lamast", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "location", :primary_key => "identity_column", :force => true do |t|
    t.string "fcfacility",       :limit => 20,  :null => false
    t.string "flocation",        :limit => 14,  :null => false
    t.string "fcinspect",        :limit => 1,   :null => false
    t.string "flocdesc",         :limit => 30,  :null => false
    t.string "fcmrpexcl",        :limit => 1,   :null => false
    t.string "fccity",           :limit => 20,  :null => false
    t.string "fcstate",          :limit => 20,  :null => false
    t.string "fczip",            :limit => 10,  :null => false
    t.string "fccountry",        :limit => 25,  :null => false
    t.string "fcfname",          :limit => 15,  :null => false
    t.string "fclname",          :limit => 20,  :null => false
    t.string "fcphone",          :limit => 20,  :null => false
    t.string "fcfax",            :limit => 20,  :null => false
    t.string "fcemail",          :limit => 128, :null => false
    t.binary "timestamp_column"
    t.text   "fmstreet",                        :null => false
  end

  add_index "location", ["flocation", "fcfacility"], :name => "location"
  add_index "location", ["flocation", "fcinspect"], :name => "loc_insp"
  add_index "location", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "locbin", :primary_key => "identity_column", :force => true do |t|
    t.string "fcloc",            :limit => 14, :default => " ", :null => false
    t.string "fcbin",            :limit => 14, :default => " ", :null => false
    t.string "fcbindesc",        :limit => 30, :default => " ", :null => false
    t.binary "timestamp_column"
  end

  add_index "locbin", ["fcloc", "fcbin"], :name => "LOCNBIN"
  add_index "locbin", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "mfr", :primary_key => "identity_column", :force => true do |t|
    t.string "fcmfrno",          :limit => 6,  :default => "", :null => false
    t.string "fcmfrname",        :limit => 35, :default => "", :null => false
    t.text   "fmaddress",                      :default => "", :null => false
    t.string "fccity",           :limit => 20, :default => "", :null => false
    t.string "fcstate",          :limit => 20, :default => "", :null => false
    t.string "fczip",            :limit => 10, :default => "", :null => false
    t.string "fccountry",        :limit => 25, :default => "", :null => false
    t.string "fcicfname",        :limit => 20, :default => "", :null => false
    t.string "fciclname",        :limit => 20, :default => "", :null => false
    t.string "fcphone",          :limit => 20, :default => "", :null => false
    t.string "fcext",            :limit => 4,  :default => "", :null => false
    t.string "fcfax",            :limit => 20, :default => "", :null => false
    t.string "fcemail",          :limit => 60, :default => "", :null => false
    t.string "fcsrfname",        :limit => 20, :default => "", :null => false
    t.string "fcsrlname",        :limit => 20, :default => "", :null => false
    t.string "fcsrphone",        :limit => 20, :default => "", :null => false
    t.string "fcsrext",          :limit => 4,  :default => "", :null => false
    t.string "fcsrfax",          :limit => 20, :default => "", :null => false
    t.string "fcsremail",        :limit => 60, :default => "", :null => false
    t.text   "fmnotes",                        :default => "", :null => false
    t.text   "fmcomments",                     :default => "", :null => false
    t.binary "timestamp_column"
  end

  add_index "mfr", ["fcmfrname"], :name => "mfrname"
  add_index "mfr", ["fcmfrno"], :name => "mfr", :unique => true
  add_index "mfr", ["identity_column"], :name => "idcolumn", :unique => true

  create_table "mfrpart", :primary_key => "identity_column", :force => true do |t|
    t.string "fcmfrno",          :limit => 6,  :default => "", :null => false
    t.string "fcmfrpart",        :limit => 50, :default => "", :null => false
    t.string "fcfac",            :limit => 20,                 :null => false
    t.string "fcpartno",         :limit => 25, :default => "", :null => false
    t.string "fcrev",            :limit => 3,  :default => "", :null => false
    t.string "fcuom",            :limit => 3,  :default => "", :null => false
    t.text   "fmcomments",                     :default => "", :null => false
    t.binary "timestamp_column"
  end

  add_index "mfrpart", ["fcmfrno", "fcmfrpart"], :name => "mfrpart"
  add_index "mfrpart", ["fcpartno", "fcrev", "fcfac", "fcmfrno", "fcmfrpart"], :name => "inmfrpart", :unique => true
  add_index "mfrpart", ["identity_column"], :name => "idcolumn", :unique => true

  create_table "ocdist", :primary_key => "identity_column", :force => true do |t|
    t.string   "fcacctnum",        :limit => 25,                                                 :null => false
    t.string   "fcomment",         :limit => 45,                                :default => " ", :null => false
    t.string   "fcrefclass",       :limit => 1,                                                  :null => false
    t.string   "fcrefname",        :limit => 4,                                                  :null => false
    t.string   "fcstatus",         :limit => 1,                                                  :null => false
    t.datetime "fctime_ts",                                                                      :null => false
    t.string   "fcuser_id",        :limit => 4,                                                  :null => false
    t.datetime "fdate",                                                                          :null => false
    t.string   "fjob_so",          :limit => 15,                                                 :null => false
    t.decimal  "fnamount",                                                                       :null => false
    t.string   "fpartno",          :limit => 25,                                                 :null => false
    t.string   "fcpartrev",        :limit => 3,                                                  :null => false
    t.string   "frcv_ship",        :limit => 6,                                                  :null => false
    t.string   "fcjosplt",         :limit => 1,                                                  :null => false
    t.string   "fccurid",          :limit => 3,                                                  :null => false
    t.decimal  "fcfactor",                       :precision => 17, :scale => 5,                  :null => false
    t.decimal  "feurofctr",                      :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fneuroamt",                                                                      :null => false
    t.decimal  "fntxnamt",                                                                       :null => false
    t.binary   "timestamp_column"
    t.string   "fac",              :limit => 20,                                                 :null => false
    t.string   "fcudrev",          :limit => 3,                                 :default => " ", :null => false
  end

  add_index "ocdist", ["fcacctnum"], :name => "acctnum"
  add_index "ocdist", ["fcstatus"], :name => "fcstatus"
  add_index "ocdist", ["fdate"], :name => "fddate"
  add_index "ocdist", ["fjob_so"], :name => "joso"
  add_index "ocdist", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "ocmisc", :primary_key => "identity_column", :force => true do |t|
    t.decimal  "fcost",                           :precision => 21, :scale => 5,                  :null => false
    t.decimal  "fnitemcost",                      :precision => 17, :scale => 5,                  :null => false
    t.datetime "fdate",                                                                           :null => false
    t.string   "fcacctnum",        :limit => 25,                                                  :null => false
    t.string   "fitem",            :limit => 3,                                                   :null => false
    t.string   "fjob_so",          :limit => 10,                                                  :null => false
    t.string   "frelease",         :limit => 3,                                                   :null => false
    t.string   "fmeasure",         :limit => 3,                                                   :null => false
    t.string   "fpartno",          :limit => 25,                                                  :null => false
    t.string   "fpartrev",         :limit => 3,                                                   :null => false
    t.decimal  "fqty_req",                        :precision => 19, :scale => 5,                  :null => false
    t.integer  "ftype",            :limit => nil, :precision => 1,  :scale => 0,                  :null => false
    t.integer  "ftrantype",        :limit => nil, :precision => 1,  :scale => 0,                  :null => false
    t.boolean  "fjob_splt",                                                                       :null => false
    t.binary   "timestamp_column"
    t.text     "fdesc",                                                          :default => " ", :null => false
    t.string   "fac",              :limit => 20
    t.string   "fcudrev",          :limit => 3,                                  :default => " ", :null => false
  end

  add_index "ocmisc", ["fjob_so", "fitem", "frelease", "fdate"], :name => "ocmisc"
  add_index "ocmisc", ["ftype"], :name => "type"
  add_index "ocmisc", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "ovfina", :primary_key => "identity_column", :force => true do |t|
    t.decimal  "finv_new",         :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fappastdue",       :precision => 17, :scale => 5,                  :null => false
    t.decimal  "farpastdue",       :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fcogoversp",       :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fcogovrest",       :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fcrovrlmts",       :precision => 17, :scale => 5,                  :null => false
    t.decimal  "ffingdsstk",       :precision => 17, :scale => 5,                  :null => false
    t.decimal  "finvnotapp",       :precision => 17, :scale => 5,                  :null => false
    t.decimal  "finv_turns",       :precision => 17, :scale => 5,                  :null => false
    t.datetime "flast_apm",                                                        :null => false
    t.datetime "flast_apy",                                                        :null => false
    t.datetime "flast_arm",                                                        :null => false
    t.datetime "flast_ary",                                                        :null => false
    t.datetime "flast_delt",                                                       :null => false
    t.datetime "flast_eom",                                                        :null => false
    t.datetime "flast_eoy",                                                        :null => false
    t.datetime "flast_glm",                                                        :null => false
    t.datetime "flast_gly",                                                        :null => false
    t.datetime "flast_prq",                                                        :null => false
    t.datetime "flast_pry",                                                        :null => false
    t.datetime "flstfinchr",                                                       :null => false
    t.decimal  "fmexpovbud",       :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fno_invcs",        :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fretnocrdt",       :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fretnodbtm",       :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fwiponhold",       :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fytdcogamt",       :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fytdcogpct",       :precision => 17, :scale => 5,                  :null => false
    t.binary   "timestamp_column"
    t.decimal  "farpastdue_d",     :precision => 17, :scale => 5, :default => 0.0, :null => false
    t.decimal  "fcrovrlmts_d",     :precision => 17, :scale => 5, :default => 0.0, :null => false
  end

  add_index "ovfina", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "ovprod", :primary_key => "identity_column", :force => true do |t|
    t.integer  "fnjoresync",       :limit => nil, :precision => 6,  :scale => 0,                :null => false
    t.integer  "fbelowsafe",       :limit => nil, :precision => 6,  :scale => 0,                :null => false
    t.string   "fchanges",         :limit => 1,                                                 :null => false
    t.integer  "fcog_over",        :limit => nil, :precision => 6,  :scale => 0,                :null => false
    t.integer  "fcost_ovrn",       :limit => nil, :precision => 6,  :scale => 0,                :null => false
    t.integer  "fdisp_in_q",       :limit => nil, :precision => 6,  :scale => 0,                :null => false
    t.integer  "finvnotapp",       :limit => nil, :precision => 6,  :scale => 0,                :null => false
    t.decimal  "finv_turns",                      :precision => 7,  :scale => 1,                :null => false
    t.integer  "fjobonhold",       :limit => nil, :precision => 6,  :scale => 0,                :null => false
    t.integer  "fjonotproc",       :limit => nil, :precision => 6,  :scale => 0,                :null => false
    t.integer  "fjopartent",       :limit => nil, :precision => 6,  :scale => 0,                :null => false
    t.integer  "flabenterr",       :limit => nil, :precision => 6,  :scale => 0,                :null => false
    t.datetime "flast_delt",                                                                    :null => false
    t.datetime "flast_eom",                                                                     :null => false
    t.datetime "flast_eoy",                                                                     :null => false
    t.datetime "flast_roll",                                                                    :null => false
    t.datetime "flstjobsch",                                                                    :null => false
    t.datetime "flsttmentr",                                                                    :null => false
    t.string   "fmonth",           :limit => 10,                                                :null => false
    t.string   "fmthno",           :limit => 2,                                                 :null => false
    t.integer  "fplst_in_q",       :limit => nil, :precision => 6,  :scale => 0,                :null => false
    t.integer  "fpopastdue",       :limit => nil, :precision => 6,  :scale => 0,                :null => false
    t.integer  "fpot_shpmt",       :limit => nil, :precision => 6,  :scale => 0,                :null => false
    t.integer  "fpo_onhold",       :limit => nil, :precision => 6,  :scale => 0,                :null => false
    t.integer  "fprch_in_q",       :limit => nil, :precision => 6,  :scale => 0,                :null => false
    t.integer  "fpstreldt1",       :limit => nil, :precision => 6,  :scale => 0,                :null => false
    t.integer  "fnfgohqty",        :limit => nil, :precision => 6,  :scale => 0,                :null => false
    t.integer  "fpurch_rej",       :limit => nil, :precision => 6,  :scale => 0,                :null => false
    t.integer  "frsnotproc",       :limit => nil, :precision => 6,  :scale => 0,                :null => false
    t.integer  "fr_notproc",       :limit => nil, :precision => 6,  :scale => 0,                :null => false
    t.integer  "fshpnotcls",       :limit => nil, :precision => 6,  :scale => 0,                :null => false
    t.integer  "fsonotproc",       :limit => nil, :precision => 6,  :scale => 0,                :null => false
    t.integer  "fsopastdue",       :limit => nil, :precision => 6,  :scale => 0,                :null => false
    t.integer  "fstd_nortg",       :limit => nil, :precision => 6,  :scale => 0,                :null => false
    t.integer  "fstknotuse",       :limit => nil, :precision => 6,  :scale => 0,                :null => false
    t.integer  "ftrav_in_q",       :limit => nil, :precision => 6,  :scale => 0,                :null => false
    t.string   "fyear",            :limit => 6,                                                 :null => false
    t.decimal  "fytdcogamt",                      :precision => 21, :scale => 5,                :null => false
    t.decimal  "fytdcogpct",                      :precision => 21, :scale => 5,                :null => false
    t.integer  "fpostarted",       :limit => nil, :precision => 5,  :scale => 0,                :null => false
    t.integer  "fnresync",         :limit => nil, :precision => 5,  :scale => 0,                :null => false
    t.integer  "fjoqtynomv",       :limit => nil, :precision => 6,  :scale => 0,                :null => false
    t.binary   "timestamp_column"
    t.integer  "idoship",          :limit => nil, :precision => 5,  :scale => 0, :default => 0
  end

  add_index "ovprod", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "ovsale", :primary_key => "identity_column", :force => true do |t|
    t.integer  "fcardays01",       :limit => nil, :precision => 6, :scale => 0,                :null => false
    t.integer  "fcardays02",       :limit => nil, :precision => 6, :scale => 0,                :null => false
    t.integer  "fcardays03",       :limit => nil, :precision => 6, :scale => 0,                :null => false
    t.integer  "fcardays04",       :limit => nil, :precision => 6, :scale => 0,                :null => false
    t.integer  "fcardays05",       :limit => nil, :precision => 6, :scale => 0,                :null => false
    t.integer  "fcardays06",       :limit => nil, :precision => 6, :scale => 0,                :null => false
    t.integer  "fcardays07",       :limit => nil, :precision => 6, :scale => 0,                :null => false
    t.integer  "fcardays08",       :limit => nil, :precision => 6, :scale => 0,                :null => false
    t.integer  "fcardays09",       :limit => nil, :precision => 6, :scale => 0,                :null => false
    t.integer  "fcardays10",       :limit => nil, :precision => 6, :scale => 0,                :null => false
    t.integer  "fcardays11",       :limit => nil, :precision => 6, :scale => 0,                :null => false
    t.integer  "fcardays12",       :limit => nil, :precision => 6, :scale => 0,                :null => false
    t.integer  "fcost_ovrn",       :limit => nil, :precision => 4, :scale => 0,                :null => false
    t.integer  "fjobonhold",       :limit => nil, :precision => 4, :scale => 0,                :null => false
    t.datetime "flastpmail",                                                                   :null => false
    t.datetime "flastsmail",                                                                   :null => false
    t.datetime "flast_delt",                                                                   :null => false
    t.datetime "flast_eom",                                                                    :null => false
    t.datetime "flast_eoy",                                                                    :null => false
    t.string   "fmonth",           :limit => 10,                                               :null => false
    t.string   "fmthno",           :limit => 2,                                                :null => false
    t.integer  "fnot_comp",        :limit => nil, :precision => 4, :scale => 0,                :null => false
    t.integer  "fovr_crdt",        :limit => nil, :precision => 4, :scale => 0,                :null => false
    t.integer  "fpardays01",       :limit => nil, :precision => 6, :scale => 0,                :null => false
    t.integer  "fpardays02",       :limit => nil, :precision => 6, :scale => 0,                :null => false
    t.integer  "fpardays03",       :limit => nil, :precision => 6, :scale => 0,                :null => false
    t.integer  "fpardays04",       :limit => nil, :precision => 6, :scale => 0,                :null => false
    t.integer  "fpardays05",       :limit => nil, :precision => 6, :scale => 0,                :null => false
    t.integer  "fpardays06",       :limit => nil, :precision => 6, :scale => 0,                :null => false
    t.integer  "fpardays07",       :limit => nil, :precision => 6, :scale => 0,                :null => false
    t.integer  "fpardays08",       :limit => nil, :precision => 6, :scale => 0,                :null => false
    t.integer  "fpardays09",       :limit => nil, :precision => 6, :scale => 0,                :null => false
    t.integer  "fpardays10",       :limit => nil, :precision => 6, :scale => 0,                :null => false
    t.integer  "fpardays11",       :limit => nil, :precision => 6, :scale => 0,                :null => false
    t.integer  "fpardays12",       :limit => nil, :precision => 6, :scale => 0,                :null => false
    t.integer  "fpastdue",         :limit => nil, :precision => 4, :scale => 0,                :null => false
    t.integer  "fpastduedt",       :limit => nil, :precision => 4, :scale => 0,                :null => false
    t.integer  "fprospects",       :limit => nil, :precision => 5, :scale => 0,                :null => false
    t.integer  "fshp_rtrns",       :limit => nil, :precision => 4, :scale => 0,                :null => false
    t.integer  "fsonotproc",       :limit => nil, :precision => 4, :scale => 0,                :null => false
    t.integer  "fso_notack",       :limit => nil, :precision => 4, :scale => 0,                :null => false
    t.string   "fyear",            :limit => 4,                                                :null => false
    t.binary   "timestamp_column"
    t.integer  "fovr_crdt_d",      :limit => nil, :precision => 4, :scale => 0, :default => 0, :null => false
    t.integer  "fnot_comp_p",      :limit => nil, :precision => 4, :scale => 0, :default => 0, :null => false
    t.integer  "fnot_comp_d",      :limit => nil, :precision => 4, :scale => 0, :default => 0, :null => false
    t.integer  "fpastdue_d",       :limit => nil, :precision => 4, :scale => 0, :default => 0, :null => false
  end

  add_index "ovsale", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "pbdtl", :primary_key => "identity_column", :force => true do |t|
    t.string   "fcref",            :limit => 2,                                :default => " ", :null => false
    t.string   "finumber",         :limit => 3,                                :default => " ", :null => false
    t.string   "fcdocno",          :limit => 6,                                :default => " ", :null => false
    t.string   "fitemno",          :limit => 3,                                :default => " ", :null => false
    t.string   "frelsno",          :limit => 3,                                :default => " ", :null => false
    t.decimal  "fnamnt",                        :precision => 17, :scale => 5, :default => 0.0, :null => false
    t.decimal  "fneuroamt",                     :precision => 17, :scale => 5, :default => 0.0, :null => false
    t.decimal  "fntxnamt",                      :precision => 17, :scale => 5, :default => 0.0, :null => false
    t.integer  "filmarkup",                                                    :default => 0,   :null => false
    t.integer  "fimmarkup",                                                    :default => 0,   :null => false
    t.datetime "fddate",                                                                        :null => false
    t.binary   "timestamp_column"
  end

  add_index "pbdtl", ["fcref", "fcdocno", "finumber", "frelsno", "fitemno"], :name => "PBItem"
  add_index "pbdtl", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "pccfgitm", :primary_key => "identity_column", :force => true do |t|
    t.string  "fconfig",          :limit => 40,                                 :default => "",   :null => false
    t.string  "fname",            :limit => 40,                                 :default => "",   :null => false
    t.string  "fclass",           :limit => 30,                                 :default => "",   :null => false
    t.integer "fleft",                                                          :default => 0,    :null => false
    t.integer "ftop",                                                           :default => 0,    :null => false
    t.string  "fcaption",         :limit => 80,                                 :default => "",   :null => false
    t.integer "ftabindex",                                                      :default => 0,    :null => false
    t.string  "fparent",          :limit => 6,                                  :default => "",   :null => false
    t.string  "ffeatureid",       :limit => 6,                                  :default => "",   :null => false
    t.string  "foptionid",        :limit => 6,                                  :default => "",   :null => false
    t.text    "fexpr",                                                          :default => "",   :null => false
    t.string  "frule",            :limit => 25,                                 :default => "",   :null => false
    t.decimal "fmin",                            :precision => 16, :scale => 5, :default => 0.0,  :null => false
    t.decimal "fmax",                            :precision => 16, :scale => 5, :default => 0.0,  :null => false
    t.decimal "fminchose",                       :precision => 16, :scale => 5, :default => 0.0,  :null => false
    t.decimal "fmaxchose",                       :precision => 16, :scale => 5, :default => 0.0,  :null => false
    t.string  "fsmartpart",       :limit => 20,                                 :default => "",   :null => false
    t.text    "fhelp",                                                          :default => "",   :null => false
    t.string  "fdocument",        :limit => 25,                                 :default => "",   :null => false
    t.boolean "fallparts",                                                      :default => true, :null => false
    t.string  "fdefopt",          :limit => 6,                                  :default => "",   :null => false
    t.decimal "fdefault",                        :precision => 16, :scale => 5, :default => 0.0,  :null => false
    t.decimal "fvalue",                          :precision => 16, :scale => 5, :default => 0.0,  :null => false
    t.decimal "fquantity",                       :precision => 16, :scale => 5, :default => 0.0,  :null => false
    t.decimal "fprice",                          :precision => 16, :scale => 5, :default => 0.0,  :null => false
    t.decimal "fpricetype",                      :precision => 16, :scale => 5, :default => 0.0,  :null => false
    t.decimal "fpricesell",                      :precision => 16, :scale => 5, :default => 0.0,  :null => false
    t.decimal "fpricevar",                       :precision => 16, :scale => 5, :default => 0.0,  :null => false
    t.string  "fbasedon",         :limit => 6,                                  :default => "",   :null => false
    t.boolean "fvisible",                                                       :default => true, :null => false
    t.text    "flist",                                                          :default => "",   :null => false
    t.text    "fselprop",                                                       :default => "",   :null => false
    t.text    "fcomments",                                                      :default => "",   :null => false
    t.integer "fspstart",         :limit => nil, :precision => 3,  :scale => 0, :default => 0,    :null => false
    t.integer "fsplength",        :limit => nil, :precision => 3,  :scale => 0, :default => 0,    :null => false
    t.integer "flistwidth",       :limit => nil, :precision => 3,  :scale => 0, :default => 0,    :null => false
    t.string  "fbitmap",          :limit => 254,                                :default => "",   :null => false
    t.binary  "timestamp_column"
  end

  add_index "pccfgitm", ["fconfig"], :name => "config"

  create_table "pccfgmst", :primary_key => "identity_column", :force => true do |t|
    t.string  "fconfig",          :limit => 40,                                 :default => "",  :null => false
    t.string  "fprodid",          :limit => 6,                                  :default => "",  :null => false
    t.text    "fdesc",                                                          :default => "",  :null => false
    t.text    "ffulldesc",                                                      :default => "",  :null => false
    t.text    "fcomments",                                                      :default => "",  :null => false
    t.string  "fcustno",          :limit => 6,                                  :default => "",  :null => false
    t.string  "fdistno",          :limit => 6,                                  :default => "",  :null => false
    t.string  "fsalespn",         :limit => 3,                                  :default => "",  :null => false
    t.string  "fsmpart",          :limit => 25,                                 :default => "",  :null => false
    t.decimal "fcustchg",                        :precision => 16, :scale => 5, :default => 0.0, :null => false
    t.decimal "fdistchg",                        :precision => 16, :scale => 5, :default => 0.0, :null => false
    t.decimal "fshipchg",                        :precision => 16, :scale => 5, :default => 0.0, :null => false
    t.string  "fcontact",         :limit => 40,                                 :default => "",  :null => false
    t.string  "fshipkey",         :limit => 4,                                  :default => "",  :null => false
    t.string  "fzipcode",         :limit => 10,                                 :default => "",  :null => false
    t.string  "fbitmap",          :limit => 254,                                :default => "",  :null => false
    t.string  "fsono",            :limit => 6,                                  :default => "",  :null => false
    t.string  "fquoteno",         :limit => 6,                                  :default => "",  :null => false
    t.string  "finumber",         :limit => 3,                                  :default => "",  :null => false
    t.binary  "timestamp_column"
  end

  add_index "pccfgmst", ["identity_column"], :name => "idcolumn", :unique => true

  create_table "pcconstr", :primary_key => "identity_column", :force => true do |t|
    t.string "fprodid",          :limit => 6, :default => "", :null => false
    t.string "foptionid",        :limit => 6, :default => "", :null => false
    t.text   "fminimum",                      :default => "", :null => false
    t.text   "fmaximum",                      :default => "", :null => false
    t.binary "timestamp_column"
  end

  add_index "pcconstr", ["fprodid", "foptionid"], :name => "featid", :unique => true

  create_table "pcgroup", :primary_key => "identity_column", :force => true do |t|
    t.string  "fgroupid",         :limit => 6,                                 :default => "", :null => false
    t.string  "fdesc",            :limit => 40,                                :default => "", :null => false
    t.string  "ffeatureid",       :limit => 6,                                 :default => "", :null => false
    t.integer "foptfeat",         :limit => nil, :precision => 1, :scale => 0, :default => 0,  :null => false
    t.binary  "timestamp_column"
  end

  add_index "pcgroup", ["ffeatureid"], :name => "featureid"
  add_index "pcgroup", ["fgroupid", "ffeatureid"], :name => "grpfeat", :unique => true

  create_table "pcprclst", :primary_key => "identity_column", :force => true do |t|
    t.string  "foptid",           :limit => 6,                                  :default => "",  :null => false
    t.string  "fdesc",            :limit => 20,                                 :default => "",  :null => false
    t.string  "ffeatid1",         :limit => 6,                                  :default => "",  :null => false
    t.decimal "ffrom1",                          :precision => 16, :scale => 5, :default => 0.0, :null => false
    t.decimal "fto1",                            :precision => 16, :scale => 5, :default => 0.0, :null => false
    t.string  "ffeatid2",         :limit => 6,                                  :default => "",  :null => false
    t.decimal "ffrom2",                          :precision => 16, :scale => 5, :default => 0.0, :null => false
    t.decimal "fto2",                            :precision => 16, :scale => 5, :default => 0.0, :null => false
    t.string  "fbasedon",         :limit => 6,                                  :default => "",  :null => false
    t.decimal "fprice1",                         :precision => 16, :scale => 5, :default => 0.0, :null => false
    t.integer "fmargbase1",       :limit => nil, :precision => 1,  :scale => 0, :default => 0,   :null => false
    t.string  "ffeatid3",         :limit => 6,                                  :default => "",  :null => false
    t.binary  "timestamp_column"
  end

  add_index "pcprclst", ["foptid", "ffeatid1", "ffrom1", "fto1"], :name => "fromto1"
  add_index "pcprclst", ["foptid", "ffeatid2", "ffrom2", "fto2"], :name => "fromto2"

  create_table "pcuom", :primary_key => "identity_column", :force => true do |t|
    t.string "ffromuom",         :limit => 3, :default => "", :null => false
    t.string "ftouom",           :limit => 3, :default => "", :null => false
    t.text   "fconvexpr",                     :default => "", :null => false
    t.binary "timestamp_column"
  end

  add_index "pcuom", ["ffromuom", "ftouom"], :name => "fromto", :unique => true

  create_table "pcupchrg", :primary_key => "identity_column", :force => true do |t|
    t.string  "fccustno",         :limit => 6,                                :default => "",  :null => false
    t.decimal "fncustchrg",                    :precision => 16, :scale => 5, :default => 0.0, :null => false
    t.decimal "fnshipchrg",                    :precision => 16, :scale => 5, :default => 0.0, :null => false
    t.binary  "timestamp_column"
  end

  add_index "pcupchrg", ["identity_column"], :name => "idcolumn", :unique => true

  create_table "plbudg", :primary_key => "identity_column", :force => true do |t|
    t.string  "fcname",           :limit => 20,                               :null => false
    t.string  "fctgtacct",        :limit => 25,                               :null => false
    t.string  "fcbaseacct",       :limit => 25,                               :null => false
    t.string  "fcsrctype",        :limit => 12,                               :null => false
    t.decimal "fnfactor",                       :precision => 7, :scale => 3, :null => false
    t.boolean "flspread",                                                     :null => false
    t.decimal "fnbaseval",                                                    :null => false
    t.decimal "fnmnthinc",                      :precision => 7, :scale => 3, :null => false
    t.boolean "fllastact",                                                    :null => false
    t.boolean "fllastbudg",                                                   :null => false
    t.decimal "fnper1",                                                       :null => false
    t.decimal "fnper2",                                                       :null => false
    t.decimal "fnper3",                                                       :null => false
    t.decimal "fnper4",                                                       :null => false
    t.decimal "fnper5",                                                       :null => false
    t.decimal "fnper6",                                                       :null => false
    t.decimal "fnper7",                                                       :null => false
    t.decimal "fnper8",                                                       :null => false
    t.decimal "fnper9",                                                       :null => false
    t.decimal "fnper10",                                                      :null => false
    t.decimal "fnper11",                                                      :null => false
    t.decimal "fnper12",                                                      :null => false
    t.decimal "fnper13",                                                      :null => false
    t.binary  "timestamp_column"
  end

  add_index "plbudg", ["fcname", "fctgtacct"], :name => "RECOVKEY"
  add_index "plbudg", ["fctgtacct"], :name => "targetacct"
  add_index "plbudg", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "pocatg", :primary_key => "identity_column", :force => true do |t|
    t.string "fcategory",        :limit => 8,                   :null => false
    t.string "fdesc",            :limit => 30, :default => " ", :null => false
    t.string "fglacct",          :limit => 25,                  :null => false
    t.binary "timestamp_column"
  end

  add_index "pocatg", ["fcategory"], :name => "pocatg"
  add_index "pocatg", ["fdesc"], :name => "descr"
  add_index "pocatg", ["fglacct"], :name => "acctnum"
  add_index "pocatg", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "poitem", :primary_key => "identity_column", :force => true do |t|
    t.string   "fpono",            :limit => 6,                                                   :null => false
    t.string   "fpartno",          :limit => 25,                                                  :null => false
    t.string   "frev",             :limit => 3,                                                   :null => false
    t.string   "fmeasure",         :limit => 3,                                                   :null => false
    t.string   "fitemno",          :limit => 3,                                                   :null => false
    t.string   "frelsno",          :limit => 3,                                                   :null => false
    t.string   "fcategory",        :limit => 8,                                                   :null => false
    t.string   "fsokey",           :limit => 6,                                                   :null => false
    t.string   "fsoitm",           :limit => 3,                                                   :null => false
    t.string   "fsorls",           :limit => 3,                                                   :null => false
    t.string   "fjokey",           :limit => 10,                                                  :null => false
    t.string   "fjoitm",           :limit => 6,                                                   :null => false
    t.integer  "fjoopno",          :limit => nil, :precision => 4,  :scale => 0,                  :null => false
    t.decimal  "flstcost",                        :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fstdcost",                        :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fleadtime",                       :precision => 5,  :scale => 1,                  :null => false
    t.datetime "forgpdate",                                                                       :null => false
    t.datetime "flstpdate",                                                                       :null => false
    t.string   "fmultirls",        :limit => 1,                                                   :null => false
    t.integer  "fnextrels",        :limit => nil, :precision => 3,  :scale => 0,                  :null => false
    t.decimal  "fnqtydm",                         :precision => 15, :scale => 5,                  :null => false
    t.datetime "freqdate",                                                                        :null => false
    t.decimal  "fretqty",                         :precision => 15, :scale => 5,                  :null => false
    t.decimal  "fordqty",                         :precision => 15, :scale => 5,                  :null => false
    t.decimal  "fqtyutol",                        :precision => 6,  :scale => 2,                  :null => false
    t.decimal  "fqtyltol",                        :precision => 6,  :scale => 2,                  :null => false
    t.decimal  "fbkordqty",                       :precision => 15, :scale => 5,                  :null => false
    t.datetime "flstsdate",                                                                       :null => false
    t.datetime "frcpdate",                                                                        :null => false
    t.decimal  "frcpqty",                         :precision => 15, :scale => 5,                  :null => false
    t.decimal  "fshpqty",                         :precision => 15, :scale => 5,                  :null => false
    t.decimal  "finvqty",                         :precision => 15, :scale => 5,                  :null => false
    t.decimal  "fdiscount",                       :precision => 5,  :scale => 1,                  :null => false
    t.string   "frework",          :limit => 1,                                                   :null => false
    t.boolean  "fstandard",                                                                       :null => false
    t.string   "ftax",             :limit => 1,                                                   :null => false
    t.decimal  "fsalestax",                       :precision => 7,  :scale => 3,                  :null => false
    t.string   "finspect",         :limit => 1,                                                   :null => false
    t.decimal  "flcost",                          :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fucost",                          :precision => 17, :scale => 5,                  :null => false
    t.string   "fprintmemo",       :limit => 1,                                                   :null => false
    t.decimal  "fvlstcost",                       :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fvleadtime",                      :precision => 5,  :scale => 1,                  :null => false
    t.string   "fvmeasure",        :limit => 5,                                                   :null => false
    t.string   "fvpartno",         :limit => 25,                                                  :null => false
    t.string   "fvptdes",          :limit => 35,                                 :default => " ", :null => false
    t.decimal  "fvordqty",                        :precision => 15, :scale => 5,                  :null => false
    t.decimal  "fvconvfact",                      :precision => 13, :scale => 9,                  :null => false
    t.decimal  "fvucost",                         :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fqtyshipr",                       :precision => 15, :scale => 5,                  :null => false
    t.datetime "fdateship",                                                                       :null => false
    t.string   "fparentpo",        :limit => 6,                                                   :null => false
    t.string   "frmano",           :limit => 25,                                                  :null => false
    t.string   "fdebitmemo",       :limit => 1,                                                   :null => false
    t.string   "finspcode",        :limit => 4,                                                   :null => false
    t.string   "freceiver",        :limit => 6,                                                   :null => false
    t.decimal  "fnorgucost",                      :precision => 17, :scale => 5,                  :null => false
    t.string   "fcorgcateg",       :limit => 19,                                                  :null => false
    t.string   "fparentitm",       :limit => 3,                                                   :null => false
    t.string   "fparentrls",       :limit => 3,                                                   :null => false
    t.string   "frecvitm",         :limit => 3,                                                   :null => false
    t.decimal  "fnorgeurcost",                    :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fnorgtxncost",                    :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fueurocost",                      :precision => 17, :scale => 5,                  :null => false
    t.decimal  "futxncost",                       :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fvueurocost",                     :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fvutxncost",                      :precision => 17, :scale => 5,                  :null => false
    t.boolean  "fljrdif",                                                                         :null => false
    t.decimal  "fucostonly",                      :precision => 17, :scale => 5,                  :null => false
    t.decimal  "futxncston",                      :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fueurcston",                      :precision => 17, :scale => 5,                  :null => false
    t.string   "fcbin",            :limit => 14,                                                  :null => false
    t.string   "fcloc",            :limit => 14,                                                  :null => false
    t.binary   "timestamp_column"
    t.text     "fcomments",                                                      :default => " ", :null => false
    t.text     "fdescript",                                                      :default => " ", :null => false
    t.string   "Fac",              :limit => 20,                                                  :null => false
    t.string   "fcudrev",          :limit => 3,                                  :default => " ", :null => false
    t.integer  "fndbrmod",         :limit => nil, :precision => 1,  :scale => 0, :default => 0,   :null => false
  end

  add_index "poitem", ["fcorgcateg"], :name => "orgcateg"
  add_index "poitem", ["fjokey", "fjoitm"], :name => "jobno"
  add_index "poitem", ["fjokey", "fjoopno"], :name => "jokey"
  add_index "poitem", ["flstpdate"], :name => "duedate"
  add_index "poitem", ["fmultirls", "frelsno"], :name => "masterrel"
  add_index "poitem", ["fordqty", "frcpqty", "finvqty"], :name => "inv_qty"
  add_index "poitem", ["fparentitm", "fparentrls", "fparentpo"], :name => "return_"
  add_index "poitem", ["fpartno", "fjokey", "frev", "Fac"], :name => "partjob"
  add_index "poitem", ["fpartno", "frev", "Fac"], :name => "partno"
  add_index "poitem", ["fpono", "fitemno", "frelsno"], :name => "poitem"
  add_index "poitem", ["fpono", "fjokey", "fpartno", "frev", "frelsno"], :name => "jorels"
  add_index "poitem", ["fqtyshipr", "fnqtydm", "fretqty"], :name => "dm_qty"
  add_index "poitem", ["frelsno"], :name => "relsno"
  add_index "poitem", ["fsokey", "fsoitm", "fsorls"], :name => "sokey"
  add_index "poitem", ["fvpartno"], :name => "vpartno"
  add_index "poitem", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "poitemdl", :primary_key => "identity_column", :force => true do |t|
    t.integer "fipoitemid",                                                     :null => false
    t.integer "fitype",                                                         :null => false
    t.integer "fiqty",                                                          :null => false
    t.boolean "flpartial",                                                      :null => false
    t.integer "fium1"
    t.decimal "fnsize1",          :precision => 18, :scale => 5
    t.integer "fium2"
    t.decimal "fnsize2",          :precision => 18, :scale => 5
    t.integer "fium3"
    t.decimal "fnsize3",          :precision => 18, :scale => 5
    t.integer "fium4"
    t.decimal "fnsize4",          :precision => 18, :scale => 5
    t.integer "fium5"
    t.decimal "fnsize5",          :precision => 18, :scale => 5
    t.binary  "timestamp_column"
    t.integer "FICOUNT",                                         :default => 0, :null => false
  end

  add_index "poitemdl", ["fipoitemid", "fitype"], :name => "POItemID"
  add_index "poitemdl", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "poland", :primary_key => "identity_column", :force => true do |t|
    t.string  "fitemno",          :limit => 3,                                :null => false
    t.decimal "fneurfob",                      :precision => 17, :scale => 5, :null => false
    t.decimal "fneurfrt",                      :precision => 17, :scale => 5, :null => false
    t.decimal "fneuroc1",                      :precision => 17, :scale => 5, :null => false
    t.decimal "fneuroc2",                      :precision => 17, :scale => 5, :null => false
    t.decimal "fneuroc3",                      :precision => 17, :scale => 5, :null => false
    t.decimal "fneuroc4",                      :precision => 17, :scale => 5, :null => false
    t.decimal "fneuroc5",                      :precision => 17, :scale => 5, :null => false
    t.decimal "fneuroc6",                      :precision => 17, :scale => 5, :null => false
    t.decimal "fnfobamt",                      :precision => 17, :scale => 5, :null => false
    t.decimal "fnfreight",                     :precision => 17, :scale => 5, :null => false
    t.decimal "fnothcst1",                     :precision => 17, :scale => 5, :null => false
    t.decimal "fnothcst2",                     :precision => 17, :scale => 5, :null => false
    t.decimal "fnothcst3",                     :precision => 17, :scale => 5, :null => false
    t.decimal "fnothcst4",                     :precision => 17, :scale => 5, :null => false
    t.decimal "fnothcst5",                     :precision => 17, :scale => 5, :null => false
    t.decimal "fnothcst6",                     :precision => 17, :scale => 5, :null => false
    t.decimal "fnpfreight",                    :precision => 7,  :scale => 1, :null => false
    t.decimal "fnpothcst1",                    :precision => 7,  :scale => 1, :null => false
    t.decimal "fnpothcst2",                    :precision => 7,  :scale => 1, :null => false
    t.decimal "fnpothcst3",                    :precision => 7,  :scale => 1, :null => false
    t.decimal "fnpothcst4",                    :precision => 7,  :scale => 1, :null => false
    t.decimal "fnpothcst5",                    :precision => 7,  :scale => 1, :null => false
    t.decimal "fnpothcst6",                    :precision => 7,  :scale => 1, :null => false
    t.decimal "fntxnfob",                      :precision => 17, :scale => 5, :null => false
    t.decimal "fntxnfrt",                      :precision => 17, :scale => 5, :null => false
    t.decimal "fntxnoc1",                      :precision => 17, :scale => 5, :null => false
    t.decimal "fntxnoc2",                      :precision => 17, :scale => 5, :null => false
    t.decimal "fntxnoc3",                      :precision => 17, :scale => 5, :null => false
    t.decimal "fntxnoc4",                      :precision => 17, :scale => 5, :null => false
    t.decimal "fntxnoc5",                      :precision => 17, :scale => 5, :null => false
    t.decimal "fntxnoc6",                      :precision => 17, :scale => 5, :null => false
    t.string  "fpono",            :limit => 6,                                :null => false
    t.string  "frelsno",          :limit => 3,                                :null => false
    t.binary  "timestamp_column"
  end

  add_index "poland", ["fpono", "fitemno", "frelsno"], :name => "POLAND"
  add_index "poland", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "pomast", :primary_key => "identity_column", :force => true do |t|
    t.string   "fcompany",         :limit => 35,                                 :default => " ", :null => false
    t.string   "fcshipto",         :limit => 8,                                                   :null => false
    t.datetime "forddate",                                                                        :null => false
    t.string   "fpono",            :limit => 6,                                                   :null => false
    t.string   "fstatus",          :limit => 20,                                                  :null => false
    t.string   "fvendno",          :limit => 6,                                                   :null => false
    t.string   "fbuyer",           :limit => 3,                                                   :null => false
    t.string   "fchangeby",        :limit => 25,                                                  :null => false
    t.datetime "fcngdate",                                                                        :null => false
    t.string   "fconfirm",         :limit => 19,                                                  :null => false
    t.string   "fcontact",         :limit => 20,                                                  :null => false
    t.string   "fcfname",          :limit => 15,                                                  :null => false
    t.datetime "fcreate",                                                                         :null => false
    t.string   "ffob",             :limit => 20,                                                  :null => false
    t.string   "fmethod",          :limit => 1,                                                   :null => false
    t.string   "foldstatus",       :limit => 20,                                                  :null => false
    t.datetime "fordrevdt",                                                                       :null => false
    t.decimal  "fordtot",                         :precision => 15, :scale => 5,                  :null => false
    t.string   "fpayterm",         :limit => 4,                                                   :null => false
    t.string   "fpaytype",         :limit => 1,                                                   :null => false
    t.string   "fporev",           :limit => 2,                                                   :null => false
    t.string   "fprint",           :limit => 1,                                                   :null => false
    t.datetime "freqdate",                                                                        :null => false
    t.datetime "freqsdt",                                                                         :null => false
    t.string   "freqsno",          :limit => 6,                                                   :null => false
    t.decimal  "frevtot",                         :precision => 15, :scale => 5,                  :null => false
    t.decimal  "fsalestax",                       :precision => 7,  :scale => 3,                  :null => false
    t.string   "fshipvia",         :limit => 20,                                                  :null => false
    t.string   "ftax",             :limit => 1,                                                   :null => false
    t.string   "fcsnaddrke",       :limit => 4,                                                   :null => false
    t.string   "fcsncity",         :limit => 20,                                                  :null => false
    t.string   "fcsnstate",        :limit => 20,                                                  :null => false
    t.string   "fcsnzip",          :limit => 10,                                                  :null => false
    t.string   "fcsncountr",       :limit => 25,                                                  :null => false
    t.string   "fcsnphone",        :limit => 20,                                                  :null => false
    t.string   "fcsnfax",          :limit => 20,                                                  :null => false
    t.string   "fcshkey",          :limit => 6,                                                   :null => false
    t.string   "fcshaddrke",       :limit => 4,                                                   :null => false
    t.string   "fcshcompan",       :limit => 35,                                 :default => " ", :null => false
    t.string   "fcshcity",         :limit => 20,                                                  :null => false
    t.string   "fcshstate",        :limit => 20,                                                  :null => false
    t.string   "fcshzip",          :limit => 10,                                                  :null => false
    t.string   "fcshcountr",       :limit => 25,                                                  :null => false
    t.string   "fcshphone",        :limit => 20,                                                  :null => false
    t.string   "fcshfax",          :limit => 20,                                                  :null => false
    t.integer  "fnnextitem",       :limit => nil, :precision => 3,  :scale => 0,                  :null => false
    t.string   "fautoclose",       :limit => 1,                                                   :null => false
    t.string   "fcusrchr1",        :limit => 20,                                                  :null => false
    t.string   "fcusrchr2",        :limit => 40,                                 :default => " ", :null => false
    t.string   "fcusrchr3",        :limit => 40,                                 :default => " ", :null => false
    t.decimal  "fnusrqty1",                       :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fnusrcur1",                                                                       :null => false
    t.datetime "fdusrdate1",                                                                      :null => false
    t.string   "fccurid",          :limit => 3,                                                   :null => false
    t.decimal  "fcfactor",                        :precision => 17, :scale => 5,                  :null => false
    t.datetime "fdcurdate",                                                                       :null => false
    t.datetime "fdeurodate",                                                                      :null => false
    t.decimal  "feurofctr",                       :precision => 17, :scale => 5,                  :null => false
    t.string   "fctype",           :limit => 1,                                                   :null => false
    t.binary   "timestamp_column"
    t.text     "fmpaytype",                                                      :default => " ", :null => false
    t.text     "fmshstreet",                                                     :default => " ", :null => false
    t.text     "fmsnstreet",                                                     :default => " ", :null => false
    t.text     "fmusrmemo1",                                                     :default => " ", :null => false
    t.text     "fpoclosing",                                                     :default => " ", :null => false
    t.text     "freasoncng",                                                     :default => " ", :null => false
    t.integer  "fndbrmod",         :limit => nil, :precision => 1,  :scale => 0, :default => 0,   :null => false
  end

  add_index "pomast", ["fcompany"], :name => "company"
  add_index "pomast", ["forddate"], :name => "orddate"
  add_index "pomast", ["fpono"], :name => "pono"
  add_index "pomast", ["fstatus"], :name => "status"
  add_index "pomast", ["fvendno", "fpono"], :name => "ven_po"
  add_index "pomast", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "poqfltr", :primary_key => "identity_column", :force => true do |t|
    t.string "fcname",           :limit => 25,                  :null => false
    t.binary "timestamp_column"
    t.text   "fmfltr",                         :default => " ", :null => false
  end

  add_index "poqfltr", ["fcname"], :name => "poqfltr"
  add_index "poqfltr", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "poqitm", :primary_key => "identity_column", :force => true do |t|
    t.datetime "fexpdate",                                                                       :null => false
    t.string   "fpartno",          :limit => 25,                                                 :null => false
    t.string   "fcpartrev",        :limit => 3,                                                  :null => false
    t.string   "fvendno",          :limit => 6,                                                  :null => false
    t.string   "fcompany",         :limit => 35,                                :default => " ", :null => false
    t.string   "fvpartno",         :limit => 25,                                                 :null => false
    t.string   "fvmeasure",        :limit => 3,                                                  :null => false
    t.decimal  "fvconvfact",                     :precision => 21, :scale => 5,                  :null => false
    t.decimal  "fbegin1",                        :precision => 15, :scale => 5,                  :null => false
    t.decimal  "fbegin2",                        :precision => 15, :scale => 5,                  :null => false
    t.decimal  "fbegin3",                        :precision => 15, :scale => 5,                  :null => false
    t.decimal  "fbegin4",                        :precision => 15, :scale => 5,                  :null => false
    t.decimal  "fbegin5",                        :precision => 15, :scale => 5,                  :null => false
    t.decimal  "fend1",                          :precision => 15, :scale => 5,                  :null => false
    t.decimal  "fend2",                          :precision => 15, :scale => 5,                  :null => false
    t.decimal  "fend3",                          :precision => 15, :scale => 5,                  :null => false
    t.decimal  "fend4",                          :precision => 15, :scale => 5,                  :null => false
    t.decimal  "fend5",                          :precision => 15, :scale => 5,                  :null => false
    t.string   "ffob",             :limit => 20,                                                 :null => false
    t.decimal  "fleadtime",                      :precision => 5,  :scale => 1,                  :null => false
    t.decimal  "fstdtime",                       :precision => 5,  :scale => 1,                  :null => false
    t.decimal  "fprice1",                        :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fprice2",                        :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fprice3",                        :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fprice4",                        :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fprice5",                        :precision => 17, :scale => 5,                  :null => false
    t.datetime "fquotedt",                                                                       :null => false
    t.string   "frfqno",           :limit => 9,                                                  :null => false
    t.string   "fvendquote",       :limit => 15,                                                 :null => false
    t.string   "fccurid",          :limit => 3,                                                  :null => false
    t.binary   "timestamp_column"
    t.string   "fcudrev",          :limit => 3,                                 :default => " ", :null => false
    t.string   "fac",              :limit => 20,                                                 :null => false
  end

  add_index "poqitm", ["fpartno", "fcpartrev", "frfqno", "fac"], :name => "PTRFQ"
  add_index "poqitm", ["fpartno", "fcpartrev", "fvendno", "fexpdate", "fac"], :name => "POQITM"
  add_index "poqitm", ["fpartno", "fvendno", "fccurid", "fexpdate", "fac"], :name => "POQITMCUR"
  add_index "poqitm", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "poqmast", :primary_key => "identity_column", :force => true do |t|
    t.boolean  "flmaster",                                                       :default => false,                 :null => false
    t.string   "fcsupdem",         :limit => 6,                                  :default => " ",                   :null => false
    t.string   "fcorderact",       :limit => 1,                                  :default => " ",                   :null => false
    t.string   "fcpartno",         :limit => 25,                                 :default => " ",                   :null => false
    t.string   "fcrev",            :limit => 3,                                  :default => " ",                   :null => false
    t.string   "fcmeasure",        :limit => 3,                                  :default => " ",                   :null => false
    t.decimal  "fntxnqty",                        :precision => 17, :scale => 5, :default => 0.0,                   :null => false
    t.datetime "fdtxndate",                                                      :default => '1900-01-01 00:00:00', :null => false
    t.decimal  "fnbalqty",                        :precision => 17, :scale => 5, :default => 0.0,                   :null => false
    t.decimal  "fnucost",                         :precision => 17, :scale => 5, :default => 0.0,                   :null => false
    t.string   "fcsource",         :limit => 5,                                  :default => " ",                   :null => false
    t.string   "fcponum",          :limit => 6,                                  :default => " ",                   :null => false
    t.string   "fcjonum",          :limit => 10,                                 :default => " ",                   :null => false
    t.integer  "fnjoopno",         :limit => nil, :precision => 4,  :scale => 0, :default => 0,                     :null => false
    t.string   "fcsonum",          :limit => 6,                                  :default => " ",                   :null => false
    t.string   "fcsoitm",          :limit => 3,                                  :default => " ",                   :null => false
    t.string   "fcsorls",          :limit => 3,                                  :default => " ",                   :null => false
    t.string   "fcdocrev",         :limit => 2,                                  :default => " ",                   :null => false
    t.string   "fcabccd",          :limit => 1,                                  :default => " ",                   :null => false
    t.string   "fcprdcls",         :limit => 2,                                  :default => " ",                   :null => false
    t.string   "fcgrpcod",         :limit => 6,                                  :default => " ",                   :null => false
    t.string   "fcplanner",        :limit => 3,                                  :default => " ",                   :null => false
    t.string   "fcvendno",         :limit => 6,                                  :default => " ",                   :null => false
    t.string   "fcvendna",         :limit => 35,                                 :default => " ",                   :null => false
    t.string   "fccompna",         :limit => 35,                                 :default => " ",                   :null => false
    t.string   "fcqsource",        :limit => 1,                                  :default => " ",                   :null => false
    t.decimal  "fonhand",                         :precision => 15, :scale => 5, :default => 0.0,                   :null => false
    t.decimal  "fonorder",                        :precision => 15, :scale => 5, :default => 0.0,                   :null => false
    t.decimal  "fqtyinspec",                      :precision => 15, :scale => 5, :default => 0.0,                   :null => false
    t.binary   "timestamp_column"
    t.text     "fmdesc",                                                         :default => " ",                   :null => false
    t.string   "fac",              :limit => 20,                                                                    :null => false
    t.string   "fcudrev",          :limit => 3,                                  :default => " ",                   :null => false
  end

  add_index "poqmast", ["fcjonum"], :name => "jo"
  add_index "poqmast", ["fcpartno", "fcrev", "fdtxndate"], :name => "POQMAST"
  add_index "poqmast", ["fcsonum", "fcsoitm", "fcsorls"], :name => "so"
  add_index "poqmast", ["fcvendno"], :name => "vendor"
  add_index "poqmast", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "poqrec", :primary_key => "identity_column", :force => true do |t|
    t.string "fpartno",          :limit => 25,                  :null => false
    t.string "frev",             :limit => 3,                   :null => false
    t.string "fdescript",        :limit => 35, :default => " ", :null => false
    t.string "fmeasure",         :limit => 3,                   :null => false
    t.binary "timestamp_column"
    t.string "fcudrev",          :limit => 3,  :default => " ", :null => false
    t.string "fac",              :limit => 20,                  :null => false
  end

  add_index "poqrec", ["fpartno", "frev", "fac"], :name => "POQREC"
  add_index "poqrec", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "porevm", :primary_key => "identity_column", :force => true do |t|
    t.string   "fpono",            :limit => 6,                                                  :null => false
    t.string   "fporev",           :limit => 2,                                                  :null => false
    t.string   "fauthorby",        :limit => 20,                                                 :null => false
    t.decimal  "fpurchcost",                     :precision => 17, :scale => 5,                  :null => false
    t.datetime "frevdate",                                                                       :null => false
    t.binary   "timestamp_column"
    t.text     "frevmemo",                                                      :default => " ", :null => false
  end

  add_index "porevm", ["fpono", "fporev"], :name => "POREVM"
  add_index "porevm", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "porfqi", :primary_key => "identity_column", :force => true do |t|
    t.string  "fitemno",          :limit => 3,                                 :default => " ",   :null => false
    t.string  "fpartno",          :limit => 25,                                :default => " ",   :null => false
    t.string  "frev",             :limit => 3,                                 :default => " ",   :null => false
    t.string  "frfqno",           :limit => 9,                                 :default => " ",   :null => false
    t.string  "fmeasure",         :limit => 3,                                 :default => " ",   :null => false
    t.string  "fprintmemo",       :limit => 1,                                 :default => " ",   :null => false
    t.string  "fprodcl",          :limit => 2,                                 :default => " ",   :null => false
    t.decimal "frfqqty1",                       :precision => 15, :scale => 5, :default => 0.0,   :null => false
    t.decimal "frfqqty2",                       :precision => 15, :scale => 5, :default => 0.0,   :null => false
    t.decimal "frfqqty3",                       :precision => 15, :scale => 5, :default => 0.0,   :null => false
    t.decimal "frfqqty4",                       :precision => 15, :scale => 5, :default => 0.0,   :null => false
    t.decimal "frfqqty5",                       :precision => 15, :scale => 5, :default => 0.0,   :null => false
    t.boolean "fstandard",                                                     :default => false, :null => false
    t.binary  "timestamp_column"
    t.text    "fcomments",                                                     :default => " ",   :null => false
    t.text    "fdescript",                                                     :default => " ",   :null => false
    t.string  "fac",              :limit => 20,                                                   :null => false
    t.string  "fcudrev",          :limit => 3,                                 :default => " ",   :null => false
  end

  add_index "porfqi", ["fpartno", "frev", "fac"], :name => "PARTNO"
  add_index "porfqi", ["frfqno", "fitemno"], :name => "PORFQI"
  add_index "porfqi", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "porfqm", :primary_key => "identity_column", :force => true do |t|
    t.string   "fcompany",         :limit => 35,                                :default => " ", :null => false
    t.string   "freqby",           :limit => 3,                                                  :null => false
    t.string   "frfqno",           :limit => 9,                                                  :null => false
    t.string   "fvendno",          :limit => 6,                                                  :null => false
    t.string   "fbuyer",           :limit => 5,                                                  :null => false
    t.string   "fcity",            :limit => 15,                                                 :null => false
    t.string   "fcontact",         :limit => 20,                                                 :null => false
    t.string   "fcfname",          :limit => 15,                                                 :null => false
    t.string   "fcountry",         :limit => 25,                                                 :null => false
    t.string   "ffob",             :limit => 20,                                                 :null => false
    t.string   "fphone",           :limit => 20,                                                 :null => false
    t.string   "fcfax",            :limit => 20,                                                 :null => false
    t.string   "fprint",           :limit => 1,                                                  :null => false
    t.datetime "frfqdate",                                                                       :null => false
    t.string   "fshipvia",         :limit => 20,                                                 :null => false
    t.string   "fcsnaddkey",       :limit => 4,                                                  :null => false
    t.string   "fstate",           :limit => 20,                                                 :null => false
    t.string   "fstatus",          :limit => 10,                                                 :null => false
    t.string   "fzip",             :limit => 10,                                                 :null => false
    t.string   "frcompany",        :limit => 35,                                :default => " ", :null => false
    t.string   "frcity",           :limit => 15,                                                 :null => false
    t.string   "frstate",          :limit => 20,                                                 :null => false
    t.string   "frzip",            :limit => 10,                                                 :null => false
    t.string   "frcountry",        :limit => 25,                                                 :null => false
    t.string   "fcreqno",          :limit => 6,                                                  :null => false
    t.datetime "freqdate",                                                                       :null => false
    t.datetime "fdreturnby",                                                                     :null => false
    t.integer  "fnlastitem",       :limit => nil, :precision => 3, :scale => 0,                  :null => false
    t.string   "fccurid",          :limit => 3,                                                  :null => false
    t.binary   "timestamp_column"
    t.text     "fmstreet",                                                      :default => " ", :null => false
    t.text     "frfqclsing",                                                    :default => " ", :null => false
    t.text     "frmstreet",                                                     :default => " ", :null => false
  end

  add_index "porfqm", ["frfqno"], :name => "porfqm"
  add_index "porfqm", ["fstatus"], :name => "status"
  add_index "porfqm", ["fvendno"], :name => "vendor"
  add_index "porfqm", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "potax", :primary_key => "identity_column", :force => true do |t|
    t.string  "fpono",            :limit => 6,  :null => false
    t.string  "finumber",         :limit => 3,  :null => false
    t.string  "frelsno",          :limit => 3,  :null => false
    t.string  "fcjrdict",         :limit => 10, :null => false
    t.string  "fctaxcode",        :limit => 10, :null => false
    t.integer "fnorder",                        :null => false
    t.binary  "timestamp_column"
  end

  add_index "potax", ["fpono", "finumber", "frelsno", "fnorder"], :name => "JRPOORDER"
  add_index "potax", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "pqdetl", :primary_key => "identity_column", :force => true do |t|
    t.string   "fcavendno",        :limit => 6,                                                   :null => false
    t.string   "fccomment",        :limit => 20,                                                  :null => false
    t.string   "fcdocno",          :limit => 25,                                                  :null => false
    t.string   "fcjono",           :limit => 10,                                                  :null => false
    t.string   "fclineno",         :limit => 3,                                                   :null => false
    t.string   "fcpartno",         :limit => 25,                                                  :null => false
    t.string   "fcpartrev",        :limit => 3,                                                   :null => false
    t.string   "fcpoitm",          :limit => 3,                                                   :null => false
    t.string   "fcpono",           :limit => 6,                                                   :null => false
    t.string   "fcporls",          :limit => 3,                                                   :null => false
    t.string   "fcrecsrc",         :limit => 1,                                                   :null => false
    t.string   "fcsoitm",          :limit => 3,                                                   :null => false
    t.string   "fcsono",           :limit => 6,                                                   :null => false
    t.string   "fcsorls",          :limit => 3,                                                   :null => false
    t.string   "fcsource",         :limit => 5,                                                   :null => false
    t.string   "fcstatus",         :limit => 10,                                                  :null => false
    t.string   "fcsupdem",         :limit => 1,                                                   :null => false
    t.string   "fctype",           :limit => 2,                                                   :null => false
    t.string   "fcwcid",           :limit => 7,                                                   :null => false
    t.datetime "fdactdate",                                                                       :null => false
    t.datetime "fdduedate",                                                                       :null => false
    t.boolean  "flactreqd",                                                                       :null => false
    t.boolean  "flactsel",                                                                        :null => false
    t.boolean  "flvendsel",                                                                       :null => false
    t.decimal  "fnextcost",                       :precision => 17, :scale => 5,                  :null => false
    t.integer  "fnjoopno",         :limit => nil, :precision => 4,  :scale => 0,                  :null => false
    t.decimal  "fnordqty",                        :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fnqtyavail",                      :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fntxnqty",                        :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fnunitcost",                      :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fnnetavail",                      :precision => 17, :scale => 5,                  :null => false
    t.string   "fcjodbomno",       :limit => 4,                                                   :null => false
    t.binary   "timestamp_column"
    t.string   "fac",              :limit => 20,                                                  :null => false
    t.string   "fcudrev",          :limit => 3,                                  :default => " ", :null => false
  end

  add_index "pqdetl", ["fcpartno", "fcpartrev", "fclineno", "fac"], :name => "pqdetl"
  add_index "pqdetl", ["fcpartno", "fcpartrev", "fdactdate", "fac"], :name => "actdate"
  add_index "pqdetl", ["fcpartno", "fcpartrev", "fdduedate", "fcsupdem", "fac"], :name => "duedate"
  add_index "pqdetl", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "pqfilt", :primary_key => "identity_column", :force => true do |t|
    t.string   "fcabcfrm",         :limit => 1,                                                  :null => false
    t.string   "fcabcthr",         :limit => 1,                                                  :null => false
    t.string   "fccustno",         :limit => 6,                                                  :null => false
    t.string   "fcextcstop",       :limit => 2,                                                  :null => false
    t.string   "fcfiltname",       :limit => 25,                                                 :null => false
    t.string   "fcgroupfrm",       :limit => 6,                                                  :null => false
    t.string   "fcgroupthr",       :limit => 6,                                                  :null => false
    t.string   "fcjofrm",          :limit => 10,                                                 :null => false
    t.string   "fcjothr",          :limit => 10,                                                 :null => false
    t.string   "fcplnnrfrm",       :limit => 3,                                                  :null => false
    t.string   "fcplnnrthr",       :limit => 3,                                                  :null => false
    t.string   "fcprdclfrm",       :limit => 2,                                                  :null => false
    t.string   "fcprdclthr",       :limit => 2,                                                  :null => false
    t.string   "fcprtnofrm",       :limit => 25,                                                 :null => false
    t.string   "fcprtnothr",       :limit => 25,                                                 :null => false
    t.string   "fcsofrm",          :limit => 6,                                                  :null => false
    t.string   "fcsothr",          :limit => 6,                                                  :null => false
    t.string   "fcvndnofrm",       :limit => 6,                                                  :null => false
    t.string   "fcvndnothr",       :limit => 6,                                                  :null => false
    t.string   "fcwcid",           :limit => 7,                                                  :null => false
    t.datetime "fdactdtthr",                                                                     :null => false
    t.datetime "fdduedtthr",                                                                     :null => false
    t.datetime "fdlastgen",                                                                      :null => false
    t.boolean  "flabc",                                                                          :null => false
    t.boolean  "flactdt",                                                                        :null => false
    t.boolean  "fladvfilt",                                                                      :null => false
    t.boolean  "flcustsup",                                                                      :null => false
    t.boolean  "flduedt",                                                                        :null => false
    t.boolean  "flexcst",                                                                        :null => false
    t.boolean  "flgroup",                                                                        :null => false
    t.boolean  "fljo",                                                                           :null => false
    t.boolean  "flnspn",                                                                         :null => false
    t.boolean  "flplnnr",                                                                        :null => false
    t.boolean  "flprdcl",                                                                        :null => false
    t.boolean  "flprtno",                                                                        :null => false
    t.boolean  "flsftystk",                                                                      :null => false
    t.boolean  "flso",                                                                           :null => false
    t.boolean  "flsubcon",                                                                       :null => false
    t.boolean  "flvndno",                                                                        :null => false
    t.decimal  "fnextcstth",                     :precision => 17, :scale => 5,                  :null => false
    t.binary   "timestamp_column"
    t.text     "fmadvfilt",                                                     :default => " ", :null => false
    t.text     "fmfiltexpr",                                                    :default => " ", :null => false
    t.string   "fcfacfrm",         :limit => 20,                                                 :null => false
    t.string   "fcfacthr",         :limit => 20,                                                 :null => false
    t.boolean  "flfacility",                                                                     :null => false
    t.string   "fac",              :limit => 20,                                                 :null => false
  end

  add_index "pqfilt", ["fcfiltname"], :name => "filtnam"
  add_index "pqfilt", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "pqsumm", :primary_key => "identity_column", :force => true do |t|
    t.string   "fcabc",            :limit => 1,                                                    :null => false
    t.string   "fcavendno",        :limit => 6,                                                    :null => false
    t.string   "fcavname",         :limit => 35,                                  :default => " ", :null => false
    t.string   "fcavuom",          :limit => 3,                                                    :null => false
    t.string   "fccomment",        :limit => 20,                                                   :null => false
    t.string   "fcgroup",          :limit => 6,                                                    :null => false
    t.string   "fcpartdesc",       :limit => 35,                                  :default => " ", :null => false
    t.string   "fcpartno",         :limit => 25,                                                   :null => false
    t.string   "fcpartrev",        :limit => 3,                                                    :null => false
    t.string   "fcplanner",        :limit => 3,                                                    :null => false
    t.string   "fcprcl",           :limit => 2,                                                    :null => false
    t.string   "fcpvendno",        :limit => 6,                                                    :null => false
    t.string   "fcpvname",         :limit => 35,                                  :default => " ", :null => false
    t.string   "fcpvuom",          :limit => 3,                                                    :null => false
    t.string   "fcucdoc",          :limit => 20,                                                   :null => false
    t.string   "fcucsrc",          :limit => 1,                                                    :null => false
    t.string   "fcuom",            :limit => 3,                                                    :null => false
    t.datetime "fdactdate",                                                                        :null => false
    t.datetime "fdduedate",                                                                        :null => false
    t.datetime "fdgentime",                                                                        :null => false
    t.boolean  "flactreqd",                                                                        :null => false
    t.boolean  "flactsel",                                                                         :null => false
    t.boolean  "flstartpo",                                                                        :null => false
    t.boolean  "flvendsel",                                                                        :null => false
    t.decimal  "fnavconv",                        :precision => 17, :scale => 10,                  :null => false
    t.decimal  "fnininsp",                        :precision => 17, :scale => 5,                   :null => false
    t.integer  "fnleadtime",       :limit => nil, :precision => 5,  :scale => 0,                   :null => false
    t.decimal  "fnonhand",                        :precision => 17, :scale => 5,                   :null => false
    t.decimal  "fnonord",                         :precision => 17, :scale => 5,                   :null => false
    t.decimal  "fnordqty",                        :precision => 17, :scale => 5,                   :null => false
    t.decimal  "fnqtyavail",                      :precision => 17, :scale => 5,                   :null => false
    t.decimal  "fnreord",                         :precision => 17, :scale => 5,                   :null => false
    t.decimal  "fnsafety",                        :precision => 17, :scale => 5,                   :null => false
    t.decimal  "fnunitcost",                      :precision => 17, :scale => 5,                   :null => false
    t.decimal  "fnnetavail",                      :precision => 17, :scale => 5,                   :null => false
    t.binary   "timestamp_column"
    t.string   "fac",              :limit => 20,                                                   :null => false
    t.string   "fcudrev",          :limit => 3,                                   :default => " ", :null => false
    t.decimal  "fnonnetqty",                      :precision => 15, :scale => 5,  :default => 0.0, :null => false
  end

  add_index "pqsumm", ["fcpartno", "fcpartrev", "fac"], :name => "partno"
  add_index "pqsumm", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "prdept", :primary_key => "identity_column", :force => true do |t|
    t.string "fdeptno",          :limit => 2,                   :null => false
    t.string "fdeptdesc",        :limit => 35, :default => " ", :null => false
    t.string "fholaccno",        :limit => 25,                  :null => false
    t.string "fothaccno",        :limit => 25,                  :null => false
    t.string "fsickaccno",       :limit => 25,                  :null => false
    t.string "fvacaccno",        :limit => 25,                  :null => false
    t.binary "timestamp_column"
    t.string "fac",              :limit => 20, :default => " ", :null => false
  end

  add_index "prdept", ["fdeptno"], :name => "deptno"
  add_index "prdept", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "prdist", :primary_key => "identity_column", :force => true do |t|
    t.string   "fcacctnum",        :limit => 25,                  :null => false
    t.string   "fcstatus",         :limit => 1,                   :null => false
    t.datetime "fchkdate",                                        :null => false
    t.string   "fcdesc",           :limit => 35, :default => " ", :null => false
    t.decimal  "fnamount",                                        :null => false
    t.string   "fcuser_id",        :limit => 4,                   :null => false
    t.string   "fctime_ts",        :limit => 8,                   :null => false
    t.string   "fcrefname",        :limit => 4,                   :null => false
    t.string   "fcrefclass",       :limit => 1,                   :null => false
    t.datetime "fddate",                                          :null => false
    t.string   "fempno",           :limit => 9,                   :null => false
    t.binary   "timestamp_column"
  end

  add_index "prdist", ["fcacctnum"], :name => "acctnum"
  add_index "prdist", ["fcstatus"], :name => "fcstatus"
  add_index "prdist", ["fddate"], :name => "fddate"
  add_index "prdist", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "prempl", :primary_key => "identity_column", :force => true do |t|
    t.string   "fempno",           :limit => 9,                                                   :null => false
    t.string   "fname",            :limit => 20,                                                  :null => false
    t.string   "ffname",           :limit => 20,                                                  :null => false
    t.string   "fmi",              :limit => 1,                                                   :null => false
    t.datetime "fbirthdate",                                                                      :null => false
    t.string   "fcity",            :limit => 35,                                 :default => " ", :null => false
    t.string   "fdept",            :limit => 2,                                                   :null => false
    t.datetime "fendate",                                                                         :null => false
    t.integer  "fnshift",          :limit => nil, :precision => 1,  :scale => 0,                  :null => false
    t.string   "fpaytype",         :limit => 2,                                                   :null => false
    t.string   "fphone",           :limit => 20,                                                  :null => false
    t.decimal  "freghr",                          :precision => 7,  :scale => 2,                  :null => false
    t.string   "fssn",             :limit => 15,                                                  :null => false
    t.string   "fstate",           :limit => 20,                                                  :null => false
    t.string   "fzip",             :limit => 10,                                                  :null => false
    t.string   "emgcontact",       :limit => 30,                                 :default => " ", :null => false
    t.string   "emgphone",         :limit => 20,                                                  :null => false
    t.decimal  "fgross",                          :precision => 11, :scale => 2,                  :null => false
    t.string   "fcountry",         :limit => 25,                                                  :null => false
    t.string   "fcemail",          :limit => 60,                                 :default => " ", :null => false
    t.binary   "timestamp_column"
    t.text     "faddress",                                                       :default => " ", :null => false
    t.datetime "fhiredate",                                                                       :null => false
  end

  add_index "prempl", ["fempno"], :name => "empno"
  add_index "prempl", ["fname", "ffname", "fmi"], :name => "NAME"
  add_index "prempl", ["fpaytype"], :name => "paytype"
  add_index "prempl", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "prgrn", :primary_key => "identity_column", :force => true do |t|
    t.string  "fcpartno",         :limit => 25,                                                 :null => false
    t.string  "fcpartrev",        :limit => 3,                                                  :null => false
    t.string  "fcorder",          :limit => 3,                                                  :null => false
    t.integer "fngrninc",         :limit => nil, :precision => 3, :scale => 0,                  :null => false
    t.string  "fcgrnprd",         :limit => 6,                                                  :null => false
    t.integer "fngrndninc",       :limit => nil, :precision => 3, :scale => 0,                  :null => false
    t.string  "fcgrndnprd",       :limit => 6,                                                  :null => false
    t.binary  "timestamp_column"
    t.string  "fac",              :limit => 20,                                                 :null => false
    t.string  "fcudrev",          :limit => 3,                                 :default => " ", :null => false
  end

  add_index "prgrn", ["fcpartno", "fcpartrev", "fcorder", "fac"], :name => "PRGRN"
  add_index "prgrn", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "prinx", :primary_key => "identity_column", :force => true do |t|
    t.string  "fcpartno",         :limit => 25,                                                    :null => false
    t.string  "fcpartrv",         :limit => 3,                                                     :null => false
    t.string  "fcpartds",         :limit => 35,                                 :default => " ",   :null => false
    t.boolean "flexcmrp",                                                                          :null => false
    t.integer "fnlevel",          :limit => nil, :precision => 3,  :scale => 0,                    :null => false
    t.decimal "fncplead",                        :precision => 11, :scale => 4,                    :null => false
    t.decimal "fnfixsu",                         :precision => 11, :scale => 4,                    :null => false
    t.decimal "fnfixmfg",                        :precision => 11, :scale => 4,                    :null => false
    t.decimal "fnvarsu",                         :precision => 11, :scale => 4,                    :null => false
    t.decimal "fnvarmfg",                        :precision => 11, :scale => 4,                    :null => false
    t.boolean "flusefix",                                                                          :null => false
    t.integer "fnpoetol",         :limit => nil, :precision => 3,  :scale => 0,                    :null => false
    t.integer "fnpoltol",         :limit => nil, :precision => 3,  :scale => 0,                    :null => false
    t.integer "fnjoetol",         :limit => nil, :precision => 3,  :scale => 0,                    :null => false
    t.integer "fnjoltol",         :limit => nil, :precision => 3,  :scale => 0,                    :null => false
    t.integer "fndaysup",         :limit => nil, :precision => 3,  :scale => 0,                    :null => false
    t.boolean "flminord",                                                                          :null => false
    t.decimal "fnminord",                        :precision => 11, :scale => 4,                    :null => false
    t.boolean "flmaxord",                                                                          :null => false
    t.decimal "fnmaxord",                        :precision => 11, :scale => 4,                    :null => false
    t.boolean "flmltord",                                                                          :null => false
    t.decimal "fnmltord",                        :precision => 11, :scale => 4,                    :null => false
    t.integer "fnptmodel",        :limit => nil, :precision => 3,  :scale => 0,                    :null => false
    t.binary  "timestamp_column"
    t.string  "fac",              :limit => 20,                                                    :null => false
    t.string  "fcudrev",          :limit => 3,                                  :default => " ",   :null => false
    t.integer "fndbrmod",         :limit => nil, :precision => 1,  :scale => 0, :default => 0,     :null => false
    t.string  "fstocktype",       :limit => 1,                                  :default => "S",   :null => false
    t.integer "fdaysdemand",                                                    :default => 0,     :null => false
    t.boolean "fexclsched",                                                     :default => false, :null => false
    t.boolean "flmanplan",                                                      :default => false, :null => false
  end

  add_index "prinx", ["fcpartds"], :name => "desc_"
  add_index "prinx", ["fcpartno", "fcpartrv", "fac"], :name => "prinx"
  add_index "prinx", ["fnlevel"], :name => "level_"
  add_index "prinx", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "prmps", :primary_key => "identity_column", :force => true do |t|
    t.string   "fcpartno",         :limit => 25,                                                 :null => false
    t.string   "fcpartrev",        :limit => 3,                                                  :null => false
    t.boolean  "flpassthru",                                                                     :null => false
    t.string   "fctxntype",        :limit => 2,                                                  :null => false
    t.datetime "fdtxndate",                                                                      :null => false
    t.decimal  "fntxnqty",                       :precision => 17, :scale => 4,                  :null => false
    t.decimal  "fnmrpqty",                       :precision => 17, :scale => 4,                  :null => false
    t.string   "fcdocno",          :limit => 10,                                                 :null => false
    t.string   "fcdocitm",         :limit => 3,                                                  :null => false
    t.string   "fcdocrls",         :limit => 3,                                                  :null => false
    t.string   "fcdoctype",        :limit => 2,                                                  :null => false
    t.string   "fcsource",         :limit => 1,                                                  :null => false
    t.boolean  "flisapl",                                                                        :null => false
    t.binary   "timestamp_column"
    t.string   "fac",              :limit => 20,                                                 :null => false
    t.string   "fcudrev",          :limit => 3,                                 :default => " ", :null => false
  end

  add_index "prmps", ["fcpartno", "fcpartrev", "fctxntype", "fdtxndate", "fac"], :name => "TXNDATE"
  add_index "prmps", ["fcpartno", "fcpartrev", "fdtxndate", "fac"], :name => "PRMPS"
  add_index "prmps", ["fctxntype"], :name => "txntype"
  add_index "prmps", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "prmpsrs", :primary_key => "identity_column", :force => true do |t|
    t.boolean "flid",             :null => false
    t.integer "fnidfrom",         :null => false
    t.integer "fnidto",           :null => false
    t.boolean "flif",             :null => false
    t.integer "fniffrom",         :null => false
    t.integer "fnifto",           :null => false
    t.boolean "flms",             :null => false
    t.integer "fnmsfrom",         :null => false
    t.integer "fnmsto",           :null => false
    t.boolean "flsr",             :null => false
    t.integer "fnsrfrom",         :null => false
    t.integer "fnsrto",           :null => false
    t.binary  "timestamp_column"
  end

  add_index "prmpsrs", ["fnidfrom"], :name => "idfrom"
  add_index "prmpsrs", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "prmrp", :primary_key => "identity_column", :force => true do |t|
    t.string   "fcpartno",         :limit => 25,                                                 :null => false
    t.string   "fcpartrev",        :limit => 3,                                                  :null => false
    t.string   "fcdocno",          :limit => 10,                                                 :null => false
    t.string   "fcdocitm",         :limit => 3,                                                  :null => false
    t.string   "fcdocrls",         :limit => 3,                                                  :null => false
    t.string   "fctxntype",        :limit => 2,                                                  :null => false
    t.datetime "fdtxndate",                                                                      :null => false
    t.decimal  "fntxnqty",                       :precision => 17, :scale => 4,                  :null => false
    t.decimal  "fntxnbal",                       :precision => 17, :scale => 4,                  :null => false
    t.string   "fcdoctype",        :limit => 2,                                                  :null => false
    t.string   "fcsource",         :limit => 1,                                                  :null => false
    t.boolean  "flisapl",                                                                        :null => false
    t.binary   "timestamp_column"
    t.string   "fac",              :limit => 20,                                                 :null => false
    t.string   "fcudrev",          :limit => 3,                                 :default => " ", :null => false
  end

  add_index "prmrp", ["fcpartno", "fcpartrev", "fdtxndate", "fac"], :name => "PRMRP"
  add_index "prmrp", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "prmrpact", :primary_key => "identity_column", :force => true do |t|
    t.string   "fcpartno",         :limit => 25,                  :null => false
    t.string   "fcpartrev",        :limit => 3,                   :null => false
    t.string   "fcplanner",        :limit => 3,                   :null => false
    t.string   "fcvendno",         :limit => 6,                   :null => false
    t.integer  "fnmsgtype",                                       :null => false
    t.datetime "fdactdtbeg",                                      :null => false
    t.datetime "fdactdtend",                                      :null => false
    t.binary   "timestamp_column"
    t.string   "fac",              :limit => 20
    t.string   "fcudrev",          :limit => 3,  :default => " ", :null => false
  end

  add_index "prmrpact", ["fcpartno", "fcpartrev", "fac"], :name => "PARTNO"
  add_index "prmrpact", ["fcplanner", "fac", "fcpartno", "fcpartrev"], :name => "PARTPLAN"
  add_index "prmrpact", ["fcvendno", "fac", "fcpartno", "fcpartrev"], :name => "PARTVEND"
  add_index "prmrpact", ["fnmsgtype"], :name => "msgtype"
  add_index "prmrpact", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "prmrpmsg", :primary_key => "identity_column", :force => true do |t|
    t.string   "fcpartno",         :limit => 25,                                                 :null => false
    t.string   "fcpartrev",        :limit => 3,                                                  :null => false
    t.string   "fcpricod",         :limit => 2,                                                  :null => false
    t.string   "fcdocno",          :limit => 13,                                                 :null => false
    t.string   "fcdocitm",         :limit => 3,                                                  :null => false
    t.string   "fcdocrls",         :limit => 3,                                                  :null => false
    t.decimal  "fntxnqty",                       :precision => 17, :scale => 4,                  :null => false
    t.datetime "fdtxndate",                                                                      :null => false
    t.datetime "fdactdate",                                                                      :null => false
    t.datetime "fdduedate",                                                                      :null => false
    t.boolean  "flacttkn",                                                                       :null => false
    t.string   "fcplanner",        :limit => 3,                                                  :null => false
    t.binary   "timestamp_column"
    t.text     "fmmsg",                                                         :default => " ", :null => false
    t.string   "fac",              :limit => 20,                                                 :null => false
    t.string   "fcudrev",          :limit => 3,                                 :default => " ", :null => false
  end

  add_index "prmrpmsg", ["fcpartno", "fcpartrev", "fcplanner", "fac"], :name => "PARTPLAN"
  add_index "prmrpmsg", ["fcpartno", "fcpartrev", "fdtxndate", "fac"], :name => "PRMRPMSG"
  add_index "prmrpmsg", ["fcplanner"], :name => "planner"
  add_index "prmrpmsg", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "prmrpnav", :primary_key => "identity_column", :force => true do |t|
    t.integer "fiparent",                       :null => false
    t.integer "fime",                           :null => false
    t.binary  "timestamp_column"
    t.string  "fac",              :limit => 20, :null => false
  end

  add_index "prmrpnav", ["fime"], :name => "me"
  add_index "prmrpnav", ["fiparent"], :name => "parent"
  add_index "prmrpnav", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "prmrprs", :primary_key => "identity_column", :force => true do |t|
    t.boolean "fliraflg",                            :null => false
    t.boolean "flssinc",                             :null => false
    t.binary  "timestamp_column"
    t.boolean "flPurOnly",        :default => false
  end

  add_index "prmrprs", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "prpln", :primary_key => "identity_column", :force => true do |t|
    t.string   "fcpartno",         :limit => 25,                                                  :null => false
    t.string   "fcpartrev",        :limit => 3,                                                   :null => false
    t.string   "fctxntype",        :limit => 2,                                                   :null => false
    t.datetime "fdtxndate",                                                                       :null => false
    t.decimal  "fntxnqty",                        :precision => 17, :scale => 4,                  :null => false
    t.binary   "timestamp_column"
    t.text     "fmnotes",                                                        :default => " ", :null => false
    t.string   "fac",              :limit => 20,                                                  :null => false
    t.string   "fcudrev",          :limit => 3,                                  :default => " ", :null => false
    t.integer  "fndbrmod",         :limit => nil, :precision => 1,  :scale => 0, :default => 0,   :null => false
  end

  add_index "prpln", ["fcpartno", "fcpartrev", "fctxntype", "fdtxndate", "fac"], :name => "PRPLN"
  add_index "prpln", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "qainsp", :primary_key => "identity_column", :force => true do |t|
    t.string  "fcode",            :limit => 4,                   :null => false
    t.string  "fdesc",            :limit => 72, :default => " ", :null => false
    t.boolean "flpassinsp",                                      :null => false
    t.binary  "timestamp_column"
  end

  add_index "qainsp", ["fcode"], :name => "code"
  add_index "qainsp", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "qajors", :primary_key => "identity_column", :force => true do |t|
    t.string   "fcompany",         :limit => 35,                                 :default => " ", :null => false
    t.string   "fjobno",           :limit => 10,                                                  :null => false
    t.integer  "foperno",          :limit => nil, :precision => 4,  :scale => 0,                  :null => false
    t.string   "fcode",            :limit => 4,                                                   :null => false
    t.boolean  "fconfirm",                                                                        :null => false
    t.decimal  "fcost",                           :precision => 17, :scale => 5,                  :null => false
    t.string   "fdisp",            :limit => 15,                                                  :null => false
    t.string   "finsp_by",         :limit => 3,                                                   :null => false
    t.datetime "finsp_dt",                                                                        :null => false
    t.string   "fmeasure",         :limit => 3,                                                   :null => false
    t.string   "fpartno",          :limit => 25,                                                  :null => false
    t.string   "fcpartrev",        :limit => 3,                                                   :null => false
    t.string   "fpro_id",          :limit => 7,                                                   :null => false
    t.decimal  "fquantity",                       :precision => 15, :scale => 5,                  :null => false
    t.string   "fsubjob",          :limit => 10,                                                  :null => false
    t.string   "ftype",            :limit => 1,                                                   :null => false
    t.string   "fcaddby",          :limit => 4,                                                   :null => false
    t.integer  "fnrecno",          :limit => nil, :precision => 15, :scale => 0,                  :null => false
    t.binary   "timestamp_column"
    t.text     "fcomment",                                                       :default => " ", :null => false
    t.string   "fac",              :limit => 20,                                                  :null => false
    t.string   "fcudrev",          :limit => 3,                                  :default => " ", :null => false
  end

  add_index "qajors", ["fjobno", "foperno"], :name => "JOBOPER"
  add_index "qajors", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "qalotc", :primary_key => "identity_column", :force => true do |t|
    t.string   "fctype",           :limit => 1,                                                  :null => false
    t.string   "fcdoc",            :limit => 15,                                                 :null => false
    t.string   "fcpartno",         :limit => 25,                                                 :null => false
    t.string   "fcpartrev",        :limit => 3,                                                  :null => false
    t.string   "fclot",            :limit => 20,                                                 :null => false
    t.string   "fcuseintype",      :limit => 1,                                                  :null => false
    t.string   "fcuseindoc",       :limit => 15,                                                 :null => false
    t.string   "fcuseinpart",      :limit => 25,                                                 :null => false
    t.string   "fcuseinrev",       :limit => 3,                                                  :null => false
    t.string   "fcuseinlot",       :limit => 20,                                                 :null => false
    t.decimal  "fnquantity",                     :precision => 15, :scale => 5,                  :null => false
    t.string   "fcnumber",         :limit => 6,                                                  :null => false
    t.string   "fccompany",        :limit => 35,                                :default => " ", :null => false
    t.datetime "fddate",                                                                         :null => false
    t.string   "fcmeasure",        :limit => 3,                                                  :null => false
    t.binary   "timestamp_column"
    t.string   "fac",              :limit => 20,                                                 :null => false
    t.string   "useinfac",         :limit => 20,                                                 :null => false
    t.string   "fcudrev",          :limit => 3,                                 :default => " ", :null => false
  end

  add_index "qalotc", ["fctype", "fcdoc", "fac", "fcpartno", "fcpartrev", "fclot"], :name => "DOCPARTLOT"
  add_index "qalotc", ["fctype", "fcdoc", "fac", "fcpartno", "fcpartrev", "fcuseindoc"], :name => "TYPDOCPART"
  add_index "qalotc", ["fctype", "fcdoc", "fclot"], :name => "TYPEDOCLOT"
  add_index "qalotc", ["fcuseindoc", "fac", "fcpartno", "fcpartrev"], :name => "DOCPART"
  add_index "qalotc", ["fcuseintype", "fcuseindoc", "fcuseinlot", "fac", "fcpartno", "fcpartrev", "fclot"], :name => "USEINDOC"
  add_index "qalotc", ["fcuseintype", "fcuseindoc", "useinfac", "fcuseinpart", "fcuseinrev", "fcuseinlot"], :name => "USEINTYPE"
  add_index "qalotc", ["fddate"], :name => "FDDATE"
  add_index "qalotc", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "qaserl", :primary_key => "identity_column", :force => true do |t|
    t.string  "fitemno",          :limit => 6,                                 :default => " ", :null => false
    t.string  "fpartno",          :limit => 25,                                :default => " ", :null => false
    t.string  "fcpartrev",        :limit => 3,                                 :default => " ", :null => false
    t.string  "fserno",           :limit => 20,                                :default => " ", :null => false
    t.string  "fshipno",          :limit => 6,                                 :default => " ", :null => false
    t.decimal "fqty",                           :precision => 15, :scale => 5, :default => 0.0, :null => false
    t.binary  "timestamp_column"
    t.string  "fac",              :limit => 20,                                                 :null => false
    t.string  "fcudrev",          :limit => 3,                                 :default => " ", :null => false
  end

  add_index "qaserl", ["fshipno", "fitemno", "fserno"], :name => "SHIPITEM"
  add_index "qaserl", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "qtcbom", :primary_key => "identity_column", :force => true do |t|
    t.string  "finumber",         :limit => 3,                                                 :null => false
    t.string  "fquoteno",         :limit => 6,                                                 :null => false
    t.string  "fseqno",           :limit => 3,                                                 :null => false
    t.decimal "fmatlcost",                     :precision => 21, :scale => 9,                  :null => false
    t.binary  "timestamp_column"
    t.text    "fbomdesc",                                                     :default => " ", :null => false
  end

  add_index "qtcbom", ["fquoteno", "finumber", "fseqno"], :name => "SEQNO"
  add_index "qtcbom", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "qtchng", :primary_key => "identity_column", :force => true do |t|
    t.string   "fquoteno",         :limit => 6,                   :null => false
    t.string   "frevno",           :limit => 3,                   :null => false
    t.datetime "fdate",                                           :null => false
    t.string   "fstatus",          :limit => 20,                  :null => false
    t.string   "fcchangeby",       :limit => 3,                   :null => false
    t.string   "fccontact",        :limit => 20,                  :null => false
    t.string   "fcfname",          :limit => 15,                  :null => false
    t.binary   "timestamp_column"
    t.text     "fmreason",                       :default => " ", :null => false
  end

  add_index "qtchng", ["fquoteno", "fdate"], :name => "date"
  add_index "qtchng", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "qtcrtg", :primary_key => "identity_column", :force => true do |t|
    t.string  "finumber",         :limit => 3,                                                 :null => false
    t.string  "fquoteno",         :limit => 6,                                                 :null => false
    t.string  "fseqno",           :limit => 3,                                                 :null => false
    t.decimal "ftime",                         :precision => 15, :scale => 5,                  :null => false
    t.decimal "frate",                         :precision => 15, :scale => 5,                  :null => false
    t.binary  "timestamp_column"
    t.text    "frtgdesc",                                                     :default => " ", :null => false
  end

  add_index "qtcrtg", ["fquoteno", "finumber", "fseqno"], :name => "SEQNO"
  add_index "qtcrtg", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "qtdbom", :primary_key => "identity_column", :force => true do |t|
    t.string  "fbompart",         :limit => 25,                                 :default => " ",   :null => false
    t.string  "fbomrev",          :limit => 3,                                  :default => " ",   :null => false
    t.string  "fbominum",         :limit => 4,                                  :default => " ",   :null => false
    t.decimal "fbomlcost",                       :precision => 21, :scale => 8, :default => 0.0,   :null => false
    t.string  "fbommeas",         :limit => 3,                                  :default => " ",   :null => false
    t.decimal "fbomocost",                       :precision => 21, :scale => 8, :default => 0.0,   :null => false
    t.string  "fbomsource",       :limit => 1,                                  :default => " ",   :null => false
    t.string  "fcostfrom",        :limit => 6,                                  :default => " ",   :null => false
    t.decimal "fextqty",                         :precision => 19, :scale => 8, :default => 0.0,   :null => false
    t.decimal "ffixcost",                        :precision => 21, :scale => 8, :default => 0.0,   :null => false
    t.string  "finumber",         :limit => 3,                                  :default => " ",   :null => false
    t.string  "fitem",            :limit => 6,                                  :default => " ",   :null => false
    t.decimal "flabcost",                        :precision => 21, :scale => 8, :default => 0.0,   :null => false
    t.integer "flastoper",        :limit => nil, :precision => 4,  :scale => 0, :default => 0,     :null => false
    t.string  "flevel",           :limit => 2,                                  :default => " ",   :null => false
    t.boolean "flextend",                                                       :default => false, :null => false
    t.boolean "fltooling",                                                      :default => false, :null => false
    t.decimal "fmatlcost",                       :precision => 17, :scale => 5, :default => 0.0,   :null => false
    t.integer "fnonpro",          :limit => nil, :precision => 3,  :scale => 0, :default => 0,     :null => false
    t.integer "fnumopers",        :limit => nil, :precision => 4,  :scale => 0, :default => 0,     :null => false
    t.decimal "forgbomqty",                      :precision => 15, :scale => 5, :default => 0.0,   :null => false
    t.decimal "fothrcost",                       :precision => 21, :scale => 8, :default => 0.0,   :null => false
    t.decimal "fovhdcost",                       :precision => 21, :scale => 8, :default => 0.0,   :null => false
    t.string  "fparinum",         :limit => 4,                                  :default => " ",   :null => false
    t.string  "fquoteno",         :limit => 6,                                  :default => " ",   :null => false
    t.decimal "fsetupcost",                      :precision => 21, :scale => 8, :default => 0.0,   :null => false
    t.decimal "fsubcost",                        :precision => 21, :scale => 8, :default => 0.0,   :null => false
    t.decimal "ftotptime",                       :precision => 14, :scale => 7, :default => 0.0,   :null => false
    t.decimal "ftotqty",                         :precision => 15, :scale => 5, :default => 0.0,   :null => false
    t.decimal "ftotstime",                       :precision => 14, :scale => 7, :default => 0.0,   :null => false
    t.decimal "fuprice",                         :precision => 21, :scale => 8, :default => 0.0,   :null => false
    t.string  "fvendno",          :limit => 6,                                  :default => " ",   :null => false
    t.boolean "fllotreqd",                                                      :default => false, :null => false
    t.string  "fclotext",         :limit => 1,                                  :default => " ",   :null => false
    t.integer "fnoperno",         :limit => nil, :precision => 4,  :scale => 0, :default => 0,     :null => false
    t.binary  "timestamp_column"
    t.text    "fbomdesc",                                                       :default => " ",   :null => false
    t.text    "fstdmemo",                                                       :default => " ",   :null => false
    t.string  "fac",              :limit => 20,                                                    :null => false
    t.string  "fcbomudrev",       :limit => 3,                                  :default => "",    :null => false
    t.integer "fndbrmod",         :limit => 1,                                                     :null => false
  end

  add_index "qtdbom", ["fbomsource", "fquoteno", "finumber"], :name => "source"
  add_index "qtdbom", ["fquoteno", "finumber", "fbominum"], :name => "parent"
  add_index "qtdbom", ["fquoteno", "finumber", "fparinum", "fac", "fbompart", "fbomrev"], :name => "PARTNO"
  add_index "qtdbom", ["fquoteno", "finumber", "fparinum", "fitem"], :name => "itemno"
  add_index "qtdbom", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "qtdbomdl", :primary_key => "identity_column", :force => true do |t|
    t.integer "fiqtdbomid",                                                     :null => false
    t.integer "fitype",                                                         :null => false
    t.integer "fiqty",                                                          :null => false
    t.boolean "flpartial",                                                      :null => false
    t.integer "fium1"
    t.decimal "fnsize1",          :precision => 18, :scale => 5
    t.integer "fium2"
    t.decimal "fnsize2",          :precision => 18, :scale => 5
    t.integer "fium3"
    t.decimal "fnsize3",          :precision => 18, :scale => 5
    t.integer "fium4"
    t.decimal "fnsize4",          :precision => 18, :scale => 5
    t.integer "fium5"
    t.decimal "fnsize5",          :precision => 18, :scale => 5
    t.integer "ficount",                                                        :null => false
    t.binary  "timestamp_column"
    t.integer "fiqtdbomdl",                                      :default => 0, :null => false
  end

  add_index "qtdbomdl", ["fiqtdbomid", "fitype"], :name => "QtDBOMID"
  add_index "qtdbomdl", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "qtdrtg", :primary_key => "identity_column", :force => true do |t|
    t.string  "fbominum",         :limit => 4,                                                    :null => false
    t.string  "fchngrates",       :limit => 1,                                                    :null => false
    t.decimal "felpstime",                       :precision => 8,  :scale => 2,                   :null => false
    t.decimal "ffixcost",                        :precision => 17, :scale => 5,                   :null => false
    t.string  "finumber",         :limit => 3,                                                    :null => false
    t.boolean "flschedule",                                                                       :null => false
    t.decimal "fmovetime",                       :precision => 8,  :scale => 2,                   :null => false
    t.integer "foperno",          :limit => nil, :precision => 4,  :scale => 0,                   :null => false
    t.decimal "foperqty",                        :precision => 19, :scale => 6,                   :null => false
    t.decimal "fothrcost",                       :precision => 17, :scale => 5,                   :null => false
    t.string  "fpro_id",          :limit => 7,                                                    :null => false
    t.string  "fquoteno",         :limit => 6,                                                    :null => false
    t.decimal "fsetuptime",                      :precision => 7,  :scale => 2,                   :null => false
    t.string  "fstddesc",         :limit => 4,                                                    :null => false
    t.decimal "fulabcost",                       :precision => 7,  :scale => 2,                   :null => false
    t.decimal "fuovrhdcos",                      :precision => 7,  :scale => 2,                   :null => false
    t.decimal "fuprodtime",                      :precision => 16, :scale => 10,                  :null => false
    t.decimal "fusubcost",                       :precision => 17, :scale => 5,                   :null => false
    t.boolean "fllotreqd",                                                                        :null => false
    t.binary  "timestamp_column"
    t.text    "fdescript",                                                       :default => " ", :null => false
    t.text    "fopermemo",                                                       :default => " ", :null => false
    t.integer "fndbrmod",         :limit => 1,                                                    :null => false
    t.integer "fnsimulops",                                                                       :null => false
  end

  add_index "qtdrtg", ["fquoteno", "finumber", "fbominum", "foperno"], :name => "OPERNO"
  add_index "qtdrtg", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "qtitem", :primary_key => "identity_column", :force => true do |t|
    t.string   "fenumber",         :limit => 3,                                                   :null => false
    t.string   "finumber",         :limit => 3,                                                   :null => false
    t.string   "fpartno",          :limit => 25,                                                  :null => false
    t.string   "fpartrev",         :limit => 3,                                                   :null => false
    t.string   "fquoteno",         :limit => 6,                                                   :null => false
    t.decimal  "fbomqty",                         :precision => 15, :scale => 5,                  :null => false
    t.string   "fcfromitem",       :limit => 3,                                                   :null => false
    t.string   "fcfromno",         :limit => 6,                                                   :null => false
    t.string   "fcfromtype",       :limit => 5,                                                   :null => false
    t.string   "fcustpart",        :limit => 25,                                                  :null => false
    t.string   "fcustptrev",       :limit => 3,                                                   :null => false
    t.boolean  "fcas_bom",                                                                        :null => false
    t.boolean  "fcas_rtg",                                                                        :null => false
    t.boolean  "fdet_bom",                                                                        :null => false
    t.boolean  "fdet_rtg",                                                                        :null => false
    t.decimal  "festqty",                         :precision => 15, :scale => 5,                  :null => false
    t.decimal  "ffixact",                         :precision => 21, :scale => 8,                  :null => false
    t.string   "fgroup",           :limit => 6,                                                   :null => false
    t.decimal  "flabact",                         :precision => 21, :scale => 8,                  :null => false
    t.boolean  "flordered",                                                                       :null => false
    t.decimal  "fmatlact",                        :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fovhdact",                        :precision => 17, :scale => 5,                  :null => false
    t.string   "fmeasure",         :limit => 3,                                                   :null => false
    t.integer  "fnextinum",        :limit => nil, :precision => 4,  :scale => 0,                  :null => false
    t.decimal  "fothract",                        :precision => 17, :scale => 5,                  :null => false
    t.boolean  "fprintmemo",                                                                      :null => false
    t.string   "fprodcl",          :limit => 2,                                                   :null => false
    t.decimal  "frtgsetupa",                      :precision => 17, :scale => 5,                  :null => false
    t.string   "fschecode",        :limit => 6,                                                   :null => false
    t.decimal  "fsetupact",                       :precision => 17, :scale => 5,                  :null => false
    t.string   "fsono",            :limit => 6,                                                   :null => false
    t.string   "fsource",          :limit => 1,                                                   :null => false
    t.boolean  "fstandpart",                                                                      :null => false
    t.decimal  "fsubact",                         :precision => 17, :scale => 5,                  :null => false
    t.decimal  "ftoolact",                        :precision => 17, :scale => 5,                  :null => false
    t.decimal  "ftotptime",                       :precision => 17, :scale => 5,                  :null => false
    t.decimal  "ftotstime",                       :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fulabcost",                       :precision => 7,  :scale => 2,                  :null => false
    t.decimal  "funetprice",                      :precision => 17, :scale => 5,                  :null => false
    t.boolean  "fllotreqd",                                                                       :null => false
    t.string   "fclotext",         :limit => 1,                                                   :null => false
    t.string   "fcprodid",         :limit => 6,                                                   :null => false
    t.decimal  "funettxnpric",                    :precision => 17, :scale => 5,                  :null => false
    t.decimal  "funeteuropr",                     :precision => 17, :scale => 5,                  :null => false
    t.string   "fschedtype",       :limit => 1,                                                   :null => false
    t.boolean  "flistaxabl",                                                                      :null => false
    t.boolean  "fljrdif",                                                                         :null => false
    t.binary   "timestamp_column"
    t.text     "fdelivery",                                                      :default => " ", :null => false
    t.text     "fdesc",                                                          :default => " ", :null => false
    t.text     "fdescmemo",                                                      :default => " ", :null => false
    t.string   "fac",              :limit => 20,                                                  :null => false
    t.string   "sfac",             :limit => 20,                                                  :null => false
    t.string   "fcpbtype",         :limit => 1,                                  :default => "",  :null => false
    t.decimal  "ITCCOST",                         :precision => 17, :scale => 5,                  :null => false
    t.string   "fcudrev",          :limit => 3,                                  :default => " ", :null => false
    t.integer  "fndbrmod",         :limit => 1,                                                   :null => false
    t.datetime "fctpdate",                                                                        :null => false
    t.datetime "fctptrans",                                                                       :null => false
  end

  add_index "qtitem", ["fquoteno", "fac", "fpartno", "fpartrev"], :name => "PARTNO"
  add_index "qtitem", ["fquoteno", "finumber"], :name => "inumber"
  add_index "qtitem", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "qtmast", :primary_key => "identity_column", :force => true do |t|
    t.string   "fcompany",         :limit => 35,                                :default => " ",   :null => false
    t.string   "fquoteno",         :limit => 6,                                                    :null => false
    t.datetime "fackdate",                                                                         :null => false
    t.string   "fccurid",          :limit => 3,                                                    :null => false
    t.decimal  "fcfactor",                       :precision => 17, :scale => 5,                    :null => false
    t.string   "fcfname",          :limit => 15,                                                   :null => false
    t.string   "fcfromno",         :limit => 6,                                                    :null => false
    t.string   "fcfromtype",       :limit => 5,                                                    :null => false
    t.string   "fcity",            :limit => 20,                                                   :null => false
    t.string   "fcountry",         :limit => 25,                                                   :null => false
    t.datetime "fdatedue",                                                                         :null => false
    t.datetime "fdaterecvd",                                                                       :null => false
    t.datetime "fdcurdate",                                                                        :null => false
    t.datetime "fdexpired",                                                                        :null => false
    t.string   "fdistno",          :limit => 6,                                                    :null => false
    t.string   "fdsalespn",        :limit => 25,                                                   :null => false
    t.boolean  "fduplicate",                                                                       :null => false
    t.string   "festimator",       :limit => 3,                                                    :null => false
    t.string   "ffax",             :limit => 20,                                                   :null => false
    t.string   "fjobname",         :limit => 65,                                :default => " ",   :null => false
    t.string   "fcsoldto",         :limit => 4,                                                    :null => false
    t.string   "fcustno",          :limit => 6,                                                    :null => false
    t.string   "fnextenum",        :limit => 3,                                                    :null => false
    t.string   "fnextinum",        :limit => 3,                                                    :null => false
    t.string   "fordpotent",       :limit => 1,                                                    :null => false
    t.string   "fordtime",         :limit => 1,                                                    :null => false
    t.string   "fphone",           :limit => 20,                                                   :null => false
    t.datetime "fprint_dt",                                                                        :null => false
    t.boolean  "fprinted",                                                                         :null => false
    t.string   "fquotecopy",       :limit => 1,                                                    :null => false
    t.datetime "fquotedate",                                                                       :null => false
    t.string   "fquoteto",         :limit => 20,                                                   :null => false
    t.string   "frequestno",       :limit => 15,                                                   :null => false
    t.string   "frevno",           :limit => 2,                                                    :null => false
    t.string   "fsalespn",         :limit => 3,                                                    :null => false
    t.string   "fstate",           :limit => 20,                                                   :null => false
    t.string   "fstatus",          :limit => 20,                                                   :null => false
    t.string   "ftype",            :limit => 1,                                                    :null => false
    t.string   "fzip",             :limit => 10,                                                   :null => false
    t.string   "fcusrchr1",        :limit => 20,                                                   :null => false
    t.string   "fcusrchr2",        :limit => 40,                                :default => " ",   :null => false
    t.string   "fcusrchr3",        :limit => 40,                                :default => " ",   :null => false
    t.decimal  "fnusrqty1",                      :precision => 15, :scale => 5,                    :null => false
    t.decimal  "fnusrcur1",                      :precision => 17, :scale => 5,                    :null => false
    t.datetime "fdusrdate1",                                                                       :null => false
    t.decimal  "fdisrate",                       :precision => 15, :scale => 5,                    :null => false
    t.string   "fterm",            :limit => 4,                                                    :null => false
    t.string   "fpaytype",         :limit => 1,                                                    :null => false
    t.datetime "fdeurodate",                                                                       :null => false
    t.decimal  "feurofctr",                      :precision => 17, :scale => 5,                    :null => false
    t.string   "fusercode",        :limit => 7,                                                    :null => false
    t.string   "fcshipto",         :limit => 4,                                                    :null => false
    t.boolean  "fltotal",                                                                          :null => false
    t.binary   "timestamp_column"
    t.text     "fclosmemo",                                                     :default => " ",   :null => false
    t.text     "fmstreet",                                                      :default => " ",   :null => false
    t.text     "fmusermemo",                                                    :default => " ",   :null => false
    t.text     "fsalumemo",                                                     :default => " ",   :null => false
    t.string   "fccontkey",        :limit => 10,                                :default => " ",   :null => false
    t.boolean  "flcontract",                                                    :default => false, :null => false
    t.integer  "fndbrmod",         :limit => 1,                                                    :null => false
  end

  add_index "qtmast", ["fcustno", "fquoteno"], :name => "CUSTNO"
  add_index "qtmast", ["fquoteno"], :name => "quoteno"
  add_index "qtmast", ["fstatus", "fcustno"], :name => "STATCUST"
  add_index "qtmast", ["fstatus", "fquoteno"], :name => "STATUS"
  add_index "qtmast", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "qtpest", :primary_key => "identity_column", :force => true do |t|
    t.string  "fenumber",         :limit => 3,                                                  :null => false
    t.string  "finumber",         :limit => 3,                                                  :null => false
    t.decimal "fquantity",                      :precision => 15, :scale => 5,                  :null => false
    t.string  "fquoteno",         :limit => 6,                                                  :null => false
    t.decimal "fdiscount",                      :precision => 17, :scale => 5,                  :null => false
    t.decimal "flabcost",                       :precision => 17, :scale => 5,                  :null => false
    t.decimal "fmatlcost",                      :precision => 17, :scale => 5,                  :null => false
    t.string  "fpartno",          :limit => 25,                                                 :null => false
    t.string  "fcpartrev",        :limit => 3,                                                  :null => false
    t.decimal "funetprice",                     :precision => 17, :scale => 5,                  :null => false
    t.decimal "fnetprice",                      :precision => 17, :scale => 5,                  :null => false
    t.decimal "fothrcost",                      :precision => 17, :scale => 5,                  :null => false
    t.decimal "fovhdcost",                      :precision => 17, :scale => 5,                  :null => false
    t.decimal "fsetupcost",                     :precision => 17, :scale => 5,                  :null => false
    t.decimal "fsubcost",                       :precision => 17, :scale => 5,                  :null => false
    t.decimal "ftoolcost",                      :precision => 17, :scale => 5,                  :null => false
    t.decimal "fnettxnprice",                   :precision => 17, :scale => 5,                  :null => false
    t.decimal "funettxnpric",                   :precision => 17, :scale => 5,                  :null => false
    t.decimal "fneteuropr",                     :precision => 17, :scale => 5,                  :null => false
    t.decimal "funeteuropr",                    :precision => 17, :scale => 5,                  :null => false
    t.decimal "fdiscpct",                       :precision => 17, :scale => 5,                  :null => false
    t.binary  "timestamp_column"
    t.string  "fcudrev",          :limit => 3,                                 :default => " ", :null => false
  end

  add_index "qtpest", ["fquoteno", "fenumber", "fquantity"], :name => "EQUANTITY"
  add_index "qtpest", ["fquoteno", "finumber", "fquantity"], :name => "QUANTITY"
  add_index "qtpest", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "qtresc", :primary_key => "identity_column", :force => true do |t|
    t.string  "fquoteno",         :limit => 6,                                 :null => false
    t.string  "finumber",         :limit => 3,                                 :null => false
    t.string  "fbominum",         :limit => 4,                                 :null => false
    t.integer "foperno",          :limit => nil, :precision => 4, :scale => 0, :null => false
    t.string  "fcres_id",         :limit => 7,                                 :null => false
    t.integer "fnsimulops",       :limit => nil, :precision => 3, :scale => 0, :null => false
    t.binary  "timestamp_column"
    t.integer "fndbrmod",         :limit => 1,                                 :null => false
  end

  add_index "qtresc", ["fquoteno", "finumber", "fbominum", "foperno", "fcres_id"], :name => "QTOPID"
  add_index "qtresc", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "qttax", :primary_key => "identity_column", :force => true do |t|
    t.string  "fquoteno",         :limit => 6,  :null => false
    t.string  "finumber",         :limit => 3,  :null => false
    t.string  "fcjrdict",         :limit => 10, :null => false
    t.string  "fctaxcode",        :limit => 10, :null => false
    t.integer "fnorder",                        :null => false
    t.binary  "timestamp_column"
  end

  add_index "qttax", ["fquoteno", "finumber", "fnorder"], :name => "jrqtorder"
  add_index "qttax", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "rccost", :primary_key => "identity_column", :force => true do |t|
    t.string  "fcinvkey",         :limit => 26,                                :default => " ", :null => false
    t.string  "fitemno",          :limit => 6,                                 :default => " ", :null => false
    t.string  "frecvkey",         :limit => 9,                                 :default => " ", :null => false
    t.string  "fpartno",          :limit => 25,                                :default => " ", :null => false
    t.decimal "fncost",                         :precision => 17, :scale => 5, :default => 0.0, :null => false
    t.decimal "fntxncost",                      :precision => 17, :scale => 5, :default => 0.0, :null => false
    t.decimal "fneurcost",                      :precision => 17, :scale => 5, :default => 0.0, :null => false
    t.string  "fcpartrev",        :limit => 3,                                 :default => " ", :null => false
    t.binary  "timestamp_column"
    t.string  "fac",              :limit => 20,                                                 :null => false
    t.string  "fcudrev",          :limit => 3,                                 :default => " ", :null => false
  end

  add_index "rccost", ["fcinvkey", "fitemno", "frecvkey"], :name => "RCCOST"
  add_index "rccost", ["frecvkey"], :name => "recvkey"
  add_index "rccost", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "rcinsp", :primary_key => "identity_column", :force => true do |t|
    t.string   "fcreceiver",       :limit => 6,                                 :default => " ",                   :null => false
    t.string   "fcitemno",         :limit => 3,                                 :default => " ",                   :null => false
    t.string   "fcpartno",         :limit => 25,                                :default => " ",                   :null => false
    t.string   "fcpartrev",        :limit => 3,                                 :default => " ",                   :null => false
    t.datetime "fdinspdate",                                                    :default => '1900-01-01 00:00:00', :null => false
    t.string   "fcinspby",         :limit => 3,                                 :default => " ",                   :null => false
    t.string   "fcinspcode",       :limit => 4,                                 :default => " ",                   :null => false
    t.decimal  "fnqtypass",                      :precision => 15, :scale => 5, :default => 0.0,                   :null => false
    t.decimal  "fnqtyfail",                      :precision => 15, :scale => 5, :default => 0.0,                   :null => false
    t.boolean  "flreturn",                                                      :default => false,                 :null => false
    t.boolean  "flreorder",                                                     :default => false,                 :null => false
    t.decimal  "fnqtyactd",                      :precision => 15, :scale => 5, :default => 0.0,                   :null => false
    t.string   "fcnewloc",         :limit => 14,                                :default => " ",                   :null => false
    t.string   "fcnewbin",         :limit => 14,                                :default => " ",                   :null => false
    t.string   "fclot",            :limit => 20,                                :default => " ",                   :null => false
    t.binary   "timestamp_column"
    t.text     "fmcomments",                                                    :default => " ",                   :null => false
    t.string   "fac",              :limit => 20,                                                                   :null => false
    t.string   "fcudrev",          :limit => 3,                                 :default => " ",                   :null => false
  end

  add_index "rcinsp", ["fcreceiver", "fcitemno"], :name => "rcinsp"
  add_index "rcinsp", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "rcinspdl", :primary_key => "identity_column", :force => true do |t|
    t.integer "fircinspid",                                      :null => false
    t.integer "fitype",                                          :null => false
    t.integer "fiqty",                                           :null => false
    t.boolean "flpartial",                                       :null => false
    t.integer "fium1",                                           :null => false
    t.decimal "fnsize1",          :precision => 17, :scale => 5, :null => false
    t.integer "fium2",                                           :null => false
    t.decimal "fnsize2",          :precision => 17, :scale => 5, :null => false
    t.integer "fium3",                                           :null => false
    t.decimal "fnsize3",          :precision => 17, :scale => 5, :null => false
    t.integer "fium4",                                           :null => false
    t.decimal "fnsize4",          :precision => 17, :scale => 5, :null => false
    t.integer "fium5",                                           :null => false
    t.decimal "fnsize5",          :precision => 17, :scale => 5, :null => false
    t.binary  "timestamp_column"
  end

  add_index "rcinspdl", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "rcitem", :primary_key => "identity_column", :force => true do |t|
    t.string   "fitemno",          :limit => 3,                                                  :null => false
    t.string   "fpartno",          :limit => 25,                                                 :null => false
    t.string   "fpartrev",         :limit => 3,                                                  :null => false
    t.decimal  "finvcost",                       :precision => 17, :scale => 5,                  :null => false
    t.string   "fcategory",        :limit => 8,                                                  :null => false
    t.string   "fcstatus",         :limit => 1,                                                  :null => false
    t.decimal  "fiqtyinv",                       :precision => 15, :scale => 5,                  :null => false
    t.string   "fjokey",           :limit => 10,                                                 :null => false
    t.string   "fsokey",           :limit => 6,                                                  :null => false
    t.string   "fsoitem",          :limit => 3,                                                  :null => false
    t.string   "fsorelsno",        :limit => 3,                                                  :null => false
    t.decimal  "fvqtyrecv",                      :precision => 15, :scale => 5,                  :null => false
    t.decimal  "fqtyrecv",                       :precision => 15, :scale => 5,                  :null => false
    t.string   "freceiver",        :limit => 6,                                                  :null => false
    t.string   "frelsno",          :limit => 3,                                                  :null => false
    t.string   "fvendno",          :limit => 6,                                                  :null => false
    t.string   "fbinno",           :limit => 14,                                                 :null => false
    t.datetime "fexpdate",                                                                       :null => false
    t.string   "finspect",         :limit => 1,                                                  :null => false
    t.decimal  "finvqty",                        :precision => 15, :scale => 5,                  :null => false
    t.string   "flocation",        :limit => 14,                                                 :null => false
    t.string   "flot",             :limit => 20,                                                 :null => false
    t.string   "fmeasure",         :limit => 3,                                                  :null => false
    t.string   "fpoitemno",        :limit => 3,                                                  :null => false
    t.string   "fretcredit",       :limit => 1,                                                  :null => false
    t.string   "ftype",            :limit => 1,                                                  :null => false
    t.string   "fumvori",          :limit => 1,                                                  :null => false
    t.decimal  "fqtyinsp",                       :precision => 15, :scale => 5,                  :null => false
    t.string   "fauthorize",       :limit => 20,                                                 :null => false
    t.decimal  "fucost",                         :precision => 17, :scale => 5,                  :null => false
    t.boolean  "fllotreqd",                                                                      :null => false
    t.boolean  "flexpreqd",                                                                      :null => false
    t.string   "fctojoblot",       :limit => 20,                                                 :null => false
    t.decimal  "fdiscount",                      :precision => 5,  :scale => 1,                  :null => false
    t.decimal  "fueurocost",                     :precision => 17, :scale => 5,                  :null => false
    t.decimal  "futxncost",                      :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fucostonly",                     :precision => 17, :scale => 5,                  :null => false
    t.decimal  "futxncston",                     :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fueurcston",                     :precision => 17, :scale => 5,                  :null => false
    t.boolean  "flconvovrd",                                                                     :null => false
    t.binary   "timestamp_column"
    t.text     "fcomments",                                                     :default => " ", :null => false
    t.text     "fdescript",                                                     :default => " ", :null => false
    t.string   "FCORIGUM",         :limit => 3,                                 :default => " ", :null => false
    t.string   "fcudrev",          :limit => 3,                                 :default => " ", :null => false
    t.decimal  "FNORIGQTY",                      :precision => 18, :scale => 5, :default => 0.0, :null => false
    t.string   "fac",              :limit => 20,                                                 :null => false
    t.string   "sfac",             :limit => 20,                                                 :null => false
    t.string   "Iso",              :limit => 10,                                :default => "",  :null => false
    t.integer  "Ship_Link",                                                     :default => 0,   :null => false
    t.integer  "ShsrceLink",                                                    :default => 0,   :null => false
  end

  add_index "rcitem", ["fcstatus"], :name => "status"
  add_index "rcitem", ["fiqtyinv", "fqtyrecv", "finvqty", "fumvori"], :name => "invbal"
  add_index "rcitem", ["fpartno", "fpartrev", "fac"], :name => "PARTNO"
  add_index "rcitem", ["freceiver", "fitemno"], :name => "rcvritem"
  add_index "rcitem", ["freceiver", "fpartno", "fpartrev", "fcategory", "frelsno", "fac"], :name => "RCVRPART"
  add_index "rcitem", ["fumvori"], :name => "umused"
  add_index "rcitem", ["fvendno"], :name => "vendor"
  add_index "rcitem", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "rcitemdl", :primary_key => "identity_column", :force => true do |t|
    t.integer "fircitemid",                                                     :null => false
    t.integer "fitype",                                                         :null => false
    t.integer "fiqty",                                                          :null => false
    t.boolean "flpartial",                                                      :null => false
    t.integer "fium1"
    t.decimal "fnsize1",          :precision => 18, :scale => 5
    t.integer "fium2"
    t.decimal "fnsize2",          :precision => 18, :scale => 5
    t.integer "fium3"
    t.decimal "fnsize3",          :precision => 18, :scale => 5
    t.integer "fium4"
    t.decimal "fnsize4",          :precision => 18, :scale => 5
    t.integer "fium5"
    t.binary  "timestamp_column"
    t.decimal "fnSize5",          :precision => 18, :scale => 5
    t.integer "FICOUNT",                                         :default => 0, :null => false
  end

  add_index "rcitemdl", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "rclotc", :primary_key => "identity_column", :force => true do |t|
    t.string   "fclot",            :limit => 20,                                               :null => false
    t.datetime "fdexpdate",                                                                    :null => false
    t.decimal  "fnlotqty",                       :precision => 15, :scale => 5,                :null => false
    t.string   "fcrcitmkey",       :limit => 9,                                                :null => false
    t.string   "fclineord",        :limit => 3,                                                :null => false
    t.decimal  "fnqtyinsp",                      :precision => 15, :scale => 5,                :null => false
    t.binary   "timestamp_column"
    t.integer  "fiLotPcs",                                                      :default => 0, :null => false
  end

  add_index "rclotc", ["fcrcitmkey", "fclineord"], :name => "rcitmkey"
  add_index "rclotc", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "rcmast", :primary_key => "identity_column", :force => true do |t|
    t.string   "fclandcost",       :limit => 1,                                                        :null => false
    t.string   "frmano",           :limit => 25,                                                       :null => false
    t.string   "fporev",           :limit => 2,                                                        :null => false
    t.string   "fcstatus",         :limit => 1,                                                        :null => false
    t.datetime "fdaterecv",                                                                            :null => false
    t.string   "fpono",            :limit => 6,                                                        :null => false
    t.string   "freceiver",        :limit => 6,                                                        :null => false
    t.string   "fvendno",          :limit => 6,                                                        :null => false
    t.string   "faccptby",         :limit => 3,                                                        :null => false
    t.string   "fbilllad",         :limit => 18,                                                       :null => false
    t.string   "fcompany",         :limit => 35,                                :default => " ",       :null => false
    t.string   "ffrtcarr",         :limit => 20,                                                       :null => false
    t.string   "fpacklist",        :limit => 15,                                                       :null => false
    t.string   "fretship",         :limit => 1,                                                        :null => false
    t.decimal  "fshipwgt",                       :precision => 11, :scale => 2,                        :null => false
    t.string   "ftype",            :limit => 1,                                                        :null => false
    t.datetime "start",                                                                                :null => false
    t.boolean  "fprinted",                                                                             :null => false
    t.boolean  "flothrupd",                                                                            :null => false
    t.string   "fccurid",          :limit => 3,                                                        :null => false
    t.decimal  "fcfactor",                       :precision => 17, :scale => 5,                        :null => false
    t.datetime "fdcurdate",                                                                            :null => false
    t.datetime "fdeurodate",                                                                           :null => false
    t.decimal  "feurofctr",                      :precision => 17, :scale => 5,                        :null => false
    t.boolean  "flpremcv",                                                                             :null => false
    t.binary   "timestamp_column"
    t.string   "docstatus",        :limit => 10,                                :default => "STARTED"
  end

  add_index "rcmast", ["fcstatus"], :name => "status"
  add_index "rcmast", ["fdaterecv"], :name => "daterecvd"
  add_index "rcmast", ["fpono"], :name => "pono"
  add_index "rcmast", ["freceiver"], :name => "receiver"
  add_index "rcmast", ["ftype"], :name => "type"
  add_index "rcmast", ["fvendno", "fpono", "freceiver"], :name => "VENPORECV"
  add_index "rcmast", ["fvendno", "freceiver"], :name => "VENRECV"
  add_index "rcmast", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "rqland", :primary_key => "identity_column", :force => true do |t|
    t.string   "frfqno",           :limit => 9,                                                  :null => false
    t.string   "fpartno",          :limit => 25,                                                 :null => false
    t.string   "fcpartrev",        :limit => 3,                                                  :null => false
    t.string   "fvendno",          :limit => 6,                                                  :null => false
    t.decimal  "fnfobamt",                       :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fnfreight",                      :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fnpfreight",                     :precision => 7,  :scale => 1,                  :null => false
    t.decimal  "fnothcst1",                      :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fnpothcst1",                     :precision => 7,  :scale => 1,                  :null => false
    t.decimal  "fnothcst2",                      :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fnpothcst2",                     :precision => 7,  :scale => 1,                  :null => false
    t.decimal  "fnothcst3",                      :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fnpothcst3",                     :precision => 7,  :scale => 1,                  :null => false
    t.decimal  "fnothcst4",                      :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fnpothcst4",                     :precision => 7,  :scale => 1,                  :null => false
    t.decimal  "fnothcst5",                      :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fnpothcst5",                     :precision => 7,  :scale => 1,                  :null => false
    t.decimal  "fnothcst6",                      :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fnpothcst6",                     :precision => 7,  :scale => 1,                  :null => false
    t.decimal  "fnbegin",                        :precision => 15, :scale => 5,                  :null => false
    t.decimal  "fnend",                          :precision => 15, :scale => 5,                  :null => false
    t.datetime "fexpdate",                                                                       :null => false
    t.binary   "timestamp_column"
    t.string   "fac",              :limit => 20,                                                 :null => false
    t.string   "fcudrev",          :limit => 3,                                 :default => " ", :null => false
  end

  add_index "rqland", ["fpartno", "fcpartrev", "fvendno", "fexpdate", "fnbegin", "fac"], :name => "expdate"
  add_index "rqland", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "scanl1", :primary_key => "identity_column", :force => true do |t|
    t.decimal  "avg_late",                        :precision => 7, :scale => 1, :null => false
    t.decimal  "cap_util",                        :precision => 7, :scale => 1, :null => false
    t.string   "descrip",          :limit => 20,                                :null => false
    t.decimal  "favg_early",                      :precision => 7, :scale => 1, :null => false
    t.integer  "fnumjobs",         :limit => nil, :precision => 4, :scale => 0, :null => false
    t.integer  "fovercap",         :limit => nil, :precision => 3, :scale => 0, :null => false
    t.decimal  "fovertime",                       :precision => 8, :scale => 1, :null => false
    t.datetime "fschddate",                                                     :null => false
    t.integer  "late_jobs",        :limit => nil, :precision => 5, :scale => 0, :null => false
    t.decimal  "make_span",                       :precision => 7, :scale => 1, :null => false
    t.decimal  "pct_ontime",                      :precision => 7, :scale => 1, :null => false
    t.integer  "rng_late",         :limit => nil, :precision => 6, :scale => 0, :null => false
    t.string   "sch_gen",          :limit => 3,                                 :null => false
    t.string   "sch_typ",          :limit => 2,                                 :null => false
    t.binary   "timestamp_column"
    t.string   "fac",              :limit => 20,                                :null => false
  end

  add_index "scanl1", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "sccaln", :primary_key => "identity_column", :force => true do |t|
    t.string  "fcyrmon",          :limit => 7,                                                  :null => false
    t.integer "fnnumdays",        :limit => nil, :precision => 2, :scale => 0,                  :null => false
    t.string  "fcshifts",         :limit => 31,                                :default => " ", :null => false
    t.integer "fnstrtshft",       :limit => nil, :precision => 6, :scale => 0,                  :null => false
    t.integer "fnweekday",        :limit => nil, :precision => 1, :scale => 0,                  :null => false
    t.binary  "timestamp_column"
    t.string  "fac",              :limit => 20,                                                 :null => false
    t.integer "fndbrmod",         :limit => nil, :precision => 1, :scale => 0, :default => 0,   :null => false
  end

  add_index "sccaln", ["fcyrmon", "fac"], :name => "year_mon"
  add_index "sccaln", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "sccalnw", :primary_key => "identity_column", :force => true do |t|
    t.string  "fcyrmon",          :limit => 7,                                                  :null => false
    t.string  "fcpro_id",         :limit => 10,                                                 :null => false
    t.integer "fnnumdays",        :limit => nil, :precision => 2, :scale => 0,                  :null => false
    t.string  "fcshifts",         :limit => 31,                                :default => " ", :null => false
    t.integer "fnstrtshft",       :limit => nil, :precision => 6, :scale => 0,                  :null => false
    t.integer "fnweekday",        :limit => nil, :precision => 1, :scale => 0,                  :null => false
    t.binary  "timestamp_column"
    t.string  "fac",              :limit => 20,                                                 :null => false
    t.integer "fndbrmod",         :limit => nil, :precision => 1, :scale => 0, :default => 0,   :null => false
  end

  add_index "sccalnw", ["fcpro_id", "fcyrmon", "fac"], :name => "wcmonth"
  add_index "sccalnw", ["fcyrmon", "fac"], :name => "year_mon"
  add_index "sccalnw", ["fcyrmon", "fcpro_id"], :name => "monthwc"
  add_index "sccalnw", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "sccapi", :primary_key => "identity_column", :force => true do |t|
    t.datetime "fdate",                                                         :null => false
    t.string   "fpro_id",          :limit => 7,                                 :null => false
    t.string   "fshift",           :limit => 1,                                 :null => false
    t.string   "ftimetype",        :limit => 1,                                 :null => false
    t.integer  "fcapacity",        :limit => nil, :precision => 9, :scale => 0, :null => false
    t.integer  "fdemand",          :limit => nil, :precision => 9, :scale => 0, :null => false
    t.integer  "fqueuetime",       :limit => nil, :precision => 9, :scale => 0, :null => false
    t.binary   "timestamp_column"
    t.string   "fac",              :limit => 20,                                :null => false
  end

  add_index "sccapi", ["ftimetype", "fdate", "fshift", "fpro_id", "fac"], :name => "SCCAPI"
  add_index "sccapi", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "sccapj", :primary_key => "identity_column", :force => true do |t|
    t.integer "favailstrt",       :limit => nil, :precision => 6, :scale => 0, :null => false
    t.string  "fjobno",           :limit => 10,                                :null => false
    t.integer "foperno",          :limit => nil, :precision => 4, :scale => 0, :null => false
    t.string  "fpro_id",          :limit => 7,                                 :null => false
    t.integer "fstrttime",        :limit => nil, :precision => 6, :scale => 0, :null => false
    t.string  "ffnshdate",        :limit => 15,                                :null => false
    t.integer "ffnshtime",        :limit => nil, :precision => 6, :scale => 0, :null => false
    t.boolean "fidle",                                                         :null => false
    t.integer "fshift",           :limit => nil, :precision => 1, :scale => 0, :null => false
    t.string  "fstrtdate",        :limit => 15,                                :null => false
    t.string  "fdept",            :limit => 2,                                 :null => false
    t.binary  "timestamp_column"
    t.string  "fac",              :limit => 20,                                :null => false
  end

  add_index "sccapj", ["fstrttime", "foperno", "fjobno", "fac"], :name => "sccapj"
  add_index "sccapj", ["fstrttime", "fpro_id", "fdept", "fac"], :name => "sccapjb"
  add_index "sccapj", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "scifset", :primary_key => "identity_column", :force => true do |t|
    t.boolean "flasalesno",       :default => true,     :null => false
    t.boolean "flaperavail",      :default => true,     :null => false
    t.boolean "flacustrange",     :default => true,     :null => false
    t.boolean "flapartrange",     :default => true,     :null => false
    t.boolean "flansaddr",        :default => true,     :null => false
    t.boolean "flashpcomp",       :default => true,     :null => false
    t.boolean "flashpcity",       :default => true,     :null => false
    t.boolean "flashipvia",       :default => true,     :null => false
    t.boolean "flaselectso",      :default => true,     :null => false
    t.boolean "flafacility",      :default => true,     :null => false
    t.boolean "flalookback",      :default => true,     :null => false
    t.boolean "fnabackdays",      :default => true,     :null => false
    t.boolean "flalookahead",     :default => true,     :null => false
    t.boolean "fnaaheaddays",     :default => true,     :null => false
    t.boolean "flalessdate",      :default => true,     :null => false
    t.boolean "fnaplusday",       :default => true,     :null => false
    t.boolean "flacombsos",       :default => true,     :null => false
    t.boolean "flbsalesno",       :default => true,     :null => false
    t.boolean "flbshipno",        :default => true,     :null => false
    t.boolean "flbcustrange",     :default => true,     :null => false
    t.boolean "flbshpcomp",       :default => true,     :null => false
    t.boolean "flbshpcity",       :default => true,     :null => false
    t.boolean "flbshipvia",       :default => true,     :null => false
    t.boolean "flbaccthold",      :default => true,     :null => false
    t.integer "FLBACCTHOLDC",     :default => 16777215
    t.boolean "flbcredhold",      :default => true,     :null => false
    t.integer "FLBCREDHOLDC",     :default => 16777215
    t.boolean "FLBNOTAVAIL",      :default => true,     :null => false
    t.integer "FLBNOTAVAILC",     :default => 16777215
    t.integer "lbackdays",        :default => 0,        :null => false
    t.integer "laheaddays",       :default => 0,        :null => false
    t.binary  "timestamp_column"
    t.boolean "flbdefdate",       :default => false,    :null => false
    t.boolean "flacombwarn",      :default => true,     :null => false
    t.boolean "flaavail",         :default => false,    :null => false
  end

  add_index "scifset", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "scmcr", :primary_key => "identity_column", :force => true do |t|
    t.boolean "lFacility",                                                     :default => false, :null => false
    t.string  "fcpro_id",         :limit => 7,                                 :default => " ",   :null => false
    t.integer "fnbegofset",       :limit => nil, :precision => 5, :scale => 0, :default => 0,     :null => false
    t.string  "cfiltexpr",        :limit => 160,                               :default => " ",   :null => false
    t.string  "cbatchname",       :limit => 15,                                :default => " ",   :null => false
    t.boolean "lWorkCenter",                                                   :default => false, :null => false
    t.string  "coutpdest",        :limit => 1,                                 :default => " ",   :null => false
    t.boolean "lexclusive",                                                    :default => false, :null => false
    t.boolean "lCompany",                                                      :default => false, :null => false
    t.string  "viewoption",       :limit => 1,                                 :default => " ",   :null => false
    t.string  "userid",           :limit => 30,                                :default => " ",   :null => false
    t.string  "fcfac",            :limit => 20,                                :default => " ",   :null => false
    t.integer "fndays",           :limit => nil, :precision => 5, :scale => 0, :default => 0,     :null => false
    t.binary  "timestamp_column"
    t.string  "fcfacwc",          :limit => 20
  end

  add_index "scmcr", ["cbatchname"], :name => "bybtchname"
  add_index "scmcr", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "scmcrrp", :primary_key => "identity_column", :force => true do |t|
    t.string   "cbatchname",       :limit => 15,                                :default => " ",                   :null => false
    t.string   "userid",           :limit => 30,                                :default => " ",                   :null => false
    t.string   "sh1Start",         :limit => 5,                                 :default => " ",                   :null => false
    t.string   "sh1End",           :limit => 5,                                 :default => " ",                   :null => false
    t.string   "sh1Br1En",         :limit => 5,                                 :default => " ",                   :null => false
    t.string   "sh1Br2St",         :limit => 5,                                 :default => " ",                   :null => false
    t.binary   "timestamp_column"
    t.string   "fcfac",            :limit => 20,                                :default => " ",                   :null => false
    t.string   "fcpro_id",         :limit => 7,                                 :default => " ",                   :null => false
    t.datetime "fdate",                                                         :default => '1900-01-01 00:00:00', :null => false
    t.string   "sh1Br2En",         :limit => 5,                                 :default => " ",                   :null => false
    t.integer  "sh1Sim",           :limit => nil, :precision => 3, :scale => 0, :default => 0,                     :null => false
    t.boolean  "sh2oper",                                                       :default => false,                 :null => false
    t.string   "sh2End",           :limit => 5,                                 :default => " ",                   :null => false
    t.string   "sh2Br3En",         :limit => 5,                                 :default => " ",                   :null => false
    t.integer  "sh2Sim",           :limit => nil, :precision => 3, :scale => 0, :default => 0,                     :null => false
    t.string   "sh3End",           :limit => 5,                                 :default => " ",                   :null => false
    t.string   "sh3Br1St",         :limit => 5,                                 :default => " ",                   :null => false
    t.string   "sh3Br1En",         :limit => 5,                                 :default => " ",                   :null => false
    t.string   "sh3Br2St",         :limit => 5,                                 :default => " ",                   :null => false
    t.string   "sh3Br2En",         :limit => 5,                                 :default => " ",                   :null => false
    t.string   "sh3Br3St",         :limit => 5,                                 :default => " ",                   :null => false
    t.integer  "sh3Sim",           :limit => nil, :precision => 3, :scale => 0, :default => 0,                     :null => false
    t.boolean  "sh1oper",                                                       :default => false,                 :null => false
    t.string   "sh2Br2St",         :limit => 5,                                 :default => " ",                   :null => false
    t.string   "sh3Start",         :limit => 5,                                 :default => " ",                   :null => false
    t.string   "sh1Br1St",         :limit => 5,                                 :default => " ",                   :null => false
    t.string   "sh1Br3St",         :limit => 5,                                 :default => " ",                   :null => false
    t.string   "sh1Br3En",         :limit => 5,                                 :default => " ",                   :null => false
    t.string   "sh2Start",         :limit => 5,                                 :default => " ",                   :null => false
    t.string   "sh2Br1St",         :limit => 5,                                 :default => " ",                   :null => false
    t.string   "sh2Br1En",         :limit => 5,                                 :default => " ",                   :null => false
    t.string   "sh2Br2En",         :limit => 5,                                 :default => " ",                   :null => false
    t.string   "sh2Br3St",         :limit => 5,                                 :default => " ",                   :null => false
    t.boolean  "sh3oper",                                                       :default => false,                 :null => false
    t.string   "sh3Br3En",         :limit => 5,                                 :default => " ",                   :null => false
    t.integer  "seqno",            :limit => nil, :precision => 8, :scale => 0, :default => 0,                     :null => false
  end

  add_index "scmcrrp", ["cbatchname", "userid"], :name => "bybtchname"
  add_index "scmcrrp", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "scmpl", :primary_key => "identity_column", :force => true do |t|
    t.string  "cbatchname",       :limit => 15, :null => false
    t.boolean "flaudit",                        :null => false
    t.string  "userid",           :limit => 30, :null => false
    t.string  "viewoption",       :limit => 1,  :null => false
    t.boolean "flsodmnd",                       :null => false
    t.boolean "flfcstdmnd",                     :null => false
    t.boolean "flssdmnd",                       :null => false
    t.binary  "timestamp_column"
    t.string  "fcAlign",          :limit => 1,  :null => false
    t.boolean "flDelete",                       :null => false
    t.boolean "flautoccr",                      :null => false
    t.string  "fcGoal",           :limit => 45, :null => false
    t.boolean "flFreeze",                       :null => false
  end

  add_index "scmpl", ["cbatchname"], :name => "bybtchname"
  add_index "scmpl", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "scmplm", :primary_key => "identity_column", :force => true do |t|
    t.string "cbatchname",       :limit => 15, :null => false
    t.string "dDate",            :limit => 10, :null => false
    t.string "cTime",            :limit => 8,  :null => false
    t.string "Description",      :limit => 30, :null => false
    t.string "fnRevenue",        :limit => 20, :null => false
    t.string "fnInv",            :limit => 20, :null => false
    t.string "fnPurch",          :limit => 20, :null => false
    t.string "fnServ",           :limit => 20, :null => false
    t.string "fnTotalCost",      :limit => 20, :null => false
    t.string "fnProfit",         :limit => 20, :null => false
    t.binary "timestamp_column"
    t.string "fcGoal",           :limit => 45, :null => false
  end

  add_index "scmplm", ["cbatchname"], :name => "bybtchname"
  add_index "scmplm", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "scmpocrp", :primary_key => "identity_column", :force => true do |t|
    t.string  "userid",           :limit => 30,                                :null => false
    t.string  "Facility",         :limit => 20,                                :null => false
    t.string  "SoNo",             :limit => 6,                                 :null => false
    t.string  "Customer",         :limit => 35,                                :null => false
    t.string  "INumber",          :limit => 3,                                 :null => false
    t.string  "PartNumber",       :limit => 29,                                :null => false
    t.string  "Source",           :limit => 10,                                :null => false
    t.string  "ReleaseNo",        :limit => 3,                                 :null => false
    t.string  "RelDueDate",       :limit => 10,                                :null => false
    t.decimal "ReleaseQty",                     :precision => 14, :scale => 5, :null => false
    t.string  "AvailDate",        :limit => 10,                                :null => false
    t.decimal "TotSupQty",                      :precision => 14, :scale => 5, :null => false
    t.binary  "timestamp_column"
    t.string  "JobNo",            :limit => 10,                                :null => false
    t.string  "ProductClass",     :limit => 2,                                 :null => false
  end

  add_index "scmpocrp", ["identity_column"], :name => "identity_column_idx1", :unique => true
  add_index "scmpocrp", ["userid", "Facility"], :name => "byuserid"

  create_table "scmpodrp", :primary_key => "identity_column", :force => true do |t|
    t.string   "userid",           :limit => 30,                                 :null => false
    t.string   "Facility",         :limit => 20,                                 :null => false
    t.string   "SoNo",             :limit => 60,                                 :null => false
    t.string   "SOItem",           :limit => 120,                                :null => false
    t.string   "Release",          :limit => 140,                                :null => false
    t.string   "SupSchedDate",     :limit => 10,                                 :null => false
    t.string   "SupDueDate",       :limit => 10,                                 :null => false
    t.string   "SupOrderNo",       :limit => 14,                                 :null => false
    t.decimal  "SupQty",                          :precision => 14, :scale => 5, :null => false
    t.string   "SupType",          :limit => 4,                                  :null => false
    t.string   "SupStatus",        :limit => 10,                                 :null => false
    t.decimal  "SupPab",                          :precision => 14, :scale => 5, :null => false
    t.datetime "SortDate",                                                       :null => false
    t.binary   "timestamp_column"
  end

  add_index "scmpodrp", ["identity_column"], :name => "identity_column_idx1", :unique => true
  add_index "scmpodrp", ["userid", "Facility"], :name => "byuserid"

  create_table "scpcal", :primary_key => "identity_column", :force => true do |t|
    t.string   "fcfac",            :limit => 20,                                :null => false
    t.string   "fcpro_id",         :limit => 7,                                 :null => false
    t.integer  "fnweekday",        :limit => nil, :precision => 2, :scale => 0, :null => false
    t.integer  "fnshiftno",        :limit => nil, :precision => 2, :scale => 0, :null => false
    t.datetime "fdate",                                                         :null => false
    t.datetime "fdate1",                                                        :null => false
    t.boolean  "floperativ",                                                    :null => false
    t.integer  "fnsimulops",       :limit => nil, :precision => 3, :scale => 0, :null => false
    t.string   "fcstart",          :limit => 5,                                 :null => false
    t.string   "fcend",            :limit => 5,                                 :null => false
    t.string   "fcbr1start",       :limit => 5,                                 :null => false
    t.string   "fcbr2start",       :limit => 5,                                 :null => false
    t.string   "fcbr3start",       :limit => 5,                                 :null => false
    t.string   "fcbr1end",         :limit => 5,                                 :null => false
    t.string   "fcbr2end",         :limit => 5,                                 :null => false
    t.string   "fcbr3end",         :limit => 5,                                 :null => false
    t.string   "fctype",           :limit => 15,                                :null => false
    t.string   "fdescript",        :limit => 35,                                :null => false
    t.boolean  "fltimeover",                                                    :null => false
    t.boolean  "flcapover",                                                     :null => false
    t.binary   "timestamp_column"
    t.boolean  "flOperOver",                                                    :null => false
  end

  add_index "scpcal", ["fcpro_id", "fnweekday", "fnshiftno", "fdate", "fdate1", "fcfac"], :name => "facility"
  add_index "scpcal", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "scshft", :primary_key => "identity_column", :force => true do |t|
    t.datetime "fdnshdate",                                                     :null => false
    t.integer  "fnshft",           :limit => nil, :precision => 6, :scale => 0, :null => false
    t.integer  "fnshiftnum",       :limit => nil, :precision => 1, :scale => 0, :null => false
    t.datetime "fdstrtdate",                                                    :null => false
    t.binary   "timestamp_column"
  end

  add_index "scshft", ["fdstrtdate"], :name => "strtdate"
  add_index "scshft", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "scstdc", :primary_key => "identity_column", :force => true do |t|
    t.integer "fnnumdays",        :limit => nil, :precision => 2, :scale => 0,                  :null => false
    t.string  "fcshifts",         :limit => 31,                                :default => " ", :null => false
    t.integer "fnstrtshft",       :limit => nil, :precision => 6, :scale => 0,                  :null => false
    t.integer "fnweekday",        :limit => nil, :precision => 1, :scale => 0,                  :null => false
    t.string  "fcyrmon",          :limit => 5,                                                  :null => false
    t.binary  "timestamp_column"
  end

  add_index "scstdc", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "semaphore", :primary_key => "identity_column", :force => true do |t|
    t.string   "ClientName",       :limit => 25, :null => false
    t.datetime "EntryDateTime",                  :null => false
    t.binary   "timestamp_column"
  end

  add_index "semaphore", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "shitem", :primary_key => "identity_column", :force => true do |t|
    t.string  "fitemno",          :limit => 6,                                                  :null => false
    t.string  "fitemtype",        :limit => 1,                                                  :null => false
    t.string  "fpartno",          :limit => 25,                                                 :null => false
    t.string  "frev",             :limit => 3,                                                  :null => false
    t.string  "fenumber",         :limit => 6,                                                  :null => false
    t.decimal "finvqty",                        :precision => 15, :scale => 5,                  :null => false
    t.string  "fmeasure",         :limit => 3,                                                  :null => false
    t.decimal "forderqty",                      :precision => 15, :scale => 5,                  :null => false
    t.string  "fcpokey",          :limit => 12,                                                 :null => false
    t.string  "fshipno",          :limit => 6,                                                  :null => false
    t.decimal "fshipqty",                       :precision => 15, :scale => 5,                  :null => false
    t.string  "fsokey",           :limit => 12,                                                 :null => false
    t.string  "fcstatus",         :limit => 1,                                                  :null => false
    t.string  "fcmiscstat",       :limit => 1,                                                  :null => false
    t.binary  "timestamp_column"
    t.text    "fmdescript",                                                    :default => " ", :null => false
    t.string  "fac",              :limit => 20,                                                 :null => false
    t.string  "sfac",             :limit => 20,                                                 :null => false
    t.string  "fcudrev",          :limit => 3,                                 :default => " ", :null => false
    t.string  "IdoNo",            :limit => 10,                                :default => "",  :null => false
    t.decimal "QtyRecvd",                       :precision => 15, :scale => 5, :default => 0.0, :null => false
    t.string  "fcustpart",        :limit => 25,                                                 :null => false
  end

  add_index "shitem", ["fcpokey"], :name => "pokey"
  add_index "shitem", ["fcstatus"], :name => "status"
  add_index "shitem", ["fitemtype"], :name => "itemtype"
  add_index "shitem", ["fpartno", "frev", "fac"], :name => "PARTNO"
  add_index "shitem", ["fshipno", "fitemno"], :name => "SHIPITEM"
  add_index "shitem", ["fshipqty", "finvqty"], :name => "invbal"
  add_index "shitem", ["fsokey", "fshipno"], :name => "SO_SHIP"
  add_index "shitem", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "shitemdl", :primary_key => "identity_column", :force => true do |t|
    t.integer "fishitemid",                                      :null => false
    t.integer "fitype",                                          :null => false
    t.integer "fiqty",                                           :null => false
    t.boolean "flpartial",                                       :null => false
    t.integer "fium1"
    t.decimal "fnsize1",          :precision => 18, :scale => 5
    t.integer "fium2"
    t.decimal "fnsize2",          :precision => 18, :scale => 5
    t.integer "fium3"
    t.decimal "fnsize3",          :precision => 18, :scale => 5
    t.integer "fium4"
    t.decimal "fnsize4",          :precision => 18, :scale => 5
    t.integer "fium5"
    t.binary  "timestamp_column"
    t.decimal "fnSize5",          :precision => 18, :scale => 5
  end

  add_index "shitemdl", ["fishitemid", "fitype"], :name => "ShItemID"
  add_index "shitemdl", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "shlotc", :primary_key => "identity_column", :force => true do |t|
    t.string  "fcshipno",         :limit => 6,                                 :null => false
    t.string  "fcitemno",         :limit => 6,                                 :null => false
    t.string  "fcsrcitmno",       :limit => 3,                                 :null => false
    t.string  "fclineord",        :limit => 3,                                 :null => false
    t.string  "fclot",            :limit => 20,                                :null => false
    t.decimal "fnlotqty",                       :precision => 15, :scale => 5, :null => false
    t.binary  "timestamp_column"
  end

  add_index "shlotc", ["fcshipno", "fcitemno", "fcsrcitmno", "fclot"], :name => "SHIPLOT"
  add_index "shlotc", ["fcsrcitmno", "fclineord", "fcshipno", "fcitemno"], :name => "primary_"
  add_index "shlotc", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "shmast", :primary_key => "identity_column", :force => true do |t|
    t.string   "fbl_lading",       :limit => 20,                                                  :null => false
    t.string   "fcjobno",          :limit => 10,                                                  :null => false
    t.string   "fcnumber",         :limit => 6,                                                   :null => false
    t.string   "fcollect",         :limit => 3,                                                   :null => false
    t.string   "fconfirm",         :limit => 1,                                                   :null => false
    t.string   "fcpono",           :limit => 6,                                                   :null => false
    t.string   "fcpro_id",         :limit => 7,                                                   :null => false
    t.string   "fcsono",           :limit => 6,                                                   :null => false
    t.string   "fcsorev",          :limit => 2,                                                   :null => false
    t.string   "fcvendno",         :limit => 6,                                                   :null => false
    t.string   "fenter",           :limit => 3,                                                   :null => false
    t.string   "ffob",             :limit => 20,                                                  :null => false
    t.decimal  "ffrtamt",                         :precision => 17, :scale => 5,                  :null => false
    t.boolean  "ffrtinvcd",                                                                       :null => false
    t.boolean  "flisinv",                                                                         :null => false
    t.integer  "fno_boxes",        :limit => nil, :precision => 5,  :scale => 0,                  :null => false
    t.datetime "fshipdate",                                                                       :null => false
    t.string   "fshipno",          :limit => 6,                                                   :null => false
    t.string   "fshipvia",         :limit => 20,                                                  :null => false
    t.decimal  "fshipwght",                       :precision => 12, :scale => 4,                  :null => false
    t.string   "fshptoaddr",       :limit => 4,                                                   :null => false
    t.string   "ftype",            :limit => 2,                                                   :null => false
    t.datetime "start",                                                                           :null => false
    t.boolean  "flpickprin",                                                                      :null => false
    t.boolean  "flshipprin",                                                                      :null => false
    t.string   "fcfname",          :limit => 15,                                                  :null => false
    t.string   "fclname",          :limit => 20,                                                  :null => false
    t.string   "fccounty",         :limit => 20,                                                  :null => false
    t.string   "fccompany",        :limit => 35,                                 :default => " ", :null => false
    t.string   "fccity",           :limit => 20,                                                  :null => false
    t.string   "fccountry",        :limit => 25,                                                  :null => false
    t.string   "fcfax",            :limit => 20,                                                  :null => false
    t.string   "fcphone",          :limit => 20,                                                  :null => false
    t.string   "fcstate",          :limit => 20,                                                  :null => false
    t.string   "fczip",            :limit => 10,                                                  :null => false
    t.string   "fporev",           :limit => 2,                                                   :null => false
    t.string   "fcbcompany",       :limit => 35,                                 :default => " ", :null => false
    t.boolean  "flpremcv",                                                                        :null => false
    t.string   "fcso_inum",        :limit => 3,                                                   :null => false
    t.string   "fcsono_rel",       :limit => 3,                                                   :null => false
    t.binary   "timestamp_column"
    t.text     "fmreferenc",                                                     :default => " ", :null => false
    t.text     "fmstreet",                                                       :default => " ", :null => false
    t.text     "fmtrckno",                                                       :default => " ", :null => false
    t.text     "fshipmemo",                                                      :default => " ", :null => false
    t.datetime "upsdate",                                                                         :null => false
    t.text     "upsaddr2",                                                       :default => "",  :null => false
    t.text     "upsaddr3",                                                       :default => "",  :null => false
  end

  add_index "shmast", ["fcjobno", "fshipno"], :name => "jobno"
  add_index "shmast", ["fcnumber"], :name => "customer"
  add_index "shmast", ["fconfirm"], :name => "confirm_"
  add_index "shmast", ["fcpono"], :name => "pono"
  add_index "shmast", ["fcsono", "fcso_inum", "fcsono_rel"], :name => "RELEASE"
  add_index "shmast", ["fcsono", "fshipno"], :name => "SONO"
  add_index "shmast", ["fcvendno"], :name => "vendor"
  add_index "shmast", ["fshipno"], :name => "shipno"
  add_index "shmast", ["ftype"], :name => "type"
  add_index "shmast", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "shsrce", :primary_key => "identity_column", :force => true do |t|
    t.string  "fcitemno",         :limit => 6,                                                  :null => false
    t.string  "fcshipno",         :limit => 6,                                                  :null => false
    t.string  "fcshipsrce",       :limit => 3,                                                  :null => false
    t.boolean "fljobcost",                                                                      :null => false
    t.decimal "fnlabcost",                      :precision => 17, :scale => 5,                  :null => false
    t.decimal "fnmatlcost",                     :precision => 17, :scale => 5,                  :null => false
    t.decimal "fnothrcost",                     :precision => 17, :scale => 5,                  :null => false
    t.decimal "fnovhdcost",                     :precision => 17, :scale => 5,                  :null => false
    t.decimal "fnshipqty",                      :precision => 15, :scale => 5,                  :null => false
    t.decimal "fnstdcost",                      :precision => 17, :scale => 5,                  :null => false
    t.string  "fcsrcitmno",       :limit => 3,                                                  :null => false
    t.binary  "timestamp_column"
    t.string  "loc",              :limit => 14,                                                 :null => false
    t.string  "bin",              :limit => 14,                                                 :null => false
    t.string  "source",           :limit => 2,                                 :default => "",  :null => false
    t.string  "fac",              :limit => 20,                                                 :null => false
    t.string  "fclocation",       :limit => 31,                                :default => " ", :null => false
    t.string  "sourcetype",       :limit => 2,                                 :default => "",  :null => false
  end

  add_index "shsrce", ["fcshipno", "fcitemno", "fclocation"], :name => "shipitemlo"
  add_index "shsrce", ["fcshipno", "fcitemno", "fcshipsrce", "fcsrcitmno"], :name => "shipitem"
  add_index "shsrce", ["fcshipno", "fcitemno", "fcsrcitmno"], :name => "shipsrcitm"
  add_index "shsrce", ["identity_column"], :name => "identity_column_idx1", :unique => true
  add_index "shsrce", ["loc"], :name => "loc"

  create_table "slcdpc", :primary_key => "identity_column", :force => true do |t|
    t.datetime "factn_date",                                                                     :null => false
    t.string   "factn_type",       :limit => 1,                                                  :null => false
    t.string   "fcustno",          :limit => 6,                                                  :null => false
    t.string   "funique",          :limit => 4,                                                  :null => false
    t.boolean  "factn_cmpl",                                                                     :null => false
    t.string   "fcjob",            :limit => 10,                                                 :null => false
    t.string   "fcquote",          :limit => 6,                                                  :null => false
    t.string   "fcso",             :limit => 6,                                                  :null => false
    t.string   "fnext_actn",       :limit => 1,                                                  :null => false
    t.integer  "fnrelate",         :limit => nil, :precision => 1, :scale => 0,                  :null => false
    t.string   "forigin",          :limit => 15,                                                 :null => false
    t.string   "fwho_by",          :limit => 15,                                                 :null => false
    t.string   "fwho_to",          :limit => 25,                                                 :null => false
    t.string   "fwho_first",       :limit => 15,                                                 :null => false
    t.binary   "timestamp_column"
    t.text     "fcomments",                                                     :default => " ", :null => false
  end

  add_index "slcdpc", ["fcustno", "factn_date", "funique"], :name => "CUSTDATE"
  add_index "slcdpc", ["fcustno", "factn_type", "factn_date"], :name => "ACTION"
  add_index "slcdpc", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "slcdpm", :primary_key => "identity_column", :force => true do |t|
    t.string   "fcustno",          :limit => 6,                                                   :null => false
    t.string   "fcompany",         :limit => 35,                                 :default => " ", :null => false
    t.string   "fcity",            :limit => 20,                                                  :null => false
    t.string   "fphone",           :limit => 20,                                                  :null => false
    t.integer  "fann_sales",       :limit => nil, :precision => 6,  :scale => 0,                  :null => false
    t.decimal  "fbacklog",                        :precision => 16, :scale => 4,                  :null => false
    t.decimal  "fbal",                            :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fbalnxt",                         :precision => 17, :scale => 5,                  :null => false
    t.string   "fcfname",          :limit => 15,                                                  :null => false
    t.string   "fcontact",         :limit => 20,                                                  :null => false
    t.string   "fcountry",         :limit => 25,                                                  :null => false
    t.datetime "fcreated",                                                                        :null => false
    t.integer  "fcrlimit",         :limit => nil, :precision => 15, :scale => 0,                  :null => false
    t.string   "fcshipto",         :limit => 4,                                                   :null => false
    t.string   "fcsoldto",         :limit => 4,                                                   :null => false
    t.string   "fcurrency",        :limit => 3,                                                   :null => false
    t.decimal  "fcurorder",                       :precision => 17, :scale => 5,                  :null => false
    t.string   "fcusrchr1",        :limit => 20,                                                  :null => false
    t.string   "fcusrchr2",        :limit => 40,                                 :default => " ", :null => false
    t.string   "fcusrchr3",        :limit => 40,                                 :default => " ", :null => false
    t.datetime "fdbdate",                                                                         :null => false
    t.string   "fdbrate",          :limit => 4,                                                   :null => false
    t.decimal  "fdisrate",                        :precision => 8,  :scale => 3,                  :null => false
    t.string   "fdistno",          :limit => 6,                                                   :null => false
    t.datetime "fdlpaydate",                                                                      :null => false
    t.datetime "fdusrdate1",                                                                      :null => false
    t.boolean  "fllongdist",                                                                      :null => false
    t.string   "ffax",             :limit => 20,                                                  :null => false
    t.boolean  "ffincharge",                                                                      :null => false
    t.string   "ffob",             :limit => 20,                                                  :null => false
    t.decimal  "fmtdamtnxt",                      :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fmtdsamt",                        :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fnardayslt",                      :precision => 17, :scale => 5,                  :null => false
    t.integer  "fno_employ",       :limit => nil, :precision => 5,  :scale => 0,                  :null => false
    t.decimal  "fnpayamt",                        :precision => 17, :scale => 5,                  :null => false
    t.string   "fcpaydex",         :limit => 3,                                                   :null => false
    t.decimal  "fnusrcur1",                       :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fnusrqty1",                       :precision => 15, :scale => 5,                  :null => false
    t.decimal  "fopencr",                         :precision => 17, :scale => 5,                  :null => false
    t.string   "fpaytype",         :limit => 1,                                                   :null => false
    t.string   "fpriority",        :limit => 2,                                                   :null => false
    t.decimal  "fsalcompct",                      :precision => 8,  :scale => 3,                  :null => false
    t.string   "fsalespn",         :limit => 3,                                                   :null => false
    t.string   "fsicno1",          :limit => 4,                                                   :null => false
    t.string   "fsicno2",          :limit => 4,                                                   :null => false
    t.string   "fshipvia",         :limit => 20,                                                  :null => false
    t.datetime "fsince",                                                                          :null => false
    t.string   "fstate",           :limit => 20,                                                  :null => false
    t.string   "ftaxcode",         :limit => 10,                                                  :null => false
    t.string   "ftaxexempt",       :limit => 15,                                                  :null => false
    t.decimal  "ftaxrate",                        :precision => 7,  :scale => 3,                  :null => false
    t.string   "fterm",            :limit => 4,                                                   :null => false
    t.string   "fterr",            :limit => 10,                                                  :null => false
    t.string   "ftype",            :limit => 1,                                                   :null => false
    t.string   "fusercode",        :limit => 7,                                                   :null => false
    t.decimal  "fytdsamt",                        :precision => 16, :scale => 4,                  :null => false
    t.string   "fyr_estab",        :limit => 4,                                                   :null => false
    t.string   "fzip",             :limit => 10,                                                  :null => false
    t.string   "fcstatus",         :limit => 1,                                                   :null => false
    t.boolean  "flistaxabl",                                                                      :null => false
    t.string   "fcemail",          :limit => 60,                                 :default => " ", :null => false
    t.boolean  "flisfcast",                                                                       :null => false
    t.binary   "timestamp_column"
    t.text     "fbus_type",                                                      :default => " ", :null => false
    t.text     "fmnotes",                                                        :default => " ", :null => false
    t.text     "fmstreet",                                                       :default => " ", :null => false
    t.text     "fmusrmemo1",                                                     :default => " ", :null => false
    t.integer  "fncrmmod",                                                       :default => 0,   :null => false
    t.string   "fccrmacct",        :limit => 12,                                 :default => "",  :null => false
    t.integer  "fscmprty",                                                       :default => 4,   :null => false
  end

  add_index "slcdpm", ["fcompany"], :name => "company"
  add_index "slcdpm", ["fcustno"], :name => "custno"
  add_index "slcdpm", ["fphone"], :name => "billphone"
  add_index "slcdpm", ["ftype", "fcustno"], :name => "CUSTTYPE"
  add_index "slcdpm", ["fusercode"], :name => "salescode"
  add_index "slcdpm", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "slcdpmar", :primary_key => "identity_column", :force => true do |t|
    t.string   "fcustno",          :limit => 6,                                  :default => "",    :null => false
    t.string   "fcompany",         :limit => 35,                                 :default => "",    :null => false
    t.string   "fcity",            :limit => 20,                                 :default => "",    :null => false
    t.string   "fphone",           :limit => 20,                                 :default => "",    :null => false
    t.integer  "fann_sales",       :limit => nil, :precision => 6,  :scale => 0, :default => 0,     :null => false
    t.decimal  "fbacklog",                        :precision => 16, :scale => 4, :default => 0.0,   :null => false
    t.decimal  "fbal",                            :precision => 17, :scale => 5, :default => 0.0,   :null => false
    t.decimal  "fbalnxt",                         :precision => 17, :scale => 5, :default => 0.0,   :null => false
    t.string   "fcfname",          :limit => 15,                                 :default => "",    :null => false
    t.string   "fcontact",         :limit => 20,                                 :default => "",    :null => false
    t.string   "fcountry",         :limit => 25,                                 :default => "",    :null => false
    t.datetime "fcreated",                                                                          :null => false
    t.integer  "fcrlimit",         :limit => nil, :precision => 15, :scale => 0, :default => 0,     :null => false
    t.string   "fcshipto",         :limit => 4,                                  :default => "",    :null => false
    t.string   "fcsoldto",         :limit => 4,                                  :default => "",    :null => false
    t.string   "fcurrency",        :limit => 3,                                  :default => "",    :null => false
    t.decimal  "fcurorder",                       :precision => 17, :scale => 5, :default => 0.0,   :null => false
    t.string   "fcusrchr1",        :limit => 20,                                 :default => "",    :null => false
    t.string   "fcusrchr2",        :limit => 40,                                 :default => "",    :null => false
    t.string   "fcusrchr3",        :limit => 40,                                 :default => "",    :null => false
    t.datetime "fdbdate",                                                                           :null => false
    t.string   "fdbrate",          :limit => 4,                                  :default => "",    :null => false
    t.decimal  "fdisrate",                        :precision => 8,  :scale => 3, :default => 0.0,   :null => false
    t.string   "fdistno",          :limit => 6,                                  :default => "",    :null => false
    t.datetime "fdlpaydate",                                                                        :null => false
    t.datetime "fdusrdate1",                                                                        :null => false
    t.boolean  "fllongdist",                                                     :default => false, :null => false
    t.string   "ffax",             :limit => 20,                                 :default => "",    :null => false
    t.boolean  "ffincharge",                                                     :default => false, :null => false
    t.string   "ffob",             :limit => 20,                                 :default => "",    :null => false
    t.decimal  "fmtdamtnxt",                      :precision => 17, :scale => 5, :default => 0.0,   :null => false
    t.decimal  "fmtdsamt",                        :precision => 17, :scale => 5, :default => 0.0,   :null => false
    t.decimal  "fnardayslt",                      :precision => 17, :scale => 5, :default => 0.0,   :null => false
    t.integer  "fno_employ",       :limit => nil, :precision => 5,  :scale => 0, :default => 0,     :null => false
    t.decimal  "fnpayamt",                        :precision => 17, :scale => 5, :default => 0.0,   :null => false
    t.string   "fcpaydex",         :limit => 3,                                  :default => "",    :null => false
    t.decimal  "fnusrcur1",                       :precision => 17, :scale => 5, :default => 0.0,   :null => false
    t.decimal  "fnusrqty1",                       :precision => 15, :scale => 5, :default => 0.0,   :null => false
    t.decimal  "fopencr",                         :precision => 17, :scale => 5, :default => 0.0,   :null => false
    t.string   "fpaytype",         :limit => 1,                                  :default => "",    :null => false
    t.string   "fpriority",        :limit => 2,                                  :default => "",    :null => false
    t.decimal  "fsalcompct",                      :precision => 8,  :scale => 3, :default => 0.0,   :null => false
    t.string   "fsalespn",         :limit => 3,                                  :default => "",    :null => false
    t.string   "fsicno1",          :limit => 4,                                  :default => "",    :null => false
    t.string   "fsicno2",          :limit => 4,                                  :default => "",    :null => false
    t.string   "fshipvia",         :limit => 20,                                 :default => "",    :null => false
    t.datetime "fsince",                                                                            :null => false
    t.string   "fstate",           :limit => 20,                                 :default => "",    :null => false
    t.string   "ftaxcode",         :limit => 10,                                 :default => "",    :null => false
    t.string   "ftaxexempt",       :limit => 15,                                 :default => "",    :null => false
    t.decimal  "ftaxrate",                        :precision => 7,  :scale => 3, :default => 0.0,   :null => false
    t.string   "fterm",            :limit => 4,                                  :default => "",    :null => false
    t.string   "fterr",            :limit => 10,                                 :default => "",    :null => false
    t.string   "ftype",            :limit => 1,                                  :default => "",    :null => false
    t.string   "fusercode",        :limit => 7,                                  :default => "",    :null => false
    t.decimal  "fytdsamt",                        :precision => 16, :scale => 4, :default => 0.0,   :null => false
    t.string   "fyr_estab",        :limit => 4,                                  :default => "",    :null => false
    t.string   "fzip",             :limit => 10,                                 :default => "",    :null => false
    t.string   "fcstatus",         :limit => 1,                                  :default => "",    :null => false
    t.boolean  "flistaxabl",                                                     :default => false, :null => false
    t.string   "fcemail",          :limit => 60,                                 :default => "",    :null => false
    t.boolean  "flisfcast",                                                      :default => false, :null => false
    t.binary   "timestamp_column"
    t.text     "fbus_type",                                                      :default => " ",   :null => false
    t.text     "fmnotes",                                                        :default => " ",   :null => false
    t.text     "fmstreet",                                                       :default => " ",   :null => false
    t.text     "fmusrmemo1",                                                     :default => " ",   :null => false
    t.string   "fccrmacct",        :limit => 12,                                 :default => "",    :null => false
    t.integer  "fncrmmod",                                                       :default => 0,     :null => false
    t.string   "fcchange",         :limit => 1,                                  :default => "",    :null => false
    t.integer  "fnKey",                                                                             :null => false
    t.datetime "fdarchive",                                                                         :null => false
  end

  add_index "slcdpmar", ["fcompany"], :name => "company"
  add_index "slcdpmar", ["fcustno", "ftype"], :name => "custtype"
  add_index "slcdpmar", ["fphone"], :name => "billphone"
  add_index "slcdpmar", ["ftype"], :name => "type"
  add_index "slcdpmar", ["fusercode"], :name => "salescode"
  add_index "slcdpmar", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "slcdpmsx", :primary_key => "identity_column", :force => true do |t|
    t.string  "fcustno",          :limit => 6,  :default => "", :null => false
    t.string  "ftype",            :limit => 1,  :default => "", :null => false
    t.string  "fcchange",         :limit => 1,  :default => "", :null => false
    t.integer "fnkey",                          :default => 0,  :null => false
    t.string  "fccrmacct",        :limit => 12, :default => "", :null => false
    t.integer "fncrmmod",                       :default => 0,  :null => false
    t.binary  "timestamp_column"
  end

  add_index "slcdpmsx", ["fnkey"], :name => "lookupkey"
  add_index "slcdpmsx", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "slchst", :primary_key => "identity_column", :force => true do |t|
    t.string  "fcustno",          :limit => 6,                                  :null => false
    t.integer "fnardays01",       :limit => nil, :precision => 10, :scale => 0, :null => false
    t.integer "fnardays02",       :limit => nil, :precision => 10, :scale => 0, :null => false
    t.integer "fnardays03",       :limit => nil, :precision => 10, :scale => 0, :null => false
    t.integer "fnardays04",       :limit => nil, :precision => 10, :scale => 0, :null => false
    t.integer "fnardays05",       :limit => nil, :precision => 10, :scale => 0, :null => false
    t.integer "fnardays06",       :limit => nil, :precision => 10, :scale => 0, :null => false
    t.integer "fnardays07",       :limit => nil, :precision => 10, :scale => 0, :null => false
    t.integer "fnardays08",       :limit => nil, :precision => 10, :scale => 0, :null => false
    t.integer "fnardays09",       :limit => nil, :precision => 10, :scale => 0, :null => false
    t.integer "fnardays10",       :limit => nil, :precision => 10, :scale => 0, :null => false
    t.integer "fnardays11",       :limit => nil, :precision => 10, :scale => 0, :null => false
    t.integer "fnardays12",       :limit => nil, :precision => 10, :scale => 0, :null => false
    t.integer "fnardays13",       :limit => nil, :precision => 10, :scale => 0, :null => false
    t.integer "fnardays14",       :limit => nil, :precision => 10, :scale => 0, :null => false
    t.integer "fnardays15",       :limit => nil, :precision => 10, :scale => 0, :null => false
    t.integer "fnardays16",       :limit => nil, :precision => 10, :scale => 0, :null => false
    t.integer "fnardays17",       :limit => nil, :precision => 10, :scale => 0, :null => false
    t.integer "fnardays18",       :limit => nil, :precision => 10, :scale => 0, :null => false
    t.integer "fnardays19",       :limit => nil, :precision => 10, :scale => 0, :null => false
    t.integer "fnardays20",       :limit => nil, :precision => 10, :scale => 0, :null => false
    t.integer "fnardays21",       :limit => nil, :precision => 10, :scale => 0, :null => false
    t.integer "fnardays22",       :limit => nil, :precision => 10, :scale => 0, :null => false
    t.integer "fnardays23",       :limit => nil, :precision => 10, :scale => 0, :null => false
    t.integer "fnardays24",       :limit => nil, :precision => 10, :scale => 0, :null => false
    t.integer "fnfirst",          :limit => nil, :precision => 10, :scale => 0, :null => false
    t.binary  "timestamp_column"
  end

  add_index "slchst", ["fcustno"], :name => "custno"
  add_index "slchst", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "slspns", :primary_key => "identity_column", :force => true do |t|
    t.string  "fdistno",          :limit => 6,                                                 :null => false
    t.string  "flastname",        :limit => 25,                                                :null => false
    t.string  "fsalespn",         :limit => 3,                                                 :null => false
    t.string  "fterr",            :limit => 10,                                                :null => false
    t.decimal "fsalcompct",                     :precision => 8, :scale => 3,                  :null => false
    t.string  "fsalespn2",        :limit => 3,                                                 :null => false
    t.string  "fsalespn3",        :limit => 3,                                                 :null => false
    t.decimal "fscompct2",                      :precision => 7, :scale => 2,                  :null => false
    t.decimal "fscompct3",                      :precision => 7, :scale => 2,                  :null => false
    t.boolean "flisfcast",                                                                     :null => false
    t.boolean "flterfcast",                                                                    :null => false
    t.binary  "timestamp_column"
    t.text    "fmnotes",                                                      :default => " ", :null => false
    t.string  "fvendno",          :limit => 6,                                :default => "",  :null => false
    t.string  "fccommcode",       :limit => 10,                               :default => "",  :null => false
    t.decimal "fnrate2",                        :precision => 8, :scale => 3, :default => 0.0, :null => false
  end

  add_index "slspns", ["fdistno"], :name => "fdistno"
  add_index "slspns", ["flastname", "fsalespn", "fterr", "fdistno"], :name => "LASTNAME"
  add_index "slspns", ["fsalespn", "fterr", "fdistno"], :name => "INITIALS"
  add_index "slspns", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "soaltr", :primary_key => "identity_column", :force => true do |t|
    t.string  "fsono",            :limit => 6,                                                    :null => false
    t.string  "finumber",         :limit => 3,                                                    :null => false
    t.string  "fbominum",         :limit => 4,                                                    :null => false
    t.integer "foperno",          :limit => nil, :precision => 4,  :scale => 0,  :default => 0,   :null => false
    t.string  "fcres_id",         :limit => 7,                                                    :null => false
    t.integer "fnsimulops",                                                                       :null => false
    t.decimal "fsetuptime",                      :precision => 7,  :scale => 2,                   :null => false
    t.decimal "fprodtime",                       :precision => 16, :scale => 10,                  :null => false
    t.integer "fndbrmod",         :limit => nil, :precision => 1,  :scale => 0,  :default => 0,   :null => false
    t.binary  "timestamp_column"
    t.decimal "fmovetime",                       :precision => 8,  :scale => 2,  :default => 0.0, :null => false
    t.decimal "felpstime",                       :precision => 12, :scale => 5,  :default => 0.0, :null => false
  end

  add_index "soaltr", ["fsono", "finumber", "fbominum", "foperno", "fcres_id"], :name => "SOOPID"
  add_index "soaltr", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "soanal", :primary_key => "identity_column", :force => true do |t|
    t.string  "fcinumber",        :limit => 3,                                                  :null => false
    t.decimal "fnnetprice",                     :precision => 15, :scale => 5,                  :null => false
    t.decimal "fnorderqty",                     :precision => 15, :scale => 5,                  :null => false
    t.string  "fcpartno",         :limit => 35,                                :default => " ", :null => false
    t.string  "fcpartrev",        :limit => 3,                                                  :null => false
    t.string  "fcprodcl",         :limit => 2,                                                  :null => false
    t.string  "fcsono",           :limit => 6,                                                  :null => false
    t.string  "fccustno",         :limit => 6,                                                  :null => false
    t.string  "fctype",           :limit => 1,                                                  :null => false
    t.decimal "fnmatcst01",                     :precision => 15, :scale => 5,                  :null => false
    t.decimal "fnmatcst02",                     :precision => 15, :scale => 5,                  :null => false
    t.decimal "fnmatcst03",                     :precision => 15, :scale => 5,                  :null => false
    t.decimal "fnmatcst04",                     :precision => 15, :scale => 5,                  :null => false
    t.decimal "fnmatcst05",                     :precision => 15, :scale => 5,                  :null => false
    t.decimal "fnmatcst06",                     :precision => 15, :scale => 5,                  :null => false
    t.decimal "fnmatcst07",                     :precision => 15, :scale => 5,                  :null => false
    t.decimal "fnmatcst08",                     :precision => 15, :scale => 5,                  :null => false
    t.decimal "fnmatcst09",                     :precision => 15, :scale => 5,                  :null => false
    t.decimal "fnmatcst10",                     :precision => 15, :scale => 5,                  :null => false
    t.decimal "fnmatcst11",                     :precision => 15, :scale => 5,                  :null => false
    t.decimal "fnmatcst12",                     :precision => 15, :scale => 5,                  :null => false
    t.decimal "fnmatcst13",                     :precision => 15, :scale => 5,                  :null => false
    t.decimal "fnlabcst01",                     :precision => 15, :scale => 5,                  :null => false
    t.decimal "fnlabcst02",                     :precision => 15, :scale => 5,                  :null => false
    t.decimal "fnlabcst03",                     :precision => 15, :scale => 5,                  :null => false
    t.decimal "fnlabcst04",                     :precision => 15, :scale => 5,                  :null => false
    t.decimal "fnlabcst05",                     :precision => 15, :scale => 5,                  :null => false
    t.decimal "fnlabcst06",                     :precision => 15, :scale => 5,                  :null => false
    t.decimal "fnlabcst07",                     :precision => 15, :scale => 5,                  :null => false
    t.decimal "fnlabcst08",                     :precision => 15, :scale => 5,                  :null => false
    t.decimal "fnlabcst09",                     :precision => 15, :scale => 5,                  :null => false
    t.decimal "fnlabcst10",                     :precision => 15, :scale => 5,                  :null => false
    t.decimal "fnlabcst11",                     :precision => 15, :scale => 5,                  :null => false
    t.decimal "fnlabcst12",                     :precision => 15, :scale => 5,                  :null => false
    t.decimal "fnlabcst13",                     :precision => 15, :scale => 5,                  :null => false
    t.decimal "fnovhcst01",                     :precision => 15, :scale => 5,                  :null => false
    t.decimal "fnovhcst02",                     :precision => 15, :scale => 5,                  :null => false
    t.decimal "fnovhcst03",                     :precision => 15, :scale => 5,                  :null => false
    t.decimal "fnovhcst04",                     :precision => 15, :scale => 5,                  :null => false
    t.decimal "fnovhcst05",                     :precision => 15, :scale => 5,                  :null => false
    t.decimal "fnovhcst06",                     :precision => 15, :scale => 5,                  :null => false
    t.decimal "fnovhcst07",                     :precision => 15, :scale => 5,                  :null => false
    t.decimal "fnovhcst08",                     :precision => 15, :scale => 5,                  :null => false
    t.decimal "fnovhcst09",                     :precision => 15, :scale => 5,                  :null => false
    t.decimal "fnovhcst10",                     :precision => 15, :scale => 5,                  :null => false
    t.decimal "fnovhcst11",                     :precision => 15, :scale => 5,                  :null => false
    t.decimal "fnovhcst12",                     :precision => 15, :scale => 5,                  :null => false
    t.decimal "fnovhcst13",                     :precision => 15, :scale => 5,                  :null => false
    t.decimal "fnshpmnt00",                     :precision => 15, :scale => 5,                  :null => false
    t.decimal "fnshpmnt01",                     :precision => 15, :scale => 5,                  :null => false
    t.decimal "fnshpmnt02",                     :precision => 15, :scale => 5,                  :null => false
    t.decimal "fnshpmnt03",                     :precision => 15, :scale => 5,                  :null => false
    t.decimal "fnshpmnt04",                     :precision => 15, :scale => 5,                  :null => false
    t.decimal "fnshpmnt05",                     :precision => 15, :scale => 5,                  :null => false
    t.decimal "fnshpmnt06",                     :precision => 15, :scale => 5,                  :null => false
    t.decimal "fnshpmnt07",                     :precision => 15, :scale => 5,                  :null => false
    t.decimal "fnshpmnt08",                     :precision => 15, :scale => 5,                  :null => false
    t.decimal "fnshpmnt09",                     :precision => 15, :scale => 5,                  :null => false
    t.decimal "fnshpmnt10",                     :precision => 15, :scale => 5,                  :null => false
    t.decimal "fnshpmnt11",                     :precision => 15, :scale => 5,                  :null => false
    t.decimal "fnshpmnt12",                     :precision => 15, :scale => 5,                  :null => false
    t.decimal "fnshpmnt13",                     :precision => 15, :scale => 5,                  :null => false
    t.decimal "fnorders00",                     :precision => 15, :scale => 5,                  :null => false
    t.decimal "fnorders01",                     :precision => 15, :scale => 5,                  :null => false
    t.decimal "fnorders02",                     :precision => 15, :scale => 5,                  :null => false
    t.decimal "fnorders03",                     :precision => 15, :scale => 5,                  :null => false
    t.decimal "fnorders04",                     :precision => 15, :scale => 5,                  :null => false
    t.decimal "fnorders05",                     :precision => 15, :scale => 5,                  :null => false
    t.decimal "fnorders06",                     :precision => 15, :scale => 5,                  :null => false
    t.decimal "fnorders07",                     :precision => 15, :scale => 5,                  :null => false
    t.decimal "fnorders08",                     :precision => 15, :scale => 5,                  :null => false
    t.decimal "fnorders09",                     :precision => 15, :scale => 5,                  :null => false
    t.decimal "fnorders10",                     :precision => 15, :scale => 5,                  :null => false
    t.decimal "fnorders11",                     :precision => 15, :scale => 5,                  :null => false
    t.decimal "fnorders12",                     :precision => 15, :scale => 5,                  :null => false
    t.decimal "fngrspft01",                     :precision => 15, :scale => 5,                  :null => false
    t.decimal "fngrspft02",                     :precision => 15, :scale => 5,                  :null => false
    t.decimal "fngrspft03",                     :precision => 15, :scale => 5,                  :null => false
    t.decimal "fngrspft04",                     :precision => 15, :scale => 5,                  :null => false
    t.decimal "fngrspft05",                     :precision => 15, :scale => 5,                  :null => false
    t.decimal "fngrspft06",                     :precision => 15, :scale => 5,                  :null => false
    t.decimal "fngrspft07",                     :precision => 15, :scale => 5,                  :null => false
    t.decimal "fngrspft08",                     :precision => 15, :scale => 5,                  :null => false
    t.decimal "fngrspft09",                     :precision => 15, :scale => 5,                  :null => false
    t.decimal "fngrspft10",                     :precision => 15, :scale => 5,                  :null => false
    t.decimal "fngrspft11",                     :precision => 15, :scale => 5,                  :null => false
    t.decimal "fngrspft12",                     :precision => 15, :scale => 5,                  :null => false
    t.decimal "fnbaklog00",                     :precision => 15, :scale => 5,                  :null => false
    t.decimal "fnbaklog01",                     :precision => 15, :scale => 5,                  :null => false
    t.decimal "fnbaklog02",                     :precision => 15, :scale => 5,                  :null => false
    t.decimal "fnbaklog03",                     :precision => 15, :scale => 5,                  :null => false
    t.decimal "fnbaklog04",                     :precision => 15, :scale => 5,                  :null => false
    t.decimal "fnbaklog05",                     :precision => 15, :scale => 5,                  :null => false
    t.decimal "fnbaklog06",                     :precision => 15, :scale => 5,                  :null => false
    t.decimal "fnbaklog07",                     :precision => 15, :scale => 5,                  :null => false
    t.decimal "fnbaklog08",                     :precision => 15, :scale => 5,                  :null => false
    t.decimal "fnbaklog09",                     :precision => 15, :scale => 5,                  :null => false
    t.decimal "fnbaklog10",                     :precision => 15, :scale => 5,                  :null => false
    t.decimal "fnbaklog11",                     :precision => 15, :scale => 5,                  :null => false
    t.decimal "fnbaklog12",                     :precision => 15, :scale => 5,                  :null => false
    t.binary  "timestamp_column"
    t.string  "fac",              :limit => 20,                                                 :null => false
    t.string  "fcudrev",          :limit => 3,                                 :default => " ", :null => false
  end

  add_index "soanal", ["fccustno", "fac", "fcpartno", "fcpartrev", "fcprodcl"], :name => "CUSPARPRO"
  add_index "soanal", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "socbom", :primary_key => "identity_column", :force => true do |t|
    t.string  "finumber",         :limit => 3,                                                 :null => false
    t.string  "fseqno",           :limit => 3,                                                 :null => false
    t.string  "fsono",            :limit => 6,                                                 :null => false
    t.decimal "fmatlcost",                     :precision => 21, :scale => 9,                  :null => false
    t.binary  "timestamp_column"
    t.text    "fbomdesc",                                                     :default => " ", :null => false
  end

  add_index "socbom", ["fsono", "finumber", "fseqno"], :name => "SEQNO"
  add_index "socbom", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "sochng", :primary_key => "identity_column", :force => true do |t|
    t.string   "fsono",            :limit => 6,                                                   :null => false
    t.string   "fsorev",           :limit => 2,                                                   :null => false
    t.datetime "fdate",                                                                           :null => false
    t.string   "fstatus",          :limit => 20,                                                  :null => false
    t.string   "fcchangeby",       :limit => 3,                                                   :null => false
    t.string   "fcfname",          :limit => 15,                                                  :null => false
    t.string   "fclname",          :limit => 20,                                                  :null => false
    t.integer  "fnmethod",         :limit => nil, :precision => 1,  :scale => 0,                  :null => false
    t.decimal  "fncost",                          :precision => 21, :scale => 5,                  :null => false
    t.decimal  "fninvamt",                        :precision => 21, :scale => 5,                  :null => false
    t.decimal  "fnprice",                         :precision => 21, :scale => 5,                  :null => false
    t.decimal  "fnpurcost",                       :precision => 21, :scale => 5,                  :null => false
    t.decimal  "fnlabor",                         :precision => 21, :scale => 5,                  :null => false
    t.binary   "timestamp_column"
    t.text     "fmdisp",                                                         :default => " ", :null => false
    t.text     "fmreason",                                                       :default => " ", :null => false
  end

  add_index "sochng", ["fsono", "fdate"], :name => "date"
  add_index "sochng", ["fsono", "fsorev"], :name => "SOREV"
  add_index "sochng", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "socrtg", :primary_key => "identity_column", :force => true do |t|
    t.string  "finumber",         :limit => 3,                                                 :null => false
    t.string  "fseqno",           :limit => 3,                                                 :null => false
    t.string  "fsono",            :limit => 6,                                                 :null => false
    t.decimal "ftime",                         :precision => 12, :scale => 5,                  :null => false
    t.decimal "frate",                         :precision => 12, :scale => 5,                  :null => false
    t.binary  "timestamp_column"
    t.text    "frtgdesc",                                                     :default => " ", :null => false
  end

  add_index "socrtg", ["fsono", "finumber", "fseqno"], :name => "SEQNO"
  add_index "socrtg", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "sodbom", :primary_key => "identity_column", :force => true do |t|
    t.string  "fbominum",         :limit => 4,                                  :default => " ",   :null => false
    t.string  "fbompart",         :limit => 25,                                 :default => " ",   :null => false
    t.string  "fbomrev",          :limit => 3,                                  :default => " ",   :null => false
    t.string  "finumber",         :limit => 3,                                  :default => " ",   :null => false
    t.string  "fitem",            :limit => 6,                                  :default => " ",   :null => false
    t.string  "fparinum",         :limit => 4,                                  :default => " ",   :null => false
    t.string  "fsono",            :limit => 6,                                  :default => " ",   :null => false
    t.decimal "fbomlcost",                       :precision => 21, :scale => 8, :default => 0.0,   :null => false
    t.string  "fbommeas",         :limit => 3,                                  :default => " ",   :null => false
    t.decimal "fbomocost",                       :precision => 21, :scale => 8, :default => 0.0,   :null => false
    t.string  "fbomsource",       :limit => 1,                                  :default => " ",   :null => false
    t.string  "fcostfrom",        :limit => 6,                                  :default => " ",   :null => false
    t.decimal "fextqty",                         :precision => 15, :scale => 5, :default => 0.0,   :null => false
    t.decimal "ffixcost",                        :precision => 21, :scale => 8, :default => 0.0,   :null => false
    t.decimal "flabcost",                        :precision => 21, :scale => 8, :default => 0.0,   :null => false
    t.decimal "flabsetcos",                      :precision => 21, :scale => 8, :default => 0.0,   :null => false
    t.integer "flastoper",        :limit => nil, :precision => 4,  :scale => 0, :default => 0,     :null => false
    t.string  "flevel",           :limit => 2,                                  :default => " ",   :null => false
    t.boolean "flextend",                                                       :default => false, :null => false
    t.boolean "fltooling",                                                      :default => false, :null => false
    t.decimal "fmatlcost",                       :precision => 17, :scale => 5, :default => 0.0,   :null => false
    t.integer "fnonpro",          :limit => nil, :precision => 3,  :scale => 0, :default => 0,     :null => false
    t.integer "fnumopers",        :limit => nil, :precision => 4,  :scale => 0, :default => 0,     :null => false
    t.decimal "fothrcost",                       :precision => 21, :scale => 8, :default => 0.0,   :null => false
    t.decimal "fovhdcost",                       :precision => 21, :scale => 8, :default => 0.0,   :null => false
    t.decimal "fovrhdsetc",                      :precision => 21, :scale => 8, :default => 0.0,   :null => false
    t.decimal "fsubcost",                        :precision => 21, :scale => 8, :default => 0.0,   :null => false
    t.decimal "ftotptime",                       :precision => 14, :scale => 7, :default => 0.0,   :null => false
    t.decimal "ftotqty",                         :precision => 15, :scale => 5, :default => 0.0,   :null => false
    t.decimal "ftotstime",                       :precision => 14, :scale => 7, :default => 0.0,   :null => false
    t.string  "fvendno",          :limit => 6,                                  :default => " ",   :null => false
    t.boolean "fllotreqd",                                                      :default => false, :null => false
    t.string  "fclotext",         :limit => 1,                                  :default => " ",   :null => false
    t.integer "fnoperno",         :limit => nil, :precision => 4,  :scale => 0, :default => 0,     :null => false
    t.binary  "timestamp_column"
    t.text    "fbomdesc",                                                       :default => " ",   :null => false
    t.text    "fstdmemo",                                                       :default => " ",   :null => false
    t.string  "fac",              :limit => 20,                                                    :null => false
    t.string  "fcbomudrev",       :limit => 3,                                  :default => "",    :null => false
    t.integer "fndbrmod",         :limit => nil, :precision => 1,  :scale => 0, :default => 0,     :null => false
  end

  add_index "sodbom", ["fsono", "finumber", "fbominum"], :name => "parent"
  add_index "sodbom", ["fsono", "finumber", "fparinum", "fac", "fbompart", "fbomrev"], :name => "PARTNO"
  add_index "sodbom", ["fsono", "finumber", "fparinum", "fitem"], :name => "itemno"
  add_index "sodbom", ["fsono", "finumber", "fparinum", "fnoperno", "fbominum"], :name => "byparent"
  add_index "sodbom", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "sodbomdl", :primary_key => "identity_column", :force => true do |t|
    t.integer "fisodbomid",                                      :null => false
    t.integer "fitype",                                          :null => false
    t.integer "fiqty",                                           :null => false
    t.boolean "flpartial",                                       :null => false
    t.integer "fium1"
    t.decimal "fnsize1",          :precision => 18, :scale => 5
    t.integer "fium2"
    t.decimal "fnsize2",          :precision => 18, :scale => 5
    t.integer "fium3"
    t.decimal "fnsize3",          :precision => 18, :scale => 5
    t.integer "fium4"
    t.decimal "fnsize4",          :precision => 18, :scale => 5
    t.integer "fium5"
    t.decimal "fnsize5",          :precision => 18, :scale => 5
    t.integer "ficount",                                         :null => false
    t.binary  "timestamp_column"
  end

  add_index "sodbomdl", ["fisodbomid", "fitype"], :name => "SODBOMID"
  add_index "sodbomdl", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "sodisp", :primary_key => "identity_column", :force => true do |t|
    t.string   "fcompany",         :limit => 35, :default => " ", :null => false
    t.string   "frev",             :limit => 2,                   :null => false
    t.string   "fsono",            :limit => 6,                   :null => false
    t.string   "fdisp",            :limit => 15,                  :null => false
    t.datetime "fduedate",                                        :null => false
    t.string   "fjobno",           :limit => 10,                  :null => false
    t.string   "fpartno",          :limit => 25,                  :null => false
    t.string   "fpartrev",         :limit => 3,                   :null => false
    t.datetime "frev_dt",                                         :null => false
    t.string   "fcpono",           :limit => 6,                   :null => false
    t.binary   "timestamp_column"
    t.string   "fac",              :limit => 20,                  :null => false
    t.string   "fcudrev",          :limit => 3,  :default => " ", :null => false
  end

  add_index "sodisp", ["fdisp"], :name => "disp"
  add_index "sodisp", ["fsono", "frev"], :name => "sorev"
  add_index "sodisp", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "sodrtg", :primary_key => "identity_column", :force => true do |t|
    t.string  "fbominum",         :limit => 4,                                                      :null => false
    t.string  "fchngrates",       :limit => 1,                                                      :null => false
    t.string  "fcstddesc",        :limit => 4,                                                      :null => false
    t.decimal "felpstime",                       :precision => 12, :scale => 5,                     :null => false
    t.decimal "ffixcost",                        :precision => 17, :scale => 5,                     :null => false
    t.string  "finumber",         :limit => 3,                                                      :null => false
    t.decimal "flaborutil",                      :precision => 7,  :scale => 2,                     :null => false
    t.boolean "flschedule",                                                                         :null => false
    t.decimal "fmovetime",                       :precision => 8,  :scale => 2,                     :null => false
    t.integer "foperno",          :limit => nil, :precision => 4,  :scale => 0,                     :null => false
    t.decimal "foperqty",                        :precision => 19, :scale => 6,                     :null => false
    t.decimal "fothrcost",                       :precision => 17, :scale => 5,                     :null => false
    t.string  "fpro_id",          :limit => 7,                                                      :null => false
    t.decimal "fsetuptime",                      :precision => 7,  :scale => 2,                     :null => false
    t.string  "fsono",            :limit => 6,                                                      :null => false
    t.decimal "fulabcost",                       :precision => 7,  :scale => 2,                     :null => false
    t.decimal "fuovrhdcos",                      :precision => 7,  :scale => 2,                     :null => false
    t.decimal "fuprodtime",                      :precision => 16, :scale => 10,                    :null => false
    t.decimal "fusubcost",                       :precision => 17, :scale => 5,                     :null => false
    t.boolean "fllotreqd",                                                                          :null => false
    t.binary  "timestamp_column"
    t.text    "fdescript",                                                       :default => " ",   :null => false
    t.text    "fopermemo",                                                       :default => " ",   :null => false
    t.integer "fndbrmod",         :limit => nil, :precision => 1,  :scale => 0,  :default => 0,     :null => false
    t.integer "fnsimulops",       :limit => nil, :precision => 3,  :scale => 0,  :default => 0,     :null => false
    t.decimal "fyield",                          :precision => 12, :scale => 5,  :default => 100.0, :null => false
    t.decimal "fsetyield",                       :precision => 8,  :scale => 2,  :default => 0.0,   :null => false
  end

  add_index "sodrtg", ["fsono", "finumber", "fbominum", "foperno"], :name => "OPERNO"
  add_index "sodrtg", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "sohist", :primary_key => "identity_column", :force => true do |t|
    t.string  "fcustno",          :limit => 6,                                :null => false
    t.string  "fcyear",           :limit => 4,                                :null => false
    t.string  "fcmonth",          :limit => 2,                                :null => false
    t.decimal "fmtdsamt",                      :precision => 17, :scale => 5, :null => false
    t.binary  "timestamp_column"
  end

  add_index "sohist", ["fcustno", "fcyear", "fcmonth"], :name => "CUSTMNTH"
  add_index "sohist", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "soitem", :primary_key => "identity_column", :force => true do |t|
    t.string   "finumber",         :limit => 3,                                                   :null => false
    t.string   "fpartno",          :limit => 25,                                                  :null => false
    t.string   "fpartrev",         :limit => 3,                                                   :null => false
    t.string   "fsono",            :limit => 6,                                                   :null => false
    t.string   "fclotext",         :limit => 1,                                                   :null => false
    t.boolean  "fllotreqd",                                                                       :null => false
    t.boolean  "fautocreat",                                                                      :null => false
    t.boolean  "fcas_bom",                                                                        :null => false
    t.boolean  "fcas_rtg",                                                                        :null => false
    t.decimal  "fcommpct",                        :precision => 8,  :scale => 2,                  :null => false
    t.string   "fcustpart",        :limit => 25,                                                  :null => false
    t.string   "fcustptrev",       :limit => 3,                                                   :null => false
    t.boolean  "fdet_bom",                                                                        :null => false
    t.boolean  "fdet_rtg",                                                                        :null => false
    t.datetime "fduedate",                                                                        :null => false
    t.string   "fenumber",         :limit => 3,                                                   :null => false
    t.decimal  "ffixact",                         :precision => 17, :scale => 5,                  :null => false
    t.string   "fgroup",           :limit => 6,                                                   :null => false
    t.decimal  "flabact",                         :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fmatlact",                        :precision => 17, :scale => 5,                  :null => false
    t.string   "fmeasure",         :limit => 3,                                                   :null => false
    t.boolean  "fmultiple",                                                                       :null => false
    t.integer  "fnextinum",        :limit => nil, :precision => 4,  :scale => 0,                  :null => false
    t.integer  "fnextrel",         :limit => nil, :precision => 3,  :scale => 0,                  :null => false
    t.decimal  "fnunder",                         :precision => 12, :scale => 5,                  :null => false
    t.decimal  "fnover",                          :precision => 12, :scale => 5,                  :null => false
    t.string   "fordertype",       :limit => 3,                                                   :null => false
    t.decimal  "fothract",                        :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fovhdact",                        :precision => 17, :scale => 5,                  :null => false
    t.boolean  "fprice",                                                                          :null => false
    t.boolean  "fprintmemo",                                                                      :null => false
    t.string   "fprodcl",          :limit => 2,                                                   :null => false
    t.decimal  "fquantity",                       :precision => 17, :scale => 5,                  :null => false
    t.string   "fcfromtype",       :limit => 6,                                                   :null => false
    t.string   "fcfromno",         :limit => 6,                                                   :null => false
    t.string   "fcfromitem",       :limit => 3,                                                   :null => false
    t.decimal  "fquoteqty",                       :precision => 15, :scale => 5,                  :null => false
    t.decimal  "frtgsetupa",                      :precision => 17, :scale => 5,                  :null => false
    t.string   "fschecode",        :limit => 6,                                                   :null => false
    t.boolean  "fshipitem",                                                                       :null => false
    t.string   "fsoldby",          :limit => 3,                                                   :null => false
    t.string   "fsource",          :limit => 1,                                                   :null => false
    t.boolean  "fstandpart",                                                                      :null => false
    t.decimal  "fsubact",                         :precision => 17, :scale => 5,                  :null => false
    t.boolean  "fsummary",                                                                        :null => false
    t.string   "ftaxcode",         :limit => 3,                                                   :null => false
    t.decimal  "ftaxrate",                        :precision => 7,  :scale => 3,                  :null => false
    t.decimal  "ftoolact",                        :precision => 17, :scale => 5,                  :null => false
    t.integer  "ftnumoper",        :limit => nil, :precision => 6,  :scale => 0,                  :null => false
    t.integer  "ftotnonpr",        :limit => nil, :precision => 4,  :scale => 0,                  :null => false
    t.decimal  "ftotptime",                       :precision => 15, :scale => 5,                  :null => false
    t.decimal  "ftotstime",                       :precision => 15, :scale => 5,                  :null => false
    t.decimal  "fulabcost1",                      :precision => 7,  :scale => 2,                  :null => false
    t.boolean  "fviewprice",                                                                      :null => false
    t.string   "fcprodid",         :limit => 6,                                                   :null => false
    t.string   "fschedtype",       :limit => 1,                                                   :null => false
    t.binary   "timestamp_column"
    t.text     "fdesc",                                                          :default => " ", :null => false
    t.text     "fdescmemo",                                                      :default => " ", :null => false
    t.string   "fac",              :limit => 20,                                                  :null => false
    t.string   "sfac",             :limit => 20,                                                  :null => false
    t.decimal  "ITCCOST",                         :precision => 17, :scale => 5,                  :null => false
    t.string   "fcudrev",          :limit => 3,                                  :default => " ", :null => false
    t.integer  "fndbrmod",         :limit => nil, :precision => 1,  :scale => 0, :default => 0,   :null => false
    t.string   "FcAltUM",          :limit => 3,                                  :default => "",  :null => false
    t.decimal  "FnAltQty",                        :precision => 17, :scale => 5, :default => 0.0, :null => false
    t.decimal  "fnlatefact",                      :precision => 4,  :scale => 2,                  :null => false
    t.integer  "fnsobuf",          :limit => nil, :precision => 2,  :scale => 0,                  :null => false
    t.boolean  "ManualPlan",                                                                      :null => false
  end

  add_index "soitem", ["fsono", "fac", "fpartno", "fpartrev"], :name => "PartNo"
  add_index "soitem", ["fsono", "fenumber"], :name => "enumber"
  add_index "soitem", ["fsono", "finumber"], :name => "inumber"
  add_index "soitem", ["fsource"], :name => "source"
  add_index "soitem", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "somast", :primary_key => "identity_column", :force => true do |t|
    t.string   "fsono",            :limit => 6,                                                     :null => false
    t.string   "fcustno",          :limit => 6,                                                     :null => false
    t.string   "fcompany",         :limit => 35,                                 :default => " ",   :null => false
    t.string   "fcity",            :limit => 20,                                                    :null => false
    t.string   "fcustpono",        :limit => 20,                                                    :null => false
    t.datetime "fackdate",                                                                          :null => false
    t.datetime "fcanc_dt",                                                                          :null => false
    t.string   "fccurid",          :limit => 3,                                                     :null => false
    t.decimal  "fcfactor",                        :precision => 17, :scale => 5,                    :null => false
    t.string   "fcfname",          :limit => 15,                                                    :null => false
    t.string   "fcfromno",         :limit => 6,                                                     :null => false
    t.string   "fcfromtype",       :limit => 5,                                                     :null => false
    t.string   "fcontact",         :limit => 30,                                 :default => " ",   :null => false
    t.datetime "fclos_dt",                                                                          :null => false
    t.string   "fcountry",         :limit => 25,                                                    :null => false
    t.string   "fcusrchr1",        :limit => 20,                                                    :null => false
    t.string   "fcusrchr2",        :limit => 40,                                 :default => " ",   :null => false
    t.string   "fcusrchr3",        :limit => 40,                                 :default => " ",   :null => false
    t.datetime "fdcurdate",                                                                         :null => false
    t.decimal  "fdisrate",                        :precision => 8,  :scale => 3,                    :null => false
    t.string   "fdistno",          :limit => 6,                                                     :null => false
    t.datetime "fduedate",                                                                          :null => false
    t.boolean  "fduplicate",                                                                        :null => false
    t.datetime "fdusrdate1",                                                                        :null => false
    t.string   "festimator",       :limit => 3,                                                     :null => false
    t.string   "ffax",             :limit => 20,                                                    :null => false
    t.string   "ffob",             :limit => 20,                                                    :null => false
    t.string   "fnextenum",        :limit => 3,                                                     :null => false
    t.string   "fnextinum",        :limit => 3,                                                     :null => false
    t.decimal  "fnusrqty1",                       :precision => 15, :scale => 5,                    :null => false
    t.decimal  "fnusrcur1",                       :precision => 17, :scale => 5,                    :null => false
    t.datetime "forderdate",                                                                        :null => false
    t.string   "fordername",       :limit => 35,                                 :default => " ",   :null => false
    t.datetime "fordrevdt",                                                                         :null => false
    t.string   "fpaytype",         :limit => 1,                                                     :null => false
    t.string   "fphone",           :limit => 20,                                                    :null => false
    t.datetime "fprint_dt",                                                                         :null => false
    t.boolean  "fprinted",                                                                          :null => false
    t.decimal  "fsalcompct",                      :precision => 8,  :scale => 3,                    :null => false
    t.boolean  "fsalecom",                                                                          :null => false
    t.string   "fshipvia",         :limit => 20,                                                    :null => false
    t.string   "fshptoaddr",       :limit => 4,                                                     :null => false
    t.string   "fsocoord",         :limit => 3,                                                     :null => false
    t.string   "fsoldaddr",        :limit => 4,                                                     :null => false
    t.string   "fsoldby",          :limit => 3,                                                     :null => false
    t.string   "fsorev",           :limit => 2,                                                     :null => false
    t.string   "fstate",           :limit => 20,                                                    :null => false
    t.string   "fstatus",          :limit => 20,                                                    :null => false
    t.string   "ftaxcode",         :limit => 3,                                                     :null => false
    t.decimal  "ftaxrate",                        :precision => 7,  :scale => 3,                    :null => false
    t.string   "fterm",            :limit => 4,                                                     :null => false
    t.string   "fterr",            :limit => 10,                                                    :null => false
    t.string   "fzip",             :limit => 10,                                                    :null => false
    t.boolean  "flprofprtd",                                                                        :null => false
    t.boolean  "flprofrqd",                                                                         :null => false
    t.decimal  "fndpstrcvd",                      :precision => 17, :scale => 5,                    :null => false
    t.decimal  "fndpstrqd",                       :precision => 17, :scale => 5,                    :null => false
    t.datetime "fdeurodate",                                                                        :null => false
    t.decimal  "feurofctr",                       :precision => 17, :scale => 5,                    :null => false
    t.string   "fsalescode",       :limit => 7,                                                     :null => false
    t.string   "fusercode",        :limit => 7,                                                     :null => false
    t.decimal  "fncancchrge",                     :precision => 17, :scale => 5,                    :null => false
    t.boolean  "flchgpnd",                                                                          :null => false
    t.string   "fllasteco",        :limit => 25,                                                    :null => false
    t.binary   "timestamp_column"
    t.text     "fackmemo",                                                       :default => " ",   :null => false
    t.text     "fmstreet",                                                       :default => " ",   :null => false
    t.text     "fmusrmemo1",                                                     :default => " ",   :null => false
    t.string   "fccontkey",        :limit => 10,                                 :default => " ",   :null => false
    t.boolean  "flcontract",                                                     :default => false, :null => false
    t.integer  "fndbrmod",         :limit => nil, :precision => 1,  :scale => 0, :default => 0,     :null => false
    t.string   "fccommcode",       :limit => 10,                                 :default => "",    :null => false
    t.integer  "fpriority",                                                      :default => 4,     :null => false
  end

  add_index "somast", ["fcompany"], :name => "company"
  add_index "somast", ["fcustno"], :name => "custno"
  add_index "somast", ["fcustpono"], :name => "cponumber"
  add_index "somast", ["fsono"], :name => "sono"
  add_index "somast", ["fstatus"], :name => "status"
  add_index "somast", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "sorcom", :primary_key => "identity_column", :force => true do |t|
    t.string  "fsono",            :limit => 6,                               :default => "",    :null => false
    t.string  "finumber",         :limit => 3,                               :default => "",    :null => false
    t.string  "frelease",         :limit => 3,                               :default => "",    :null => false
    t.string  "fsalespn",         :limit => 3,                               :default => "",    :null => false
    t.decimal "fnrate",                        :precision => 8, :scale => 3, :default => 0.0,   :null => false
    t.boolean "flrate2",                                                     :default => false, :null => false
    t.binary  "timestamp_column"
  end

  add_index "sorcom", ["fsono", "finumber", "frelease", "fsalespn"], :name => "release"
  add_index "sorcom", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "sorels", :primary_key => "identity_column", :force => true do |t|
    t.string   "fenumber",         :limit => 3,                                                   :null => false
    t.string   "finumber",         :limit => 3,                                                   :null => false
    t.string   "fpartno",          :limit => 25,                                                  :null => false
    t.string   "fpartrev",         :limit => 3,                                                   :null => false
    t.string   "frelease",         :limit => 3,                                                   :null => false
    t.string   "fshptoaddr",       :limit => 4,                                                   :null => false
    t.string   "fsono",            :limit => 6,                                                   :null => false
    t.boolean  "favailship",                                                                      :null => false
    t.decimal  "fbook",                           :precision => 15, :scale => 5,                  :null => false
    t.decimal  "fbqty",                           :precision => 15, :scale => 5,                  :null => false
    t.decimal  "fdiscount",                       :precision => 17, :scale => 5,                  :null => false
    t.datetime "fduedate",                                                                        :null => false
    t.decimal  "finvamount",                      :precision => 17, :scale => 5,                  :null => false
    t.decimal  "finvqty",                         :precision => 15, :scale => 5,                  :null => false
    t.boolean  "fjob",                                                                            :null => false
    t.decimal  "fjoqty",                          :precision => 15, :scale => 5,                  :null => false
    t.decimal  "flabcost",                        :precision => 17, :scale => 5,                  :null => false
    t.decimal  "flngth",                          :precision => 15, :scale => 5,                  :null => false
    t.datetime "flshipdate",                                                                      :null => false
    t.boolean  "fmasterrel",                                                                      :null => false
    t.decimal  "fmatlcost",                       :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fmaxqty",                         :precision => 15, :scale => 5,                  :null => false
    t.decimal  "fmqty",                           :precision => 15, :scale => 5,                  :null => false
    t.decimal  "fmsi",                            :precision => 15, :scale => 5,                  :null => false
    t.decimal  "fnetprice",                       :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fninvship",                       :precision => 15, :scale => 5,                  :null => false
    t.decimal  "fnpurvar",                                                                        :null => false
    t.decimal  "forderqty",                       :precision => 15, :scale => 5,                  :null => false
    t.decimal  "fothrcost",                       :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fovhdcost",                       :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fpoqty",                          :precision => 15, :scale => 5,                  :null => false
    t.string   "fpostatus",        :limit => 6,                                                   :null => false
    t.decimal  "fquant",                          :precision => 15, :scale => 5,                  :null => false
    t.decimal  "fsetupcost",                      :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fshipbook",                       :precision => 15, :scale => 5,                  :null => false
    t.decimal  "fshipbuy",                        :precision => 15, :scale => 5,                  :null => false
    t.decimal  "fshipmake",                       :precision => 15, :scale => 5,                  :null => false
    t.boolean  "fshpbefdue",                                                                      :null => false
    t.boolean  "fsplitshp",                                                                       :null => false
    t.string   "fstatus",          :limit => 10,                                                  :null => false
    t.decimal  "fstkqty",                         :precision => 15, :scale => 5,                  :null => false
    t.decimal  "fsubcost",                        :precision => 17, :scale => 5,                  :null => false
    t.decimal  "ftoolcost",                       :precision => 17, :scale => 5,                  :null => false
    t.decimal  "ftoshpbook",                      :precision => 15, :scale => 5,                  :null => false
    t.decimal  "ftoshpbuy",                       :precision => 15, :scale => 5,                  :null => false
    t.decimal  "ftoshpmake",                      :precision => 15, :scale => 5,                  :null => false
    t.decimal  "funetprice",                      :precision => 17, :scale => 5,                  :null => false
    t.string   "fvendno",          :limit => 6,                                                   :null => false
    t.decimal  "fwidth",                          :precision => 15, :scale => 5,                  :null => false
    t.decimal  "fnretpoqty",                      :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fnettxnprice",                    :precision => 17, :scale => 5,                  :null => false
    t.decimal  "funettxnpric",                    :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fneteuropr",                      :precision => 17, :scale => 5,                  :null => false
    t.decimal  "funeteuropr",                     :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fdiscpct",                        :precision => 17, :scale => 5,                  :null => false
    t.boolean  "fljrdif",                                                                         :null => false
    t.boolean  "flistaxabl",                                                                      :null => false
    t.boolean  "flatp",                                                                           :null => false
    t.string   "fcbin",            :limit => 14,                                                  :null => false
    t.string   "fcloc",            :limit => 14,                                                  :null => false
    t.binary   "timestamp_column"
    t.text     "fdelivery",                                                      :default => " ", :null => false
    t.string   "fcpbtype",         :limit => 1,                                  :default => "",  :null => false
    t.string   "fcudrev",          :limit => 3,                                  :default => " ", :null => false
    t.integer  "fndbrmod",         :limit => nil, :precision => 1,  :scale => 0, :default => 0,   :null => false
    t.integer  "fpriority",                                                      :default => 4,   :null => false
    t.datetime "SchedDate",                                                                       :null => false
  end

  add_index "sorels", ["fduedate"], :name => "duedate"
  add_index "sorels", ["forderqty", "fshipbook", "fshipmake", "fshipbuy"], :name => "dmdamt"
  add_index "sorels", ["fpartno", "fpartrev", "fsono"], :name => "buyparts"
  add_index "sorels", ["fshipbook", "fshipmake", "fshipbuy", "finvqty"], :name => "shipamt"
  add_index "sorels", ["fsono", "finumber", "frelease"], :name => "makeitems"
  add_index "sorels", ["fsono", "fshptoaddr", "finumber"], :name => "shipto"
  add_index "sorels", ["ftoshpbook", "ftoshpmake", "fninvship", "forderqty", "fshipbook", "fshipmake", "ftoshpbuy", "fshipbuy", "finvqty"], :name => "invopen"
  add_index "sorels", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "soresc", :primary_key => "identity_column", :force => true do |t|
    t.string  "fsono",            :limit => 6,                                                :null => false
    t.string  "finumber",         :limit => 3,                                                :null => false
    t.string  "fbominum",         :limit => 4,                                                :null => false
    t.integer "foperno",          :limit => nil, :precision => 4, :scale => 0,                :null => false
    t.string  "fcres_id",         :limit => 7,                                                :null => false
    t.integer "fnsimulops",       :limit => nil, :precision => 3, :scale => 0,                :null => false
    t.binary  "timestamp_column"
    t.integer "fndbrmod",         :limit => nil, :precision => 1, :scale => 0, :default => 0, :null => false
  end

  add_index "soresc", ["fsono", "finumber", "fbominum", "foperno", "fcres_id"], :name => "SOOPID"
  add_index "soresc", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "soship", :primary_key => "identity_column", :force => true do |t|
    t.string "fcsono",           :limit => 6,                   :null => false
    t.string "fcenumber",        :limit => 3,                   :null => false
    t.string "fcinumber",        :limit => 3,                   :null => false
    t.string "fcrelease",        :limit => 3,                   :null => false
    t.string "fccompany",        :limit => 35, :default => " ", :null => false
    t.string "fccity",           :limit => 20,                  :null => false
    t.string "fcstate",          :limit => 20,                  :null => false
    t.string "fczip",            :limit => 10,                  :null => false
    t.string "fccountry",        :limit => 25,                  :null => false
    t.string "fcphone",          :limit => 20,                  :null => false
    t.string "fcfax",            :limit => 20,                  :null => false
    t.binary "timestamp_column"
    t.text   "fmstreet",                       :default => " ", :null => false
  end

  add_index "soship", ["fcsono", "fcenumber"], :name => "ENUMBER"
  add_index "soship", ["fcsono", "fcinumber", "fcrelease"], :name => "RELEASE"
  add_index "soship", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "sotax", :primary_key => "identity_column", :force => true do |t|
    t.string  "fsono",            :limit => 6,  :null => false
    t.string  "finumber",         :limit => 3,  :null => false
    t.string  "frelease",         :limit => 3,  :null => false
    t.string  "fcjrdict",         :limit => 10, :null => false
    t.string  "fctaxcode",        :limit => 10, :null => false
    t.integer "fnorder",                        :null => false
    t.binary  "timestamp_column"
  end

  add_index "sotax", ["fsono", "finumber", "frelease", "fnorder"], :name => "JRSOORDER"
  add_index "sotax", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "syaddr", :primary_key => "identity_column", :force => true do |t|
    t.boolean "fllongdist",                                      :null => false
    t.string  "fcaddrkey",        :limit => 4,                   :null => false
    t.string  "fcaddrtype",       :limit => 1,                   :null => false
    t.string  "fcaliaskey",       :limit => 6,                   :null => false
    t.string  "fcalias",          :limit => 10,                  :null => false
    t.string  "fcfname",          :limit => 15,                  :null => false
    t.string  "fclname",          :limit => 20,                  :null => false
    t.string  "fccounty",         :limit => 20,                  :null => false
    t.string  "fccompany",        :limit => 35, :default => " ", :null => false
    t.string  "fccity",           :limit => 20,                  :null => false
    t.string  "fccountry",        :limit => 25,                  :null => false
    t.string  "fcfax",            :limit => 20,                  :null => false
    t.string  "fcphone",          :limit => 20,                  :null => false
    t.string  "fcstate",          :limit => 20,                  :null => false
    t.string  "fczip",            :limit => 10,                  :null => false
    t.string  "fcjrdict",         :limit => 10,                  :null => false
    t.string  "fcemail",          :limit => 60, :default => " ", :null => false
    t.string  "fcloc",            :limit => 14,                  :null => false
    t.binary  "timestamp_column"
    t.text    "fmnotes",                        :default => " ", :null => false
    t.text    "fmstreet",                       :default => " ", :null => false
    t.integer "fncrmmod",                       :default => 0,   :null => false
    t.string  "fccrmaddrs",       :limit => 12, :default => "",  :null => false
    t.string  "fac",              :limit => 20,                  :null => false
  end

  add_index "syaddr", ["fcaddrkey"], :name => "fcaddrkey"
  add_index "syaddr", ["fcaddrtype"], :name => "type"
  add_index "syaddr", ["fcalias", "fcaddrtype"], :name => "FASTLU"
  add_index "syaddr", ["fcalias", "fcaliaskey", "fcaddrtype", "fcaddrkey"], :name => "lookupkey"
  add_index "syaddr", ["fcaliaskey"], :name => "aliaskey"
  add_index "syaddr", ["fccity"], :name => "city"
  add_index "syaddr", ["fccompany"], :name => "company"
  add_index "syaddr", ["fcphone"], :name => "phone"
  add_index "syaddr", ["fczip"], :name => "zip"
  add_index "syaddr", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "syaddrar", :primary_key => "identity_column", :force => true do |t|
    t.boolean  "fllongdist",                     :default => false, :null => false
    t.string   "fcaddrkey",        :limit => 4,  :default => "",    :null => false
    t.string   "fcaddrtype",       :limit => 1,  :default => "",    :null => false
    t.string   "fcaliaskey",       :limit => 6,  :default => "",    :null => false
    t.string   "fcalias",          :limit => 10, :default => "",    :null => false
    t.string   "fcfname",          :limit => 15, :default => "",    :null => false
    t.string   "fclname",          :limit => 20, :default => "",    :null => false
    t.string   "fccounty",         :limit => 20, :default => "",    :null => false
    t.string   "fccompany",        :limit => 35, :default => "",    :null => false
    t.string   "fccity",           :limit => 20, :default => "",    :null => false
    t.string   "fccountry",        :limit => 25, :default => "",    :null => false
    t.string   "fcfax",            :limit => 20, :default => "",    :null => false
    t.string   "fcphone",          :limit => 20, :default => "",    :null => false
    t.string   "fcstate",          :limit => 20, :default => "",    :null => false
    t.string   "fczip",            :limit => 10, :default => "",    :null => false
    t.string   "fcjrdict",         :limit => 10, :default => "",    :null => false
    t.string   "fcemail",          :limit => 60, :default => "",    :null => false
    t.string   "fcloc",            :limit => 14, :default => "",    :null => false
    t.binary   "timestamp_column"
    t.text     "fmnotes",                        :default => " ",   :null => false
    t.text     "fmstreet",                       :default => " ",   :null => false
    t.string   "fccrmaddrs",       :limit => 12, :default => "",    :null => false
    t.integer  "fncrmmod",                       :default => 0,     :null => false
    t.string   "fcchange",         :limit => 1,  :default => "",    :null => false
    t.string   "fac",              :limit => 20,                    :null => false
    t.integer  "fnKey",                                             :null => false
    t.datetime "fdarchive",                                         :null => false
  end

  add_index "syaddrar", ["fcaddrkey"], :name => "fcaddrkey"
  add_index "syaddrar", ["fcaddrtype", "fcalias"], :name => "fastlu"
  add_index "syaddrar", ["fcaddrtype", "fcaliaskey", "fcaddrkey", "fcalias"], :name => "lookupkey"
  add_index "syaddrar", ["fcaddrtype", "fcaliaskey", "fcalias"], :name => "fastlu2"
  add_index "syaddrar", ["fcalias"], :name => "alias"
  add_index "syaddrar", ["fcaliaskey"], :name => "aliaskey"
  add_index "syaddrar", ["fccity"], :name => "city"
  add_index "syaddrar", ["fccompany"], :name => "company"
  add_index "syaddrar", ["fcphone"], :name => "phone"
  add_index "syaddrar", ["fczip"], :name => "zip"
  add_index "syaddrar", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "syaddrsx", :primary_key => "identity_column", :force => true do |t|
    t.string  "fcaliaskey",       :limit => 6,  :default => "", :null => false
    t.string  "fcalias",          :limit => 10, :default => "", :null => false
    t.string  "fcaddrkey",        :limit => 4,  :default => "", :null => false
    t.string  "fcaddrtype",       :limit => 1,  :default => "", :null => false
    t.string  "fcchange",         :limit => 1,  :default => "", :null => false
    t.integer "fnkey",                          :default => 0,  :null => false
    t.string  "fccrmaddrs",       :limit => 12, :default => "", :null => false
    t.integer "fncrmmod",                       :default => 0,  :null => false
    t.binary  "timestamp_column"
  end

  add_index "syaddrsx", ["fnkey"], :name => "lookupkey"
  add_index "syaddrsx", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "syadsl", :primary_key => "identity_column", :force => true do |t|
    t.string  "fcalias",          :limit => 10,                               :default => "",  :null => false
    t.string  "fcaliaskey",       :limit => 6,                                :default => "",  :null => false
    t.string  "fcaddrtype",       :limit => 1,                                :default => "",  :null => false
    t.string  "fcaddrkey",        :limit => 4,                                :default => "",  :null => false
    t.string  "fsalespn",         :limit => 3,                                :default => "",  :null => false
    t.decimal "fnrate1",                        :precision => 8, :scale => 3, :default => 0.0, :null => false
    t.string  "fccommcode",       :limit => 10,                               :default => "",  :null => false
    t.decimal "fnrate2",                        :precision => 8, :scale => 3, :default => 0.0, :null => false
    t.binary  "timestamp_column"
  end

  add_index "syadsl", ["fcalias", "fcaliaskey", "fcaddrtype", "fcaddrkey", "fsalespn"], :name => "salespn"
  add_index "syadsl", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "syarclog", :primary_key => "identity_column", :force => true do |t|
    t.string "fcdoc",            :limit => 3,                   :null => false
    t.string "fcdocid1",         :limit => 25,                  :null => false
    t.string "fcdocid2",         :limit => 25,                  :null => false
    t.string "fcdocset",         :limit => 3,                   :null => false
    t.string "fctxnno",          :limit => 10,                  :null => false
    t.binary "timestamp_column"
    t.text   "fmreason",                       :default => " ", :null => false
  end

  add_index "syarclog", ["fcdocid1"], :name => "docid"
  add_index "syarclog", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "sychek", :primary_key => "identity_column", :force => true do |t|
    t.string  "fchkid",           :limit => 4,                                                  :null => false
    t.integer "flineno",          :limit => nil, :precision => 3, :scale => 0,                  :null => false
    t.string  "ftext",            :limit => 250,                               :default => " ", :null => false
    t.binary  "timestamp_column"
  end

  add_index "sychek", ["fchkid", "flineno"], :name => "SYCHEK"
  add_index "sychek", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "sycsl", :primary_key => "identity_column", :force => true do |t|
    t.string   "fcapproved",       :limit => 25,                                                 :null => false
    t.string   "fcassigned",       :limit => 25,                                                 :null => false
    t.string   "fccompletd",       :limit => 25,                                                 :null => false
    t.string   "fccontact",        :limit => 25,                                                 :null => false
    t.string   "fccustomer",       :limit => 35,                                :default => " ", :null => false
    t.string   "fcentered",        :limit => 25,                                                 :null => false
    t.string   "fcincident",       :limit => 6,                                                  :null => false
    t.string   "fcistatus",        :limit => 25,                                                 :null => false
    t.string   "fcitype",          :limit => 25,                                                 :null => false
    t.string   "fcpartno",         :limit => 25,                                                 :null => false
    t.string   "fcpartrev",        :limit => 3,                                                  :null => false
    t.string   "fcphone",          :limit => 20,                                                 :null => false
    t.string   "fcpono",           :limit => 6,                                                  :null => false
    t.string   "fcreviewed",       :limit => 25,                                                 :null => false
    t.string   "fcrinscode",       :limit => 4,                                                  :null => false
    t.string   "fcrmano",          :limit => 25,                                                 :null => false
    t.string   "fcsono",           :limit => 6,                                                  :null => false
    t.string   "fcusrchr1",        :limit => 20,                                                 :null => false
    t.string   "fcusrchr2",        :limit => 40,                                :default => " ", :null => false
    t.string   "fcusrchr3",        :limit => 40,                                :default => " ", :null => false
    t.string   "fcvendor",         :limit => 35,                                :default => " ", :null => false
    t.datetime "fdcdate",                                                                        :null => false
    t.datetime "fdecdate",                                                                       :null => false
    t.datetime "fdidate",                                                                        :null => false
    t.datetime "fdrdate",                                                                        :null => false
    t.decimal  "fnusrcur1",                                                                      :null => false
    t.datetime "fnusrdate1",                                                                     :null => false
    t.decimal  "fnusrqty1",                      :precision => 17, :scale => 5,                  :null => false
    t.binary   "timestamp_column"
    t.text     "fmpblm",                                                        :default => " ", :null => false
    t.text     "fmrltn",                                                        :default => " ", :null => false
    t.text     "fmusrmemo1",                                                    :default => " ", :null => false
    t.string   "fcudrev",          :limit => 3,                                 :default => " ", :null => false
  end

  add_index "sycsl", ["fcassigned", "fdecdate"], :name => "assigned"
  add_index "sycsl", ["fccompletd", "fdcdate"], :name => "completed"
  add_index "sycsl", ["fccontact", "fdidate"], :name => "contact"
  add_index "sycsl", ["fccustomer", "fdidate"], :name => "customer"
  add_index "sycsl", ["fcincident", "fdidate"], :name => "sycsl"
  add_index "sycsl", ["fcistatus", "fdidate"], :name => "status"
  add_index "sycsl", ["fcitype", "fdidate"], :name => "type"
  add_index "sycsl", ["fcreviewed", "fdrdate"], :name => "reviewed"
  add_index "sycsl", ["fcrmano"], :name => "rma"
  add_index "sycsl", ["fcvendor"], :name => "vendor"
  add_index "sycsl", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "sycsla", :primary_key => "identity_column", :force => true do |t|
    t.string "fcstddesc",        :limit => 4,                  :null => false
    t.binary "timestamp_column"
    t.text   "fmstdact",                      :default => " ", :null => false
  end

  add_index "sycsla", ["fcstddesc"], :name => "fcstddesc"
  add_index "sycsla", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "sycslc", :primary_key => "identity_column", :force => true do |t|
    t.string   "fcinqno",          :limit => 6,                   :null => false
    t.datetime "fdactdate",                                       :null => false
    t.string   "fcnextact",        :limit => 1,                   :null => false
    t.string   "fcactby",          :limit => 3,                   :null => false
    t.string   "fcassignto",       :limit => 3,                   :null => false
    t.string   "fcjobno",          :limit => 10,                  :null => false
    t.string   "fckbid",           :limit => 10,                  :null => false
    t.binary   "timestamp_column"
    t.text     "fmaction",                       :default => " ", :null => false
    t.text     "fmintnotes",                     :default => " ", :null => false
  end

  add_index "sycslc", ["fcinqno", "fdactdate"], :name => "FCINQNO"
  add_index "sycslc", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "sycslm", :primary_key => "identity_column", :force => true do |t|
    t.string   "fcinqno",          :limit => 6,                                                  :null => false
    t.string   "fcsono",           :limit => 6,                                                  :null => false
    t.string   "fcpartno",         :limit => 25,                                                 :null => false
    t.string   "fcpartrev",        :limit => 3,                                                  :null => false
    t.datetime "fdinqdate",                                                                      :null => false
    t.string   "fctype",           :limit => 1,                                                  :null => false
    t.string   "fcstatus",         :limit => 20,                                                 :null => false
    t.string   "fcenterby",        :limit => 3,                                                  :null => false
    t.string   "fcauthby",         :limit => 3,                                                  :null => false
    t.string   "fccustomer",       :limit => 35,                                :default => " ", :null => false
    t.string   "fcvendor",         :limit => 35,                                :default => " ", :null => false
    t.string   "fcphone",          :limit => 20,                                                 :null => false
    t.string   "fcrmano",          :limit => 25,                                                 :null => false
    t.string   "fcassignto",       :limit => 3,                                                  :null => false
    t.datetime "fdestdate",                                                                      :null => false
    t.string   "fcreslvby",        :limit => 3,                                                  :null => false
    t.datetime "fdreslvdat",                                                                     :null => false
    t.string   "fcrevwby",         :limit => 3,                                                  :null => false
    t.datetime "fdrevwdate",                                                                     :null => false
    t.string   "fcusrchr1",        :limit => 40,                                :default => " ", :null => false
    t.string   "fcusrchr2",        :limit => 40,                                :default => " ", :null => false
    t.string   "fcusrchr3",        :limit => 40,                                :default => " ", :null => false
    t.string   "fcusrchr4",        :limit => 40,                                :default => " ", :null => false
    t.decimal  "fnusrqty1",                      :precision => 17, :scale => 5,                  :null => false
    t.decimal  "fnusrcur1",                                                                      :null => false
    t.datetime "fdusrdate1",                                                                     :null => false
    t.string   "fccustno",         :limit => 6,                                                  :null => false
    t.string   "fcvendno",         :limit => 6,                                                  :null => false
    t.string   "fcseverity",       :limit => 1,                                                  :null => false
    t.string   "fccategory",       :limit => 1,                                                  :null => false
    t.string   "fcclass",          :limit => 1,                                                  :null => false
    t.string   "fcrinscode",       :limit => 4,                                                  :null => false
    t.string   "fcpono",           :limit => 6,                                                  :null => false
    t.string   "fcfax",            :limit => 20,                                                 :null => false
    t.string   "fcemail",          :limit => 60,                                :default => " ", :null => false
    t.decimal  "fnqty",                          :precision => 17, :scale => 5,                  :null => false
    t.string   "fcfname",          :limit => 15,                                                 :null => false
    t.string   "fclname",          :limit => 20,                                                 :null => false
    t.string   "fccustpo",         :limit => 20,                                                 :null => false
    t.string   "fcsalecode",       :limit => 7,                                                  :null => false
    t.string   "fccuststat",       :limit => 1,                                                  :null => false
    t.string   "fcnextact",        :limit => 1,                                                  :null => false
    t.string   "fcother",          :limit => 1,                                                  :null => false
    t.string   "fcmeasure",        :limit => 3,                                                  :null => false
    t.string   "fcother2",         :limit => 20,                                                 :null => false
    t.string   "fclot",            :limit => 20,                                                 :null => false
    t.datetime "fdincidate",                                                                     :null => false
    t.string   "fcwlitem",         :limit => 6,                                                  :null => false
    t.string   "finumber",         :limit => 3,                                                  :null => false
    t.string   "frelsno",          :limit => 3,                                                  :null => false
    t.binary   "timestamp_column"
    t.text     "fminquiry",                                                     :default => " ", :null => false
    t.text     "fmusrmemo1",                                                    :default => " ", :null => false
    t.string   "fac",              :limit => 20,                                                 :null => false
    t.string   "fcudrev",          :limit => 3,                                 :default => " ", :null => false
  end

  add_index "sycslm", ["fcinqno"], :name => "fcinqno"
  add_index "sycslm", ["fcrmano"], :name => "rma"
  add_index "sycslm", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "syecaudt", :primary_key => "identity_column", :force => true do |t|
    t.string   "fcaction",         :limit => 1,                          :null => false
    t.string   "fcfield",          :limit => 12,                         :null => false
    t.string   "fcform",           :limit => 8,                          :null => false
    t.string   "fctable",          :limit => 12,                         :null => false
    t.string   "fcuser",           :limit => 10,                         :null => false
    t.datetime "ftdate",                                                 :null => false
    t.string   "fcmaster",         :limit => 25,                         :null => false
    t.string   "fcprimekey",       :limit => 100, :default => " "
    t.string   "fcrev",            :limit => 3,                          :null => false
    t.binary   "timestamp_column"
    t.binary   "fgnewval",                        :default => "0x00",    :null => false
    t.binary   "fgoldval",                        :default => "0x00",    :null => false
    t.text     "fmnewval",                        :default => " ",       :null => false
    t.text     "fmoldval",                        :default => " ",       :null => false
    t.string   "fac",              :limit => 20,  :default => "Default", :null => false
  end

  add_index "syecaudt", ["fcaction"], :name => "action"
  add_index "syecaudt", ["fcform"], :name => "form"
  add_index "syecaudt", ["fcmaster", "fcrev"], :name => "MASTER"
  add_index "syecaudt", ["fcprimekey"], :name => "PRIMEKEY"
  add_index "syecaudt", ["fcuser"], :name => "user_"
  add_index "syecaudt", ["ftdate", "fcfield", "fcaction"], :name => "RECOVERY"
  add_index "syecaudt", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "sylabl", :primary_key => "identity_column", :force => true do |t|
    t.integer "flineno",          :limit => nil, :precision => 2, :scale => 0,                  :null => false
    t.string  "ftext",            :limit => 200,                               :default => " ", :null => false
    t.binary  "timestamp_column"
  end

  add_index "sylabl", ["flineno", "ftext"], :name => "label"
  add_index "sylabl", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "sylog", :primary_key => "identity_column", :force => true do |t|
    t.string   "flogcomp",         :limit => 2,                                                  :null => false
    t.string   "flogid",           :limit => 10,                                                 :null => false
    t.string   "flogtype",         :limit => 1,                                                  :null => false
    t.integer  "floglevel",        :limit => nil, :precision => 2, :scale => 0,                  :null => false
    t.boolean  "finternal",                                                                      :null => false
    t.datetime "flogdate",                                                                       :null => false
    t.string   "flogtable",        :limit => 12,                                                 :null => false
    t.string   "flogtime",         :limit => 8,                                                  :null => false
    t.string   "floguser",         :limit => 10,                                                 :null => false
    t.binary   "timestamp_column"
    t.text     "flogbefore",                                                    :default => " ", :null => false
    t.text     "flogdata",                                                      :default => " ", :null => false
  end

  add_index "sylog", ["flogcomp"], :name => "compid"
  add_index "sylog", ["flogid", "flogtype"], :name => "LOGID"
  add_index "sylog", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "sylogo", :primary_key => "identity_column", :force => true do |t|
    t.decimal "fcol",                            :precision => 7, :scale => 3,                  :null => false
    t.integer "ffontnum",         :limit => nil, :precision => 2, :scale => 0,                  :null => false
    t.decimal "fparam1",                         :precision => 7, :scale => 3,                  :null => false
    t.decimal "fparam2",                         :precision => 7, :scale => 3,                  :null => false
    t.decimal "fparam3",                         :precision => 7, :scale => 3,                  :null => false
    t.decimal "fparam4",                         :precision => 7, :scale => 3,                  :null => false
    t.decimal "fparam5",                         :precision => 7, :scale => 3,                  :null => false
    t.decimal "frow",                            :precision => 7, :scale => 3,                  :null => false
    t.string  "ftext",            :limit => 60,                                :default => " ", :null => false
    t.binary  "timestamp_column"
  end

  add_index "sylogo", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "synoti", :primary_key => "identity_column", :force => true do |t|
    t.string   "fcdoctype",        :limit => 10,                                                 :null => false
    t.string   "fcevent",          :limit => 10,                                                 :null => false
    t.string   "fckey",            :limit => 10,                                                 :null => false
    t.string   "fcpersresp",       :limit => 10,                                                 :null => false
    t.string   "fcaction",         :limit => 10,                                                 :null => false
    t.string   "fccustid",         :limit => 10,                                                 :null => false
    t.string   "fcdocid",          :limit => 25,                                                 :null => false
    t.integer  "fnidtype",         :limit => nil, :precision => 2, :scale => 0,                  :null => false
    t.string   "fcpersfrom",       :limit => 10,                                                 :null => false
    t.string   "fcrectype",        :limit => 10,                                                 :null => false
    t.datetime "fddate",                                                                         :null => false
    t.boolean  "flfired",                                                                        :null => false
    t.boolean  "flnotified",                                                                     :null => false
    t.boolean  "flprivate",                                                                      :null => false
    t.string   "fcfaxstd",         :limit => 10,                                                 :null => false
    t.boolean  "flcover",                                                                        :null => false
    t.string   "fccopy",           :limit => 35,                                :default => " ", :null => false
    t.string   "fcompany",         :limit => 35,                                :default => " ", :null => false
    t.string   "fcfname",          :limit => 15,                                                 :null => false
    t.string   "fcontact",         :limit => 20,                                                 :null => false
    t.string   "ffax",             :limit => 20,                                                 :null => false
    t.boolean  "flprinted",                                                                      :null => false
    t.binary   "timestamp_column"
    t.text     "fcmessage",                                                     :default => " ", :null => false
  end

  add_index "synoti", ["fcdoctype", "fcevent"], :name => "docevent"
  add_index "synoti", ["fckey"], :name => "fckey"
  add_index "synoti", ["fcpersresp"], :name => "persresp"
  add_index "synoti", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "syphon", :primary_key => "identity_column", :force => true do |t|
    t.boolean "fllongdist",                                      :null => false
    t.string  "fcfax",            :limit => 25,                  :null => false
    t.string  "fcclass",          :limit => 3,                   :null => false
    t.string  "fcemail",          :limit => 60, :default => " ", :null => false
    t.string  "fcextensio",       :limit => 6,                   :null => false
    t.string  "fcnumber",         :limit => 25,                  :null => false
    t.string  "fcsourceid",       :limit => 6,                   :null => false
    t.string  "fcs_alias",        :limit => 10,                  :null => false
    t.string  "fcbesttime",       :limit => 10,                  :null => false
    t.string  "fccurid",          :limit => 3,                   :null => false
    t.string  "fcfname",          :limit => 15,                  :null => false
    t.string  "fcontact",         :limit => 20,                  :null => false
    t.string  "fcrange",          :limit => 10,                  :null => false
    t.string  "fsalute",          :limit => 5,                   :null => false
    t.string  "fctitle",          :limit => 25,                  :null => false
    t.string  "fccountry",        :limit => 25,                  :null => false
    t.binary  "timestamp_column"
    t.text    "fmnotes",                        :default => " ", :null => false
    t.integer "fncrmmod",                       :default => 0,   :null => false
    t.string  "fccrmcntct",       :limit => 12, :default => "",  :null => false
  end

  add_index "syphon", ["fcclass"], :name => "fcclass"
  add_index "syphon", ["fcextensio"], :name => "fcextenio"
  add_index "syphon", ["fcnumber"], :name => "fcnumber"
  add_index "syphon", ["fcontact"], :name => "fcontact"
  add_index "syphon", ["fcs_alias", "fcsourceid", "fcontact", "fcfname", "fcnumber", "fcextensio"], :name => "PRIMARYKEY"
  add_index "syphon", ["fcsourceid"], :name => "fcsourceid"
  add_index "syphon", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "syphonar", :primary_key => "identity_column", :force => true do |t|
    t.boolean  "fllongdist",                     :default => false, :null => false
    t.string   "fcfax",            :limit => 25, :default => "",    :null => false
    t.string   "fcclass",          :limit => 3,  :default => "",    :null => false
    t.string   "fcemail",          :limit => 60, :default => "",    :null => false
    t.string   "fcextensio",       :limit => 6,  :default => "",    :null => false
    t.string   "fcnumber",         :limit => 25, :default => "",    :null => false
    t.string   "fcsourceid",       :limit => 6,  :default => "",    :null => false
    t.string   "fcs_alias",        :limit => 10, :default => "",    :null => false
    t.string   "fcbesttime",       :limit => 10, :default => "",    :null => false
    t.string   "fccurid",          :limit => 3,  :default => "",    :null => false
    t.string   "fcfname",          :limit => 15, :default => "",    :null => false
    t.string   "fcontact",         :limit => 20, :default => "",    :null => false
    t.string   "fcrange",          :limit => 10, :default => "",    :null => false
    t.string   "fsalute",          :limit => 5,  :default => "",    :null => false
    t.string   "fctitle",          :limit => 25, :default => "",    :null => false
    t.string   "fccountry",        :limit => 25, :default => "",    :null => false
    t.binary   "timestamp_column"
    t.text     "fmnotes",                        :default => " ",   :null => false
    t.string   "fccrmcntct",       :limit => 12, :default => "",    :null => false
    t.integer  "fncrmmod",                       :default => 0,     :null => false
    t.string   "fcchange",         :limit => 1,  :default => "",    :null => false
    t.integer  "fnKey",                          :default => 0,     :null => false
    t.datetime "fdarchive",                                         :null => false
  end

  add_index "syphonar", ["fcclass"], :name => "fcclass"
  add_index "syphonar", ["fcextensio", "fcsourceid", "fcs_alias", "fcnumber", "fcontact", "fcfname"], :name => "primarykey"
  add_index "syphonar", ["fcnumber"], :name => "fcnumber"
  add_index "syphonar", ["fcontact"], :name => "fcontact"
  add_index "syphonar", ["fcs_alias"], :name => "fcsalias"
  add_index "syphonar", ["fcsourceid", "fcs_alias", "fcnumber", "fcontact", "fcfname"], :name => "primeconta"
  add_index "syphonar", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "syphonsx", :primary_key => "identity_column", :force => true do |t|
    t.string  "fcsourceid",       :limit => 6,  :default => "", :null => false
    t.string  "fcs_alias",        :limit => 10, :default => "", :null => false
    t.string  "fcontact",         :limit => 20, :default => "", :null => false
    t.string  "fcfname",          :limit => 15, :default => "", :null => false
    t.string  "fcnumber",         :limit => 25, :default => "", :null => false
    t.string  "fcextensio",       :limit => 6,  :default => "", :null => false
    t.string  "fcchange",         :limit => 1,  :default => "", :null => false
    t.integer "fnkey",                          :default => 0,  :null => false
    t.string  "fccrmcntct",       :limit => 12, :default => "", :null => false
    t.integer "fncrmmod",                       :default => 0,  :null => false
    t.binary  "timestamp_column"
  end

  add_index "syphonsx", ["fnkey"], :name => "lookupkey"
  add_index "syphonsx", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "sysequ", :primary_key => "identity_column", :force => true do |t|
    t.string  "fcclass",          :limit => 25,                                :null => false
    t.string  "fcprompt",         :limit => 25,                                :null => false
    t.string  "fcprefix",         :limit => 5,                                 :null => false
    t.string  "fcseqtype",        :limit => 1,                                 :null => false
    t.string  "fcsuffix",         :limit => 5,                                 :null => false
    t.string  "fcnumber",         :limit => 25,                                :null => false
    t.integer "fnwidth",          :limit => nil, :precision => 2, :scale => 0, :null => false
    t.integer "fnincremen",       :limit => nil, :precision => 3, :scale => 0, :null => false
    t.integer "fnbase36di",       :limit => nil, :precision => 1, :scale => 0, :null => false
    t.string  "fcbase36sk",       :limit => 10,                                :null => false
    t.binary  "timestamp_column"
  end

  add_index "sysequ", ["fcclass"], :name => "fcclass"
  add_index "sysequ", ["fcprompt"], :name => "fcprompt"
  add_index "sysequ", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "sywlnk", :primary_key => "identity_column", :force => true do |t|
    t.string  "fcdoctype",        :limit => 3,                                                  :null => false
    t.string  "fcdockey",         :limit => 50,                                :default => " ", :null => false
    t.integer "fnnumber",         :limit => nil, :precision => 3, :scale => 0,                  :null => false
    t.binary  "timestamp_column"
    t.text    "fmcomment",                                                     :default => " ", :null => false
    t.text    "fmlink",                                                        :default => " ", :null => false
  end

  add_index "sywlnk", ["fcdoctype", "fcdockey", "fnnumber"], :name => "number"
  add_index "sywlnk", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "syxform", :primary_key => "identity_column", :force => true do |t|
    t.string "SrcTable",         :limit => 50,  :default => "", :null => false
    t.string "SrcField",         :limit => 50,  :default => "", :null => false
    t.string "SrcValue",         :limit => 250, :default => "", :null => false
    t.string "TgtTable",         :limit => 50,  :default => "", :null => false
    t.string "TgtField",         :limit => 50,  :default => "", :null => false
    t.string "TgtValue",         :limit => 250, :default => "", :null => false
    t.binary "timestamp_column"
  end

  add_index "syxform", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "upsin", :primary_key => "identity_column", :force => true do |t|
    t.string  "fshipno",          :limit => 6,   :null => false
    t.string  "fctrkno",          :limit => 25,  :null => false
    t.string  "fncost",           :limit => 30,  :null => false
    t.boolean "flposted",                        :null => false
    t.string  "fcshpref",         :limit => 35,  :null => false
    t.string  "fcpkgref",         :limit => 35,  :null => false
    t.string  "fcshpref2",        :limit => 35,  :null => false
    t.string  "fcpkgref2",        :limit => 35,  :null => false
    t.string  "fcerror",          :limit => 200, :null => false
    t.string  "fcvoid",           :limit => 1,   :null => false
    t.string  "fnpkgwt",          :limit => 30,  :null => false
    t.integer "fnboxes",                         :null => false
    t.binary  "timestamp_column"
  end

  add_index "upsin", ["fshipno"], :name => "shipno"
  add_index "upsin", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "upsitem", :primary_key => "identity_column", :force => true do |t|
    t.string "fcshipno",         :limit => 6,  :null => false
    t.string "fcpono",           :limit => 6,  :null => false
    t.string "fcustpono",        :limit => 6,  :null => false
    t.string "fcsono",           :limit => 6,  :null => false
    t.string "fcjobno",          :limit => 10, :null => false
    t.binary "timestamp_column"
  end

  add_index "upsitem", ["fcjobno"], :name => "jobno"
  add_index "upsitem", ["fcpono"], :name => "pono"
  add_index "upsitem", ["fcshipno"], :name => "shipno"
  add_index "upsitem", ["fcsono"], :name => "sono"
  add_index "upsitem", ["fcustpono"], :name => "custno"
  add_index "upsitem", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "upsmast", :primary_key => "identity_column", :force => true do |t|
    t.string   "fbl_lading",       :limit => 20,                                                  :null => false
    t.string   "fcjobno",          :limit => 10,                                                  :null => false
    t.string   "fcnumber",         :limit => 6,                                                   :null => false
    t.string   "fcollect",         :limit => 3,                                                   :null => false
    t.string   "fconfirm",         :limit => 1,                                                   :null => false
    t.string   "fcpono",           :limit => 6,                                                   :null => false
    t.string   "fcpro_id",         :limit => 7,                                                   :null => false
    t.string   "fcsono",           :limit => 6,                                                   :null => false
    t.string   "fcso_inum",        :limit => 3,                                                   :null => false
    t.string   "fcsono_rel",       :limit => 3,                                                   :null => false
    t.string   "fcsorev",          :limit => 2,                                                   :null => false
    t.string   "fcvendno",         :limit => 6,                                                   :null => false
    t.string   "fenter",           :limit => 3,                                                   :null => false
    t.string   "ffob",             :limit => 20,                                                  :null => false
    t.decimal  "ffrtamt",                         :precision => 17, :scale => 5,                  :null => false
    t.boolean  "ffrtinvcd",                                                                       :null => false
    t.boolean  "flisinv",                                                                         :null => false
    t.integer  "fno_boxes",        :limit => nil, :precision => 5,  :scale => 0,                  :null => false
    t.datetime "fshipdate",                                                                       :null => false
    t.string   "fshipno",          :limit => 6,                                                   :null => false
    t.string   "fshipvia",         :limit => 20,                                                  :null => false
    t.decimal  "fshipwght",                       :precision => 12, :scale => 4,                  :null => false
    t.string   "fshptoaddr",       :limit => 4,                                                   :null => false
    t.string   "ftype",            :limit => 2,                                                   :null => false
    t.datetime "start",                                                                           :null => false
    t.boolean  "flpickprin",                                                                      :null => false
    t.boolean  "flshipprin",                                                                      :null => false
    t.string   "fcfname",          :limit => 15,                                                  :null => false
    t.string   "fclname",          :limit => 20,                                                  :null => false
    t.string   "fccounty",         :limit => 20,                                                  :null => false
    t.string   "fccompany",        :limit => 35,                                 :default => " "
    t.string   "fccity",           :limit => 20,                                                  :null => false
    t.string   "fccountry",        :limit => 25,                                                  :null => false
    t.string   "fcfax",            :limit => 20,                                                  :null => false
    t.string   "fcphone",          :limit => 20,                                                  :null => false
    t.string   "fcstate",          :limit => 20,                                                  :null => false
    t.string   "fczip",            :limit => 10,                                                  :null => false
    t.string   "fporev",           :limit => 2,                                                   :null => false
    t.string   "fcbcompany",       :limit => 35,                                 :default => " ", :null => false
    t.boolean  "flpremcv",                                                                        :null => false
    t.binary   "timestamp_column"
    t.text     "fmreferenc",                                                     :default => " ", :null => false
    t.text     "fmstreet",                                                       :default => " ", :null => false
    t.text     "fshipmemo",                                                      :default => " ", :null => false
    t.text     "FMTRCKNO",                                                       :default => " ", :null => false
    t.datetime "ftsnddttm",                                                                       :null => false
    t.text     "upsaddr2",                                                       :default => "",  :null => false
    t.datetime "upsdate",                                                                         :null => false
    t.text     "upsaddr3",                                                       :default => "",  :null => false
    t.string   "fcustpono",        :limit => 20,                                 :default => "",  :null => false
    t.string   "fcemail",          :limit => 60,                                 :default => "",  :null => false
    t.string   "qvnoption",        :limit => 1,                                  :default => "",  :null => false
    t.string   "qvntype",          :limit => 6,                                  :default => "",  :null => false
    t.string   "qvnsubj",          :limit => 75,                                 :default => "",  :null => false
  end

  add_index "upsmast", ["fcjobno", "fshipno"], :name => "jobno"
  add_index "upsmast", ["fcnumber"], :name => "customer"
  add_index "upsmast", ["fcpono"], :name => "pono"
  add_index "upsmast", ["fcsono", "fcso_inum", "fcsono_rel"], :name => "RELEASE"
  add_index "upsmast", ["fcsono", "fshipno"], :name => "SONO"
  add_index "upsmast", ["fcvendno"], :name => "vendor"
  add_index "upsmast", ["fshipno"], :name => "shipno"
  add_index "upsmast", ["ftype"], :name => "type"
  add_index "upsmast", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "upsset", :primary_key => "identity_column", :force => true do |t|
    t.boolean "batch",                          :default => true,     :null => false
    t.boolean "autoconfirm",                    :default => true,     :null => false
    t.boolean "computerprocess",                :default => true,     :null => false
    t.boolean "exportconfirm",                  :default => true,     :null => false
    t.boolean "exporttype",                     :default => true,     :null => false
    t.boolean "firstbatch",                     :default => true,     :null => false
    t.integer "interval",                       :default => 1,        :null => false
    t.boolean "invoicecharges",                 :default => true,     :null => false
    t.boolean "packageweight",                  :default => true,     :null => false
    t.boolean "numberboxes",                    :default => true,     :null => false
    t.binary  "timestamp_column"
    t.string  "qvnoption",        :limit => 1,  :default => "N",      :null => false
    t.string  "qvntype",          :limit => 6,  :default => "E-MAIL", :null => false
    t.string  "qvnsubj",          :limit => 75, :default => "",       :null => false
    t.boolean "upsmapwarn",                     :default => true,     :null => false
  end

  add_index "upsset", ["identity_column"], :name => "identity_column_idx1", :unique => true

  create_table "utfield", :id => false, :force => true do |t|
    t.string  "fcgroup",    :limit => 10,                                :null => false
    t.string  "fctable",    :limit => 8,                                 :null => false
    t.string  "fcfield",    :limit => 12,                                :null => false
    t.string  "fctype",     :limit => 1,                                 :null => false
    t.integer "fnlength",   :limit => nil, :precision => 3, :scale => 0, :null => false
    t.integer "fnnodec",    :limit => nil, :precision => 2, :scale => 0, :null => false
    t.string  "fcdesc",     :limit => 50,                                :null => false
    t.text    "fmmemofld",                                               :null => false
    t.string  "fccase",     :limit => 5,                                 :null => false
    t.string  "fcstatus",   :limit => 1,                                 :null => false
    t.string  "fcfromtab",  :limit => 8,                                 :null => false
    t.string  "fcfromfld",  :limit => 10,                                :null => false
    t.text    "fcconvnote",                                              :null => false
    t.integer "fnbrsorder", :limit => nil, :precision => 4, :scale => 0, :null => false
    t.string  "fclabel",    :limit => 20,                                :null => false
    t.string  "fcrjustify", :limit => 20,                                :null => false
    t.string  "fcorder",    :limit => 4,                                 :null => false
    t.string  "fcbrsexcld", :limit => 3,                                 :null => false
    t.string  "fcscreen",   :limit => 8,                                 :null => false
    t.string  "fcobject",   :limit => 8,                                 :null => false
    t.string  "fcflowtb",   :limit => 8,                                 :null => false
    t.string  "fcflowfd",   :limit => 8,                                 :null => false
    t.string  "fcversion",  :limit => 10,                                :null => false
    t.text    "fmhelp",                                                  :null => false
    t.text    "fmunote",                                                 :null => false
    t.text    "fmflow",                                                  :null => false
    t.integer "fnlkporder", :limit => nil, :precision => 4, :scale => 0, :null => false
  end

  create_table "utindex", :id => false, :force => true do |t|
    t.string  "fctable",    :limit => 8,   :null => false
    t.string  "fctag",      :limit => 10,  :null => false
    t.string  "fckey",      :limit => 100, :null => false
    t.string  "fcoldkey",   :limit => 100, :null => false
    t.string  "fcusertle",  :limit => 10,  :null => false
    t.string  "fcuserdesc", :limit => 50,  :null => false
    t.string  "fcshowuser", :limit => 3,   :null => false
    t.string  "fcrecover",  :limit => 1,   :null => false
    t.string  "fcfor",      :limit => 100, :null => false
    t.string  "fcinclscrn", :limit => 50,  :null => false
    t.string  "fcexclscrn", :limit => 50,  :null => false
    t.string  "fcorderdir", :limit => 1,   :null => false
    t.boolean "flisunique",                :null => false
    t.string  "fctype",     :limit => 10,  :null => false
  end

  create_table "uttable", :id => false, :force => true do |t|
    t.string  "fcgroup",    :limit => 10, :null => false
    t.string  "fctable",    :limit => 8,  :null => false
    t.string  "fcoldname",  :limit => 8,  :null => false
    t.string  "fcdesc",     :limit => 50, :null => false
    t.string  "fcdatabase", :limit => 50, :null => false
    t.string  "fcdir",      :limit => 50, :null => false
    t.text    "fmdescmemo",               :null => false
    t.string  "fcolddir",   :limit => 2,  :null => false
    t.boolean "flmigrate",                :null => false
    t.boolean "flonerec",                 :null => false
  end

  create_table "vendmfr", :primary_key => "identity_column", :force => true do |t|
    t.string  "fcfac",            :limit => 20,                    :null => false
    t.string  "fcpartno",         :limit => 25, :default => "",    :null => false
    t.string  "fcrev",            :limit => 3,  :default => "",    :null => false
    t.string  "fcvendno",         :limit => 6,  :default => "",    :null => false
    t.string  "fcmfrno",          :limit => 6,  :default => "",    :null => false
    t.string  "fcmfrpart",        :limit => 50, :default => "",    :null => false
    t.boolean "flpreferred",                    :default => false, :null => false
    t.binary  "timestamp_column"
  end

  add_index "vendmfr", ["fcmfrno", "fcmfrpart"], :name => "mfrpart"
  add_index "vendmfr", ["fcpartno", "fcrev", "fcfac", "fcmfrno", "fcmfrpart"], :name => "inmfrpart"
  add_index "vendmfr", ["fcpartno", "fcrev", "fcfac", "fcvendno", "fcmfrno", "fcmfrpart"], :name => "vendmfr", :unique => true
  add_index "vendmfr", ["identity_column"], :name => "idcolumn", :unique => true

end
