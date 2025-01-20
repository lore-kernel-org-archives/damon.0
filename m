Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611A6192B75
	for <damon@lists.linux.dev>; Mon, 20 Jan 2025 18:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737397208; cv=none; b=hNKo01nqHSP39k05ACmQ0KunU9N86fr8W89MSarwQsk1bqQvxxnotAq2pFPWl530Fhz+KzhcB7rav7stDmKqWT79PLWGy05Dd6FS8emWQeGxrO2ThD3Hx5KvdbEmqMKtaOWNLJizoxPdNjnjkp1Z4B21tYYzbxU8fmxVe17ORD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737397208; c=relaxed/simple;
	bh=d7TaFEGDnn8X7aIB23xz8k2GdsBtSwW7hHqYua6bdF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HgISmMvIyz3XVY5dtyPOTRP3jJYrMhvo/syI7MinCBhtvvgwqam25/17eHAxzExTJ/vWpSfK4OU8XSqbMCxIoF11wGMWXoYTQEv0KgPUQmrBtPl1ImMbcMXlU1vl3zBJEtr6t7LaUP1s5t3Uaw2Qc5R0l4TyCjbuImY1V44zoog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JIxfDhkv; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JIxfDhkv"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6d8edad9932so36391116d6.0
        for <damon@lists.linux.dev>; Mon, 20 Jan 2025 10:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737397206; x=1738002006; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1M4q3OzaFWK9ln4L3PJAAcFbjl3Cez+v0LDvBWtRTqI=;
        b=JIxfDhkvZdb875Bgi63GZhnE6cXBnRMA2LRGouqh5b3QbAcEgcn8/LHa+Ya4wcy8Ii
         dc0Lj7ARq975H0J0DE8Ex3WpDDOMf2jVEVYYII7eA+QvBu1EWzhK49zVrrmpAs6dmdon
         O8Uqsh+vA2WU3tpnwX1cwZH2uNXhAwjYPA4X9xNDSrNzuOHyjuOcNxQTppPnUWVtHs9t
         88jAfah6lLjOnPw4Uo9k37YABum9kqobytf+gu9sdCalpfFkliYjgW5iWxzgqZc2aNzu
         4ykwsxdZhAvhgp5hLQQACTsuNp1AHo9+ZDjMpwUzBqCPR7YG3P1HyBGDtgqz4HRcPraJ
         RqGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737397206; x=1738002006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1M4q3OzaFWK9ln4L3PJAAcFbjl3Cez+v0LDvBWtRTqI=;
        b=fDCpgJubAuZqNSfPg4QOi7RjhSCkCpfgaQe/kl2gy0c6VS4CLTa1koFlCw1UKexLPR
         HSrNBA+0x+lTG9yabEwYd7gUIsBjJyRL6jo1Rt9KnNGLO1zWpIXevjtnmN3XV+6/hgLS
         8t5T++WgQOSkBdSzoJVVy4K5dBBtXFkehG4KQTEVtnlVlZ0JZQAlN5wgrOTZODfMN7Cd
         6OoZoNmdEJAFjY9HKBkSYZG/eG06adak2Xy9UAUkfeSHAujn3aQFy8xl2lALd3mrtlJV
         EpVDTjeqQCoZXlQ+wrgEquYdMxubvFiE1GXNb1xkF93G3prtg0ERxza+JVcXJI0qL2SG
         qvng==
X-Gm-Message-State: AOJu0YynSl7ZgHq1yuJIp9Ye5zPD0v32dMHnyKsTYQCKAUxgcbypoKZP
	3XfNW6fFeSJvb82awtiB/IewtdrBZK8K6HKtKKxIpbRU4z1BVp/B
X-Gm-Gg: ASbGncul0UC5rWM647ywcGljvQkEQEOeOdpUytNPGkKA7+ete2M3KKIrF3tjIeWl8Ey
	yaZWVXOz5YcE3yX9XmUGwKimLfiNYSCmsVD/sWKRoeNRtP+mS8BitvgWz/NQgNF7kLjUWYPMp5Z
	Z3HBLPB1dcpPYka4RzLFlg9hVX/rcyS//+K5RONhSzLnJRlXafaIImeClLKFu5ynFiXHBDd0n6t
	WnQkmdkZE6MuK45BuvD1Ikx+yGF75mLp+Jeq62HQ1WISayfTPNueW2x7nmHYlR+DlZv
