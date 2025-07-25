Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AEF19E83C
	for <damon@lists.linux.dev>; Fri, 25 Jul 2025 16:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753461223; cv=none; b=qaJTNy9QYigkacdEKqQGkr132tSZNk9q12DjVqvNTLAZfuJWEBH+YKLyz+LUCA3PadV2CFlto5ADjZYv0S3uVcleudvfr+8uTj+iNZGi23fJwo/1put0BlFaayCnA4i/BvryJTB1DQnSf4Hed4ks9ZH2dtupZ9d8VKBvcHnv7JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753461223; c=relaxed/simple;
	bh=qz36GnD2yxRt9mAPG+aYKKHmn7X5RPXWQd5xMtzkOCc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fPsfkWOL7aSPxA0+ep4UmjyWOHXpQDozMi3IuXQQ3RRsgP4Kz4pOGRvcaH4yIKz8G+gMhcnyZ8mbBeksW5yVnxe3r2QZNqIojeKn8+t9W7kh8uBIUxY1O7/hPTbz1TQMBY+UG4ysKirHHHJPnqzEbBWIBkeHOutUY87Wto2Li50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GTDZ8ui/; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTDZ8ui/"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e8dee33b5d8so763404276.0
        for <damon@lists.linux.dev>; Fri, 25 Jul 2025 09:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753461220; x=1754066020; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CuSVB39VTwFvp064jrtVS3lbNZPZ0LiRX/EnLFvU1t0=;
        b=GTDZ8ui/LQsy2Er2mY4GC/emYQZbsISmrMwxiN+7v7dAqAGmZEad76td6S1BBhpPwp
         p+K9EfgOi7MsPkQCkzg/vZIszvaS0aHCj0ZeogYgwaXFZTGqL7ug27xDzEpou4xXS+UL
         y+9zzjqNYOBRvmdP3fD/k5tgPVfUKY1K4jqJMDsT2yQcAWkOn5HGIk85b39bJdoBRW1M
         xVrtPAhq+IpoBCGvgq1VD6khzoe12qYS+ArNPAAYPczpdAST3KIzqyZ0YwUzvj8QvdBv
         7UoS7Yl9+K4RJD6busziKdbeycXD2+hgPnpagyMt8JAQW7kxsGAQxmYy8PNktVkXBEzT
         31jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753461220; x=1754066020;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CuSVB39VTwFvp064jrtVS3lbNZPZ0LiRX/EnLFvU1t0=;
        b=ef2NLLwqfPrz0MUf5oa6SeERFFD8YvfKEjBOhno475j65lfa+TyFL8wzBzVbNvgCb0
         v636nsJmSF2LpT0UT+ZogIuuUk36bzx+r9knL6nqp94YM5v+O2wu4zzljFdhek+9Zp+y
         sHFXOuCyBTACOjETsh46DrmiMYcigHtsKOQUNjJwze0jJ1MdwubyX64czMXkx0Vkrx3o
         WgnybHov4OgpGHKNVdeZmX8B8afo14z4WV9UbA9grggjX7taCMIh81W5+JDWQbYdSg8U
         zhDEXIRSpowaV+kQuXF5Er1sTSNV6hAMj9WkySedlSKHEQZupmuPgHi9+XVIpnboymGO
         b4ig==
X-Forwarded-Encrypted: i=1; AJvYcCXCtkWqr3vewP0NK6jK43n8rZOtrUyrL6ySyPZX5dXrhxozdf8FE48EhpatR4WwJKTJguKDEg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzyDh/OAaypGVm22tkcsaK0NoQ3PkaPRt3BYvOUk1h/HVT1LQ8y
	c+MXU9z893fQGbGYbflX28KxeX5cUnonrYKv5FlpAh7u8BhVhuBvVtls
X-Gm-Gg: ASbGncsNdleQBsD8L0KNP59/qyRj0C3hcd34aDoC2YXO0EilYQP1zq42xgjyAZ5A8rp
	/Pr86dIQ3BRTBP6LKNlLlFY91BI8eU9ba9sjAX6pWvZt/puJwxupqc71kTyqg1YU7PBxdjwbBE2
	6PBVZnbZZ2vfZWowkpSD7MNHS7gQ1GutVPnB5Of+ezJpldUAgW/jkJPHgZryElefouHgASVIt1R
	umaDZoGhyKXcYNN0vwoFoSGuNbasFmqebV803xyosjiZosRRHElgDykfgIxQv5iX/Z0eWWKkYdj
	OBUr56oypfv7d337cNRDnyhBr1C3+RBNQynSFis+QqWhpiMwQ1l7bgKDAHCPok+MB79Tx3p5Gjb
	YHmHmoK6FO0M4+LU50DF6ZVYMr0S6SjA95tK8VG3F
