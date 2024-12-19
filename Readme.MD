# CutLink  ✂🔗

CutLink is a lightweight and efficient URL shortener application built using Go, Redis, and Docker. This project aims to provide a simple and scalable solution for creating and managing shortened URLs.

## Features

- **Fast and Scalable**: Powered by Go and Redis for optimal performance.
- **Containerized Setup**: Easily deployable using Docker and Docker Compose.
- **Custom Slugs**: Generate and use custom or random slugs for shortened URLs.
- **RESTful API**: Exposes APIs for URL shortening, retrieval, and analytics.
- **Cloud-Ready**: Designed for deployment on AWS or other cloud platforms.

## Technologies

- **Backend**: Go
- **Database**: Redis (key-value store)
- **Containerization**: Docker & Docker Compose

## Getting Started

### Prerequisites

Ensure the following tools are installed:

- [Go](https://golang.org/doc/install)
- [Docker](https://www.docker.com/)
- [Docker Compose](https://docs.docker.com/compose/)

### Clone the Repository

```bash
git clone https://github.com/andresilvase/cutlink.git
cd cutlink
```

### Configure Environment Variables

Create a `.env` file in the project root with the following variables:

```env
REDIS_HOST=redis
REDIS_PORT=6379
APP_PORT=1818
```

### Build and Run the Application

1. Build and start the services:

```bash
make run
```

2. Access the application at `http://localhost:1818`.

## API Endpoints

- **POST /shorten**  
  Shortens a URL.  
  Request Body:  
  ```json
  {
    "url": "https://example.com",  
  }
  ```
  Response:  
  ```json
  {
    "shortened_url": "host.url/SHORTENED-URL"
  }
  ```

- **GET /{slug}**  
  Redirects to the original URL.

## Folder Structure

```plaintext
cutlink/
├── Dockerfile           # Docker image setup
├── docker-compose.yaml  # Container orchestration
├── .env.example         # Environment variable template
├── internal/            # Application logic
│   ├── controller/        # API route controller handlers
│   ├── errros/          # Custom errors
│   └── models/          # Domain models
│   └── repository/      # Layer that handle storage
│   └── constants.go     # App constant values
├── cmd/                 # Application entry point
├── README.md            # Project documentation
└── tests/               # Unit and integration tests
```

## Deployment

For production deployment, consider using a cloud platform like AWS with services like **Elastic Beanstalk**, **ECS**, or **Lambda**. Update environment variables accordingly.

## Contributing

Contributions are welcome! Please fork the repository, make your changes, and submit a pull request.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.