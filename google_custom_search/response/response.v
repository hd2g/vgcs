module response

import net.http
import json
import x.json2 { Any }

pub struct Response {
pub:
	items []Item
	len   int
}

pub struct Item {
pub:
	kind               string
	title              string
	html_title         string
	link               string
	display_link       string
	snippet            string
	html_snippet       string
	formatted_url      string
	html_formatted_url string
	pagemap            Pagemap
}

pub struct Pagemap {
pub:
	cse_thumbnail []CseThumbnail
	cse_image     []CseImage
}

pub struct CseThumbnail {
pub:
	src    string
	width  i32
	height i32
}

pub struct CseImage {
pub:
	src string
}

fn cse_thumbnail_from_map(m map[string]Any) !CseThumbnail {
	return CseThumbnail{
		src: m['src']!.str()
		width: m['width']!.str().parse_int(10, 32) or {
			return error('pagmap.cse_thumbnail.width isnt integer')
		}
		height: m['height']!.str().parse_int(10, 32) or {
			return error('pagmap.cse_thumbnail.height isnt integer')
		}
	}
}

fn cse_image_from_map(m map[string]Any) !CseImage {
	return CseImage{
		src: m['src']!.str()
	}
}

fn pagemap_from_map(m map[string]Any) !Pagemap {
	cse_thumbnail := if a := m['cse_thumbnail'] {
		a.arr().map(cse_thumbnail_from_map(it.as_map()) or {
			return error('failed convert item to cse_thumbnail: ${err}')
		})
	} else {
		[]CseThumbnail{}
	}

	cse_image := if a := m['cse_image'] {
		a.arr().map(cse_image_from_map(it.as_map()) or {
			return error('failed convert item to cse_image: ${err}')
		})
	} else {
		[]CseImage{}
	}

	return Pagemap{cse_thumbnail, cse_image}
}

fn item_from_map(m map[string]Any) !Item {
	pagemap := if mpagemap := m['pagemap'] {
		pagemap_from_map(mpagemap.as_map()) or { return error('failed convert to Pagemap: ${err}') }
	} else {
		Pagemap{}
	}

	return Item{
		kind: m['kind']!.str()
		title: m['title']!.str()
		html_title: m['htmlTitle']!.str()
		link: m['link']!.str()
		display_link: m['displayLink']!.str()
		snippet: m['snippet']!.str()
		html_snippet: m['htmlSnippet']!.str()
		formatted_url: m['formattedUrl']!.str()
		html_formatted_url: m['htmlFormattedUrl']!.str()
		pagemap: pagemap
	}
}

// OPTIMIZE: 遅い...
//   - json2.raw_decodeのせいかも
pub fn from_map(m map[string]Any) !Response {
	items := m['items']!.arr().map(item_from_map(it.as_map()) or {
		return error('failed convert to Item: ${err}')
	})
	len := items.len
	return Response{
		items: items
		len: len
	}
}

pub fn from_http_response(resp http.Response) !Response {
	if int(resp.status_code / 100) != 2 {
		mut msg := []string{}
		msg << 'response code: ${resp.status_code}'
		msg << resp.body
		msg << 'cannot convert from failed response: ${resp.status_msg}'
		return error(msg.join('\n'))
	}
	jso := json2.raw_decode(resp.body)!
	return from_map(jso.as_map())
}

pub fn (self Response) encode_json() string {
	// TODO: json2.encode[Response](self)にしたい
	//   - なんがfile.vでエラー出る
	return json.encode(self)
}
