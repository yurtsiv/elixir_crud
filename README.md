## API

### Authors

- **POST** `/api/author`

  Request headers

  ```
  Content-type: application/json
  ```

  Request body

  ```
  {
    "author": {
      "first_name": string,
      "last_name": string,
      "age": integer
    }
  }
  ```

  Response

  ```
  {
    "data": {
      "author": {
        "id": integer,
        "first_name": string,
        "last_name": string,
        "age": integer
      },
      "token": string
    }
  }
  ```

- **GET** `/api/protected/authors/:id`

  Request headers

  ```
  Authorization: "Bearer #{token}"
  ```

  Response

  ```
  {
    "data": {
      "id": integer,
      "first_name": string,
      "last_name": string,
      "age": integer
    }
  }
  ```

- **PUT** `/api/protected/authors/:id`

  Request headers

  ```
  Content-type: application/json
  Authorization: "Bearer #{token}"
  ```

  Request body

  ```
  {
    "author": {
      "first_name": string,
      "last_name": string,
      "age": integer
    }
  }
  ```

  Response

  ```
  {
    "data": {
      "id": integer,
      "first_name": string,
      "last_name": string,
      "age": integer
    }
  }
  ```

### Articles

- **POST** `/api/protected/articles`

  Request headers

  ```
  Content-type: application/json
  Authorization: "Bearer #{token}"
  ```

  Request body

  ```
  {
    "article": {
      "title": string,
      "body": string,
      "description": string
    }
  }
  ```

  Response

  ```
  {
    "data": {
      "id": integer,
      "title": string,
      "body": string,
      "description": string,
      "published_date": string,
      "author": {
        "id": integer,
        "first_name": string,
        "last_name": string,
        "age": integer
      },
    }
  }
  ```

- **GET** `/api/protected/articles/:id`

  Request headers

  ```
  Authorization: "Bearer #{token}"
  ```

  Response

  ```
  {
    "data": [
      {
        "id": integer,
        "title": string.
        "body": string,
        "description": string,
        "published_date": string,
        "author": {
          "id": integer,
          "first_name": string,
          "last_name": string,
          "age": integer,
        },
      },
    ]
  }
  ```

- **DELETE** `/api/protected/articles/:id`

  Request headers

  ```
  Authorization: "Bearer #{token}"
  ```
