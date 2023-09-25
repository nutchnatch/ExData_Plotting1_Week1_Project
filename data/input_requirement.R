row_number <- 2075259
column_number <- 9
bytes <- 8
memory_in_bytes <- row_number * column_number * bytes
permutations_base_2 <- 2 ^ 10
# Memory requirement in Kb
memory_in_kb <- memory_in_bytes / permutations_base_2
memory_in_mb <- memory_in_kb / permutations_base_2
# Memory requirement in Mb
memory_in_mb