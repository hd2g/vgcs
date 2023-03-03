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
