Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5A733E374
	for <damon@lists.linux.dev>; Thu, 17 Sep 2026 00:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789605367; cv=none; b=TVdEDyIEVoCi/dBu7VjLMyHJk6C3DasC1zZcn/WIyCd6El2ZIATiudpI/xuthC/b8rxi0wDRz/TxxCSHkNQ6Vy0PEKlB9BAz7UUZebzR5Q2fWe7rdeeknH4Khnhvm/Ra37t39nxpqgNnFH435LXxc/Oxc6NqLowEwdBk/EVogRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789605367; c=relaxed/simple;
	bh=oY1XqwwwWT1+uL3YekTkyArK2uBkPFLMbeNHh5pTIV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BZZva57mXZnxDVjHvebAxHEbJB9Onl/vI0aPBTLgJdkj5Gf68843P4inwxZZR9pJD+kUJzqzntLqsAkTqaDZjJltWPqvf9MhkP2NdyyILeEyBSbP7GmfpSVqZd949MeSYIQ/qlPJ5asq3/mJKGK97iaq7xqC9e1zd3JacnalxtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UU7fOJ/I; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UU7fOJ/I"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39dacf053eeso174944a91.2
        for <damon@lists.linux.dev>; Wed, 16 Sep 2026 17:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789605363; x=1790210163; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+SZOEiF1GstbodCCQqhjQU6Va5Mh92J9eROCVHW7eeM=;
        b=UU7fOJ/II47ZYwHUp2xQUQmvsML2D0sHGwgUKWjP6xG1yStyvc32UjN9biPONVQUcF
         mH7xz4H8WC4sKw/9ZYsqlHlnPPFtefDDQabLzB690aaBXJC2iXvBPSzwCvVubMXWzQ4C
         p1f6+S8y4ytJJ7ayJEJZMvoel2gs0goKkEyDaNOT3zIKlSVJtoFhi9lj+iy0gP0aS97r
         8Wk8D3O/nnO0ERyVPDtof40u4V/BdWjeiTuW8LbtrDpttTGI1wIk50eesBdo8BeWY2NK
         AX1P1CmaCxVDD3AyvJoEHyAestHzxKkeLTki6lkie8Da1NPGci1Jn9FK//3YfhnpaFGF
         3JKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789605363; x=1790210163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+SZOEiF1GstbodCCQqhjQU6Va5Mh92J9eROCVHW7eeM=;
        b=ONSRYPW1O/NwrxOYgOVsZKmmpiCkYuOPWpB830LVKWX4BsE9Nv4kE6XKVnPj/aB6d+
         ymsLVMyHVrAmVLocAgl4nxoWqKKEeYGHdpkQIolXbW/ExYE52sp248YCkJJ5O7zvIsda
         DZLEoaqOZpMg8PwPaMJBZ+DexZ2W6d2zgauQ9v76xiIGOyCsZoIW5HTUWBXPx77B4222
         MOBkMwFG5a1GkLWymJ1NH1CdqLBukhxQFvu3AAKcpMTIxcZrVtuGvKEVPOV8XU4GSxGF
         TyEHJVT+2Ht8VSIHdpGkIjz3p31chGbFlMeZF6BJ+KaTSV28Auw3rg7WYEUuZBy7I0F4
         KVEQ==
X-Gm-Message-State: AFuF++kpRX+ZBfXtygqdqnFNTLxEFRmTxi8mfjD2WxmQ+I4NPpy+zbn7
	quvR6jA0fkRFNnkS9G4rxOiEp9sRThrCMtnNw18zPPm9lQ9FQS86dnc=
