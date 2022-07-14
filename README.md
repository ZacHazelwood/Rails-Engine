<h1 align="center">Rails Engine</h1>

  <p align="center">
    An Exercise in Building an API in Rails<br>
    Turing School of Software and Design, Module 3
  </p>
</div>

<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
        <li><a href="#tested-with">Tested With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#installation">Installation</a></li>
        <li><a href="#usage">Usage</a></li>
        <li><a href="#api-endpoints">API Endpoints</a></li>
      </ul>
    </li>
    <li><a href="#contributors">Contributors</a></li>
  </ol>  
</details>

<!-- PROJECT DETAILS -->
## Project Details

The purpose of this project is to practice building a practical API application.<br>
Using data related to a mocked e-commerce platform, the goal of this project is to design serializers to format JSON files that can be accessed through a controller.<br><br>
For a complete breakdown of the project's technical requirements and goals for understanding, please click this link:<br> [Rails Engine Lite](https://backend.turing.edu/module3/projects/rails_engine_lite/)

  ### Built With

* [Rails v5.2.8](https://rubyonrails.org/)
* [Ruby v2.7.4](https://www.ruby-lang.org/en/)
* [PostgreSQL v14.2](https://www.postgresql.org/)

### Tested With

* [RSpec v3.11](https://rspec.info/)
* [PostMan](https://www.postman.com/)

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- GETTING STARTED -->
## Getting Started

### Installation

1. Fork this Repo (optional), or Clone this Repo with the following command:<br>
* Using https:
```
  git clone https://github.com/ZacHazelwood/Rails-Engine.git
```  
* Using SSH key:
```
  git clone git@github.com:ZacHazelwood/Rails-Engine.git
```
2. Install Required Technologies, or check for correct versions using the following commands:<br>
```
  ruby -v
  rails-v
  rspec -v
  postgres -V
```  
3. Install required gems included within the gemfile:<br>
```
  bundle install
```
4. Create PostgreSQL database, run migrations and seed the database:<br>
```
  rails db:{create,migrate,seed}
```

<p align="right">(<a href="#top">back to top</a>)</p>

### Usage

To access the data presented, simply launch a local server by typing `rails s` into the command prompt.<br>
Then, use a browser or PostMan (or equivalent) to explore the API from the following URL and included endpoints, listed below:<br>
```
  http://localhost:3000
```

If using PostMan, please follow the instructions provided beneath the <b>Postman</b> header from the project details page, [Rails Engine Lite](https://backend.turing.edu/module3/projects/rails_engine_lite/)

<!-- API ENDPOINTS -->
### API Endpoints

#### Merchants:
  * get all merchants `GET http://localhost:3000/api/v1/merchants`
  * get one merchant `GET http://localhost:3000/api/v1/merchants/:merchant_id`
  * get all items held by a given merchant `GET http://localhost:3000/api/v1/merchants/:merchant_id/items`
#### Items:
  * get all items `GET http://localhost:3000/api/v1/items`
  * get one item `GET http://localhost:3000/api/v1/items/:item_id`
  * create an item `POST http://localhost:3000/api/v1/items/:item_id`
  * edit an item `PUT http://localhost:3000/api/v1/items/:item_id`
  * delete an item `DESTROY http://localhost:3000/api/v1/items/:item_id`
  * get the merchant data for a given item ID `GET http://localhost:3000/api/v1/items/:item_id/merchant`
#### Search:
  * find one merchant by name `GET http://localhost:3000/api/v1/merchants/find?name=some_query`
  * find all merchants by name `GET http://localhost:3000/api/v1/merchants/find_all?name=some_query`
  * find one item by name `GET http://localhost:3000/api/v1/items/find?name=some_query`
  * find all items by name `GET http://localhost:3000/api/v1/items/find_all?name=some_query`
  * find one item by minimum price `GET http://localhost:3000/api/v1/items/find?min_price=some_query`
  * find one item by maxmimum price `GET http://localhost:3000/api/v1/items/find?max_price=some_query`
  * find one item by price range `GET http://localhost:3000/api/v1/items/find?min_price=some_query&max_price=another_query`

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- CONTRIBUTORS -->
### Contributors

[Zac Hazelwood](https://github.com/ZacHazelwood)

<p align="right">(<a href="#top">back to top</a>)</p>
