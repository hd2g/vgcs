// Copyright (C) 2023  1one

// The contents of this file are subject to the Mozilla Public License
// Version 1.1 (the "License"); you may not use this file except in
// compliance with the License. You may obtain a copy of the License at
// http://www.mozilla.org/MPL/

// Software distributed under the License is distributed on an "AS IS"
// basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
// License for the specific language governing rights and limitations
// under the License.
module api

import google_custom_search.query { Query, queries_of_strings }
import google_custom_search.response { Response }
import google_custom_search.requests { Requestable }

pub const (
	base_url = 'https://customsearch.googleapis.com/customsearch/v1'
)

pub struct Client[A] {
pub:
	cx     string
	key    string
	client Requestable[A]
}

pub fn new_client[A](cx string, key string, client Requestable[A]) !Client[A] {
	if cx == '' {
		return error('cx is empty')
	}
	if key == '' {
		return error('key is empty')
	}
	if isnil(client) {
		return error('client is null')
	}
	return Client[A]{cx, key, client}
}

pub fn (self Client[A]) list(queries []string) !Response {
	q := Query{
		cx: self.cx
		key: self.key
		q: queries_of_strings(queries).to_q()
	}
	url := q.to_url(api.base_url)!

	resp := self.client.get(url.str())!
	return response.from_http_response(resp)!
}
