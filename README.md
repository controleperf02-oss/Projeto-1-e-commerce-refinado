# Projeto Logístico: E-commerce Refinado (Lógico/SQL)

**Analista:** Paulo Roberto  
**Base do Projeto:** Bootcamp Klabin - Excel e Power BI Dashboards  
**Tecnologia:** MySQL Workbench

---

## 🚀 Descrição do Projeto
Este projeto consiste na replicação e refinamento do modelo lógico de e-commerce. Foram aplicadas definições rigorosas de Chaves Primárias (PK), Estrangeiras (FK) e Constraints para garantir a integridade referencial. O modelo foca na especialização de clientes (PF/PJ), flexibilidade de pagamentos e rastreamento logístico detalhado.

## 🛠️ Modificações Estruturais
Para os novos recursos funcionarem, as seguintes alterações foram realizadas:
*   **Tabela clientes:** Removidos campos específicos para a tabela `clientes_pf`, tornando-a uma tabela base de endereçamento e tipo.
*   **Tabela pedidos:** Adicionada a coluna `id_pedido_pagamento` para vincular a transação ao método de pagamento escolhido.
*   **Novas Tabelas:** Inclusão de `clientes_pf`, `clientes_pj`, `pagamentos` e `entregas` para suporte às novas regras de negócio.

---

## 📊 Desafio e Queries SQL
As queries foram desenvolvidas utilizando os requisitos técnicos: `SELECT`, `WHERE`, Atributos Derivados, `ORDER BY`, `HAVING` e `JOINs` complexos.

### Perguntas de Negócio Respondidas:
1. **Clientes PF e Gastos:** Identificação de clientes físicos e cálculo de frete com 10% de seguro.
2. **Compras por Tipo:** Média de frete por categoria (PF/PJ) com filtro de grupo.
3. **Rastreamento Logístico:** Status de produtos extraviados ou em trânsito.
4. **Gestão de Inventário:** Localização de produtos e seus fornecedores originais.
5. **Fidelidade:** Identificação de clientes com mais de 1 pedido e categorização VIP.
6. **Risco de Estoque:** Alerta de abastecimento baseado na quantidade disponível.

---

## 🏗️ Refinamentos Implementados
Conforme as diretrizes do desafio, o esquema lógico foi expandido:
*   **Cliente PJ e PF:** Especialização que garante que uma conta seja exclusivamente um ou outro.
*   **Pagamento:** Possibilidade de múltiplos métodos de pagamento por cliente.
*   **Entrega:** Controle logístico independente com status e código de rastreio.

---

## 📑 Documentação Complementar
Acesse os artefatos do projeto através dos links abaixo:

*   📜 **[Script Principal (SQL)](./SCRIPTS/Projeto_1_e_commerce_refinado.sql):** Criação, povoamento e consultas.
*   📖 **[Descrição do Projeto (TXT)](./DOCS/Projeto_1_e_commerce_refinado.txt):** Racional das decisões de negócio.
*   🗂️ **[Dicionário de Dados (Metadados)](./SCRIPTS/Metadados_e_Documentacao_Projeto_1_e_commerce_refinado.sql):** Comentários técnicos das tabelas.
*   🎨 **[Modelo Lógico (PDF)](./DOCS/Modelo_Logico_Ecommerce_Refinado_Projeto-1.pdf):** Diagrama visual (EER).
*   💾 **[Arquivo de Projeto (MWB)](./MODELO/Modelo_Logico_Ecommerce_Refinado_Projeto-1.mwb):** Arquivo fonte do MySQL Workbench.

---

## ✅ Observação Final
Foi mantida a sincronia entre o modelo lógico e o físico. O esquema SQL apresentado reflete fielmente as entidades e relacionamentos modelados no diagrama EER. As Chaves Estrangeiras (FKs) e Constraints garantem que as regras de negócio sejam aplicadas rigorosamente no banco de dados real.

---
### 🖼️ Visualização de Metadados
![Metadados](./DOCS/Metadados_e_Documentacao_Projeto_1_e_commerce_refinado.png)
