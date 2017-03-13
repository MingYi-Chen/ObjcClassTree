find path/ -name '*.h' -exec  grep '@interface.*:' {} \;  > log.txt
sort log.txt | uniq -d > log3.txt
