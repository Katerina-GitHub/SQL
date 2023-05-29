SELECT * FROM hw_for_lesson2.orders;
SELECT id, employee_id, amount, 
IF (order_status='OPEN', 'Order is in open state',
	IF(order_status='CLOSED', 'Order is closed', 'Order is cancelled'))
		AS 'full_order_status'
        FROM orders;