X-Gm-Gg: AYBFou0OKu43QRnKF4vkMAJXuJgpLR/xzX0/8GB11GZRQo9fwg7k3rFHfJeRxSj7Nbj
	CQa5mxLnoiF/+66hUsqPqBCZ1elT/lu1wInSHsEbAWBgPspNQnkHJN2WIQAlv6Lt6fgRdrsHXGr
	VGO/txaL7iTPDskPhuc/OgXKV6qwdfeBBYAR24XJI5HrUp33vZYisUC+dEnKKPk5ZZQjc1IxdqV
	wCLGl4URKlxIm3pql4JsshRj14ZnB1lsqKDta+tTBJ2C13qkxTFz8bYGlSfhDdvV8YSDZ0CwauE
	NfRHM8P71zECyJ5i1bM/ZEgBAGGzdynRPQ3pNRpoMtYkhWKghXfVLi58Lt88s8kE5VKQ/mZ7VcX
	3ySvWqOKevEYCwFxhJ8IP/5B7tdBJHiy2fwOze9krHwSdBPIqWYQAPZDyqcJAtzV549/2k+GVC/
	+Q15q+uaQpr+albvknCYdPlovHK6xGEQW5fMxY6rlwUbz7Jqua+kHa3gR3H/41LEj0JcxujH4Ux
	wQby65hJJzF3fExGJfStLrkgpM=
X-Received: by 2002:a17:90b:2585:b0:39d:f351:8f0c with SMTP id 98e67ed59e1d1-39e1e48b580mr10065782a91.13.1789605363080;
        Wed, 16 Sep 2026 17:36:03 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:7f00:8c85:3990:d106:a51f:be7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e36115cc8sm1722374a91.3.2026.09.16.17.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 17:36:02 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	donggeunyoo.kernel@gmail.com
Subject: [PATCH v1 1/2] mm/damon/core: charge only the part of a region the filter left
Date: Thu, 17 Sep 2026 09:35:52 +0900
Message-ID: <20260917003553.2465523-2-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917003553.2465523-1-donggeunyoo.kernel@gmail.com>
References: <20260917003553.2465523-1-donggeunyoo.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An address range DAMOS filter that partially overlaps a monitoring
region splits the region at the filter boundary, so the scheme action is
applied to only one side of it.  damos_apply_scheme() reads the region
size once on entry, before damos_core_filter_out() performs that split.

The quota charge and the statistics update therefore account for the
region as it was before the trim.  schemes/<S>/stats/sz_tried counts
memory the filter excluded, which Documentation/mm/damon/design.rst says
is not counted as tried, and with quotas/bytes set the excluded part is
charged against the budget, throttling the scheme to a fraction of what
was configured.

Re-read the region size after the core filters have run.

Fixes: ab9bda001b68 ("mm/damon/core: introduce address range type damos filter")
Cc: <stable@vger.kernel.org> # 6.6.x
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
---
KUnit, mm/damon/tests, x86_64, with patch 2 applied to both trees:

  without patch 1  36/38  damos_test_apply_scheme_filtered_sz and
                          damos_test_apply_scheme_filter_sz_unchanged fail
  with patch 1     38/38

  Expected s->stat.sz_tried == 2 * min_sz, but
      s->stat.sz_tried == 16384 (0x4000)
      2 * min_sz == 8192 (0x2000)

All 15 DAMON selftests pass with the series applied, in a QEMU guest booted
with slab_nomerge and CONFIG_DEBUG_INFO, the latter so drgn could run two of
them.  sysfs_update_schemes_tried_regions_wss_estimation.py and
damos_quota.py are timing sensitive and have each failed intermittently on
both patched and unpatched trees over 15 runs.

One path is not covered by patch 2: the quota split failing at
damon_split_region_at().  A KUnit case cannot make that allocation fail.  The
sibling exit, a quota remainder below one region, is covered and reaches the
same update_stat label.

 mm/damon/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index dd4317df42ff..68f1749ded43 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2784,6 +2784,7 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 		}
 		if (damos_core_filter_out(c, t, r, s))
 			return;
+		sz = damon_sz_region(r);
 		ktime_get_coarse_ts64(&begin);
 		trace_damos_before_apply(cidx, sidx, tidx, r, nr_accesses,
 				damon_nr_regions(t), do_trace);
-- 
2.53.0

