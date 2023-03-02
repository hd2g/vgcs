module api

const (
	cx       = '***cx***'
	exclient = Client{
		cx: cx
	}
)

fn test_new_client() {
	actual := new(api.cx)!
	expected := api.exclient
	assert actual == expected
}

fn test_new_client_failure() {
	new('') or { return }
	assert false
}
