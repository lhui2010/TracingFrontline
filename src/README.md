## Scripts in src dir

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
