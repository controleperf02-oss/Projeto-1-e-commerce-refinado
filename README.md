# Projeto Logístico: E-commerce Refinado (Lógico/SQL)

**Analista:** Paulo Roberto  
**Base do Projeto:** Bootcamp Klabin - Excel e Power BI Dashboards  
**Tecnologia:** MySQL Workbench  

---

## Desafio de Projeto: E-commerce Refinado (Lógico/SQL)

### 1. Descrição do Projeto
Este projeto consiste na replicação e refinamento do modelo lógico de e-commerce. Foram aplicadas definições rigorosas de Chaves Primárias (PK), Estrangeiras (FK) e Constraints para garantir a integridade referencial. O modelo atende aos refinamentos propostos no módulo de modelagem conceitual, focando na especialização de clientes, flexibilidade de pagamentos e rastreamento logístico.

### 2. Modificações Estruturais
Para os novos recursos funcionarem, as seguintes alterações foram realizadas:

*   **Tabela clientes:** Removidos campos específicos (CPF, Nomes) para a tabela `clientes_pf`, tornando-a uma tabela base de endereçamento e tipo.
*   **Tabela pedidos:** Adicionada a coluna `id_pedido_pagamento` para vincular a transação exata ao fechamento da venda.
*   **Novas Tabelas:** Inclusão de `clientes_pf`, `clientes_pj`, `pagamentos` e `entregas` para suporte às novas regras de negócio.

### 3. Script SQL (Criação e Povoamento)
O script contempla a criação de todas as 14 tabelas (incluindo as de relacionamento M:N) e a persistência de dados para testes, com registros distribuídos entre todos os perfis (clientes, fornecedores, vendedores e produtos).

---

### 4. Desafio

#### A) Requisitos Técnicos Aplicados:
1.  Recuperações simples com `SELECT Statement`
2.  Filtros com `WHERE Statement`
3.  Expressões para gerar atributos derivados
4.  Ordenações dos dados com `ORDER BY`
5.  Condições de filtros aos grupos – `HAVING Statement`
6.  Junções entre tabelas para fornecer uma perspectiva mais complexa dos dados

#### B) Queries SQL com as Cláusulas do Desafio:

*   **Relatório de Clientes PF e seus Gastos (Requisitos 1, 2, 3 e 6)**  
    *Quem são nossos clientes físicos, quanto eles pagaram de frete total e qual seria o valor do frete com um acréscimo de 10% para seguro?*
*   **Análise de Compras por Tipo de Cliente (Requisitos 4, 5 e 6)**  
    *Qual a média de frete paga por tipo de cliente (PF ou PJ), mas mostre apenas os tipos que gastaram mais de R$ 20,00 em média?*
*   **Rastreamento Logístico Detalhado (Requisitos 1, 2 e 6)**  
    *Quais produtos estão em pedidos que foram 'Extraviados' ou estão 'Em trânsito'?*
*   **Gestão de Inventário e Fornecedores (Perspectiva Complexa)**  
    *Quais produtos estão no estoque de São Paulo e quem é o seu fornecedor original?*

#### C) Queries de Perspectiva Complexa (Requisitos 1 a 6 - Adicionais):

1.  **Clientes com múltiplos pedidos:** (Usa: Join, Group By, Having e Atributo Derivado para status).
2.  **Fornecedores por categoria:** (Usa: Recuperação simples com filtro de categoria 'Eletrônico').
3.  **Análise de Extravios por Estado:** (Usa: Join entre 3 tabelas, Atributo Derivado de Localização, Group By e Having).
4.  **Ticket Médio por Tipo de Pagamento:** (Usa: Join, Group By, Order By e Atributo Derivado de Ticket Médio).
5.  **Variedade de Produtos por Vendedor:** (Usa: INNER JOIN, GROUP BY, HAVING e Atributo Derivado).
6.  **Risco de Falta de Produto:** (Usa: INNER JOIN entre 4 tabelas, Atributo Derivado (CASE WHEN), SELECT Statement e ORDER BY).

---

### 5. Diretrizes de Expansão do Esquema Lógico

O esquema foi expandido com os seguintes pontos:
*   **Cliente PJ e PF:** Uma conta pode ser PJ ou PF, mas não pode ter as duas informações.
*   **Pagamento:** Pode ter cadastrado mais de uma forma de pagamento.
*   **Entrega:** Possui status e código de rastreio.

#### Refinamentos Implementados:
*   **Especialização de Clientes:** Garantindo exclusividade mútua através da estrutura de tabelas `clientes`, `clientes_pf` e `clientes_pj`.
*   **Flexibilidade de Pagamento:** Tabela `pagamentos` vinculada ao cliente para múltiplas formas de pagamento.
*   **Rastreamento Logístico:** Tabela `entregas` com `status_entrega` e `codigo_rastreio` para monitoramento independente.

#### Queries de Negócio:
*   Quantos pedidos foram feitos por cada cliente?
*   Algum vendedor também é fornecedor?
*   Relação de produtos, fornecedores e estoques.
*   Relação de nomes dos fornecedores e nomes dos produtos.

---

### 6. Observação Final
Foi mantida a sincronia entre o modelo lógico e o físico. O esquema SQL apresentado reflete fielmente as entidades e relacionamentos modelados no diagrama EER. As Chaves Estrangeiras (FKs) e Constraints (como UNIQUE para CPF/CNPJ e ENUM para tipos de cliente) garantem que as regras de negócio definidas na modelagem conceitual sejam aplicadas rigorosamente no banco de dados real.

---

### 7. Documentação Complementar

*   **Script Principal (SQL):** Arquivo contendo toda a DDL de criação e DML de povoamento e consultas.
*   **Descrição do Projeto (TXT):** Documentação textual com o racional das decisões de negócio.
*   **Dicionário de Dados (Metadados):** Script com comentários detalhados aplicados a cada tabela.
*   **Modelo Lógico (PDF):** Diagrama visual das entidades e relacionamentos para consulta rápida.
*   **Arquivo de Projeto (MWB):** Arquivo fonte do MySQL Workbench para sincronização e edições futuras.
