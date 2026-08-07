Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C30C3D9DB9
	for <damon@lists.linux.dev>; Fri,  7 Aug 2026 09:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786095339; cv=none; b=sSHipSlYzjzCGpLoqS2FfrdcGRls5X43GPlIF2+md4dPbbX/a4i+sjFmSuZu40rmsVRyZjMQaDTLfYgCcnhKbUSLn6zwdKTa1QwiRIdNSQwKDNnIQwmk6CVjQWsZ3WvZcvDCgPWyc7PBwQRPekggrL4by6nYXYFE32vSKIK0l/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786095339; c=relaxed/simple;
	bh=bpL4J3HJe6/9KdhobE8+gmR2nv5PTnPxPTklawOMcEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h0o6ZY3wXjR0G1CL7o3RE7QDL0Jbgnu9xXih9ftU/Uop3KTeGbK1+gps3A4LOIm2A9sz/7DC1FnoVthqMbxZ4fJAWjBlB5ezS6OnMpdePLrBavLaBIzDgljmqd5ovayGkYhsOvRKDslufQ5p7Q2hZ6vhV3Nb5CkOvKCbn2jwbXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M4EQpX7L; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M4EQpX7L"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cc7ef7ec27so39785685ad.1
        for <damon@lists.linux.dev>; Fri, 07 Aug 2026 02:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786095338; x=1786700138; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BoZJUvqOnB9ofJGbnDsG82ZWVAW/7cBOGmRgNjA3QOQ=;
        b=M4EQpX7LYbZmzBYPKk+yrlcw/d6FdW1uBNaua9Di+H84iYZLAEw/ZwICLyvNsOyNRC
         UK2o+LO1XIdl8BWypXa1i1lpjX5uP2FMi4tBp7gaHrdkfJ+6FbpMcin+wbJVH2yV0//Z
         7umdS9yx5WPNNKB5MVp+RtCrxfMBJxKzr0MTEJmU1eNF7125mZvi9ZYoipQGnf9iYNxe
         xjoRdYXX9Xz88O86GjXcvuffrRutrS+NVrxqlYvxYvwNYOn7ICcJh/OUzsc5JumXvAQd
         5sH+BmfgzIFY2ovQaaN3/rZfA4iY8Ts+ZQf7Z8vw6RXINCIAPE6oHXLc67EMC+F8MmUE
         SQtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786095338; x=1786700138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BoZJUvqOnB9ofJGbnDsG82ZWVAW/7cBOGmRgNjA3QOQ=;
        b=bB5aGXkXlwXNlyg9CVAuXC9Jc+79h734e5/AmJvCGg733hTQMs9/WyfUGw6ee9Jomz
         F+nWgQb/REXyyASaVwMIk6ixk/0fvLcHxp7M9H1xSvXFJsbY7sxcK300x2xANqYqw5MR
         KdyE53+/m87bNsTVcVAKfVQG3OlttSGmz65xADNwW/DUnev615FVRSdl6QN1+XBW1tt7
         bOTKyw572zVu02U+cJz1TTNMedv/y4rDV7jqzG+OqM3fMkepHWQAIqGruKJHt4Qgz5E1
         JE/iNtLvUY9LY8XCwO8RvzozdU+1DvnFj6lr7601WQmetHE5W/iPjEct9f2tf2fIHhMy
         TODQ==
X-Gm-Message-State: AOJu0YwCLHT3rax6wUrI0iInuwSRGjluig53hAlC/oykPKQWrbexjHDG
	apauhIq64sMeR/4V4JkjtfEMrrSdr2Ig98MIO9shu5el+YiZWxHElZdQ
