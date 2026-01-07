/*
Write a query to determine which parts have begun the assembly process but are not yet finished.
Assumptions:
1. parts_assembly table contains all parts currently in production, each at varying stages of the assembly process.
2. An unfinished part is one that lacks a finish_date.
*/

-- filter records where finish_date = NULL
select part, assembly_step
from parts_assembly
where finish_date is null;
