// 悪い例: プレフィックスなし
const tools = [
  { name: "search", ... },
  { name: "update", ... },
  { name: "list", ... },
];

// 良い例: サービス + リソースの二重プレフィックス
const tools = [
  { name: "asana_projects_search", ... },
  { name: "asana_users_search", ... },
  { name: "jira_issues_search", ... },
  { name: "jira_issues_update", ... },
];
