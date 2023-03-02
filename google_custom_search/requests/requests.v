module requests

import net.http { Response }

// TODO: 他のメソッドも追加する
//   - GET gcs.list しかapiがないから、いったんgetのみにした
pub interface Requestable[A] {
	get(url string) !A
}

pub struct Requests {}

pub fn new() Requestable[Response] {
	return Requests{}
}

pub fn (self Requests) get(url string) !Response {
	return http.get(url)
}
