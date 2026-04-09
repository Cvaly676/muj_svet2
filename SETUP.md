# 🌿 Můj Svět — Kompletní návod na spuštění

Tento návod vás provede od nuly ke spuštěnému webu s databází.
Žádné programování není potřeba — jen pár kliknutí.

---

## 📁 Soubory v tomto projektu

| Soubor | Popis |
|---|---|
| `index.html` | Hlavní web pro zákazníky |
| `admin.html` | Panel pro majitele — přidávání/mazání jídel |
| `schema.sql` | SQL příkazy pro vytvoření databáze |
| `SETUP.md` | Tento návod |

---

## KROK 1 — Vytvořte Supabase projekt (zdarma)

1. Jděte na **https://supabase.com** a klikněte **Start your project**
2. Přihlaste se přes GitHub nebo e-mail
3. Klikněte **New project**
4. Vyplňte:
   - **Name:** `mujsvet` (nebo cokoliv)
   - **Database Password:** vymyslete silné heslo a **uložte si ho**
   - **Region:** `Central EU (Frankfurt)` — nejblíže ČR
5. Klikněte **Create new project** a počkejte ~2 minuty

---

## KROK 2 — Vytvořte databázovou tabulku

1. V Supabase dashboardu klikněte vlevo na **SQL Editor**
2. Klikněte **New query**
3. Zkopírujte celý obsah souboru `schema.sql` a vložte ho do editoru
4. Klikněte **Run** (zelené tlačítko)
5. Dole se zobrazí `Success. No rows returned` — to je správně ✅

---

## KROK 3 — Získejte přístupové klíče

1. V Supabase dashboardu klikněte vlevo na **Project Settings** (ozubené kolečko)
2. Klikněte na záložku **API**
3. Zkopírujte si tyto dvě hodnoty:
   - **Project URL** — vypadá jako `https://xyzabcdef.supabase.co`
   - **anon / public** klíč — dlouhý řetězec znaků začínající `eyJ...`

> ⚠️ **DŮLEŽITÉ:** `anon` klíč je veřejný — to je v pořádku, může být v HTML.
> `service_role` klíč NIKDY nedávejte do HTML souborů!

---

## KROK 4 — Vložte klíče do souborů

### V souboru `index.html`:
Najděte tyto dva řádky (jsou poblíž konce souboru ve `<script>` sekci):
```
const SUPABASE_URL      = 'VASE_SUPABASE_URL';
const SUPABASE_ANON_KEY = 'VASE_SUPABASE_ANON_KEY';
```
Nahraďte je svými hodnotami, například:
```
const SUPABASE_URL      = 'https://xyzabcdef.supabase.co';
const SUPABASE_ANON_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...';
```

### V souboru `admin.html`:
Najděte stejné dva řádky a vyplňte stejné hodnoty.

---

## KROK 5 — Vytvořte účet pro majitele (admin přihlášení)

1. V Supabase dashboardu klikněte vlevo na **Authentication**
2. Klikněte na záložku **Users**
3. Klikněte **Invite user** (nebo **Add user → Create new user**)
4. Zadejte e-mail majitele (např. `majitel@mujsvet.cz`) a heslo
5. Klikněte **Create user** ✅

> Toto je e-mail a heslo, kterým se majitel přihlásí do `admin.html`.
> Heslo lze kdykoliv změnit znovu v Authentication → Users.

---

## KROK 6 — Nahrajte na GitHub Pages

### 6a. Vytvořte GitHub repozitář
1. Jděte na **https://github.com** a přihlaste se (nebo se zaregistrujte)
2. Klikněte na **+** → **New repository**
3. Nastavte:
   - **Repository name:** `mujsvet-web`
   - **Visibility:** `Private` ✅ (doporučeno)
4. Klikněte **Create repository**

### 6b. Nahrajte soubory
1. Na stránce repozitáře klikněte **Add file → Upload files**
2. Přetáhněte všechny 4 soubory: `index.html`, `admin.html`, `schema.sql`, `SETUP.md`
3. Dole napište zprávu např. `První verze webu`
4. Klikněte **Commit changes**

### 6c. Zapněte GitHub Pages
1. Klikněte na záložku **Settings** (v repozitáři)
2. V levém menu klikněte **Pages**
3. Pod **Source** vyberte **Deploy from a branch**
4. Vyberte `main` branch a `/ (root)` složku
5. Klikněte **Save**
6. Počkejte 1–2 minuty

### 6d. Vaše adresy budou:
- **Web pro zákazníky:** `https://vaseuzivatelskejmeno.github.io/mujsvet-web/`
- **Admin panel:** `https://vaseuzivatelskejmeno.github.io/mujsvet-web/admin.html`

---

## KROK 7 — Otestujte

1. Otevřete `admin.html` → přihlaste se vaším e-mailem a heslem z Kroku 5
2. Přidejte testovací jídlo (např. Pondělí, Polévka, "Testovací polévka", 59 Kč)
3. Otevřete `index.html` → přejděte do sekce **Denní menu**
4. Jídlo by se mělo zobrazit ✅

---

## 🔒 Bezpečnost — jak to funguje

| Co | Jak je chráněno |
|---|---|
| Přidávání jídel | Jen přihlášený uživatel (Supabase Auth JWT token) |
| Mazání jídel | Jen přihlášený uživatel |
| Čtení jídel | Veřejné — zákazníci nemusí být přihlášeni |
| Admin heslo | Uloženo v Supabase, nikdy v HTML souboru |
| Databáze | Row Level Security (RLS) — neautorizovaný zápis odmítnut na úrovni DB |
| API klíč | `anon` klíč je veřejný záměrně — může jen číst (RLS to zajišťuje) |

---

## ❓ Časté problémy

**"Supabase není nakonfigurováno"** → Nevyplnili jste klíče v Kroku 4.

**"Chyba přihlášení"** → Zkontrolujte e-mail a heslo v Authentication → Users.

**Jídla se nezobrazují na webu** → Zkontrolujte, zda jste spustili `schema.sql` (Krok 2) a zda jsou klíče správně vyplněny v `index.html`.

**"permission denied"** → RLS politiky nebyly vytvořeny — spusťte `schema.sql` znovu.

---

## 📱 Jak přidat nové jídlo (pro majitele — každý týden)

1. Otevřete `admin.html` ve vašem prohlížeči
2. Přihlaste se
3. Vyberte den, kategorii, napište název a cenu
4. Klikněte **Přidat jídlo**
5. Jídlo se okamžitě zobrazí na webu zákazníkům ✅

Na konci týdne:
- Klikněte **Smazat celý týden** → potvrďte → přidejte nová jídla

---

*Vytvořeno pro Můj Svět Restaurant & Coffee, Kopřivnice*