X-Gm-Gg: AR+sD11hquNcW2lGvpcLTmJPT0npCSMHHG5ntQE3XHB360DnFesHLdrzicG4Nt0eU5h
	Q+MdznkxkxnQxR0j0+AR26lCFIzmY4VXrHRUTQLG83dCB9MmL9S7DRONqirYH2IkWVGlQWdZHDc
	5pY0b3zhBBMz9VaXrSloA7fQTropkdNlBwH8IEi+Q/7YcI+/Pevp4wzNF0Cvp9UHT8UIZAFyoGm
	x37243bH4D7UTJhOtw3X86Fgzv2os9kpFkkMoERGEkAqr8vc29jZZ4NYYZTjlERPPaXj1OHK4+v
	ofx5T5lKKXcAAawWcD0VuiyAK6iQqu3kfgr/1GF8J85zYz4wjbXL4IETyiMg7sTxLAOAUwV4qzb
	cq3XmRNjSNab1khTD+aAAtZoK7U8G2q/lbuOpQolWzc64ffZHdUj+1T3Zo990idiEUxi5+22BM1
	j8OyKMueEHH+rZI9LnAuCNky2ZcAVv6Q703bHc/91HUqkwpAcqV0PwLg092QOpN/Ug
X-Received: by 2002:a17:90a:da83:b0:38d:e0c4:c955 with SMTP id 98e67ed59e1d1-3903c5d84b2mr21355052a91.15.1786095337751;
        Fri, 07 Aug 2026 02:35:37 -0700 (PDT)
Received: from celestia ([2402:1980:935:f4a7:6f5c:e816:9aba:2090])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3926254ee45sm1604269a91.2.2026.08.07.02.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 02:35:37 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	Liew Rui Yan <aethernet65535@gmail.com>
Subject: [PATCH 1/2] mm/damon: fix nr_snapshots counting using tried_applied flag
Date: Fri,  7 Aug 2026 17:35:25 +0800
Message-ID: <20260807093526.183009-2-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260807093526.183009-1-aethernet65535@gmail.com>
References: <20260807093526.183009-1-aethernet65535@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, nr_snapshots is only incremented when damon_is_last_region()
returns true. This is semantically incorrect because nr_snapshots should
count the number of DAMON snapshots (aggregation intervals) where the
scheme was tried to be applied, as documented in design.rst.

The "tried to be applied" means the scheme passed all guard checks
including access pattern, quotas, watermarks, and max_nr_snapshots
filters. The old damon_is_last_region() check does not accurately
reflect this semantic.

To fix this, add a tried_applied flag to 'struct damos' that is set
whenever a scheme passes all guard checks and is considered for
application in damon_do_apply_schemes(). Then, increment nr_snapshots
based on this flag in kdamond_apply_schemes() after the walk completes.
This ensures nr_snapshots accurately reflects the number of snapshots
where the scheme was actually tried.

Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
---
 include/linux/damon.h |  2 ++
 mm/damon/core.c       | 12 ++++--------
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 0c8b7ddef9ab..01e899a2150c 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -573,6 +573,8 @@ struct damos {
 	unsigned long next_apply_sis;
 	/* informs if ongoing DAMOS walk for this scheme is finished */
 	bool walk_completed;
+	/* informs if damos is tried applied in this phase */
+	bool tried_applied;
 	/*
 	 * If the current region in the filtering stage is allowed by core
 	 * layer-handled filters.  If true, operations layer allows it, too.
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 644daf5a1656..7230483e771f 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -398,12 +398,6 @@ static void damon_destroy_region(struct damon_region *r,
 	damon_free_region(r);
 }
 
-static bool damon_is_last_region(struct damon_region *r,
-		struct damon_target *t)
-{
-	return list_is_last(&r->list, &t->regions_list);
-}
-
 /**
  * damon_probe_hits_wsum() - Returns probe hits weighted sum of a region.
  * @r:		region to get the weighted sum of.
@@ -2668,8 +2662,7 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
 		if (damos_valid_target(c, r, s))
 			damos_apply_scheme(c, t, r, s);
 
-		if (damon_is_last_region(r, t))
-			s->stat.nr_snapshots++;
+		s->tried_applied = true;
 	}
 }
 
@@ -3249,6 +3242,9 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
 	damon_for_each_scheme(s, c) {
 		if (time_before(c->passed_sample_intervals, s->next_apply_sis))
 			continue;
+		if (s->tried_applied)
+			s->stat.nr_snapshots++;
+		s->tried_applied = false;
 		damos_walk_complete(c, s);
 		damos_set_next_apply_sis(s, c);
 		s->last_applied = NULL;
-- 
2.55.0

