module api

import net.http
import google_custom_search.query { Query, queries_of_strings }
import google_custom_search.response { Response }

pub const (
	base_url = 'https://customsearch.googleapis.com/customsearch/v1'
)

pub struct Client {
	cx string
}

pub fn new(cx string) !Client {
	if cx == '' {
		return error('cx is empty')
	}
	return Client{cx}
}

pub fn (self Client) search(queries []string) !Response {
	q := Query{
		cx: self.cx
		q: queries_of_strings(queries).to_q()
	}
	url := q.to_url(api.base_url)!
	resp := http.get(url.str())!
	return response.from_http_response(resp)
}
