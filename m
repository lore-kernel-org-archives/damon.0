Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E972EB661
	for <damon@lists.linux.dev>; Sun,  3 Aug 2025 13:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754226071; cv=none; b=Na5ZNAK2BXJ/rKovt6TCAN32HyVM5UbdMDuzEZ5fA30c5NnXtHngwpb5Y+jMejdvGDqCn6Fpi3nnx22XWVhME58wbpgMLX4nqf+7alslJZsM7yTBVGrBq9JwmQKRLERoingf+8PyqJ8pqMMndCVQDlGQlMPliARThwbK/8cbtCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754226071; c=relaxed/simple;
	bh=VpPSBWXAR6JbA7YILVj/+0K0OZeWPu0+C87HDnj+10Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Jxms0fc9CgTk1NGfCw9T3XL96aIMAyhwiAhq73/hxu3B9jtpS5bwsR/GVe4Ge4BRus6wUR/D9DrXsdWutwne7v1nH3gxA/TzpKVl3jHJ67DeejuvCSQrqd3C+5mLIvOZAHqzluoZgz7pBUZZV/S5ql+uxruYWHX1LixD0P5JsL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bqReQXZV; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bqReQXZV"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-76bd041c431so2861902b3a.2
        for <damon@lists.linux.dev>; Sun, 03 Aug 2025 06:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754226069; x=1754830869; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t4BPNVqFZfC6kbftm/OhzO8uiYlQiZCB4SdUhBKV4x4=;
        b=bqReQXZVrBzUtnrqIoPQsZsAMw1ofHIN7VLCaf8+q3/RZRSI+u9UJUy8ZXu+FTfrcu
         Hfj6rNPEMpq/ki5AlUYJAKXS/0K7vKIl1ImaihCrVYkYXLRTSVksayfH+0rmiyOjF1DI
         z8LW9xrqrgyu21pqTHGadprxcFz/Bfg/iSJ/izKIVO8nMei2FLkK3ybJe7anCQKEXR8Q
         yvrbVi9Ccy37kFEDTmyN4mUrkhCB2jKCurzWzBXiprksBW7JsycsFgIcxiCBuYAClUIg
         3Gro7ypLnNGWOJkLg1a8mP2Zf9QmLONGf144e7f4zZesg51AOcayq3CXpEyLK3wkUkUH
         mvjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754226069; x=1754830869;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t4BPNVqFZfC6kbftm/OhzO8uiYlQiZCB4SdUhBKV4x4=;
        b=XKGVvyDjvzOjmswcxayjB2rj2fvCvzPGCYiRyRwQYVzWD0/SEM1wx9VzdC/KhwIuJ2
         bmCT4CRGoeCzvgccoOI/7mvBrWUTY6XZ9G8mABlzP0xE7sd6j3LKPUJtgiJJR3BIcu2R
         rQIVlMQusxL7i2p3dkuOotGqQ2/NIeji4Wh1MgnB60LuDMJLY3R3M7lOLaHF5Hvlj5Ix
         WtuhcAhBL3hmiWdy8Gv8KvJBBFwI6PlsDiRvWUoTgULAOkTSUjxB2/xsOd/46Fmc9F6P
         B+oq8j/P2IW4L4lMAWkDErsxkdN8yK/w/uYhpyvvytXooZSsPHNmOYxGHOF3XvpeKjG7
         Vyjw==
X-Gm-Message-State: AOJu0YynF8HAhfBVGdytF+INW0HOZi/JCATH7HS8zR7nc6WVHGQCVLUk
	Xz6m3HJqrQjQtRE8tYBFoPZVilIJz/rewvcKJ2iyVo9wpLf1jyNkFujuJhtwEQ==
