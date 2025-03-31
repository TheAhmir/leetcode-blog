module main

import veb
import utils

// Our context struct must embed `veb.Context`!
pub struct Context {
	veb.Context // pub mut:
	// 	// In the context struct we store data that could be different
	// 	// for each request. Like a User struct or a session id
	// 	user       string
	// 	session_id string
}

pub struct App {
	veb.Middleware[Context] // pub:
	// 	// In the app struct we store data that should be accessible by all endpoints.
	// 	// For example, a database or configuration values.
	// 	secret_key string
}

// This is how endpoints are defined in veb. This is the index route
pub fn (app &App) index(mut ctx Context) veb.Result {
	data := utils.build_data('./posts')
	return ctx.json(data)
}

// endpoint for individual post
@['/:post_slug']
pub fn (app &App) get_post(mut ctx Context, post_slug string) veb.Result {
	data := utils.build_data('./posts')
	return ctx.json(data[post_slug])
}

fn main() {
	mut app := &App{}

	// Attach CORS middleware before running the app
	app.use(veb.cors[Context](veb.CorsOptions{
		origins: ['*']

		// Allow all origins
		allowed_methods:   [.get, .post, .put, .delete, .options]
		allowed_headers:   ['*']
		allow_credentials: true
		expose_headers:    ['Content-Length']
		max_age:           3600
	}))

	// Start the server
	veb.run[App, Context](mut app, 9000)
}
