module google_custom_search

import net.http
import google_custom_search.api
import google_custom_search.response { Response }
import google_custom_search.requests
import google_custom_search.config { Config }

pub struct Client {
	cx  string
	key string
}

pub fn new(cx string, key string) Client {
	return Client{cx, key}
}

pub fn from_config(cfg Config) Client {
	return Client{
		cx: cfg.cx
		key: cfg.key
	}
}

pub fn (self Client) list(queries []string) !Response {
	client := api.new_client[http.Response](self.cx, self.key, requests.new())!
	return client.list(queries)
}
