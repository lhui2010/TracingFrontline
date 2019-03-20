## TracingFrontline
Get the latest scientific publication in a single webpage.

## Usage

### Fromat rss links to static html files

```bash
python rss2table.py rss_link_table >rss.html
```

### Input format

```
Science http://science.sciencemag.org/rss/current.xml
Nature http://feeds.nature.com/nature/rss/current
NatBiotechnol http://www.nature.com/nbt/current_issue/rss/
```

### Output format

```
000Science	20190314	<h5><b>[Science]</b> <a href=http://science.sciencemag.org/cgi/content/short/363/6432/1125?rss=1>Data sharing for pediatric cancers</a>. Vaske, O. M., Haussler, D. 2019-03-14T <button type="button" class="btn btn-primary btn-xs" data-toggle="collapse" data-target="#abstractDatasharingforpediatriccancers">Abstract</button></h5><div id="abstractDatasharingforpediatriccancers" class="collapse"></div> `
```

## Wrappers


### Updater scripts that keep local html file up to date

```bash
bash shell 
```

### Routine scripts for archieve existing html file before it went too large (usually weekly)

```bash
bash shell_7d
```
