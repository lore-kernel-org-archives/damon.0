Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123CE210F5A
	for <damon@lists.linux.dev>; Mon,  3 Feb 2025 22:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738623383; cv=none; b=UOVTWK1fP7V7XHpiV7mGtPsBrTFkh1JYPpV4ekT9512VIWRImfdzGNDVtdbZmhf77AvGiRKQc00aEvgr9hN1LEdtYNFosOejEXIe13zqI4Og19+Y1L+czE9WaJJjGZtB1wKzzRnb2B4xeHQ/ylcL1X0naGOA8TvfVYYZusm3xIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738623383; c=relaxed/simple;
	bh=AmQStpct6BpjbGuIpbtTJQbj2DNGcLhUnv8pdm8g454=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K2bXZEunfGCbl4RdnXhcHK05i76TjqFHKVEsrrxWg1pHTaY/Vnwe0Xsv5Uq0t3+JsZWHLmO8tTu7rT3ayIHqZSGAHeq447rgyupWlnmJaZO7WfhQJOiiLE20yZ6/JuSZHTfkbkdbyv/Yiht4NM/HurcDIDH0OWVi4uNQ6VKPSx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mZ9k5XKT; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZ9k5XKT"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7b7041273ddso441406585a.3
        for <damon@lists.linux.dev>; Mon, 03 Feb 2025 14:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738623381; x=1739228181; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bZr3JU4IzgMkzaYCXnAAdzMCXxOR4d7z95TUJqJCBA8=;
        b=mZ9k5XKTyib/8DEVESnOi2dNTzt7pVGo46692uzkLdKgqTu+kaQ5/nwovR/aqcaVmm
         2T2zPMc0OzkhjY0m8BOBfM4o0m25LpSbxmP+jFrfCIADodkfR+g/YemUoURzB39N8Q7J
         qTQrIbXj/PdecZADUEn896lMhnJs1jtIGnSTPVPfzZW97DaT0GRot8sY8o4n3Ms2bV5B
         hFRIY+XgGLNoOWKP/BK2lYMy4/ZhFqhsmzRQRKbt3dTcDcrreNIa/0xIeoM6bQrQPGas
         KhcEwXzgt3WqjaLJa6GHUzK6R+w7w/ilXJUhabrx/hdnixhXynzTomCXk+2FAlST+UJu
         GF8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738623381; x=1739228181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bZr3JU4IzgMkzaYCXnAAdzMCXxOR4d7z95TUJqJCBA8=;
        b=AuTE2PnJxMZ5dwXWf0K6khP+oHYu3vMna+4yEAtcqqlwEUGPUa1Dvp8RXyMXLlPpJc
         PQpMH8861EVqYtnEutKabYELJjX9Wn0Jkh2tfPSRXif+KuywY4EbcjxYCBcvuw5XeJXs
         hmqTpqt2Eu1jHjJHCklvvhFhbtddr2Tv6vI34Kue5j6zXjKSEt9iFYioKUd7r91llUh7
         z32/TJOA32tZfd7xNpb6gwgzwjGLa21fkoMM6tJEH9wL3I93dydRIs6k/rsCBogCIZ7v
         OsHOu+ZkYh5MP8KWeTZ/yOKmZpb1x9+jSH+9e2ipTP3vmOIXGdp9/AHDTrJOX5IbU5eL
         iBRw==
X-Gm-Message-State: AOJu0YzE/torAWa1VdP6QIsKJmFL+J0owaCN9OhEkmomg0zjV5WdhH4h
	JbBzT4ywoSGfd51mBsugeIaJCswbtAFO1W0x/mNtJY7HJQh8bjli
X-Gm-Gg: ASbGnctBy8OXcx68xA1k1zHzmkXTlSWa+MxdSV4TJAFFOIbRBAl90TWsyvqwHYtU5cQ
	ew1eIQhMIqa9psvy+Mi4mZ9c/qNiF1ubIH6icezXzER0JZcwL2ioaDDkxrCyAHkJjKQerNB8dBX
	edXWAk/ONTbU3YfRYp2XZ35qiZO6Y6J9+XE0Cbi8YmTXeGlicLCdYy2AsvSRbO5l2mMEC6UKIpt
	amBNU/+RbHGwoYMbiJz3qULm7vRRKnmsYd6dLa0+WNhdTIo9PbXK5PvMoVbntbEpqyydAsd+ECr
	586hn3vQrrU+sw==
