module google_custom_search

import net.http
import google_custom_search.api
import google_custom_search.response { Response }
import google_custom_search.requests

pub fn list(cx string, key string, queries []string) !Response {
	client := api.new_client[http.Response](cx, key, requests.new())!
	return client.list(queries)
}
