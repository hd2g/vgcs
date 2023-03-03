// Copyright (C) 2023  1one

// The contents of this file are subject to the Mozilla Public License
// Version 1.1 (the "License"); you may not use this file except in
// compliance with the License. You may obtain a copy of the License at
// http://www.mozilla.org/MPL/

// Software distributed under the License is distributed on an "AS IS"
// basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
// License for the specific language governing rights and limitations
// under the License.
module config

import os
import x.json2

pub struct Config {
pub:
	cx  string
	key string
}

pub fn from_json(raw_json string) !Config {
	return json2.decode[Config](raw_json)
}

pub fn from_file(pathname string) !Config {
	raw_json := os.read_file(pathname)!
	return from_json(raw_json)
}
