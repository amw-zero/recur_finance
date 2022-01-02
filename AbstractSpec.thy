theory AbstractSpec

imports Main

begin

text "Abstract Specification"

section "Dates"

datatype day = Mo | Tu | We | Th | Fr | Sa | Su

datatype month = Jan | Feb | Mar | Apr | May | Jun | Jul | Aug | Sep | Oct | Nov | Dec

record date =
  year :: nat
  month :: month
  day :: nat

definition next_month :: "month => month" where
"next_month d =
  (case d of
    Jan \<Rightarrow> Feb |
    Feb \<Rightarrow> Mar |
    Mar \<Rightarrow> Apr |
    Apr \<Rightarrow> May |
    May \<Rightarrow> Jun |
    Jun \<Rightarrow> Jul |
    Jul \<Rightarrow> Aug |
    Aug \<Rightarrow> Sep |
    Sep \<Rightarrow> Oct |
    Oct \<Rightarrow> Nov |
    Nov \<Rightarrow> Dec |
    Dec \<Rightarrow> Jan)"

definition month_ord :: "month \<Rightarrow> nat" where
"month_ord m =
  (case m of
    Jan \<Rightarrow> 0 |
    Feb \<Rightarrow> 1 |
    Mar \<Rightarrow> 2 |
    Apr \<Rightarrow> 3 |
    May \<Rightarrow> 4 |
    Jun \<Rightarrow> 5 |
    Jul \<Rightarrow> 6 |
    Aug \<Rightarrow> 7 |
    Sep \<Rightarrow> 8 |
    Oct \<Rightarrow> 9 |
    Nov \<Rightarrow> 10 |
    Dec \<Rightarrow> 11)"

definition date_next_month :: "date \<Rightarrow> date" where
"date_next_month d = 
  (if (month d) = Dec then 
    \<lparr> year = year d + 1, month = Jan, day = day d \<rparr>
  else
    d\<lparr> month := next_month (month d) \<rparr>
  )"

definition date_gte :: "date \<Rightarrow> date \<Rightarrow> bool" where
"date_gte d1 d2 = (year d1 \<ge> year d2 \<and> month_ord (month d1) \<ge> month_ord (month d2) \<and> day d1 \<ge> day d2)"

definition date_lte :: "date \<Rightarrow> date \<Rightarrow> bool" where
"date_lte d1 d2 = (year d1 \<le> year d2 \<and> month_ord (month d1) \<le> month_ord (month d2) \<and> day d1 \<le> day d2)"

section "Recurring Transaction Administration"

datatype monthly_rule =
  ByMonthDay "nat list"

datatype weekly_rule =
  ByDay "day list"

datatype recur_rule =
  Monthly monthly_rule
  | Weekly weekly_rule

record recurring_transaction =
  r_amount :: int
  rule :: recur_rule
  name :: string

definition create_recurring_transaction :: "recurring_transaction \<Rightarrow> recurring_transaction set \<Rightarrow> recurring_transaction set" where
"create_recurring_transaction t ts = insert t ts"

section "Concrete Transactions - Within Date Interval"

record transaction =
  amount :: int
  date :: date

datatype transaction_filter =
  CurrentMonth

(* Expands a recurring transaction into concrete transactions within the given date range *)
definition expand :: "date \<Rightarrow> date \<Rightarrow> recurring_transaction \<Rightarrow> transaction set" where
"expand st ed rt = {t. date_gte (date t) st \<and> date_lte (date t) ed }"

definition transactions_by_date :: "date \<Rightarrow> date \<Rightarrow> recurring_transaction set \<Rightarrow> transaction set" where
"transactions_by_date st ed ts = \<Union> ((expand st ed) ` ts)"

definition current_month_range :: "date \<Rightarrow> (date * date)" where
"current_month_range now = (\<lparr> year = 2021, month = Dec, day = 1\<rparr>, \<lparr> year = 2021, month = Dec, day = 31 \<rparr>)"

(* add transaction_filter param *)
(* Returns concrete transactions within a date range *)
definition transactions_within :: "date \<Rightarrow> recurring_transaction set \<Rightarrow> transaction set" where
"transactions_within now ts = 
    (let (first_of_month, last_of_month) = current_month_range now in 
    transactions_by_date first_of_month last_of_month ts)"

(* theorem "ts' = create_transaction r ts \<longrightarrow> view_transactions d ts f = ts'" *)

section "Test data"

value "transaction :: recurring_transaction \<equiv> \<lparr> r_amount = 5, rule = Monthly (ByMonthDay [1]), name = ''test'' \<rparr>"

definition make_recurring_transaction :: "(int * recur_rule * string) \<Rightarrow> recurring_transaction" where
"make_recurring_transaction d = (let (a, r, n) = d in \<lparr> r_amount = a, rule = r, name = n \<rparr>)"

definition "recurring_transactions = map make_recurring_transaction [
  (10, Monthly (ByMonthDay [1]), ''t1''),
  (11, Weekly (ByDay [Mo]), ''t2'')
]"

definition "now = \<lparr> year = 2021, month = Dec, day = 11 \<rparr>"
definition "jan = \<lparr> year = 2022, month = Jan, day = 11 \<rparr>"

(*
value "
  (let ts = foldl (\<lambda>ts tr. create_recurring_transaction tr ts) {} recurring_transactions in
  view_transactions now ts)" *)

value "recurring_transactions"

(* value "expand transaction now jan" *)  

end