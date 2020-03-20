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
./tracefl -o example_output/ table.test
#Open the resulting html in your browser to see if it's OK.
open  example_output/rss.html
```

The output should be like :
![](src/screenshot.png)

## Basic usage

### Setting output directory 

Use `-o` to specify the output directory. If you're using Apache, change it to:

```
./tracefl -o /var/www/html
```

### Filter html with kewords

Normally, there should be two html files in output directory. One is `rss-all.html` which is the total 
rss result (Usually too long). So you can filter it with your keywords specified with `-k`. Use `\|` to
seperate multiple keywords. Filtered html will be written to `rss.html` file 

```
./tracefl -o /var/www/html -k "genome\|sequence"
```

### Flush current database

By default, the rss\_feeds will store in db/content.db and new feeds will keep adding to this database.
As time goes by, this file may be too long to read. If you want to make an archive of current html pages and
 flush current database (Can't be undone), use `--rotate`

```
./tracefl -o /var/www/html -k "genome" --rotate
```

where the previous rss.html and rss-all.html will be renamed as `rss-03-20-2020.html`, `rss-all-03-20-2020.html`
and put in archive folder

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

### Specify your custom rss table

By default is `table` file.

```
./tracefl -o /var/www/html -k "genome" --rotate table.test
```

## CHANGELOG

### 2020.03.20
Update readme
Now support multiple rss for one journal
Also table2html.sh were largely re-written to ease use
