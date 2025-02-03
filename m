Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85D12101B5
	for <damon@lists.linux.dev>; Mon,  3 Feb 2025 22:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738623387; cv=none; b=kPaH82pbC9lSoKVZ8cowZaUyEa3WRduFU6zK2FnRQVO2B7D97D0Bjzgj81rl+nUCn6WONm9kBurREJRmt1yQs8oS4T7u+jNugkJTgpA3T3yT1NjWhaHz/bY2b0z87H1/ZNVdPaVbrjySWu0RuVfbAAGqS/G2myyHFp7qYjSAGJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738623387; c=relaxed/simple;
	bh=spZdcNxsp0j3B1H5+OIF4muI/hQmUQfT6V6HHlAXbVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CxM8U26CUSu4wk8X+Iny00REc/yoGH4pJRkfUQ78rzKIWofhU/+Hg8HerjHdQYoNWq9KuI+ob5wU+mLBF6whigbM2C/pH6345eIheQ5dQrf7KvCvKBpZq/kGV1QQ20TDLM5/ZYv4uISG8vYppVnvWvxhhba1W2V8/zj8PGNRFOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YusreiqP; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YusreiqP"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7be44a90468so595919585a.3
        for <damon@lists.linux.dev>; Mon, 03 Feb 2025 14:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738623385; x=1739228185; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=42HHIMqh2iJaWiyZ3I2a3Q2yrqc7Y9pAkTTacWWAGL8=;
        b=YusreiqPXcAoilyK7KDGnwUcnvuZc1azCBPx86oc54WJr+HtIIZOznhcycX45tDsOV
         x3ogBSGR73l4WR5diFBC/difAHZAz7eI0ObTYZ9QGia4EnqkQvys0+UWRa23KzvbEIM2
         qCRPL7Is4mbMosTwiKcye1iyq4Y0LhLvP/H2I7XHZX2cWQ7TGSLglsw93aptLaYinf4j
         zOvqvvMaJUSArHTReoJ7aHczQardV2UIwNd/qf3GqgD07Gdrc8QNY13ZOoL17myzBI/Y
         vOmzwx3gw3wKzis7SQMxm1VuYQdXs2J9zOJTPgDyAO4Xzn+1hruxZzEt2nllBkyLstiY
         sFoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738623385; x=1739228185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=42HHIMqh2iJaWiyZ3I2a3Q2yrqc7Y9pAkTTacWWAGL8=;
        b=TKA55wsHIuHKQBD1JOr+T+gt7+K+dj6ToNe7mYT2UeKsT0NYcIgvHmgoY3JTcC6WXJ
         4Q82dJRH8UiVMqro+FHOebfHtpGbzKRCX4ZqU3DvItRBed8113t8N16Nq+PvwznwM11q
         vNRHoxlxuvjos2CPo3f+m6cd3iZNWkVHk3DZ3hMDSwvt2icnbS3z5nIO49EJYHmEAENh
         5vWaSgvwYI3CSlD5ZT/MJOkxTj2X7gBVJyamQRNOM6U9W+50tCpykZyJPoV6bm4e1UPp
         CgQ89dUO3spMhi0dwJcdkiSXr3J8N9ph5XeVxrrSi1ERC36EKnleiI6EF0v3IulitEmS
         gqgA==
X-Gm-Message-State: AOJu0Yyk6aEcALwkcl/mR+ezDtYFXfzMXp8OrRjtroH9++INH3hrdljj
	tKv3XhICiJZuSm1NG8JmF8xwn/hjREfhwpFrDtRpT8zgG9YFVjTR
X-Gm-Gg: ASbGncslYpxV6ZUtgBdn/bVzeAMLWAM0SxBeU3ylcO4m3wu2r1G22BpF68P5Ddq1EpR
	jL+w1HpxuvlLRquyJtYTapJRKiZVEqj3Bo4F5OgjAHnZ0R4kBFKZzs/9VsOi3y+6TrqQKtCejxJ
	mevQqmq3tAYN4gyS2yntkrjR7wMkUUuVhCw213F38NAoIFal4WnkayLb5Cv7NWSP2eqDk4/QlEj
	W1dlyTvq5VWH84R8jnm2uaxTQApzYDaTzTBb2VRIN+dPx2nmMEKg+eAXP69TRcEJCx9y8LViyPo
	gB8Md2uIaOELsQ==
