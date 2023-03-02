module api

import google_custom_search.query { Query, queries_of_strings }
import google_custom_search.response { Response }
import google_custom_search.requests { Requestable }

pub const (
	base_url = 'https://customsearch.googleapis.com/customsearch/v1'
)

pub struct Client[A] {
	cx     string
	client Requestable[A]
}

pub fn new_client[A](cx string, client Requestable[A]) !Client[A] {
	if cx == '' {
		return error('cx is empty')
	}
	if isnil(client) {
		return error('client is null')
	}
	return Client[A]{cx, client}
}

pub fn (self Client[A]) list(queries []string) !Response {
	q := Query{
		cx: self.cx
		q: queries_of_strings(queries).to_q()
	}
	url := q.to_url(api.base_url)!

	resp := self.client.get(url.str())!
	return response.from_http_response(resp)
}
