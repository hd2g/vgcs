module main

import os
import cli { Command, Flag }
import google_custom_search as gcs
import google_custom_search.config { Config }

const (
	default_gcs_config_json_pathname = 'gcs.config.json'
)

fn execute_list(cmd Command) ! {
	cx := cmd.flags.get_string('config')!
	api_key := cmd.flags.get_string('api-key')!

	cfg := if cx != '' && api_key != '' {
		Config{
			cx: cx
			key: api_key
		}
	} else {
		pathname := os.getenv_opt('GCS_CONFIG_PATHNAME') or { default_gcs_config_json_pathname }
		config.from_file(pathname) or {
			return error('failed to read config from file: ${pathname}')
		}
	}

	client := gcs.Client{
		cx: cfg.cx
		key: cfg.key
	}
	resp := client.list(cmd.args)!
	println(resp.encode_json())
}

fn main() {
	mut app := Command{
		name: 'gvcs'
		description: 'google custom search sdk for V lang'
		flags: [
			Flag{
				name: 'help'
				abbrev: 'h'
				flag: .bool
				global: true
			},
		]
		commands: [
			Command{
				name: 'list'
				description: 'search keywords using google search engine'
				args: [
					'cx',
				]
				flags: [
					Flag{
						name: 'config'
						abbrev: 'c'
						flag: .string
					},
					Flag{
						name: 'api-key'
						abbrev: 'k'
						flag: .string
					},
				]
				execute: execute_list
			},
		]
	}
	app.setup()
	app.parse(os.args)
}