X-Google-Smtp-Source: AGHT+IFhlyc186tNNuJZi79PI3qlJsGmHC4/KUNG9CBtZP6SR5/AFRLR5sFR2OFiW12cBhbVQ+j77Q==
X-Received: by 2002:a05:6214:2582:b0:6df:97ba:4f7a with SMTP id 6a1803df08f44-6e243c5eb6fmr359442226d6.33.1738623384681;
        Mon, 03 Feb 2025 14:56:24 -0800 (PST)
Received: from localhost ([2a03:2880:20ff:70::])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e254814d01sm54971636d6.41.2025.02.03.14.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 14:56:24 -0800 (PST)
From: Usama Arif <usamaarif642@gmail.com>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	hannes@cmpxchg.org,
	david@redhat.com,
	kernel-team@meta.com,
	Usama Arif <usamaarif642@gmail.com>
Subject: [PATCH v4 6/6] Docs/admin-guide/mm/damon/usage: Document hugepage filter type
Date: Mon,  3 Feb 2025 22:55:33 +0000
Message-ID: <20250203225604.44742-7-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250203225604.44742-1-usamaarif642@gmail.com>
References: <20250203225604.44742-1-usamaarif642@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This includes both the 'hugepage' filter type and the min/max
files used to decide range of sizes to filter on.

Signed-off-by: Usama Arif <usamaarif642@gmail.com>
---
 Documentation/admin-guide/mm/damon/usage.rst | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index 47a44bd348ab..5765896aaa7e 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -83,7 +83,7 @@ comma (",").
     │ │ │ │ │ │ │ │ │ 0/target_metric,target_value,current_value
     │ │ │ │ │ │ │ :ref:`watermarks <sysfs_watermarks>`/metric,interval_us,high,mid,low
     │ │ │ │ │ │ │ :ref:`filters <sysfs_filters>`/nr_filters
-    │ │ │ │ │ │ │ │ 0/type,matching,allow,memcg_path,addr_start,addr_end,target_idx
+    │ │ │ │ │ │ │ │ 0/type,matching,allow,memcg_path,addr_start,addr_end,target_idx,min,max
     │ │ │ │ │ │ │ :ref:`stats <sysfs_schemes_stats>`/nr_tried,sz_tried,nr_applied,sz_applied,sz_ops_filter_passed,qt_exceeds
     │ │ │ │ │ │ │ :ref:`tried_regions <sysfs_schemes_tried_regions>`/total_bytes
     │ │ │ │ │ │ │ │ 0/start,end,nr_accesses,age,sz_filter_passed
@@ -406,13 +406,14 @@ number (``N``) to the file creates the number of child directories named ``0``
 to ``N-1``.  Each directory represents each filter.  The filters are evaluated
 in the numeric order.
 
-Each filter directory contains seven files, namely ``type``, ``matching``,
-``allow``, ``memcg_path``, ``addr_start``, ``addr_end``, and ``target_idx``.
-To ``type`` file, you can write one of five special keywords: ``anon`` for
-anonymous pages, ``memcg`` for specific memory cgroup, ``young`` for young
-pages, ``addr`` for specific address range (an open-ended interval), or
-``target`` for specific DAMON monitoring target filtering.  Meaning of the
-types are same to the description on the :ref:`design doc
+Each filter directory contains nine files, namely ``type``, ``matching``,
+``allow``, ``memcg_path``, ``addr_start``, ``addr_end``, ``min``, ``max``
+and ``target_idx``. To ``type`` file, you can write one of six special
+keywords: ``anon`` for anonymous pages, ``memcg`` for specific memory cgroup,
+``young`` for young pages, ``addr`` for specific address range (an open-ended
+interval), ``hugepage`` for large folios of a specific size range [``min``,
+``max``] or ``target`` for specific DAMON monitoring target filtering. Meaning
+of the types are same to the description on the :ref:`design doc
 <damon_design_damos_filters>`.
 
 In case of the memory cgroup filtering, you can specify the memory cgroup of
-- 
2.43.5

