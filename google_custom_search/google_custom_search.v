// Copyright (C) 2023  1one

// The contents of this file are subject to the Mozilla Public License
// Version 1.1 (the "License"); you may not use this file except in
// compliance with the License. You may obtain a copy of the License at
// http://www.mozilla.org/MPL/

// Software distributed under the License is distributed on an "AS IS"
// basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
// License for the specific language governing rights and limitations
// under the License.
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
