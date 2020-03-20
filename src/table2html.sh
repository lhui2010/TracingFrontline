
Date=`date +"%m-%d-%Y"`

#keyword='genom\|assembly\|sequencing'
KEYWORD=$_arg_keyword
ROTATE=$_arg_rotate
HTML_DIR=$_arg_output
RSS_TABLE=$_arg_rss_table

#First test wether $1 is given or we will use default output dir "."
#https://stackoverflow.com/questions/3601515/how-to-check-if-a-variable-is-set-in-bash
ASSET_DIR="asset"
ARCHIVE_DIR="archive"
DB_DIR="db"
SRC_DIR="src"

if [ ${ROTATE} == "on" ]
then 
#Rotate means current rss html will be archived and all current data stored in content.db are wiped
#Use it when you find the html list is too long
    mkdir -p ${HTML_DIR}/${ARCHIVE_DIR}
#Split
    sed "14s/${ARCHIVE_DIR}/./" ${HTML_DIR}/rss.html > ${HTML_DIR}/${ARCHIVE_DIR}/rss-${Date}.html
    sed "14s/${ARCHIVE_DIR}/./" ${HTML_DIR}/rss-all.html > ${HTML_DIR}/${ARCHIVE_DIR}/rss-all-${Date}.html
    touch ${DB_DIR}/content.db &&  rm  ${DB_DIR}/content.db 
    echo "<a href=\"${ARCHIVE_DIR}/rss-${Date}.html\" class=\"btn btn-primary btn-xs\" role=\"button\">Previous Week</a>" >${DB_DIR}/prev.html
    echo "<a href=\"./rss-all.html\" class=\"btn btn-primary btn-xs\" role=\"button\">Full Repertoire</a>" >>${DB_DIR}/prev.html
    echo "<a href=\"${ARCHIVE_DIR}/rss-all-${Date}.html\" class=\"btn btn-primary btn-xs\" role=\"button\">Previous Week</a>" >${DB_DIR}/prev-all.html
    echo "<a href=\"./rss.html\" class=\"btn btn-primary btn-xs\" role=\"button\">Slim Version</a>" >>${DB_DIR}/prev-all.html
fi


#############
#transform rss to table
python3 ${SRC_DIR}/rss2table.py ${RSS_TABLE} >>${DB_DIR}/content.db
#Add spacing line between different rss source
sed 's/<hr>//g' ${DB_DIR}/content.db |sort -k1,1 -k2,2nr |uniq  >${DB_DIR}/content.db.sortuq
perl ${SRC_DIR}/add_hr.pl ${DB_DIR}/content.db.sortuq >${DB_DIR}/content.db.all
grep ${KEYWORD} ${DB_DIR}/content.db.sortuq | perl ${SRC_DIR}/add_hr.pl >${DB_DIR}/content.db.genome

cat ${ASSET_DIR}/head.html >${DB_DIR}/index.html
touch ${DB_DIR}/prev.html ${DB_DIR}/prev-all.html
echo "<h3>Updated in ${Date}</h3>" >>${DB_DIR}/index.html
sed '6s/Tracing Frontline/Full Repertoire/'  ${DB_DIR}/index.html >${DB_DIR}/index-all.html
cat ${DB_DIR}/prev.html >>${DB_DIR}/index.html
cat ${DB_DIR}/prev-all.html >>${DB_DIR}/index-all.html
cut -f3 ${DB_DIR}/content.db.genome >>${DB_DIR}/index.html
cut -f3 ${DB_DIR}/content.db.all >>${DB_DIR}/index-all.html

cat ${DB_DIR}/prev.html ${ASSET_DIR}/foot.html >>${DB_DIR}/index.html
cat ${DB_DIR}/prev-all.html ${ASSET_DIR}/foot.html >>${DB_DIR}/index-all.html
###
#debug
#cp index.html ../themes/casper/test.html

#production
mv ${DB_DIR}/index.html ${HTML_DIR}/rss.html
mv ${DB_DIR}/index-all.html ${HTML_DIR}/rss-all.html