X-Google-Smtp-Source: AGHT+IFQAsTito3CSh5J8vV/UKToUeMLlCwtyu125qfFxl1QXAB+MAWCHYWQfO74uxRe9qi8MQIimw==
X-Received: by 2002:a05:6214:5296:b0:6d8:a0c8:e467 with SMTP id 6a1803df08f44-6e1b217a15emr222678776d6.13.1737397206176;
        Mon, 20 Jan 2025 10:20:06 -0800 (PST)
Received: from localhost ([2a03:2880:20ff:49::])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e1afce473dsm43444246d6.106.2025.01.20.10.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 10:20:05 -0800 (PST)
From: Usama Arif <usamaarif642@gmail.com>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	Usama Arif <usamaarif642@gmail.com>
Subject: [PATCH v3 2/2] mm/damon: introduce DAMOS filter type hugepage
Date: Mon, 20 Jan 2025 18:19:59 +0000
Message-ID: <20250120181959.2564362-2-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250120181959.2564362-1-usamaarif642@gmail.com>
References: <20250120181959.2564362-1-usamaarif642@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is to gather statistics to check if memory regions of specific
access tempratures are backed by hugepages. This includes both THPs
and hugetlbfs.
This filter can help to observe and prove the effectivenes of
different schemes for shrinking/collapsing hugepages.

Signed-off-by: Usama Arif <usamaarif642@gmail.com>
---
v2 -> v3:
- expose hugepage via sysfs even if the kernel is
  built without hugepage support. DAMON will just
  just return 0. (SJ Park)

v1 -> v2:
- Wrap DAMOS_FILTER_TYPE_HUGEPAGE case with
  CONFIG_PGTABLE_HAS_HUGE_LEAVES (SJ Park)
---
 include/linux/damon.h    | 2 ++
 mm/damon/paddr.c         | 5 +++++
 mm/damon/sysfs-schemes.c | 1 +
 3 files changed, 8 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index af525252b853..1d94d7d88b36 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -326,6 +326,7 @@ struct damos_stat {
  * @DAMOS_FILTER_TYPE_ANON:	Anonymous pages.
  * @DAMOS_FILTER_TYPE_MEMCG:	Specific memcg's pages.
  * @DAMOS_FILTER_TYPE_YOUNG:	Recently accessed pages.
+ * @DAMOS_FILTER_TYPE_HUGEPAGE:	Page is part of a hugepage.
  * @DAMOS_FILTER_TYPE_ADDR:	Address range.
  * @DAMOS_FILTER_TYPE_TARGET:	Data Access Monitoring target.
  * @NR_DAMOS_FILTER_TYPES:	Number of filter types.
@@ -345,6 +346,7 @@ enum damos_filter_type {
 	DAMOS_FILTER_TYPE_ANON,
 	DAMOS_FILTER_TYPE_MEMCG,
 	DAMOS_FILTER_TYPE_YOUNG,
+	DAMOS_FILTER_TYPE_HUGEPAGE,
 	DAMOS_FILTER_TYPE_ADDR,
 	DAMOS_FILTER_TYPE_TARGET,
 	NR_DAMOS_FILTER_TYPES,
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index c0ccf4fade24..224308140441 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -222,6 +222,11 @@ static bool damos_pa_filter_match(struct damos_filter *filter,
 		if (matched)
 			damon_folio_mkold(folio);
 		break;
+#if defined(CONFIG_PGTABLE_HAS_HUGE_LEAVES)
+	case DAMOS_FILTER_TYPE_HUGEPAGE:
+		matched = folio_size(folio) == HPAGE_PMD_SIZE;
+		break;
+#endif
 	default:
 		break;
 	}
diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 98f93ae9f59e..de9265f7ccde 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -329,6 +329,7 @@ static const char * const damon_sysfs_scheme_filter_type_strs[] = {
 	"anon",
 	"memcg",
 	"young",
+	"hugepage",
 	"addr",
 	"target",
 };
-- 
2.43.5

