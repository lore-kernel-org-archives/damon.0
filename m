Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB6A6FB9
	for <damon@lists.linux.dev>; Tue, 11 Feb 2025 12:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739277889; cv=none; b=uz+tdy+INx7Qmhbpn4Zoja85pxr7I6AxATKy9ex3nje39uEy/fRlRI5DHKAtwZJ623P/7NPIVRPuX3QnZvwY0igrcSkxAA+5vwUv1GFlk2TmZa2JKp63CLuTjH3eGfQdijggp9ZMRs+4W1uG30amZjjO2YSkWs01wKj3BWNfns0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739277889; c=relaxed/simple;
	bh=sJRKoTTVtScNildY0jRtHAK9jP8WCLtZysMLVQ2dvxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hjnEXJhLKYX+6gEWlE6yF5pVPy+zeCNaU10U2zb8/wxIK3yHSZU/yMZRzqoITPAUft2Ts5cxlNiUOeBFGdr1DhSLBFjL9lvjC1dq65YaB/eU0GV/mcz0MO6pm4TPjlXvkxgmFi1dt3g7bFG1ZK9HW0CSEMLoXmJdtulrBpsS5Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EX3+3sUt; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EX3+3sUt"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7c050c6e201so274043785a.0
        for <damon@lists.linux.dev>; Tue, 11 Feb 2025 04:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739277887; x=1739882687; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hMONiW56Kzu0ciAkO3PDySjZmgbC1d6a5x6dVsP970k=;
        b=EX3+3sUtlIutMawRA4lq9NSHaESSjQWo3eXrIbRkTWYG02YbtevPIMI0Ds7gT0MS5k
         IC6UVRztyTIEvpk1HoRXJ7mksiRpGd40uGH/Xsq1awTcWciSmKYilQDNEINoMQr/ovtN
         tv1GgilXzRhk9ModRv1OMEhbGcHnKael1hE2DGaFZUNty9zEozKN3moNihTEfbVCQriR
         5oRVL4OfaienRSDb+q7/ayUho/ZGC/2juF7Ln2Wk9EK4U6TZqdIAAROdf1cwqxQjHOoR
         x0QDkNH5w6vTJ8NRduKym1ybn6Sgm02IS85a+3g897kzeHRI2qD3TS5cr61Um6303DKZ
         vFHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739277887; x=1739882687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hMONiW56Kzu0ciAkO3PDySjZmgbC1d6a5x6dVsP970k=;
        b=MXYFtKTawsF1bk8p6h/trpoICOe6BBZPqBhCg7gwDoG1jpsA/YJOyHCDA6xxu72Bnx
         +rtKzaUFIY/Kcj/peOXWZZxMyTmERxAPALpQCZ88wVgIMTLoFi1R5zxTa1zECjJWmiuW
         aLn62MjUqrXGKWN+bfCRYJxT3h3tCXwc+HtP38qWpbCke26VlgCo9Qqj34VGLDyIvghs
         lejh412Nw1V3DCeq2vNe7XwAuiGarzowc9rWFE761NLg+mJ8bd471iYDA6rRIIkcUN5s
         CIP3MiC0FtqqJIBb+S1xSm0rmx0qhMtioL0H2A1PQFPRFiRwdwN43sjLcoeoQ9Ug023C
         K0Qg==
X-Gm-Message-State: AOJu0Yy0XqawYaq0LOvcwbfgjOPL45tDb9daZZuQEsC7FAYG9bdTOVWM
	0AdfQ8nU6cLj0R3eNUb5Fiy8YyDHYjVULo684ZB2YwcnPNMsO0KQ
X-Gm-Gg: ASbGncuVTFLQSp7Y+T8nqSKBTwEmmsUyaLl++Gy25Aw9QDoSvxslPWfsEZ8u4SBV+LF
	lErxNci7b96BORBONWhLBnhIq6YOcxRuTD2IC9je/CKOSfNKJTADGecpN1JfsiL2FCwEsMMM5df
	VZantl1u4XvCIXn4rHJ2aGugzVKgwChWjjSEKtH1dJEAc77ue4GRom47DZkZUn2Id9DJAVYtETq
	7PqZ6lOhQoa84s8WtFAVRzFr5P0+tPE/qIyb/acQr+vWbESkrw9xsOw5UeRhDsySNHayGLn9bSX
	2MmIPmKPI9w/qg==
X-Google-Smtp-Source: AGHT+IFKntpXB2K8ZD124mh79ttrIMlKqsgtcQpvmiG3JL+RES1YLXKDTI/bJD0DBnChJdR3XXbF6Q==
X-Received: by 2002:a05:620a:3945:b0:7b1:4f5c:6e86 with SMTP id af79cd13be357-7c047c4fc32mr2525466985a.17.1739277886776;
        Tue, 11 Feb 2025 04:44:46 -0800 (PST)
