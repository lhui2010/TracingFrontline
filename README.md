# TracingFrontline
Track the latest scientific publication via rss feeds and output in one single webpage.

## Dependency
* feedparser
* python3

## Quick start

TracingFrontline help you track the latest scientific publications from a webpage. 
To use it.

```bash
#Install
git clone https://github.com/lhui2010/TracingFrontline
pip install feedparser
#Test if it works
cd TracingFrontline
./tracefl -o example_output/ 
#Open the resulting html in your browser to see if it's OK.
open  example_output/rss.html
```

The output should be like :
![](src/screenshot.png)

## Basic usage

Use `-o` to specify the output directory of your html. If you're using Apache, change it to:

```
./tracefl -o /var/www/html
```

Use `-k` to filter html. 
Normally, there should be two html files in output directory. One is `rss-all.html` which is the total 
rss result (Usually too long). So you can filter it with your keywords specified with `-k`. Use `\|` to
seperate multiple keywords. Filtered html will be written to `rss.html` file 

```
./tracefl -o /var/www/html -k "genome\|sequence"
```

Use `--rotate` to flush current database. 
By default, the rss\_feeds will store in db/content.db and new feeds will keep adding to this database.
As time goes by, this file may be too long to read. If you want to make an archive of current html pages and
 flush current database (Can't be undone), use `--rotate`

```
./tracefl -o /var/www/html -k "genome" --rotate
```

where the previous rss.html and rss-all.html will be renamed as `rss-03-20-2020.html`, `rss-all-03-20-2020.html`
and put in archive folder

You can also specify your custom rss table name

```
./tracefl -o /var/www/html -k "genome" --rotate table.test
```


### Add new rss feeds 
If you want mak a custom rss table, edit the table file and paste your journal name and RSS feeds seperated with space or tab.
If you have multiple rss feeds url for one journal, use ',' to seperate them

```
$vi table
Science http://science.sciencemag.org/rss/current.xml
Nature http://feeds.nature.com/nature/rss/current
NatBiotechnol http://www.nature.com/nbt/current_issue/rss/
MolBiolEvol https://academic.oup.com/rss/site_5325/3191.xml,https://academic.oup.com/rss/site_5325/advanceAccess_3191.xml,https://academic.oup.com/rss/site_5325/OpenAccess.xml
```

---

## scripts in src dir

### add\_hr.pl

Used to add a `<hr>` tag between adjacent differnt journals to seperate them.

### rss2table.py

rss2table.py is used to fromat rss links to tab seperated text files, input is `table` file

```bash
python rss2table.py rss_link_table >rss.table
```
### Output format

Column 1 was used for journal order
Column 2 was publication date
Column 3 was html format of this rss item
Use `cut -f3 rss.table >index.html` to get html file

```
000Science	20190314	<h5><b>[Science]</b> <a href=http://science.sciencemag.org/cgi/content/short/363/6432/1125?rss=1>Data sharing for pediatric cancers</a>. Vaske, O. M., Haussler, D. 2019-03-14T <button type="button" class="btn btn-primary btn-xs" data-toggle="collapse" data-target="#abstractDatasharingforpediatriccancers">Abstract</button></h5><div id="abstractDatasharingforpediatriccancers" class="collapse"></div> `
```

## CHANGELOG

### 2020.03.20
Update readme
Now support multiple rss for one journal
Also table2html.sh were largely re-written to ease use
