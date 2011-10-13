select pomast.fcompany as vendor,
   pomast.fpono as po_number,
   pomast.fstatus as status, 
   poitem.fpartno as part_number, 
   poitem.fordqty as quantity_ordered, 
   poitem.frcpqty as quantity_received,
   poitem.forgpdate as original_promise_date,
   poitem.flstpdate as last_promise_date,
   poitem.frcpdate as date_received
from poitem
left join pomast on poitem.fpono = pomast.fpono
where poitem.fordqty >= 5
