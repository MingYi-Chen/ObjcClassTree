PROGNAME=$0

usage() {
cat << EOF >&2
Usage: $PROGNAME [-o <outputfile>] [-p <path>]
-p <path>: 輸入路徑
-o <outputfile>: 輸出文件名（若無輸入則取代輸入文件名）
EOF
exit 1
}

outputfile="" path=""
while getopts o:p: i; do
case $i in
(p) path=$OPTARG;;
(o) outputfile=$OPTARG;;
(*) usage
esac
done
shift "$((OPTIND - 1))"

if  [[ $path == "" ]] ; then
usage
fi

find $path -name '*.h' -exec  grep '@interface.*:' {} \;  > tmp.txt
sort tmp.txt | uniq  > tmp1.txt
rm tmp.txt

classPath=$(pwd)
input=$classPath/tmp1.txt
output=$classPath/$outputfile

ObjcClassTree $input $output
#rm tmp1.txt
