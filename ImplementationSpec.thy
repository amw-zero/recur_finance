theory ImplementationSpec

imports Main AbstractSpec

begin

record new_recurring_transaction =
  amount :: int
  name :: string

definition from_new_recurring_transaction :: "new_recurring_transaction \<Rightarrow> int \<Rightarrow> recurring_transaction" where
"from_new_recurring_transaction nrt last_id = 
  \<lparr> 
    id = last_id + 1, 
    r_amount = amount nrt, 
    rule = Weekly (ByDay [Mo]),
    name =  name nrt
  \<rparr>"

definition create_recurring_transaction :: "recurring_transaction set \<Rightarrow> new_recurring_transaction \<Rightarrow> int \<Rightarrow> recurring_transaction set" where
"create_recurring_transaction rts new last_id = 
  AbstractSpec.create_recurring_transaction 
    (from_new_recurring_transaction new last_id) 
    rts"

end