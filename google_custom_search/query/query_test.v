module query

import net.urllib

const (
	queries = queries_of_strings(['a', 'b'])
	key     = '***key***'
	cx      = '***cx***'
	q       = 'a+b'
	exquery = Query{
		key: key
		cx: cx
		q: q
	}
)

fn test_queries_to_q() {
	assert query.queries.to_q() == query.q
}

fn test_convert_query_to_values() {
	values := query.exquery.as_values()
	assert values.get('key') == query.key
	assert values.get('cx') == query.cx
	assert values.get('q') == query.q
}

fn test_convert_query_to_url() {
	base_url := 'https://customsearch.googleapis.com/customsearch/v1'
	url := query.exquery.to_url(base_url) or {
		assert false
		return
	}
	assert url.str() == urllib.parse('${base_url}?cx=${urllib.query_escape(query.cx)}&key=${urllib.query_escape(query.key)}&q=${urllib.query_escape(query.q)}')!.str()
}
