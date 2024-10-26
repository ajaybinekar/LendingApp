# LendingApp

Welcome to LendingApp! This application streamlines loan approval and adjustment processes, providing a user-friendly experience for administrators and clients.

## Prerequisites

To set up and run this application, you’ll need:

- **Ruby version**: 3.1.1
- **Rails version**: 6.1.7
- **Redis**: for background job processing
- **Bundler**: for gem management

## Getting Started

Follow these steps to clone the repository, set up dependencies, configure the database, and start the server.

### 1. Clone the Repository

```bash
git clone https://github.com/ajaybinekar/LendingApp.git
cd LendingApp
```

### 2. Install Dependencies

Ensure you’re using the correct version of Ruby and Rails. Then, install the required gems:

```bash
bundle install
```

### 3. Set Up the Database

```bash
rails db:create
rails db:migrate
rails db:seed
```

### 4. Start the Server

```bash
rails server
```

The app will be accessible at [http://localhost:3000](http://localhost:3000).

## Background Jobs with Sidekiq

If your app has background jobs:

1. Ensure Redis is running:

   ```bash
   redis-server
   ```

2. Start Sidekiq for background processing:

   ```bash
   bundle exec sidekiq -C config/sidekiq.yml
   ```

---
Demo:
https://drive.google.com/file/d/170EHTnwbQFThOfu3lTNs8yJNZi88Q1MB/view?usp=sharing