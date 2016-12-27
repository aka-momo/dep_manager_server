# DepManager Server

This is a rails web server app, acts as tool to supply the developers with system dependency libraries for gems and npm packages. The system provides an api for the gem [DepManager](https://github.com/mohameddiaa27/dep_manager) that automates the proccess of installing the system dependencies of a target project (ruby or node). The webserver is deployed on heroku [here](https://dep-manager.herokuapp.com).

* Ruby version
	- 2.2.2
* System dependencies
	- postgresql
* Database creation

	```ruby
	$ rails db:create
	```
* Database initialization

	```ruby
	$ rails db:migrate db:seed
	```
* Gems Added
	- pg
	- bootstrap
	- cocoon
	- haml-rails
	- kaminari
	- rails-assets-tether

## Design
The system uses a relational database (postgresql) for saving the packages and their dependencies.

### Database
The database consists of:

- **Packages Table**: representing the gems or npm packages.

	| Column     | Type    |      |
	|------------|---------|------|
	| name       | string  |      |
	| language   | integer | enum |
	| source_url | string  |      |

- **System Dependencies Table**: representing the system-level dependencies required by the specific package for a certain operating system.

	| Column           | Type    |             |
	|------------------|---------|-------------|
	| name             | string  |             |
	| package_id       | integer | association |
	| operating_system | integer | enum        |


### API
There is only one api avilable to support the gem. The api serves the dependencies while it requires the list of packeges, the language used, and the operating system.

- **Request**
	- Parameters:

		| Param           	| Type    |          |
		|-------------------|---------|----------|
		| packages       	| array  	| required |
		| lanuage      		| string  | required |
		| operating_system 	| string 	| required |

	- HTTP

		|        |      |   
		|--------|------|
		| METHOD | POST |
		| FORMAT | json |

Usually such api should be implemented as a `GET` request instead of `post`. But in case of parsing a large array of packeges that may not fit in the url, it is intentionally set to `post` to avoid firing multiple get requesta on the server.

- **Response**
	The response is served in `json` format, it includes every packages along with its 
	- sample

		```json
		{
		  [
		     {
		       "name": "nokogiri",
		       "system_dependncies": [
		         {
		           "name": "ruby-dev"
		         },
		         {
		           "name": "zlib1g-dev"
		         },
		         {
		           "name": "liblzma-dev"
		         }
		       ]
		     },
		     {
		       "name": "pg",
		       "system_dependncies": [
		         {
		           "name": "postgresql"
		         }
		       ]
		     }
		  ]
		}
		```

### Interface
The system provides a user friendly CRUD interface for managing packages implemented using:

- haml
- scss, bootstrap, font-awesome
- jquery, js

## TODO

- Verfied Package cannot be deleted or modified
- Report Verfied Package