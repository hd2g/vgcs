// Copyright (C) 2023  1one

// The contents of this file are subject to the Mozilla Public License
// Version 1.1 (the "License"); you may not use this file except in
// compliance with the License. You may obtain a copy of the License at
// http://www.mozilla.org/MPL/

// Software distributed under the License is distributed on an "AS IS"
// basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
// License for the specific language governing rights and limitations
// under the License.
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
