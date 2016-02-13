EMAIL_FORMAT = /
  # Given john.doe@example.org
  # 1 - john
  # 2 - .doe
  # 3 - @
  # 4 - example
  # 5 - .org

  \A
  [a-z0-9]+              # 1
  ([._][a-z0-9]+)*       # 2
  (\+[^@]+)?             # filter
  @                      # 3
  [a-z0-9]+              # 4
  ([.-][a-z0-9]+)*       # 4
  \.[a-z]{2,6}           # 5
  \z
/xi
