module api

import net.http
import google_custom_search.requests

const (
	cx       = '***cx***'
	key      = '***key***'
	exclient = Client[http.Response]{
		cx: cx
		key: key
		// TODO: use mock
		client: requests.new()
	}
)

fn test_new_client() {
	actual := // TODO: use mock
	new_client(api.cx, api.key, requests.new())!
	expected := api.exclient
	assert actual == expected
}

fn test_new_client_failure() {
	// TODO: use mock
	new_client('', '', requests.new()) or { return }
	assert false
}
