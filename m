Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.228.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793202431;
	b=KnjF4zhYjHR0RFy9Fdtj33vrp+dRfsbUkOITdJMDVJQnlw1W2SZT/cqJF/jbmUXvgUHg
	 UAv7GbRgQ8qKcMuYG2HHMyztzfq5jWM5NVSzNH10dsSBaxchY7xaxVU6XjrV3V+THIHuD
	 gv0gLrdXBFZc9kjr+klqAYuJTnnS3kxSBVLvrts1lGWph+9L/juvC6clFp8+2JwJsAN9+
	 dTrI4oRmaf/KQqqF41mTrdO4JXWs9bH6wqUb3IJqD0ds9NK8nGEN3YhdYxVPOI/fEqfvI
	 vqdyGyHc3LhBf3ylyJ/SJxy+T+DPSKhjklN8bAv9DzevDF1sYxi0bVc8v7EBsU494OQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793202431;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:To:
	 Cc:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=kDf0N2qKy2D5WoUW21DkgIjyXDWbzLDsDhnlR4wrAP4=;
	b=QZ+wJNRBHnwQVJm2OjTS6yXSoaMbKRpozJNx1ikF1BaMckhPIjifP4WRlsIJpHPvfiDH
	 40JAvPxJKUBuGcQ/jqzGDkcwOTPPGqa+nWnbCgyB+snS6pwYB1AzbWPM90uVbnwboAtxX
	 74lz6OSTWNcFBEP2a21iXJyFFffjvDbgCSRe4LKhB3jw+/u619Mk9rWEzx6fTlITxYRGv
	 375Mr0OgfdfpVwaLwEiGgeT32ihxJZ1F5JWi9W5hL7E4mC09+sKG049ba2qP86MbJBJ+f
	 13MYqhnfTM4JQT+Ekvfdol3iFNa4M/5ZCQFNpvBrhOsD5jNfJvoCKBoroR3Oq2fHWhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xn25DQu6;
	arc=none smtp.remote-ip=74.125.228.5
Received: from mail-pz2-f5.google.com (mail-pz2-f5.google.com [74.125.228.5])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2354606A330
	for <damon@lists.linux.dev>; Wed, 28 Oct 2026 15:47:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2354606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xn25DQu6
Received: by mail-pz2-f5.google.com with SMTP id 41be03b00d2f7-cdae9336a3eso187837a12.0
        for <damon@lists.linux.dev>; Wed, 28 Oct 2026 08:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793202429; x=1793807229; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:message-id:cc
         :to:subject:date:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kDf0N2qKy2D5WoUW21DkgIjyXDWbzLDsDhnlR4wrAP4=;
        b=Xn25DQu63MXMbDbx2ndrw8BNLO93dmoqrciURB4qw9l5e+wKtujGyBQ3ek98FLE/oD
         jmcmFusKWGjBkfGQ1E48rnm6oWPC17ytTKvKgsfxOJt6+uK//R86GxrnPWg/2zVyFk1u
         /hK68OFX74Ag+6xzQWi1jU+yQw0St8VKdE1bnEQ/c7By9CUkPzh3z10JO4nCLXzF58R8
         QHMlcVtCATGjKYeZV561FUAZE74DwvRB8gF7qirvpVw9fAqoj0jER/8Y3MmGEirAnn0Q
         o1B4zSuWJVZ6um2MvtkWw84glhE8v287NZqKZKg5Es1pThkKVlibkw1Cj7crqfVQlAGr
         LVsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793202429; x=1793807229;
        h=content-transfer-encoding:content-type:mime-version:message-id:cc
         :to:subject:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kDf0N2qKy2D5WoUW21DkgIjyXDWbzLDsDhnlR4wrAP4=;
        b=P+9jBSUJF97tOQnVGGuUIlH0IFD0rNtxGZmm+4NEKJmT3264lLAMqNvM8Ichk1JVY3
         M701UUs1z+sahvilgf18bmTWAE+JS5ZtyHXXOz/1fzQiRXqyegHXROSzNqsPOjXXiNvF
         fmwgwcSXZWyP2quE+K6wxEHyAhLhadEWAQI1yEweods5DeeN7AgHpjICmz8SEw3JCDif
         wJcu5aTbaOrmd/9xO+2b8RJ9pysamqBpn5VrMIKjXBWVCjH9oLHnwUEePRYXcazjnpVT
         LT4+lnOc4Q6QKvcLZfHHIXF4NygNUSFLgvrUJWUGraRotUB2wa4n2hURjdwuU18KCJdn
         MGuw==
