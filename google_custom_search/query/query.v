module query

import net.urllib { URL, Values }

pub const (
	delimiter = '+'
)

// TODO: 追々他のパラメータも実装する
//   - url: [Method: cse.list  |  Custom Search JSON API  |  Google Developers](https://developers.google.com/custom-search/v1/reference/rest/v1/cse/list?hl=ja)
pub struct Query {
pub:
	cx  string
	key string
	q   string
}

pub type Queries = []string

pub fn queries_of_strings(ss []string) Queries {
	return ss
}

pub fn (self Queries) to_q() string {
	return self.join(query.delimiter)
}

pub fn (self Query) as_values() Values {
	mut vs := urllib.new_values()
	vs.add('cx', self.cx)
	vs.add('key', self.key)
	vs.add('q', self.q)
	return vs
}

pub fn (self Query) to_url(base string) !URL {
	raw_url := '${base}?${self.as_values().encode()}'
	return urllib.parse(raw_url)
}