Received: from localhost ([2a03:2880:20ff:47::])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c05bf73803sm306654585a.75.2025.02.11.04.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 04:44:45 -0800 (PST)
From: Usama Arif <usamaarif642@gmail.com>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	hannes@cmpxchg.org,
	david@redhat.com,
	kernel-team@meta.com,
	Usama Arif <usamaarif642@gmail.com>
Subject: [PATCH v5 1/4] mm/damon: introduce DAMOS filter type hugepage_size
Date: Tue, 11 Feb 2025 12:43:40 +0000
Message-ID: <20250211124437.278873-2-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250211124437.278873-1-usamaarif642@gmail.com>
References: <20250211124437.278873-1-usamaarif642@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is to gather statistics to check if memory regions of specific
access tempratures are backed by pages of a size in a specific
range.
This filter can help to observe and prove the effectivenes of
different schemes for shrinking/collapsing hugepages.

Signed-off-by: Usama Arif <usamaarif642@gmail.com>
---
 include/linux/damon.h    | 13 +++++++++++++
 mm/damon/core.c          |  3 +++
 mm/damon/paddr.c         |  6 ++++++
 mm/damon/sysfs-schemes.c |  1 +
 4 files changed, 23 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index a390af84cf0f..0adfc2f4ca75 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -35,6 +35,16 @@ struct damon_addr_range {
 	unsigned long end;
 };
 
+/**
+ * struct damon_size_range - Represents size for filter to operate on [@min, @max].
+ * @min:	Min size (inclusive).
+ * @max:	Max size (inclusive).
+ */
+struct damon_size_range {
+	unsigned long min;
+	unsigned long max;
+};
+
 /**
  * struct damon_region - Represents a monitoring target region.
  * @ar:			The address range of the region.
@@ -326,6 +336,7 @@ struct damos_stat {
  * @DAMOS_FILTER_TYPE_ANON:	Anonymous pages.
  * @DAMOS_FILTER_TYPE_MEMCG:	Specific memcg's pages.
  * @DAMOS_FILTER_TYPE_YOUNG:	Recently accessed pages.
+ * @DAMOS_FILTER_TYPE_HUGEPAGE_SIZE:	Page is part of a hugepage.
  * @DAMOS_FILTER_TYPE_ADDR:	Address range.
  * @DAMOS_FILTER_TYPE_TARGET:	Data Access Monitoring target.
  * @NR_DAMOS_FILTER_TYPES:	Number of filter types.
@@ -345,6 +356,7 @@ enum damos_filter_type {
 	DAMOS_FILTER_TYPE_ANON,
 	DAMOS_FILTER_TYPE_MEMCG,
 	DAMOS_FILTER_TYPE_YOUNG,
+	DAMOS_FILTER_TYPE_HUGEPAGE_SIZE,
 	DAMOS_FILTER_TYPE_ADDR,
 	DAMOS_FILTER_TYPE_TARGET,
 	NR_DAMOS_FILTER_TYPES,
@@ -376,6 +388,7 @@ struct damos_filter {
 		unsigned short memcg_id;
 		struct damon_addr_range addr_range;
 		int target_idx;
+		struct damon_size_range sz_range;
 	};
 	struct list_head list;
 };
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 1a4dd644949b..81aafdd8644d 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -776,6 +776,9 @@ static void damos_commit_filter_arg(
 	case DAMOS_FILTER_TYPE_TARGET:
 		dst->target_idx = src->target_idx;
 		break;
+	case DAMOS_FILTER_TYPE_HUGEPAGE_SIZE:
+		dst->sz_range = src->sz_range;
+		break;
 	default:
 		break;
 	}
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index d64c6fe28667..e04f0b4a7df0 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -203,6 +203,7 @@ static bool damos_pa_filter_match(struct damos_filter *filter,
 {
 	bool matched = false;
 	struct mem_cgroup *memcg;
+	size_t folio_sz;
 
 	switch (filter->type) {
 	case DAMOS_FILTER_TYPE_ANON:
@@ -222,6 +223,11 @@ static bool damos_pa_filter_match(struct damos_filter *filter,
 		if (matched)
 			damon_folio_mkold(folio);
 		break;
+	case DAMOS_FILTER_TYPE_HUGEPAGE_SIZE:
+		folio_sz = folio_size(folio);
+		matched = filter->sz_range.min <= folio_sz &&
+			  folio_sz <= filter->sz_range.max;
+		break;
 	default:
 		break;
 	}
diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 98f93ae9f59e..9020bc9befac 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -329,6 +329,7 @@ static const char * const damon_sysfs_scheme_filter_type_strs[] = {
 	"anon",
 	"memcg",
 	"young",
+	"hugepage_size",
 	"addr",
 	"target",
 };
-- 
2.43.5