X-Gm-Message-State: AFq9FYJH31Pj7Gzu9BP+mswA/fktU+xFM9UnAiZK9KJc07KmtHE55G4R
	9iYB6NJfWI9rft1PDVwPNir52c9WHyVGAx3Bof/R6MdpU1wSRVuP3MF3erSB1hv9gR935w==
X-Gm-Gg: AYBFou0R6JB6i4VNx7CoP+7WbJwdXFfur+H7AQC7R1FmrBb29BZIaY7bgJ50m9oNPZ3
	siexm5C3uNRhIDADaVpaxWirGUrqpFeSj76fRUw0dHKp8MkLzPzs+GAppb8AvjTyTdOE8vHcG1G
	UcrvHnuoHdMKpsx9/1x28lnTmId3nBLz+hunwqZtc7Wnk1ZadN47EDZolLHKsggO12RgCzV2veR
	meTKcZPSjhYz2eUqXKCgbWzSxNhXFV6TpfxGyTANFJ4gEmTfItqm0QQnUoEh9FH/8P1ETTa+qpa
	YxmCenM3Yd3VV7e/lIG1CDk2UzU2kEY3aegNhLLJFCqUB8FUXVIH8nF9OCVXv+3+IRqV7pUYc1/
	4kRWhMa8uJCJePDBjILbfYt7jQTGEMU0t2+Lss0cgJ3lHldh7NGSgaX/Il911IPtIRX5rybK2Gn
	/ciPkZfOGchqupI1I+4nKyKwdZxpd8PZHOUUEUl5MSMvjbuiGsRETciIdW2T+5MWdj80U1M++tl
	Dr2cUNg2jJVXXpdyH0vPrFqxc0nGRKMf22mz0FleLCpCuFi32jirAbHYYsC5dsAVvD6LhuxcgyH
	iWTJXcu2R+IgdhXTu2YPTLG/k05xdvd66d4ysk19Le29lRhAI4YzNTd81YHZsFKNeoX0Zis5Vlr
	unYm3aqk/lVFx1gIFIyS8k6A44g==
X-Received: by 2002:a05:6a00:3493:b0:8a0:2344:c44b with SMTP id d2e1a72fcca58-8a6e8b8347fmr2113647b3a.40.1793202428981;
        Wed, 28 Oct 2026 08:47:08 -0700 (PDT)
Received: from localhost (n106-71-19-159.sun21.vic.optusnet.com.au. [106.71.19.159])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a6a5f66bcesm1375802b3a.15.2026.10.28.08.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 08:47:08 -0700 (PDT)
From: Aveline Noir <jm5905938@gmail.com>
Date: Thu, 29 Oct 2026 00:05:46 +1100
Subject: [PATCH] mm/damon: skip folios already on the migration target node
To: SJ Park <sj@kernel.org>,
    Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev,
    linux-mm@kvack.org,
    linux-kernel@vger.kernel.org,
    Bijan Tabatabai <bijan311@gmail.com>,
    Bijan Tabatabai <bijantabatab@micron.com>
Message-ID: <179320218513.2.7432933245840036676.damon-same-node-skip@gmail.com>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

While measuring DAMOS migration overhead, I found that the target_nid
path isolates folios already on the target node, then puts them back on
the LRU without migrating them.

Skip them before isolation in vaddr and paddr, as the vaddr explicit
destinations path already does.

Signed-off-by: Aveline Noir <jm5905938@gmail.com>