X-Google-Smtp-Source: AGHT+IFgwn45RHOswiTHACnY/GDGR+0xCj3o/m7mcVU1ENbjUzG07lEUnTfMgUp3v53B9gcqZUg33A==
X-Received: by 2002:a05:620a:2b4d:b0:7b6:cedf:1b48 with SMTP id af79cd13be357-7bffccc4b73mr3247916785a.3.1738623381017;
        Mon, 03 Feb 2025 14:56:21 -0800 (PST)
Received: from localhost ([2a03:2880:20ff:74::])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c00a8bb9c3sm577777285a.17.2025.02.03.14.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 14:56:20 -0800 (PST)
From: Usama Arif <usamaarif642@gmail.com>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	hannes@cmpxchg.org,
	david@redhat.com,
	kernel-team@meta.com,
	Usama Arif <usamaarif642@gmail.com>
Subject: [PATCH v4 4/6] mm/damon: introduce DAMOS filter type hugepage
Date: Mon,  3 Feb 2025 22:55:31 +0000
Message-ID: <20250203225604.44742-5-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250203225604.44742-1-usamaarif642@gmail.com>
References: <20250203225604.44742-1-usamaarif642@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is to gather statistics to check if memory regions of specific
access tempratures are backed by hugepages of a size in a specific
range
This filter can help to observe and prove the effectivenes of
different schemes for shrinking/collapsing hugepages.

Signed-off-by: Usama Arif <usamaarif642@gmail.com>
---
 include/linux/damon.h    | 2 ++
 mm/damon/paddr.c         | 7 +++++++
 mm/damon/sysfs-schemes.c | 1 +
 3 files changed, 10 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 6f30ceeff215..5ba6c2114e3f 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -336,6 +336,7 @@ struct damos_stat {
  * @DAMOS_FILTER_TYPE_ANON:	Anonymous pages.
  * @DAMOS_FILTER_TYPE_MEMCG:	Specific memcg's pages.
  * @DAMOS_FILTER_TYPE_YOUNG:	Recently accessed pages.
+ * @DAMOS_FILTER_TYPE_HUGEPAGE:	Page is part of a hugepage.
  * @DAMOS_FILTER_TYPE_ADDR:	Address range.
  * @DAMOS_FILTER_TYPE_TARGET:	Data Access Monitoring target.
  * @NR_DAMOS_FILTER_TYPES:	Number of filter types.
@@ -355,6 +356,7 @@ enum damos_filter_type {
 	DAMOS_FILTER_TYPE_ANON,
 	DAMOS_FILTER_TYPE_MEMCG,
 	DAMOS_FILTER_TYPE_YOUNG,
+	DAMOS_FILTER_TYPE_HUGEPAGE,
 	DAMOS_FILTER_TYPE_ADDR,
 	DAMOS_FILTER_TYPE_TARGET,
 	NR_DAMOS_FILTER_TYPES,
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 3f59a3fdc391..34fe1eb664cc 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -227,6 +227,7 @@ static bool damos_pa_filter_match(struct damos_filter *filter,
 {
 	bool matched = false;
 	struct mem_cgroup *memcg;
+	size_t folio_sz;
 
 	switch (filter->type) {
 	case DAMOS_FILTER_TYPE_ANON:
@@ -246,6 +247,12 @@ static bool damos_pa_filter_match(struct damos_filter *filter,
 		if (matched)
 			damon_folio_mkold(folio);
 		break;
+#if defined(CONFIG_PGTABLE_HAS_HUGE_LEAVES)
+	case DAMOS_FILTER_TYPE_HUGEPAGE:
+		folio_sz = folio_size(folio);
+		matched = filter->folio_size.min <= folio_sz && folio_sz <= filter->folio_size.max;
+		break;
+#endif
 	default:
 		break;
 	}
diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index bc7ca43ca9c4..76aee3ab277e 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -330,6 +330,7 @@ static const char * const damon_sysfs_scheme_filter_type_strs[] = {
 	"anon",
 	"memcg",
 	"young",
+	"hugepage",
 	"addr",
 	"target",
 };
-- 
2.43.5

