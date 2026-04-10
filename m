Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C260F331A5B
	for <damon@lists.linux.dev>; Fri, 10 Apr 2026 04:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775796198; cv=none; b=qU8DbkwnqNXgUabA3EsucoApivAa+IH8gSF1Ppgp1Lu2tOB8ENvnpFTnk2g1OCS8pT764PvMg0y0RnMQ2EEz2RjJyKRd7r6Zx45avuWzA/7mKV/WZac2iozR9MhifQP598G6ZSbtTiVx7LTkfYSSMb+QA8r9w6AhsEwsK3Xf9tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775796198; c=relaxed/simple;
	bh=iN3sIFcZLTLFMSNhoVbJjjcQ9cXhEOUIXwgOoP8u4v4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qlWaYCFw8sUjnXVgXCHHQ26xFrNsyTznoYVM1y3SY8/DS295+nWzOdSyFC9H8/IwPAjAwuicIf5yld/lefX226rSwDC9ufzDZPK7OlHMzlCWEUVTe3BkKO232iFWFynBiLi3GrUMhVRF7OpvEwxVhw2v/UYP9JqE8UoTLJONhEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nUaz6dtD; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nUaz6dtD"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-82c70e4654eso764999b3a.2
        for <damon@lists.linux.dev>; Thu, 09 Apr 2026 21:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775796197; x=1776400997; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jBXWLvahdu/HVwF/Faib/MOJG0gD/Btl4TI2BjLmBLY=;
        b=nUaz6dtDstRYQHGFLdqOv3vzy4Fjn8vMzt+ufzklswVoqGWhxGyXmtkulRlxtqLhiF
         oVbU4kJhVmLcWpY+Ge8KLAyc4o0bsEucr/9Fbm59w29Mo7Ei22bhzI2v3YAbuMboC4gk
         S0WhH952pXwMQrEOtqG+waR3K5fzxQU3X0gO8sLxAxEn6VjAbcJKlPvBevV7ppuGOe8I
         8UBVVXEeZKqrqGHqX2lX5qynNN5tPFOb2MOge64WGAxfhrXucGUN6vSjoOAzKNJ5lCK1
         jWEL+amMI/g4lcNSVarTpMSRNfdLxy8ZMx0G/BQZrjfZLDA7M9c0QmLBV7dBmAUT1mUy
         edww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775796197; x=1776400997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jBXWLvahdu/HVwF/Faib/MOJG0gD/Btl4TI2BjLmBLY=;
        b=mpuoM/CF1p0jFR60sCBadcQX75UEGFQlm2c2k450BV06GLJZbX5s0dy8AK8u9vPBsj
         loychmivfPDNyI+6N8GPBNHKVzPfltrZDTF0Nnm+tOnm2EhxY2pna2N7hTzRGA0v0tUb
         On3MATcSWxAJ6sA0Q/WdNiJFaCFU4F2nrFQqgcDqyPPCPCnxwT+QFbwqg9ab9IwWzZap
         uExmLjHJXchZDQXQWOsIKzfziOa+Ux/CeL9Fg/LtVzJCLpuXjKVTeqU7U+0dRlyoNg+d
         2zBdVD2Mf5f7lGoCh/H2Z01n/sOcJ5f0xoQ742fDIPKvmxv/cQYJr7q+oCHa6BxSTkPz
         Nu7g==
X-Forwarded-Encrypted: i=1; AJvYcCVIEKjMnlUezIH/5yPToT4GRorMUicaU1WjwPeFRD+iJ+XSTRC7bJD5nBh7MIiwMdO+dnMysA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxQooDopMV5ISCqBW5YpVHe11npo6PCnnFjWlE8WBRjpTpqNykm
	RVec+1YtD6jDO1I/mq6IeW6JBV9NW7VhFpJvd08F1a4Suezza99u+x3IA3TEcg==
