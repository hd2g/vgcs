// Copyright (C) 2023  1one

// The contents of this file are subject to the Mozilla Public License
// Version 1.1 (the "License"); you may not use this file except in
// compliance with the License. You may obtain a copy of the License at
// http://www.mozilla.org/MPL/

// Software distributed under the License is distributed on an "AS IS"
// basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
// License for the specific language governing rights and limitations
// under the License.
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