X-Google-Smtp-Source: AGHT+IFw23rb4EOn1f5E1CRR6PboLxC0Lq7jWPQhC13bhKmS3MQg6viTQTk7iAO7B221UWGTNUczSg==
X-Received: by 2002:a05:6902:2013:b0:e8b:4455:787d with SMTP id 3f1490d57ef6-e8df1228357mr2550580276.42.1753461220113;
        Fri, 25 Jul 2025 09:33:40 -0700 (PDT)
Received: from bijan-laptop.attlocal.net ([2600:1700:680e:c000:79b4:320c:b28d:62])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e8df86ea200sm106376276.35.2025.07.25.09.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 09:33:39 -0700 (PDT)
From: Bijan Tabatabai <bijan311@gmail.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	damon@lists.linux.dev
Cc: sj@kernel.org,
	akpm@linux-foundation.org,
	Bijan Tabatabai <bijantabatab@micron.com>
Subject: [PATCH] mm/damon/vaddr: Skip isolating folios already in destination nid
Date: Fri, 25 Jul 2025 11:33:00 -0500
Message-ID: <20250725163300.4602-1-bijan311@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bijan Tabatabai <bijantabatab@micron.com>

damos_va_migrate_dests_add() determines the node a folio should be in
based on the struct damos_migrate_dests associated with the migration
scheme and adds the folio to the linked list corresponding to that node
so it can be migrated later. Currently, folios are isolated and added to
the list even if they are already in the node they should be in.

In using damon weighted interleave more, I've found that the overhead of
needlessly adding these folios to the migration lists can be quite
high. The overhead comes from isolating folios and placing them in the
migration lists inside of damos_va_migrate_dests_add(), as well as the
cost of handling those folios in damon_migrate_pages(). This patch
eliminates that overhead by simply avoiding the addition of folios that
are already in their intended location to the migration list.

To show the benefit of this patch, we start the test workload and start
a DAMON instance attached to that workload with a migrate_hot scheme
that has one dest field sending data to the local node. This way, we are
only measuring the overheads of the scheme, and not the cost of migrating
pages, since data will be allocated to the local node by default.
I tested with two workloads: the embedding reduction workload used in [1]
and a microbenchmark that allocates 20GB of data then sleeps, which is
similar to the memory usage of the embedding reduction workload.

The time taken in damos_va_migrate_dests_add() and damon_migrate_pages()
each aggregation interval is shown below.

Before this patch:
                       damos_va_migrate_dests_add damon_migrate_pages
microbenchmark                   ~2ms                      ~3ms
embedding reduction              ~1s                       ~3s

After this patch:
                       damos_va_migrate_dests_add damon_migrate_pages
microbenchmark                    0us                      ~40us
embedding reduction               0us                      ~100us

I did not do an in depth analysis for why things are much slower in the
embedding reduction workload than the microbenchmark. However, I assume
it's because the embedding reduction workload oversaturates the
bandwidth of the local memory node, increasing the memory access
latency, and in turn making the pointer chasing involved in iterating
through a linked list much slower.
Regardless of that, this patch results in a significant speedup.

[1] https://lore.kernel.org/damon/20250709005952.17776-1-bijan311@gmail.com/

Signed-off-by: Bijan Tabatabai <bijantabatab@micron.com>
---
Sorry I missed this in the original patchset!

 mm/damon/vaddr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 7f5dc9c221a0..4404c2ab0583 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -711,6 +711,10 @@ static void damos_va_migrate_dests_add(struct folio *folio,
 		target -= dests->weight_arr[i];
 	}
 
+	/* If the folio is already in the right node, don't do anything */
+	if (folio_nid(folio) == dests->node_id_arr[i])
+		return;
+
 isolate:
 	if (!folio_isolate_lru(folio))
 		return;
-- 
2.43.5

