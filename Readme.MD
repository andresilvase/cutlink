# ShortCut Link  ✂🔗

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

### Build and Run the Application

1. Build and start the services:

```bash
make up
```

2. Access the application at `http://localhost:8080`.

## API Endpoints

- **POST /cut**  
  Shortens a URL.  
  Request Body:  
  ```json
  {
    "url": "https://example.com/something-here?maybe=here-too",  
  }
  ```
  Response:  
  ```json
  {
    "data": {
      "shortened_url": "https://example.com/{slug}"
    }
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

For production deployment, consider using a cloud platform like AWS with services like **Elastic Container Registry**, **Elastic Container Service**, or **Route53**, **AWS Amplify**, **AWS S3**.