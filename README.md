# Nebula AI

Nebula AI is a sophisticated client application designed for seamless interaction with AWS Bedrock services. It provides an intuitive interface for leveraging various AI models, managing knowledge bases, and implementing Retrieval-Augmented Generation (RAG) systems.

![Nebula AI Logo](assets/images/logo.png)

## Features

### 🤖 AI Model Integration
- Access to multiple AWS Bedrock models including Llama 3 (70B & 8B), Mistral 7B, and Titan
- Real-time model switching during chat sessions
- Customizable model parameters (temperature, max tokens)
- Model performance metrics and status monitoring

### 💬 Chat Interface
- Intuitive chat experience with AI models
- Code block support with syntax highlighting
- File and image attachment capabilities
- Voice input support
- Message feedback system
- Chat history management

### 📚 Knowledge Base Management (RAG)
- Create and manage multiple knowledge bases
- Support for various document formats (PDF, TXT, DOCX, MD)
- Document embedding using AWS Bedrock embedding models
- Real-time document processing and indexing
- Query interface for knowledge base interaction

### ⚙️ Advanced Settings
- Customizable AI parameters
- AWS credentials management
- Embedding model selection
- Dark mode support
- Push and email notification settings
- Profile and security management

### 🔄 Integration Features
- Seamless AWS Bedrock API integration
- Real-time model status monitoring
- Secure credential management
- Enterprise-grade security features

## Technical Stack
- Flutter for cross-platform development
- GetX for state management
- Bolt UI Kit for consistent design
- AWS Bedrock SDK integration

## Getting Started

1. **Installation**
   ```bash
   flutter pub get
   ```

2. **AWS Configuration**
   - Configure AWS credentials
   - Set up Bedrock access permissions

3. **Running the App**
   ```bash
   flutter run
   ```

## Architecture

The app follows a clean architecture pattern with:
- Feature-based organization
- Controller-based state management
- Reusable components
- Separation of concerns

### Key Directories
```
lib/
├── src/
│   ├── components/      # Reusable UI components
│   ├── controllers/     # Business logic and state management
│   ├── features/        # Feature modules
│   │   ├── chat/
│   │   ├── home/
│   │   ├── login/
│   │   ├── rag/
│   │   └── settings/
│   └── helpers/         # Utility functions
```

## Requirements
- Flutter SDK 3.0 or higher
- AWS Account with Bedrock access
- Compatible with iOS and Android
