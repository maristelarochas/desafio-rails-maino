# Movie Catalog

> Catálogo de filmes com autenticação de usuários, gerenciamento de filmes, sistema de comentários e busca inteligente por IA.

[![Ruby](https://img.shields.io/badge/Ruby-3.4.1-red.svg)](https://www.ruby-lang.org/)
[![Rails](https://img.shields.io/badge/Rails-8.0-red.svg)](https://rubyonrails.org/)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-16-blue.svg)](https://www.postgresql.org/)
[![Tailwind CSS](https://img.shields.io/badge/Tailwind-3.0-38B2AC.svg)](https://tailwindcss.com/)

---

## Sobre o Projeto

**Movie Catalog** é uma aplicação web desenvolvida em Ruby on Rails que permite aos usuários criar e gerenciar um catálogo completo de filmes. A aplicação oferece uma interface moderna e intuitiva, com funcionalidades de autenticação, autorização, comentários públicos/privados e busca automática de dados de filmes via API externa.

### Objetivo

Desenvolver uma aplicação Ruby on Rails funcional que sirva como um catálogo de filmes completo, demonstrando boas práticas de desenvolvimento, organização de código e arquitetura MVC.

---

## Funcionalidades

### Área Pública (Sem Login)

- **Listagem de Filmes**
  - Exibição de todos os filmes cadastrados
  - Ordenação do mais recente ao mais antigo
  - Paginação (6 filmes por página)
  - Cards visuais com poster, título, diretor, ano e duração

- **Detalhes do Filme**
  - Visualização completa: título, sinopse, ano, duração, diretor
  - Exibição de poster (quando disponível)
  - Informação do usuário que cadastrou
  - Categorias associadas ao filme

- **Sistema de Comentários Anônimos**
  - Adicionar comentários sem necessidade de login
  - Informar apenas nome e conteúdo do comentário
  - Visualizar todos os comentários (mais recentes primeiro)

- **Busca e Filtros**
  - Busca por título (busca parcial)
  - Busca por diretor (busca parcial)
  - Filtro por ano de lançamento
  - Filtro por categoria

- **Autenticação**
  - Cadastro de novos usuários (com nome, email e senha)
  - Login de usuários existentes
  - Recuperação de senha por email

### Área Autenticada (Com Login)

- **Gerenciamento de Filmes**
  - Cadastrar novos filmes
  - Editar filmes criados pelo usuário
  - Excluir filmes criados pelo usuário
  - Upload de poster do filme (JPEG, PNG, GIF até 5MB)
  - Busca automática de dados via IA (OMDb API)

- **Sistema de Categorias**
  - Associar múltiplas categorias aos filmes
  - 10 categorias disponíveis: Ação, Aventura, Comédia, Drama, Ficção Científica, Terror, Romance, Suspense, Animação, Documentário

- **Comentários Vinculados**
  - Comentários automaticamente associados ao usuário logado
  - Nome do usuário aparece automaticamente

- **Gerenciamento de Perfil**
  - Editar nome e email
  - Alterar senha
  - Excluir conta

- **Autorização**
  - Usuário só pode editar/excluir seus próprios filmes
  - Proteção contra ações não autorizadas

### Diferencial: Busca por IA

- **Integração com OMDb API**
  - Campo de busca no formulário de cadastro/edição
  - Busca por título do filme (em inglês)
  - Preenchimento automático dos campos:
    - Título oficial
    - Sinopse completa
    - Ano de lançamento
    - Duração em minutos
    - Nome do diretor
  - Tratamento de erros e feedback visual
  - Loading state durante a busca

---

## Tecnologias Utilizadas

### Backend
- **Ruby** 3.4.1
- **Ruby on Rails** 8.0
- **PostgreSQL** 16.x (banco de dados)

### Frontend
- **Tailwind CSS** 3.x (framework CSS)
- **JavaScript** (Vanilla - busca por IA)
- **ERB** (Templates)
- **Hotwire** (Turbo & Stimulus)

### Gems Principais
- **Devise** 4.9.4 - Autenticação de usuários
- **Kaminari** 1.2.2 - Paginação
- **HTTParty** 0.22.0 - Requisições HTTP (OMDb API)
- **Active Storage** - Upload e gerenciamento de imagens

### APIs Externas
- **OMDb API** - The Open Movie Database (dados de filmes)

---

## Instalação e Configuração

### Pré-requisitos

Certifique-se de ter instalado:
- Ruby 3.0 ou superior
- PostgreSQL 12 ou superior
- Node.js 14 ou superior
- Git

### 1. Clone o Repositório

```bash
git clone https://github.com/SEU-USUARIO/movie-catalog.git
cd movie-catalog
```

### 2. Instale as Dependências

```bash
# Instalar gems
bundle install

# Instalar dependências do Node
npm install
```

### 3. Configure o Banco de Dados

Edite o arquivo `config/database.yml` com suas credenciais do PostgreSQL:

```yaml
default: &default
  adapter: postgresql
  encoding: unicode
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  username: postgres          # Seu usuário PostgreSQL
  password: sua_senha_aqui    # Sua senha PostgreSQL
  host: localhost

development:
  <<: *default
  database: movie_catalog_development

test:
  <<: *default
  database: movie_catalog_test
```

Crie e configure o banco de dados:

```bash
rails db:create
rails db:migrate
rails db:seed
```

### 4. Configure as Credenciais

#### OMDb API Key

1. Acesse: http://www.omdbapi.com/apikey.aspx
2. Escolha o plano **FREE** (1.000 requisições/dia)
3. Confirme seu email
4. Copie a API Key recebida

#### Adicione as credenciais ao Rails

```bash
EDITOR="code --wait" rails credentials:edit
```

Adicione no arquivo que abrir:

```yaml
omdb:
  api_key: SUA_API_KEY_AQUI
```

Salve e feche o arquivo.

### 5. Inicie o Servidor

```bash
rails server
```

Acesse: **http://localhost:3000**

---

## Credenciais de Teste

Após executar `rails db:seed`, você pode usar:

**Email:** teste@teste.com
**Senha:** 123456

---

## Como Usar

### Cadastrar um Filme Manualmente

1. Faça login na aplicação
2. Clique em **"Adicionar Filme"** na navbar
3. Preencha os campos:
   - Título (obrigatório)
   - Sinopse
   - Ano de lançamento
   - Duração (em minutos)
   - Diretor
   - Categorias (selecione uma ou mais)
   - Poster (imagem)
4. Clique em **"Salvar"**

**Exemplos de títulos para busca:**
- "The Godfather"
- "Pulp Fiction"
- "The Shawshank Redemption"
- "Interstellar"
- "The Dark Knight"

### Comentar em um Filme

**Sem login (anônimo):**
1. Acesse a página de detalhes do filme
2. Na seção **"Comentários"**
3. Digite seu nome
4. Digite seu comentário
5. Clique em **"Comentar"**

**Com login:**
1. Acesse a página de detalhes do filme
2. Na seção **"Comentários"**
3. Digite seu comentário (nome preenchido automaticamente)
4. Clique em **"Comentar"**

### Buscar e Filtrar Filmes

1. Acesse a página **"Filmes"**
2. Use os filtros no topo:
   - **Título:** busca parcial (ex: "Matrix")
   - **Diretor:** busca parcial (ex: "Nolan")
   - **Ano:** busca exata (ex: "2010")
   - **Categoria:** selecione no dropdown
3. Clique em **"Buscar"**
4. Para limpar filtros, clique em **"Limpar"**

---

## Segurança e Autorização

### Proteções Implementadas

- **Autenticação com Devise**
  - Senhas criptografadas (bcrypt)
  - Recuperação de senha via email
  - Sessões seguras

- **Autorização Customizada**
  - Usuários só podem editar/excluir seus próprios filmes
  - Verificação no controller antes de cada ação
  - Redirecionamento com mensagem de erro

- **Validações**
  - Validação de dados no backend (models)
  - Proteção contra SQL Injection (Active Record)
  - CSRF Protection (Rails padrão)

### Exemplo de Autorização

```ruby
# app/controllers/movies_controller.rb
def authorize_user!
  unless @movie.user == current_user
    redirect_to movies_path, alert: "Você não tem permissão para essa ação."
  end
end
```

---

## Interface e Design

### Princípios de Design

- **Responsivo:** Funciona em desktop, tablet e mobile
- **Moderno:** Interface limpa com Tailwind CSS
- **Acessível:** Contraste adequado e elementos semânticos
- **Intuitivo:** Navegação clara e feedback visual

### Componentes Principais

1. **Navbar Responsiva**
   - Desktop: menu horizontal com dropdown
   - Mobile: menu hambúrguer

2. **Cards de Filmes**
   - Poster visual
   - Informações principais
   - Hover effects

3. **Formulários**
   - Validação inline
   - Mensagens de erro claras
   - Loading states

4. **Comentários**
   - Avatar com inicial do nome
   - Timestamp relativo
   - Ordenação cronológica

---

## Deploy

### Render.com (Recomendado)

#### 1. Preparar Aplicação

Certifique-se de ter:
- Código no GitHub
- `config/credentials.yml.enc` commitado
- Variáveis de ambiente documentadas

#### 2. Criar PostgreSQL Database

1. Dashboard do Render > New > PostgreSQL
2. Nome: `movie-catalog-db`
3. Plano: Free
4. Create Database
5. Copiar **Internal Database URL**

#### 3. Criar Web Service

1. Dashboard > New > Web Service
2. Conectar repositório GitHub
3. Configurações:
   - **Runtime:** Ruby
   - **Build Command:** `./bin/render-build.sh`
   - **Start Command:** `bundle exec puma -C config/puma.rb`

#### 4. Environment Variables

Adicionar no Render:

```
DATABASE_URL=[Internal Database URL da sua DB]
RAILS_MASTER_KEY=[conteúdo de config/master.key]
SECRET_KEY_BASE=[gerar com: rails secret]
RAILS_ENV=production
RAILS_SERVE_STATIC_FILES=true
```

#### 5. Deploy

- Push para `main` → Deploy automático
- Primeira vez pode demorar 5-10 minutos
- Acompanhar logs na aba "Logs"

#### 6. Popular Banco em Produção (Opcional)

Na aba "Shell" do Render:

```bash
rails db:seed
```

---

## Melhorias Futuras

### Curto Prazo
- [ ] Implementar testes automatizados (RSpec)
- [ ] Adicionar I18n (PT-BR e EN)
- [ ] Sistema de tags
- [ ] Busca full-text (PostgreSQL)

### Médio Prazo
- [ ] Sistema de avaliações (ratings com estrelas)
- [ ] Favoritos de usuários
- [ ] Watchlist (lista de filmes para assistir)
- [ ] Notificações (novos comentários)

### Longo Prazo
- [ ] Importação CSV em massa (Sidekiq)
- [ ] API REST (JSON)
- [ ] Aplicativo mobile (React Native)
- [ ] Recomendações personalizadas (ML)

---

## Contribuindo

Contribuições são bem-vindas! Para contribuir:

1. Fork o projeto
2. Crie uma branch: `git checkout -b feature/nova-funcionalidade`
3. Commit suas mudanças: `git commit -m 'Add nova funcionalidade'`
4. Push para a branch: `git push origin feature/nova-funcionalidade`
5. Abra um Pull Request

### Padrões de Código

- Seguir [Ruby Style Guide](https://rubystyle.guide/)
- Commits em português ou inglês (consistente)
- Mensagens descritivas

---

## Licença

Este projeto foi desenvolvido como parte de um teste técnico.

---

## Autora

**Maristela**

- GitHub: [@seu-usuario](https://github.com/seu-usuario)
- LinkedIn: [Seu Nome](https://linkedin.com/in/seu-nome)
- Email: seu.email@example.com

---

<div align="center">

**Desenvolvido com ❤️ usando Ruby on Rails**

</div>
