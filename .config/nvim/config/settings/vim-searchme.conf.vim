 let g:query = {
            \ 'google':'https://google.com/search\?q\={query}',
            \ 'github':'https://github.com/search\?q\={query}',
            \ 'stackoverflow':'https://stackoverflow.com/search\?q\={query}',
            \ 'bilibili':'http://search.bilibili.com/all\?keyword\={query}',
            \ 'askubuntu': 'https://askubuntu.com/search\?q\={query}',
            \ 'wikipedia': 'https://en.wikipedia.org/wiki/{query}',
            \ 'duckduckgo': 'https://duckduckgo.com/\?q\={query}',
            \ 'twitter-search': 'https://twitter.com/search/{query}',
            \ 'twitter-user': 'https://twitter.com/{query}',
            \ 'reddit':'https://www.reddit.com/search\?q\={query}',
            \ 'youtube':'https://www.youtube.com/results\?search_query\={query}\&page\=\&utm_source\=opensearch',
            \ 'zhihu':'https://www.zhihu.com/search\?q\={query}',
            \ 'baidu':'https://www.baidu.com/s\?ie\=UTF-8\&wd\={query}'
\}

let g:search_engine = 'duckduckgo'
let g:broswer_path = 'firefox'
