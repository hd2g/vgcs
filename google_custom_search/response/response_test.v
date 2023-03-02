module response

import x.json2 { Any }

const (
	raw_json = '{
    "items": [
      {
        "kind": "***kind***",
        "title": "***title***",
        "htmlTitle": "***htmlTitle***",
        "link": "***link***",
        "displayLink": "***displayLink***",
        "mime": "***mime***",
        "fileFormat": "***fileFormat***",
        "image": {
          "contextLink": "***contextLink***",
          "height": 180,
          "width": 240,
          "byteSize": 360,
          "thumbnailLink": "***thumbnailLink***",
          "thumbnailHeight": "***thumbnailHeight***",
          "thumbnailWidth": "***thumbnailWidth***"
        },
        "labels": [
          {
            "name": "***name***",
            "displayName": "***displayName***",
            "labelWithOp": "***labelWithOp***"
          }
        ]
      }
    ]
  }'
)

fn mksource() !map[string]Any {
	return json2.raw_decode(response.raw_json)!.as_map()
}

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

fn test_response_from_map() {
	src := mksource() or {
		eprintln('make source failure: ${err}')
		assert false
		return
	}
	actual := from_map(src) or {
		eprintln(err)
		assert false
		return
	}
	expected := Response{
		items: [
			Item{
				kind: '***kind***'
				title: '***title***'
				html_title: '***htmlTitle***'
				link: '***link***'
				display_link: '***displayLink***'
				mime: '***mime***'
				file_format: '***fileFormat***'
				image: Image{
					context_link: '***contextLink***'
					height: 180
					width: 240
					byte_size: 360
					thumbnail_link: '***thumbnailLink***'
					thumbnail_height: '***thumbnailHeight***'
					thumbnail_width: '***thumbnailWidth***'
				}
				labels: [
					Label{
						name: '***name***'
						display_name: '***displayName***'
						label_with_op: '***labelWithOp***'
					},
				]
			},
		]
		len: 1
	}
	assert actual == expected
}