X-Gm-Gg: ASbGnctL8xz56MNDEg2kORIf0zOwp4/BMG+2Kf6M5XkfNuD17+s4IlM6y0TKf3PCE69
	pPaC7MCINs7VAruT+JtaNgukxofrfRaQwiayDRnyQg8ajlKoNwQrGTpfVqB5gtd8AWxJRjB4RLt
	q5U2VoAOo+PPNt5FhpomcY4y28k5H49Y7eNjFzkDIyq6F+PfJYyv+9esfmRbj+u9p7IL5YZZbeS
	iTK5RLKGSQwZ+WYC01dx/DJuBCu/seovHu0bR0HlIgl1U2DH9a8Y8xIxgIbzBx3678+RPqDDXQE
	peOkdyvcvHX+LLD72ifkR5bmHzDSGNu2arjDvGsVVJV4gnIuAXO/X/zIrlq55wWq7Irg9M5ahUO
	bCVaTC9tJuHbynYdGdHsD3/TeU885wVQX9lG5Ag==
X-Google-Smtp-Source: AGHT+IFLppEtHRB2Jd0UXLE7DxZwnpuwQ65IQqAT0LT8ZzQzjkkqX0BRx28f+M1C7o7YBQMHk+PyVw==
X-Received: by 2002:a05:6a20:728f:b0:23d:e9e2:6c0f with SMTP id adf61e73a8af0-23df90fab06mr11323762637.31.1754226067133;
        Sun, 03 Aug 2025 06:01:07 -0700 (PDT)
Received: from localhost.localdomain ([240f:34:212d:1:4c17:452e:3df8:7bde])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422babfbbdsm7286906a12.35.2025.08.03.06.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Aug 2025 06:01:06 -0700 (PDT)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: damon@lists.linux.dev
Cc: akinobu.mita@gmail.com,
	SeongJae Park <sj@kernel.org>,
	Bijan Tabatabai <bijantabatab@micron.com>
Subject: [PATCH] mm/damon/vaddr: avoid unnecessary migration between target nodes
Date: Sun,  3 Aug 2025 22:00:28 +0900
Message-Id: <20250803130028.162537-1-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change avoids unnecessary migration by checking if the folio to which
the migration is applied is already located in one of the target nodes.

Cc: SeongJae Park <sj@kernel.org>
Cc: Bijan Tabatabai <bijantabatab@micron.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
 mm/damon/vaddr.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 87e825349bdf..d531763a3b2b 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -665,6 +665,7 @@ static bool damos_va_filter_out(struct damos *scheme, struct folio *folio,
 struct damos_va_migrate_private {
 	struct list_head *migration_lists;
 	struct damos *scheme;
+	nodemask_t dest_nodes;
 };
 
 /*
@@ -747,6 +748,8 @@ static int damos_va_migrate_pmd_entry(pmd_t *pmd, unsigned long addr,
 	if (!folio)
 		goto unlock;
 
+	if (node_isset(folio_nid(folio), priv->dest_nodes))
+		goto put_folio;
 	if (damos_va_filter_out(s, folio, walk->vma, addr, NULL, pmd))
 		goto put_folio;
 
@@ -781,6 +784,8 @@ static int damos_va_migrate_pte_entry(pte_t *pte, unsigned long addr,
 	if (!folio)
 		return 0;
 
+	if (node_isset(folio_nid(folio), priv->dest_nodes))
+		goto put_folio;
 	if (damos_va_filter_out(s, folio, walk->vma, addr, pte, NULL))
 		goto put_folio;
 
@@ -865,10 +870,13 @@ static unsigned long damos_va_migrate(struct damon_target *target,
 		sizeof(*priv.migration_lists), GFP_KERNEL);
 	if (!priv.migration_lists)
 		return 0;
+	priv.dest_nodes = NODE_MASK_NONE;
 
-	for (int i = 0; i < nr_dests; i++)
+	for (int i = 0; i < nr_dests; i++) {
 		INIT_LIST_HEAD(&priv.migration_lists[i]);
-
+		node_set(use_target_nid ? s->target_nid : dests->node_id_arr[i],
+				priv.dest_nodes);
+	}
 
 	mm = damon_get_mm(target);
 	if (!mm)
-- 
2.34.1