X-Gm-Gg: AeBDiesOK7oe7gDXWkK/wHVNdPaOyMKm+R3KbkPeLbZkbDTLTqwB+9dpc5cZW/OK+Ps
	faR0BfhUnLKiVCu+IdANJApQw0tsv4u/lwYa7cIdHz4KBT+XpHtyfvwyPw16phQg9t6abw63MsL
	KTAk4Hl41DjpMlHsZ1OyWY+b1NMmTlW1UUVOGPrICsIoAP+uiQzaIM3bV0KB1pm0L9Y374BjcrJ
	shuL5KE5tC0bcL2ebwEkxJTDkCxTw4p5Vl9xfwEsO0VN2iHPJ4aCUqsevdzL3jVHzIovN5pDj4G
	ii6V5Sh9R6TfBukMdPjm0+b/ZvANvbD+U8rmznpCLJpEZRZhX/Ju4rkHuE/yiQoLQYV04jVUIGi
	Mtns5aauHAQV6oXqKqM02CUk60BUk2tRZL1mvDtM8FGN7FKh7LAxOThXgIwCB2KeRhJiok9DNPA
	9YYRUaoUYn/FieZvA6OXlADUT8/yE=
X-Received: by 2002:a05:6a00:b908:b0:82c:6da7:2d3d with SMTP id d2e1a72fcca58-82f0c250a31mr2001305b3a.11.1775796196784;
        Thu, 09 Apr 2026 21:43:16 -0700 (PDT)
Received: from celestia ([2402:1980:898b:301c:d085:a35:99e7:ffec])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c30e7besm1200109b3a.5.2026.04.09.21.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 21:43:16 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: SeongJae Park <sj@kernel.org>
Cc: Quanmin Yan <yanquanmin1@huawei.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	Liew Rui Yan <aethernet65535@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v4 1/2] mm/damon/lru_sort: validate min_region_size to be power of 2
Date: Fri, 10 Apr 2026 12:42:58 +0800
Message-ID: <20260410044259.95877-2-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410044259.95877-1-aethernet65535@gmail.com>
References: <20260410044259.95877-1-aethernet65535@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Problem
=======
When a user sets an invalid 'addr_unit' (e.g., 3) via
DAMON_LRU_SORT, 'min_region_sz' becomes a non-power-of-2
value. This value eventually reaches damon_commit_ctx(), which does:

    dst->maybe_corrupted = true;
    if (!is_power_of_2(src->min_region_sz))
        return -EINVAL;

Although -EINVAL is returned, 'maybe_corrupted' is already set. The
running kdamond observers this flag and terminates unexpectedly.

"Unexpected termination" here means the kdamond exits without any user
request (e.g., not by writing 'N' to 'enabled').

User Impact
===========
Once kdamond terminates this way, it cannot be restarted via sysfs
because:

1. DAMON_LRU_SORT is built into the kernel, so it cannot be unloaded and
   reloaded at runtime.
2. Writing 'N' to 'enabled' fails because kdamond no longer exists;
   Writing 'Y' does nothing, as 'enabled' is already Y.

Reproduction
============
1. Enable DAMON_LRU_SORT
2. Set addr_unit=3
3. Commit inputs via 'commit_inputs'
4. Observe kdamond termination

Solution
========
Add an early validation in damon_lru_sort_apply_parameters() to check
'min_region_sz' before any state change occurs. If it is non-power-of-2,
return -EINVAL immediately, preventing 'maybe_corrupted' from being set.

Fixes: 2e0fe9245d6b ("mm/damon/lru_sort: support addr_unit for DAMON_LRU_SORT")
Cc: <stable@vger.kernel.org> # 6.18.x
Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
---
 mm/damon/lru_sort.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 554559d72976..3fd176ef9d9c 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -294,6 +294,11 @@ static int damon_lru_sort_apply_parameters(void)
 	param_ctx->addr_unit = addr_unit;
 	param_ctx->min_region_sz = max(DAMON_MIN_REGION_SZ / addr_unit, 1);
 
+	if (!is_power_of_2(param_ctx->min_region_sz)) {
+		err = -EINVAL;
+		goto out;
+	}
+
 	if (!damon_lru_sort_mon_attrs.sample_interval) {
 		err = -EINVAL;
 		goto out;
-- 
2.53.0

