module utils

import os

fn extract_metadata(content string) map[string][]string {
	parts := content.split_any('\n')

	mut all_items := [][]string{}

	mut new_list := []string{}

	for i in parts {
		if i == '' {
			continue
		}
		if i.contains(':') {
			if new_list.len == 0 {
				new_list << i.split_n(':', 2).map(it.trim_space())
			} else {
				all_items << new_list
				new_list = []string{}
				cur_check := i.split_n(':', 2).map(it.trim_space())
				if cur_check[1] == '' {
					new_list << cur_check[0]
				} else {
					new_list << cur_check
				}
			}
		} else if i.contains('-') {
			new_list << i.replace('-', '').trim_space()
		} else {
			new_list << i
		}
	}
	all_items << new_list
	mut my_metadata := map[string][]string{}

	for item in all_items {
		key := item[0]
		value := item[1..]

		my_metadata[key] = value

		// if value.len == 1 {
		// 	my_metadata[key] = value[0]
		// } else {
		// }
	}
	return my_metadata
}

pub fn get_files(path string) []string {
	if !os.exists(path) {
		panic('Directory does not exist: ${path}')
	}

	posts := os.ls(path) or { [] }

	return posts
}

pub fn build_data(base_path string) map[string]map[string][]string {
	if !os.exists(base_path) {
		panic('Directory does not exist: ${base_path}')
	}

	posts := os.ls(base_path) or { panic('Failed to read directory: ${base_path}') }

	mut ret := map[string]map[string][]string{}

	for filename in posts {
		file_path := base_path + '/' + filename

		if os.is_readable(file_path) {
			text := os.read_file(file_path) or { continue }
			sections := text.split_n('---', 3)[1..]

			mut object := extract_metadata(sections[0])

			object['content'] = [sections[1]]

			ret[object['slug'][0]] = object.clone()
		}
	}

	return ret
}

// fn main() {
// 	println(build_data())
// }
