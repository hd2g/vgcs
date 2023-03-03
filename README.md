# Google Custom Search's sdk for V lang


## Examples
### SEARCH_ENGINE_IDとAPI_KEYを直接指定して検索
```v
import google_custom_search as gcs

fn main() {
  client := gcs.Client{cx: '<your SEARCH_ENGINE_ID>', key: '<your API_KEY>'}
  resp := client.list(['vlang', 'docs']) or {
    eprintln('failed request to google custom engine: ${err}')
    exit(1)
  }
  println(resp.items.map(it.html_title).join('\n'))
}
```

### gcs.config.jsonを使用
```v
import google_custom_search as gcs
import google_custom_search.config

fn main() {
  cfg := config.from_file('path/to/gcs.config.json')!
  client :=  gcs.from_config(cfg)
  resp := client.list(['vlang', 'docs']) or {
    eprintln('failed request to google custom engine: ${err}')
    exit(1)
  }
  println(resp.items.map(it.html_title).join('\n'))
}
```

### cliとして使用
```sh
$ gvcs -h
Usage: gvcs [flags] [commands]

google custom search sdk for V lang

Flags:
  -h  -help
      -man            Prints the auto-generated manpage.

Commands:
  list                search keywords using google search engine
  help                Prints help information.
  man                 Prints the auto-generated manpage.

$ gvcs list -h
Usage: gvcs list [flags]

search keywords using google search engine

Flags:
  -c  -config
  -k  -api-key
  -h  -help
      -man            Prints the auto-generated manpage.

$ ls -1
gcs.config.js

$ cat gcs.config.js
{
  "key": "<your API_KEY>",
  "cx": "<your SEARCH_ENGINE_ID>"
}

$ vgcs list vlang
```
