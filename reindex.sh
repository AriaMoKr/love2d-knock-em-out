for i in `ls step*.lua | sort`
  do echo -n "$i "
  awk 'NR == 1 { print $0 }' $i
done > index.txt