---
DAMON KUnit and selftests all passed. In a synthetic same-node fvaddr
test on a two-node x86-64 KVM guest (8 interleaved runs per kernel),
guest-kernel cycles fell by about 29%
with 4 KiB regions and 90% with 16 MiB regions. Median kdamond CPU
time fell by about 76% with 16 MiB regions, with no clear change
with 4 KiB regions.
---
 mm/damon/paddr.c |  2 ++
 mm/damon/vaddr.c | 22 ++++++++++++----------
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 2cfdc356b415..5b773012a876 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -368,6 +368,8 @@ static unsigned long damon_pa_migrate(struct damon_region *r,
 		else
 			*sz_filter_passed += folio_size(folio) / addr_unit;
 
+		if (folio_nid(folio) == s->target_nid)
+			goto put_folio;
 		if (!folio_isolate_lru(folio))
 			goto put_folio;
 		node_stat_add_folio(folio, NR_ISOLATED_ANON +
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index b549496ea8e2..cd71fb1ac209 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -786,14 +786,15 @@ struct damos_va_migrate_private {
  */
 static void damos_va_migrate_dests_add(struct folio *folio,
 		struct vm_area_struct *vma, unsigned long addr,
-		struct damos_migrate_dests *dests,
+		struct damos *s,
 		struct list_head *migration_lists)
 {
+	struct damos_migrate_dests *dests = &s->migrate_dests;
 	pgoff_t ilx;
 	int order;
 	unsigned int target;
 	unsigned int weight_total = 0;
-	int i;
+	int i, nid;
 
 	/*
 	 * If dests is empty, there is only one migration list corresponding
@@ -801,7 +802,8 @@ static void damos_va_migrate_dests_add(struct folio *folio,
 	 */
 	if (!dests->nr_dests) {
 		i = 0;
-		goto isolate;
+		nid = s->target_nid;
+		goto check_nid;
 	}
 
 	order = folio_order(folio);
@@ -821,12 +823,13 @@ static void damos_va_migrate_dests_add(struct folio *folio,
 			break;
 		target -= dests->weight_arr[i];
 	}
+	nid = dests->node_id_arr[i];
 
+check_nid:
 	/* If the folio is already in the right node, don't do anything */
-	if (folio_nid(folio) == dests->node_id_arr[i])
+	if (folio_nid(folio) == nid)
 		return;
 
-isolate:
 	if (!folio_isolate_lru(folio))
 		return;
 	node_stat_add_folio(folio, NR_ISOLATED_ANON +
@@ -840,7 +843,6 @@ static int damos_va_migrate_pmd_entry(pmd_t *pmd, unsigned long addr,
 	struct damos_va_migrate_private *priv = walk->private;
 	struct list_head *migration_lists = priv->migration_lists;
 	struct damos *s = priv->scheme;
-	struct damos_migrate_dests *dests = &s->migrate_dests;
 	struct folio *folio;
 	spinlock_t *ptl;
 	pte_t *start_pte, *pte, ptent;
@@ -858,8 +860,8 @@ static int damos_va_migrate_pmd_entry(pmd_t *pmd, unsigned long addr,
 			goto huge_out;
 		if (damos_va_filter_out(s, folio, walk->vma, addr, NULL, pmd))
 			goto huge_out;
-		damos_va_migrate_dests_add(folio, walk->vma, addr, dests,
-				migration_lists);
+		damos_va_migrate_dests_add(folio, walk->vma, addr, s,
+					   migration_lists);
 huge_out:
 		spin_unlock(ptl);
 		return 0;
@@ -883,8 +885,8 @@ static int damos_va_migrate_pmd_entry(pmd_t *pmd, unsigned long addr,
 			continue;
 		if (damos_va_filter_out(s, folio, walk->vma, addr, pte, NULL))
 			continue;
-		damos_va_migrate_dests_add(folio, walk->vma, addr, dests,
-				migration_lists);
+		damos_va_migrate_dests_add(folio, walk->vma, addr, s,
+					   migration_lists);
 		page_idx = folio_page_idx(folio, pte_page(ptent));
 		nr = folio_nr_pages(folio) - page_idx;
 	}

base-commit: d865f2677c44cb2171b833d6775cf692756fa8be
-- 
2.56.0

