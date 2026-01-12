---
name: library-research
description: Guide for researching latest library and framework information. Use when investigating new libraries, checking version updates, comparing alternatives, or finding best practices for specific technologies. Leverages Context7 MCP for up-to-date information.
---

# Library Research

このスキルは、最新のライブラリ・フレームワーク情報を効率的に調査する方法をガイドします。

## クイックスタート

### 基本的な調査フロー

```
調査チェックリスト:
- [ ] 1. 目的を明確化する
- [ ] 2. 候補ライブラリをリストアップ
- [ ] 3. 最新情報を収集
- [ ] 4. 比較・評価
- [ ] 5. 決定・ドキュメント化
```

## 調査の目的別ガイド

### 1. 新しいライブラリの発見

**ユースケース**:
- 「〇〇を実現するライブラリを探したい」
- 「△△の代替ライブラリを知りたい」

**調査手順**:

1. **要件の明確化**
   - 解決したい問題は何か
   - 必須機能は何か
   - 制約条件は何か（ライセンス、サイズ、依存関係など）

2. **候補のリストアップ**
   - エコシステム内の人気ライブラリ
   - GitHub Stars/Downloads数
   - コミュニティの活発さ

3. **最新情報の収集**
   - 公式ドキュメント
   - リリースノート
   - コミュニティの評判

### 2. バージョンアップデート調査

**ユースケース**:
- 「〇〇の最新バージョンを知りたい」
- 「破壊的変更があるか確認したい」

**調査手順**:

1. **現在のバージョン確認**
   ```bash
   # TypeScript/JavaScript
   npm list <package-name>
   
   # Rust
   cargo tree | grep <crate-name>
   ```

2. **最新バージョン確認**
   ```bash
   # TypeScript/JavaScript
   npm show <package-name> version
   npm show <package-name> versions
   
   # Rust
   cargo search <crate-name>
   ```

3. **変更内容の確認**
   - CHANGELOG.md
   - リリースノート
   - マイグレーションガイド

### 3. ライブラリの比較

**ユースケース**:
- 「AとBどちらを使うべきか」
- 「各ライブラリの長所・短所を知りたい」

**比較項目**:

| 項目 | 確認ポイント |
|------|------------|
| **機能** | 必要な機能を満たしているか |
| **パフォーマンス** | ベンチマーク結果、バンドルサイズ |
| **メンテナンス** | 最終更新日、Issue対応速度 |
| **コミュニティ** | GitHub Stars、ダウンロード数 |
| **ドキュメント** | 充実度、サンプルコードの質 |
| **ライセンス** | プロジェクトに適合するか |
| **依存関係** | 依存パッケージの数と質 |
| **TypeScript対応** | 型定義の品質 |

## Context7 MCPの活用

Context7 MCPを使用して、最新の情報を効率的に収集できます。

### 使用例

**TypeScript/JavaScriptライブラリの調査**:
```
「React 19の新機能について教えて」
「Vitestの最新バージョンの変更点は？」
「Next.js App Routerのベストプラクティスは？」
```

**Rustクレートの調査**:
```
「tokioの最新バージョンの変更点は？」
「axumとactix-webの比較を教えて」
「serdeの使い方のベストプラクティスは？」
```

## 情報源

### 公式リソース

#### TypeScript/JavaScript
- **npm**: パッケージ情報、ダウンロード数
- **GitHub**: ソースコード、Issue、PR
- **公式ドキュメント**: 使い方、API リファレンス

#### Rust
- **crates.io**: クレート情報、ダウンロード数
- **docs.rs**: APIドキュメント
- **GitHub**: ソースコード、Issue、PR

### コミュニティリソース

- **Stack Overflow**: 実際の使用例、問題解決
- **Reddit**: コミュニティの評判、議論
- **Dev.to/Zenn**: チュートリアル、ベストプラクティス
- **Twitter/X**: 最新トレンド、開発者の意見

## 調査結果のドキュメント化

### テンプレート

```markdown
# [ライブラリ名] 調査結果

## 基本情報

- **バージョン**: X.Y.Z
- **ライセンス**: MIT/Apache-2.0/etc
- **最終更新**: YYYY-MM-DD
- **GitHub Stars**: XXX
- **週間ダウンロード数**: XXX

## 概要

[ライブラリの簡単な説明]

## 主な機能

- 機能1
- 機能2
- 機能3

## 長所

- 長所1
- 長所2

## 短所

- 短所1
- 短所2

## 使用例

```[language]
// サンプルコード
```

## 代替ライブラリ

| ライブラリ | 特徴 | 選択理由 |
|-----------|------|---------|
| A | ... | ... |
| B | ... | ... |

## 決定

[選択したライブラリと理由]

## 参考リンク

- [公式ドキュメント](URL)
- [GitHub](URL)
- [チュートリアル](URL)
```

## ベストプラクティス

### 1. 複数の情報源を確認

単一の情報源に依存せず、複数の視点から情報を収集します。

### 2. 最新性を確認

情報の公開日を確認し、古い情報に注意します。

### 3. 実際に試す

可能であれば、小さなプロトタイプで実際に試してみます。

### 4. コミュニティの活発さを確認

- Issue/PRの対応速度
- 最終コミット日
- メンテナーの活動状況

### 5. 長期的な視点で評価

- プロジェクトの持続可能性
- バージョンアップの頻度
- 破壊的変更の頻度

## トラブルシューティング

### 情報が見つからない

1. 検索キーワードを変える
2. 英語で検索する
3. GitHubのIssue/Discussionsを確認
4. コミュニティフォーラムで質問

### 情報が古い

1. 公式ドキュメントの最新版を確認
2. GitHubのmainブランチを確認
3. リリースノートを確認

### 比較が難しい

1. 比較項目を明確にする
2. 実際のユースケースで評価
3. コミュニティの意見を参考にする

## 関連Skill

- **testing-typescript**: [testing-typescript](../testing-typescript/SKILL.md) - TypeScriptテストライブラリの選択
- **testing-rust**: [testing-rust](../testing-rust/SKILL.md) - Rustテストクレートの選択
- **ci-cd-setup**: [ci-cd-setup](../ci-cd-setup/SKILL.md) - CI/CDツールの選択

## 参考リソース

- [npm trends](https://npmtrends.com/) - npmパッケージの比較
- [bundlephobia](https://bundlephobia.com/) - JavaScriptバンドルサイズ確認
- [lib.rs](https://lib.rs/) - Rustクレートの検索・比較
- [State of JS](https://stateofjs.com/) - JavaScriptエコシステムのトレンド
- [State of Rust](https://blog.rust-lang.org/) - Rustエコシステムのトレンド
