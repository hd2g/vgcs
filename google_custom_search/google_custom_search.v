module google_custom_search

import net.http
import google_custom_search.api
import google_custom_search.response { Response }
import google_custom_search.requests

pub fn list(queries []string, cx string) !Response {
	client := api.new_client[http.Response](cx, requests.new())!
	return client.list(queries)
}
