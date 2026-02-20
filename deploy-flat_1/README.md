# 🎯 Digital Ace — TikTok Growth Tracker

Dashboard compartilhado para acompanhar o crescimento das contas TikTok da Digital Ace.

**Stack:** HTML estático + Supabase (banco de dados) + Vercel (hospedagem)  
**Custo:** 100% gratuito nos tiers free  
**Tempo de setup:** ~15 minutos

---

## 📋 Passo a Passo para Deploy

### PASSO 1: Criar conta no Supabase (banco de dados)

1. Acesse **https://supabase.com** e crie uma conta (pode usar Google login)
2. Clique em **"New Project"**
3. Preencha:
   - **Name:** `digital-ace-tracker`
   - **Database Password:** escolha uma senha forte (guarde ela!)
   - **Region:** escolha a mais perto de você (ex: South America / São Paulo)
4. Aguarde o projeto ser criado (~2 minutos)

### PASSO 2: Criar as tabelas no Supabase

1. No painel do Supabase, vá em **SQL Editor** (ícone no menu lateral)
2. Clique em **"New query"**
3. Copie e cole TODO o conteúdo do arquivo `supabase-schema.sql`
4. Clique em **"Run"** (ou Ctrl+Enter)
5. Deve aparecer "Success" — todas as tabelas e dados iniciais foram criados

### PASSO 3: Pegar as credenciais do Supabase

1. No painel do Supabase, vá em **Settings** → **API**
2. Copie estes dois valores:
   - **Project URL** (parece com: `https://xyzxyz.supabase.co`)
   - **anon public key** (uma string longa que começa com `eyJ...`)

### PASSO 4: Configurar o dashboard

1. Abra o arquivo `public/index.html` em qualquer editor de texto
2. Procure estas duas linhas (perto do final do arquivo, no `<script>`):

```javascript
const SUPABASE_URL = 'YOUR_SUPABASE_URL';
const SUPABASE_ANON_KEY = 'YOUR_SUPABASE_ANON_KEY';
```

3. Substitua pelos seus valores:

```javascript
const SUPABASE_URL = 'https://xyzxyz.supabase.co';
const SUPABASE_ANON_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6...';
```

4. Salve o arquivo

### PASSO 5: Deploy na Vercel (hospedagem)

**Opção A — Via GitHub (recomendado):**

1. Crie uma conta no GitHub (https://github.com) se não tiver
2. Crie um novo repositório e suba a pasta `digital-ace-tracker`
3. Acesse **https://vercel.com** e faça login com GitHub
4. Clique em **"Add New" → "Project"**
5. Selecione o repositório `digital-ace-tracker`
6. Em "Framework Preset" selecione **"Other"**
7. Em "Output Directory" coloque **`public`**
8. Clique em **"Deploy"**
9. Pronto! Você vai receber uma URL tipo `digital-ace-tracker.vercel.app`

**Opção B — Via CLI (terminal):**

```bash
# Instale a CLI da Vercel (precisa de Node.js)
npm install -g vercel

# Na pasta do projeto
cd digital-ace-tracker
vercel

# Siga as instruções — ele vai perguntar:
# - Link to existing project? No
# - Project name? digital-ace-tracker
# - Directory? ./
# - Override settings? No
```

### PASSO 6: Compartilhar com a equipe

Depois do deploy, envie o link para sua equipe. Exemplo:
```
https://digital-ace-tracker.vercel.app
```

Qualquer pessoa com o link pode:
- ✅ Ver todos os dados
- ✅ Adicionar dados diários
- ✅ Registrar vídeos
- ✅ Criar contas e países
- ✅ Importar planilhas Excel
- ✅ Exportar CSV

As alterações aparecem em **tempo real** para todos os usuários conectados.

---

## 🔧 Funcionalidades

| Feature | Descrição |
|---------|-----------|
| 📊 Dashboard | Visão geral com gráficos e stats por país |
| 📅 Calendário | Grid estilo planilha com edição inline |
| 🌡️ Heatmap | Visualização de intensidade de followers |
| 🎬 Vídeos | Registro de postagens com nicho e horário |
| 🔄 Nicho | Tracking de mudanças de nicho por conta |
| 📥 Import | Importar dados via .xlsx ou .csv |
| 📊 Export | Exportar tudo como CSV |
| 🌍 Países | Adicionar países dinamicamente |
| 🌙☀️ Tema | Dark mode e Light mode |
| ⚡ Realtime | Atualizações ao vivo via Supabase |

---

## 📁 Estrutura do Projeto

```
digital-ace-tracker/
├── public/
│   └── index.html          ← Dashboard completo (HTML único)
├── supabase-schema.sql     ← SQL para criar tabelas
├── vercel.json             ← Config do Vercel
├── package.json
└── README.md               ← Este arquivo
```

---

## 📊 Formato do Excel para Importação

O arquivo deve ter este formato:

| País | Conta | 2026-02-19 | 2026-02-20 | ... |
|------|-------|------------|------------|-----|
| US   | 96    | 1381       | 1420       | ... |
| UK   | 83    | 0          | 15         | ... |

- **Coluna 1:** Código do país (US, UK, IND, PHI, etc.)
- **Coluna 2:** ID da conta
- **Colunas 3+:** Datas (formato YYYY-MM-DD) com valores de followers

---

## ⚠️ Notas Importantes

- **Dados ficam no Supabase** — mesmo se limpar cache do navegador, os dados estão seguros no banco
- **Sem login** — qualquer pessoa com o link pode editar. Se quiser adicionar autenticação depois, é possível via Supabase Auth
- **Gratuito** — Supabase Free Tier: 500MB de banco + 50K requests/mês. Vercel Free: ilimitado para sites estáticos
- **Fallback local** — se o Supabase ficar offline, o dashboard funciona com localStorage automaticamente
- **Backup** — Use o botão "Export" regularmente para ter um CSV de backup

---

## 🆘 Troubleshooting

**"Bolinha verde no header está vermelha"**  
→ Verifique se as credenciais do Supabase estão corretas no `index.html`

**"Dados não aparecem para outros usuários"**  
→ Confirme que o SQL schema foi executado corretamente no Supabase SQL Editor

**"Erro ao importar Excel"**  
→ Verifique se o formato segue o padrão: País, Conta, Datas...

**"Quero adicionar autenticação depois"**  
→ Supabase Auth permite login via email/senha, Google, GitHub. Me pergunte e eu implemento.
