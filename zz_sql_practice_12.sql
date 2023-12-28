---
select round(sum(tiv_2016),2) as tiv_2016 from
(
    select *,
    count(*) over(partition by tiv_2015) as cnt,
    count(*) over(partition by lat,lon) as lat_lon
    from insurance
) tem
where tem.cnt>1 and tem.lat_lon=1

