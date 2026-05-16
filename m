Received: from mail-yw1-f196.google.com (mail-yw1-f196.google.com [209.85.128.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8679637BE9E
	for <damon@lists.linux.dev>; Sat, 16 May 2026 21:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778965456; cv=none; b=HEECh1ar3miURMKvP7RFO2VzGewg8lCSXuZy6PB1W9a+jABqyalSgEESeT1YyCFAbfRcfpizp3SaSR03YnvX5i/BsDWn91vA4XdBorcBKV0sS8Jt+Ch3vVNKFOBFHUpq3ZtH9Mgq0HoE0zmAiL5xGlBV59VTa9Ygv38Z7Q+pQP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778965456; c=relaxed/simple;
	bh=suVlmThmLOSeu54xK5SymaNpAeUN5cZJpWPOhRRKbjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VmIFqYSA3I+wsKCi+rfzhPuusCu33y0OHpRav7qZGGDBlXd8q5L9zvKC6ZspAgPROGEdojZyo9hjLL1KTN+sJdGjlF7W03CeghwZBJzlkis3pjbCTUiVWIHvlCKkOnaOivp2ZPIUhMiYqvP7j+chKobMAlG/gal7uZ+WePOEkns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cLhVKDTX; arc=none smtp.client-ip=209.85.128.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cLhVKDTX"
Received: by mail-yw1-f196.google.com with SMTP id 00721157ae682-7bd810cdc5dso4586407b3.1
        for <damon@lists.linux.dev>; Sat, 16 May 2026 14:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778965453; x=1779570253; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fGoieryUDtogh5w/DQ0mDHeFWPd+g3z7hodtgl9YwHU=;
        b=cLhVKDTXtdmk1pbTj9ClTnTnxbwqFbjfdvcyrwFdW+M5zE1wdpRsbzMuviX9k7wfhK
         jc9N3AaZWbYkCB4u0xZ/TV7x+s6egKhuYvhsEaO9SMPjFT7edpP0meuQJtT+39BB0lxh
         Uu7dvz/IRfoDelBWqz7m9/dnF98yZeF16XBNbGsVTiFnMAkTFkcP5d73PGYM7r0Rpd3A
         PeJS/+XVanWFIZF9SVCPpjj0+XrWnWM4TxGE2fFQpebwoj34lSAUGGsL9B952n9Rph41
         fBtt38ycR/HB9HOK4wPWomtkwCXHZOO664MJIJ52kNB2QKaAPRvkkxHdsnPhLI+LMWnc
         tTUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778965453; x=1779570253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fGoieryUDtogh5w/DQ0mDHeFWPd+g3z7hodtgl9YwHU=;
        b=T2FVZ2z/AIISFleSQpSSDkh42gXa5/jjglk/Qgg/1NRyB95nf+LLKIagqLjQa6Dlje
         9hqnHhM6sJl1ybdp+yg9hMTUwbu344kAP9nq9p3DTSQ7VO0k7QxCCNrvDb0CudFvgfnz
         XUFNRbZtTyInC6VIC6y9FiF81Jvhg0l4Y00SDRQqq1yiIAr90oNbikZwCuYranPJgjkB
         ZTZOwWmUizDmWe6vvxBQIlHcBtwE5iHHLcWgarxf3RwWQzhOoyGXUt94hGTtx8W19Wtg
         qFWPk0dla4wvwf2ea3XPAewgYCNPrs4KyvL1T4kJsujfIERi5nECig98eolij6zIkQi7
         kRtA==
X-Forwarded-Encrypted: i=1; AFNElJ8xKOs5sEWlJEUrbhIfftcxaNLm6pqRhxUsBWsMmmkUozPmNcug5/2I51cByowXYf//QV2q0Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw/cQ9dxTq1+ocLupksOpeempPF0F5Fu+tM+JOrgysKc9jL7TzC
	lslraUAi46NWjC1wwGIrBZHYqrniks/m+WvYodzTKWA75fZz9YXFpG8=
X-Gm-Gg: Acq92OHLj18kjZvrwkFBK9WvyQiCWdVx7aXPRD+iqAhjqd8dPAq3eeqJu/By4l7bUoM
	LOaIUe6qBmAbBcYncrQEUVHGD4ltYU43qSN6sjT053LpwF0JJ3w+n806SwGJeWdMqyOuVeye6IE
	YrelDBwlrLOQEftYYFFrej2PSOcBe2yw93ICY5mLselCp8inDojmorAbCcb/FVN9LmTe/F1Mdlj
	KN5Pu0ii4Cgt5qLIdLa3IUrB1GW0hca+GnFceJGoT0PYMaCvX3wkQ4G5IzKHLXg7N7rrX1iGRYU
	V3/4NXlW5qScehBuxkFYIXV8aFZ1vWUv1nvSH50uDFxlMVfOOHKpCqWSAZkiAnoxnznIrd+2na8
	eCqYP2sauZwYlp+9nJBJdZbiBy/O4AbOmQ5aIRUZqOf09LX4ij7OGDvm/0MwYwBM+4BIwQVC6J2
	KcQ+fxvs8CzlT6esxC5+PIH1sW8Ak+Z5oY7t2gy942EDK2DTfdRIoKOf3uP1xLWgxCGo0owa9bY
	Q==
X-Received: by 2002:a05:690c:e4d7:b0:7a0:4146:6eda with SMTP id 00721157ae682-7c959b8ebabmr94328007b3.20.1778965452710;
        Sat, 16 May 2026 14:04:12 -0700 (PDT)
Received: from localhost (23-116-43-216.lightspeed.sntcca.sbcglobal.net. [23.116.43.216])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7c7f55bca95sm47468617b3.39.2026.05.16.14.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 14:04:11 -0700 (PDT)
From: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
To: sj@kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: akpm@linux-foundation.org,
	corbet@lwn.net,
	bijan311@gmail.com,
	ajayjoshi@micron.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com,
	ravis.opensrc@gmail.com
Subject: [RFC PATCH 5/5] mm/damon/paddr: add time budget to migration page walk
Date: Sat, 16 May 2026 14:03:57 -0700
Message-ID: <20260516210357.2247-6-ravis.opensrc@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260516210357.2247-1-ravis.opensrc@gmail.com>
References: <20260516210357.2247-1-ravis.opensrc@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On populated physical address ranges the pageblock skip optimization
alone is insufficient — most pageblocks contain at least one allocated
page, so the walk still iterates millions of PFNs.

Add a 100ms wall-clock time budget to damon_pa_migrate().  Once the
deadline is reached, the walk breaks out and migrates whatever folios
have been collected so far.

The time check is amortized by only calling ktime_get() every 4096
pages (~16MB of address space), adding negligible overhead to the
fast path.

Signed-off-by: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
---
 mm/damon/paddr.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index e844c990987b9..a2565287bc10f 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -14,6 +14,7 @@
 #include <linux/swap.h>
 #include <linux/memory-tiers.h>
 #include <linux/mm_inline.h>
+#include <linux/ktime.h>
 
 #include "../internal.h"
 #include "ops-common.h"
@@ -254,6 +255,14 @@ static unsigned long damon_pa_deactivate_pages(struct damon_region *r,
 	return damon_pa_de_activate(r, addr_unit, s, false, sz_filter_passed);
 }
 
+/* Maximum wall-clock time to spend in a single migration walk (ns) */
+#define DAMON_PA_MIGRATE_BUDGET_NS	(100 * NSEC_PER_MSEC)
+
+/* Check the time budget every 4096 pages (~16MB) to amortize ktime_get(). */
+#define DAMON_PA_MIGRATE_TIME_CHECK_PAGES	4096
+#define DAMON_PA_MIGRATE_TIME_CHECK_MASK	\
+	(DAMON_PA_MIGRATE_TIME_CHECK_PAGES - 1)
+
 static unsigned long damon_pa_migrate(struct damon_region *r,
 		unsigned long addr_unit, struct damos *s,
 		unsigned long *sz_filter_passed)
@@ -262,6 +271,7 @@ static unsigned long damon_pa_migrate(struct damon_region *r,
 	LIST_HEAD(folio_list);
 	struct folio *folio = NULL;
 	unsigned long pfn;
+	ktime_t deadline = ktime_add_ns(ktime_get(), DAMON_PA_MIGRATE_BUDGET_NS);
 
 	addr = damon_pa_phys_addr(r->ar.start, addr_unit);
 	end = damon_pa_phys_addr(r->ar.end, addr_unit);
@@ -283,6 +293,11 @@ static unsigned long damon_pa_migrate(struct damon_region *r,
 			}
 		}
 
+		/* Time budget: keep kdamond responsive on long migration walks. */
+		if (!(pfn & DAMON_PA_MIGRATE_TIME_CHECK_MASK) &&
+		    ktime_after(ktime_get(), deadline))
+			break;
+
 		folio = damon_get_folio(pfn);
 		if (damon_pa_invalid_damos_folio(folio, s)) {
 			addr += PAGE_SIZE;
-- 
2.43.0

