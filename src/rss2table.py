#!/usr/bin/python3
import feedparser
import sys
import re
import logging
import time

# create logger
logger = logging.getLogger('rss2html')
logger.setLevel(logging.DEBUG)

# create console handler and set level to debug
ch = logging.StreamHandler()
ch.setLevel(logging.DEBUG)

# create formatter
formatter = logging.Formatter('%(asctime)s - %(levelname)s - %(message)s')

# add formatter to ch
ch.setFormatter(formatter)

# add ch to logger
logger.addHandler(ch)

# 'application' code
#TODO add time stamp
journal_dict = {}
journal_list = []


logger.info('Reading url list Complete...')
with open(sys.argv[1]) as file:
    for line in file:
        if (len(line.strip())==0 or re.match("#", line)):
            continue
        (journal, url) = line.split()
        journal_dict[journal] = url.rstrip()
        journal_list.append(journal)

#journal_dict = {"123":sys.argv[1]}
filter_keywords = r'genom|assembly|sequencing'

 
#localtime = time.strftime("%Y%m%d", time.localtime())
#abstract_id=int(localtime + "000000")
#print("<h3>Updated in {}</h3>".format(localtime))
journal_count=0

for j in journal_list:
    logger.info("Processing {}..".format(j))
#journal name for easy sorting
    sort_j_name="{:03d}{}".format(journal_count, j)
    journal_count +=1
    #print (j)
    #print (journal_dict[j])
    for rss_url in journal_dict[j].rstrip().split(','):
        feed = feedparser.parse(rss_url)
        #print(feed)

        feed_title = feed['feed']['title']
        feed_entries = feed.entries
    #debug
        #print (feed_entries)

        rss_link = {}
        rss_time = {}

        for entry in feed.entries:
            article_title = entry.title
            print_buf = ""
    #只输出基因组的
    #        if(not re.search(filter_keywords, article_title, re.IGNORECASE)):
    #            continue
            try:
                article_link = entry.link
                article_published_at = re.sub(r'\d\d:\d\d:\d\d.*', '', entry.updated) # Unicode string
                article_published_at_parsed = entry.updated_parsed # Time object
                article_format_date = "{:04d}{:02d}{:02d}".format(entry.updated_parsed[0], entry.updated_parsed[1], entry.updated_parsed[2])
                #article_author = entry.author + entry.authors
                article_author = str(entry.author)
                article_author_len = len(article_author)
                if(article_author_len > 100):
                    article_author = article_author[0:50] + ".." + article_author[article_author_len-50:article_author_len]
                if(len(entry.summary) >1):
                    article_summary = entry.summary
                else:
                    article_summary = entry.description
    #leading infor like date and journal name for sorting
                abstract_id = re.sub(r'[^\w]', '',article_title)
                print_buf = "{}\t{}\t".format(sort_j_name, article_format_date)
                print_buf += "<h5><b>[{}]</b> <a href={}>{}</a>. ".format(j, article_link, article_title)
                print_buf += "{} {} ".format( article_author, article_published_at)
                print_buf += '<button type="button" class="btn btn-primary btn-xs" data-toggle="collapse" data-target="#abstract{}">Abstract</button></h5><div id="abstract{}" class="collapse">{}</div>'.format(abstract_id, abstract_id,article_summary)

            except:
                logger.error("Processing {} in  {} failed!".format(article_title, j))
                continue
            print_buf = re.sub(r'<img src.*?/>|\n', '', print_buf)
            rss_link[article_link] = print_buf
            rss_time[article_link] = article_published_at_parsed

    #    printer=""
        for k in rss_link.keys():
            print(rss_link[k])

    #        printer +=rss_link[k]+"\n"
    #    printer = re.sub(r'\n$', '<hr>', printer)
    #    print(printer)




