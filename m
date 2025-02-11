Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C64B1B85FD
	for <damon@lists.linux.dev>; Tue, 11 Feb 2025 12:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739277893; cv=none; b=G4vXampCgvQ6ngFu455cET+7cfw21fyNd0kISWJ2BQGFE83LxBn9v7vLTmaUu8h5qM1WWJ+BhlUPEeSnxsL5FE/Jypl/tlfHz5M+M/6dr0TZc00ZXIHM2HAXr0vE3P/HjN2x6t6exh03aJe+pISsC8KUPwC6PBw3BAwMUfFJ16Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739277893; c=relaxed/simple;
	bh=alLkK4k8Q41R+Fg+7kC+DnEIGNKHRdZQ97ftSfwspbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CGhQkrqpAnUCHjcMmlbu0hwC8FE+g6tPqvQqPpXXCd3+RIKCxBWj/Oyt8/IaequThPpbVqZohJ6YVGGDQmoyRiz3rRhUIxn+HHkKLfM5MVu9ovFDe8Km+gz06oWyAX9Us+WnQlDuW2zGoEWlUShs0XSF2uvxrt99wYRt1uqdQaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KVQCZExP; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KVQCZExP"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c05f3dde21so250227485a.2
        for <damon@lists.linux.dev>; Tue, 11 Feb 2025 04:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739277891; x=1739882691; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CMpax52mTZ8HpB5qaIoavLxDy1tCpJlcHHk/nmljXSI=;
        b=KVQCZExPIaqPFl3R0wkRue2sfUPoklX+iXIt3q74f6gAF0eIkU9hNy36BNf5qcQagU
         ROmmiY6lIqMJfaiTBEI6sN0bIsYM/l/h/pabfsx2qewfstfVh99STAW6h1ekIekMCexI
         MAfAXvrnIdViQr6IShUqLZpdDwzxQOdBy3Mx/6qnceJ+wLadmTFj6xOf3nwBi+XPMDX+
         CuW8axArtCuL8+1XN/AMXZ21Ab4hM2/w/Ud4e8AAMmiMU5zSbcPsDdbonD0X8JbfG+pj
         PXf+NkGQjlsE2IJb5LznPovwWJOdIW7GAZS+cR5xpzZWTuhU5qs32ebVQZPL/0lzXhhw
         4lJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739277891; x=1739882691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CMpax52mTZ8HpB5qaIoavLxDy1tCpJlcHHk/nmljXSI=;
        b=eMCs+ikTd9qWokExbKR2mLTaIN6eu982Hgl9yo0cfzBErotsu7O8I/LQIoqWD9lo36
         q91PkPqNiGcLTZLn7ytiMgmYgi8Gzhob1r+0lrwoKZ3sP2JSsPKWzgIDvv3AhTPgykRf
         KsonrpEeaAJuQI2xIMSqcUhXmeG4P76XUlUpn3IplLdDEyQoxZSyqXFg1K7GRgGfbj8l
         xNeqzMvuK4ay6aGxlCcNwJlxg3B/FPiKfmcv8JWQfkbJeleU4oOlMV6NIU54q4tXXpQ6
         3JozCShueROvn0ni7NBKghyokd0N76SZBCkNxXYm5bm4sD3OTFzpcHfLHiV4kSKsM4qb
         mdCg==
X-Gm-Message-State: AOJu0YyQ57nJZDwwJcJikYKH6BMP/yhb7G9OWdpmTIrg8oTUirtakTsD
	43WpAiIpjOScDsr1lCNAyzam6ftcX8WNCE4V2D3woGr5wyy/ijak
X-Gm-Gg: ASbGncudXz+dyBuPqoRPmjsh79oC1XkJNfMejVHXwW0sNE238qb5nIbGq0K9GuHL++c
	FQoLUxaJlBlrI7jZ/4Yct/aIYGkvGmqmHHop10T4rn2Tp/fCFBPpG8+5oGKtLuWZFg6+gb9xm2Y
	IKdx3l9iN3rXJVwRoJdlkywSm8LW82Bd6zxHvE9n9QqkPS+AFSFtv0QcOLSIvzI3jFVF/0Ru5Nz
	GKRW3oFX77y7eh72XtIyz9iyiBEanFEW4tN3zfV6tU3zvcxl7DJw0qeATczDPFkO+KlQm9PTbmT
	yr3LTPzbYxo6nw==
X-Google-Smtp-Source: AGHT+IEmiyxZeL3sd7uvIckZHDQoOiXcxTqD2r2xsGU0tH2ecYI3/ky1JVJC5fU0oahk6j9XCQI/fQ==
X-Received: by 2002:a05:620a:27cf:b0:7b6:c714:f65c with SMTP id af79cd13be357-7c047c356e1mr2262320585a.28.1739277890995;
        Tue, 11 Feb 2025 04:44:50 -0800 (PST)
Received: from localhost ([2a03:2880:20ff:73::])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c05a07824esm331948685a.101.2025.02.11.04.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 04:44:50 -0800 (PST)
From: Usama Arif <usamaarif642@gmail.com>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	hannes@cmpxchg.org,
	david@redhat.com,
	kernel-team@meta.com,
	Usama Arif <usamaarif642@gmail.com>
Subject: [PATCH v5 4/4] Docs/admin-guide/mm/damon/usage: Document hugepage_size filter type
Date: Tue, 11 Feb 2025 12:43:43 +0000
Message-ID: <20250211124437.278873-5-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250211124437.278873-1-usamaarif642@gmail.com>
References: <20250211124437.278873-1-usamaarif642@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This includes both the 'hugepage_size' filter type and the min/max
files used to decide range of sizes to filter on.

Signed-off-by: Usama Arif <usamaarif642@gmail.com>
---
 Documentation/admin-guide/mm/damon/usage.rst | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index 47a44bd348ab..51af66c208c5 100644
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
+and ``target_idx``.  To ``type`` file, you can write one of six special
+keywords: ``anon`` for anonymous pages, ``memcg`` for specific memory cgroup,
+``young`` for young pages, ``addr`` for specific address range (an open-ended
+interval), ``hugepage_size`` for large folios of a specific size range [``min``,
+``max``] or ``target`` for specific DAMON monitoring target filtering.  Meaning
+of the types are same to the description on the :ref:`design doc
 <damon_design_damos_filters>`.
 
 In case of the memory cgroup filtering, you can specify the memory cgroup of
-- 
2.43.5

