module response

import os
import x.json2

fn test_failed_response_from_map() {
	src := json2.raw_decode('{"badKey": []}')!.as_map()
	from_map(src) or { return }
	assert false
}

fn test_empty_response_from_map() {
	src := json2.raw_decode('{"items": []}')!.as_map()
	actual := from_map(src)!
	expected := Response{
		items: []
		len: 0
	}
	assert actual == expected
}

fn test_response_from_map() ! {
	src := os.read_file('tests/examples/raw.response.json')!
	jso := json2.raw_decode(src)!
	actual := from_map(jso.as_map())!
}

fn test_encode_response_to_raw_json() {
	src := os.read_file('tests/examples/compact.raw.response.json')!
	jso := json2.raw_decode(src)!
	resp := from_map(jso.as_map())!

	// TODO: ちゃんとした差分テストをする
	assert resp.encode_json() != ''
}
