module response

import net.http
import x.json2 { Any }

pub struct Response {
	items []Item
	len   int
}

struct Item {
	kind         string
	title        string
	html_title   string
	link         string
	display_link string
	mime         string
	file_format  string
	image        Image
	labels       []Label
}

struct Image {
	context_link     string
	height           int
	width            int
	byte_size        int
	thumbnail_link   string
	thumbnail_height string
	thumbnail_width  string
}

struct Label {
	name          string
	display_name  string
	label_with_op string
}

fn image_from_map(m map[string]Any) !Image {
	return Image{
		context_link: m['contextLink']!.str()
		height: m['height']!.int()
		width: m['width']!.int()
		byte_size: m['byteSize']!.int()
		thumbnail_link: m['thumbnailLink']!.str()
		thumbnail_height: m['thumbnailHeight']!.str()
		thumbnail_width: m['thumbnailWidth']!.str()
	}
}

fn label_from_map(m map[string]Any) !Label {
	return Label{
		name: m['name']!.str()
		display_name: m['displayName']!.str()
		label_with_op: m['labelWithOp']!.str()
	}
}

fn item_from_map(m map[string]Any) !Item {
	return Item{
		kind: m['kind']!.str()
		title: m['title']!.str()
		html_title: m['htmlTitle']!.str()
		link: m['link']!.str()
		display_link: m['displayLink']!.str()
		mime: m['mime']!.str()
		file_format: m['fileFormat']!.str()
		image: image_from_map(m['image']!.as_map()) or {
			return error('failed convert item to image: ${err}')
		}
		labels: m['labels']!.arr().map(label_from_map(it.as_map()) or {
			return error('failed convert item to label: ${err}')
		})
	}
}

// OPTIMIZE: 遅い...
//   - json2.raw_decodeのせいかも
pub fn from_map(m map[string]Any) !Response {
	items := m['items']!.arr().map(item_from_map(it.as_map()) or { Item{} })
	len := items.len
	return Response{
		items: items
		len: len
	}
}

pub fn from_http_response(resp http.Response) !Response {
	if int(resp.status_code / 100) != 2 {
		return error('cannot convert from failed response: ${resp.status_msg}')
	}
	jso := json2.raw_decode(resp.body)!
	return from_map(jso.as_map())
}
