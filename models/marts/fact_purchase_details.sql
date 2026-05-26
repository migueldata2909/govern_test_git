select
    f.purchase_id,
    f.purchase_date,
    f.quantity,

    c.customer_id,
    c.customer_name,
    c.email,

    p.product_id,
    p.product_name,
    p.category,
    p.price,

    f.quantity * p.price as purchase_amount

from {{ ref('fact_purchases') }} f
join {{ ref('dim_customers') }} c
    on f.customer_id = c.customer_id
join {{ ref('dim_products') }} p
    on f.product_id = p.product_id
where f.quantity > 0