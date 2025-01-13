Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920FE1C54BF
	for <damon@lists.linux.dev>; Mon, 13 Jan 2025 19:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736795264; cv=none; b=GxpIRqSCJrSaaLELEUwkPnOpEEGgPUDdsctQWcBEtlK2up6+ETL8vxCFPGYB/nwvIRgjawHv1J8l/NZnkRnjs8QGbGTU7EPMsA04ohRAtxwGUA28Lq/9HWmfOgICfabUa+GoMS8x5U4/3+U4ZOjPJQEevmiW10EIEZNpFBTrslU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736795264; c=relaxed/simple;
	bh=37UFwy3P+ZFns5IhPaA7QQkH9Gr30T4T5ZOe+WykLRI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bbjp+FSc/9G3Tt7nLfKaDozTVc6GQ2y+LqHOUFadDf5JI+FgkSOcOdkAvE+7h0xiUyQf7+vqZ3Xs7LmpEkusH2qtzRjUa/gAAmiUSiHNVwEw3seB6b91+8iLo8z6UqHj6v34H10D5X8xN63nPVTZzwBov+oermQV7Po9+MLJ2+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hzKG+yJc; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hzKG+yJc"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7b6f0afda3fso481663085a.2
        for <damon@lists.linux.dev>; Mon, 13 Jan 2025 11:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736795261; x=1737400061; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fN2r+oYRm8VKwOWlsegJ1ciPAZUowW4WF0J8VLzLcrc=;
        b=hzKG+yJcUxFZtAJgN9ZKVdl5rXqFgNAYW8Lp5OqLdUaHXqrB93+e1015elp6K6KJ/H
         MI2TwXaMDT7yhQMqK+EFGySK55ra/aK0T+aLzGRCC+Y1WlIdO2uMGE9thcr0O57F2Iy3
         w9CTDCYMe1zWmZyko3B4n95G6tRg5eEqOzgyLz9Zse9lGr9a558KSfftM3Aimg6cIPRR
         KXPQc1Dp4HEfJPOZKuVyjQ4Xn3K/PewRPqSG9w6jQ/saMG3Bm+XsUQKZukJD9h9YdmHY
         daz3GY/miqVCMqxSSokVXLi7qB2SJpHTxFm1XnorGK3mS4iMtu8PDSlio7j/7mvg2/S4
         rkmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736795261; x=1737400061;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fN2r+oYRm8VKwOWlsegJ1ciPAZUowW4WF0J8VLzLcrc=;
        b=tC1I6XstjVnyTarC6pS9Y5ZuZbvdZxPtozk7jZP+FohKLnN7hEVra9BM0iMlNpJSic
         um6LoPa5YH3YM5ITEohFuOWKuZoED5bhmzYtJYD2VqbwQ4bj96jHg0qbTnuiRJEo6SdV
         1vt1LgapY6+XeV+G7YQF8HhKhaZgVsb9k3ta/hXKVy8DeSzrsE6t3Yr1oMBKu0H4//TH
         biKYD8Op29S5o3Hxlu0AnDHtHGS5nh53C5xojneNybzBc0CVjVsOZvnTw6/cCNg3CfFK
         NALpFc+N4wHWqrfrWN+waQWpmQzHGGUv+qTcFBrWU07+2j93STY6jYE5sbD90yIwoP58
         Ekjg==
X-Gm-Message-State: AOJu0YyR5cEviTuxND9JAEC0lL7hDQNxHmlVX2weSsYqhBSyD12VQC1r
	hE/FRz9lZ31Gtrx7WJzDVROIAMmopfLRxKaN8KhGxgvAx5hx1rta
X-Gm-Gg: ASbGncvfvtcAp29E8yHeio/lUKvpEwEwcgG/fLx+uXIoy4EnEkEs4/SxFNq+ZynFI6i
	wpYQKKRFxmZP6gjrnlqW8yHrx3xZpLFnp9qWdT+3wPU1itmm5OVGYuYG9BeN8WpBnRb+1JYeqjM
	/GetIwaNToPQQiIUsu223YASTiIRDWVapnC8VMjG7y36cIJnWUKtakDNO8CFVWDgS5ANsXX4YvF
	Kglga7PrNCGEG4+BYlUbHsvsX8FbEs87kb/Fla9KY6e00N4nNJOqXc=
X-Google-Smtp-Source: AGHT+IERpp9QriM2xmQpFOewoGObdi8kvSThCUOCEi6hwWeezVQIzsdAyC4Pmdq9xZ2RVFNymG+AVA==
X-Received: by 2002:a05:6214:3289:b0:6d8:8f81:e2e3 with SMTP id 6a1803df08f44-6df9b1cf331mr369453146d6.8.1736795261383;
        Mon, 13 Jan 2025 11:07:41 -0800 (PST)
Received: from localhost ([2a03:2880:20ff:41::])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dfade892cfsm44246616d6.106.2025.01.13.11.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 11:07:41 -0800 (PST)
From: Usama Arif <usamaarif642@gmail.com>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	Usama Arif <usamaarif642@gmail.com>
Subject: [v2] mm/damon/paddr: increment pa_stat damon address range by folio size
Date: Mon, 13 Jan 2025 19:07:38 +0000
Message-ID: <20250113190738.1156381-1-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is to avoid going through all the pages in a folio.
For folio_size > PAGE_SIZE, damon_get_folio will return NULL
for tail pages, so the for loop in those instances will be a
nop. Have a more efficient loop by just incrementing the
address by folio_size.

Signed-off-by: Usama Arif <usamaarif642@gmail.com>
---
v1 -> v2 (SJ Park):
- Update commit message to change the description as an optimization
  instead of a fix.
- handle case when damon_get_folio returns NULL.
---
 mm/damon/paddr.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 6b4397de4199..bd8cfe10121b 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -504,17 +504,21 @@ static unsigned long damon_pa_stat(struct damon_region *r, struct damos *s,
 	if (!damon_pa_scheme_has_filter(s))
 		return 0;
 
-	for (addr = r->ar.start; addr < r->ar.end; addr += PAGE_SIZE) {
+	addr = r->ar.start;
+	while (addr < r->ar.end) {
 		struct folio *folio = damon_get_folio(PHYS_PFN(addr));
 
-		if (!folio)
+		if (!folio) {
+			addr += PAGE_SIZE;
 			continue;
+		}
 
 		if (damos_pa_filter_out(s, folio))
 			goto put_folio;
 		else
 			*sz_filter_passed += folio_size(folio);
 put_folio:
+		addr += folio_size(folio);
 		folio_put(folio);
 	}
 	return 0;
-- 
2.43.5

