Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08F1190485
	for <damon@lists.linux.dev>; Tue, 18 Mar 2025 18:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742322634; cv=none; b=l9imCuUrc4n5krL69mAfkVCdbLF4XZBz9GTaRNo3vdstq5yncDaKeXRyBnsW1TPMouVrytNpWJI+aaqvlSv8BbbSBo0stoO95znIwPsBfeViujM4SBERJdiScmrfbNycqeKr7hyyx/saCVFhxmU1M6jd/n8T9+FCoLlShBhIKDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742322634; c=relaxed/simple;
	bh=8UmMrEbwosQ3I7rVgmJ3k1gmLZhsQSeAtpCKw7acIy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D6Y0BuxuSjugcweHwOjxnS0He0/frJp45lvk7xNYPxBDIibu6Q+l2++bYbreVJQ9M7+LMWlBZgRLUj1ne7w+8GkxUAeOjwrLupFoL+Xxq/jscCXUc1QLD5FAGD2gt5+DLpHDrrs6DbskzQhIC5Go29IB5J0GWtBblfCUYTp3NEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hNGsWqHB; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hNGsWqHB"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6ff4faf858cso32305807b3.2
        for <damon@lists.linux.dev>; Tue, 18 Mar 2025 11:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742322631; x=1742927431; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bz8uuhNno3q6sJ6pl27PZsjnFKz8/XRS+VHqCZ7l+k4=;
        b=hNGsWqHBFGq3co1jqVgm07203IYglFUpMCIxXfQHr54NvLBkL7Xax4vv2IlSmcrSa4
         1U1/zJg67Ui6sNXBEHPYVWlBmpRnlwZ2BSS3Ldy4vYR2eX6Zxi94JXHI1NwfwdOIsGIX
         38VU3KoeKaEg3QSh+5UcbYHzHPTmsOsKZD7sGX56qeaG0xzXRrXnYtCkOeHvTb7vrJGY
         YLLYl5k8Vbgxqwpu7QzSdV5VgiJkAnCuhWSZXhXVLv/BSHAwkw0vGoexgemzu0FfYnvJ
         33WbEVya9a8NpTkQgyYkC+VvAc47/Bo3nNDf27OCDgtxksgEEic937nAduMubRVIiG3R
         HA5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742322631; x=1742927431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bz8uuhNno3q6sJ6pl27PZsjnFKz8/XRS+VHqCZ7l+k4=;
        b=dwPnpal6yKooGyGYQr9ERhee6d2wwFm9pQGCXZ9Zk9EQijvGnCQIxI/2fZAEDkdOEX
         /gw86izvjpkOjhDIA6plwQ7EvgvYeqJR1f9GR+F6VxSd9n2pWZP76nDCRxLA1K+A46jp
         lxyb0vFD3fUBzKDMdagNryXbdam7Cq1m2+LFHH/4cvMox42yvHDY06uiNvFvqdtb1lSt
         0Zj8CmDoAALtsZiYU+q6Bx2LJa/HF+1oquR7jDnntISegHBHwbspa5DrV1PQG6dR+zl8
         eM3wsOrwmL27E0TEPmt9HO8u/QVi3Cmcbm5/xZoLOlA4jiXQBgkY3DBtRtScK9+RA1Gc
         2nkg==
X-Forwarded-Encrypted: i=1; AJvYcCU+N9jqJ36JNG4BL5aZn4RSkuaIYVId/YPBCNRekd87hXeLeAB8aJ1EsmJtL7D8k9Rlks/fiw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yya2D1F34/HFT36v9Rru3FtpV7dsPR+8T80Xns1Wtl7CHZLmgfs
	W+/gP9WkXN5pLv69bhdKvIsDvVfW49uBgUoh9/PxsZ4HlsQOH6/vCPzJSA==
X-Gm-Gg: ASbGncvp5lBuNLUmjAyzf93NoRD9vpXVb2TXD79KVz9+GHjRUJrrIRoFVE5d6Q/cg24
	6PZ6Qg9TSqCBPwH42YHdOCQkegXgiW8DDhYA0axFDRp4Rgl41Im6jJoWD6T2WOjx3KId4Kibqkl
	XxLPmJk95u3Q9INDI51T7V7ZEF6AiSIUGimrqwPzcXyaFMFjzprfshrRd3fM7p/NpXMdv1yIWX8
	0Zct2RPzr6VxBipUw/hp2Fi/F6G1lYPwIddGCoTQO0fa4u1FWkiyXga3zDSlY3eGyQZYsYM+G/+
	mJVo/rwDbfon2GsuGgxnpdIEd66XgBUoi19sEaZzkp8SOg==
X-Google-Smtp-Source: AGHT+IGYgBrUer7kW3bh3Q7uDDRkpmEW94MY1wds50m2vry9jn+b2LRjGPiGem3A0ZsXjlrEpDiQ7Q==
X-Received: by 2002:a05:690c:6f04:b0:6fd:4521:f9d7 with SMTP id 00721157ae682-6ff45ff5be5mr220687117b3.24.1742322630662;
        Tue, 18 Mar 2025 11:30:30 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:7::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ff32894c7csm27161417b3.65.2025.03.18.11.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 11:30:30 -0700 (PDT)
From: Nhat Pham <nphamcs@gmail.com>
To: akpm@linux-foundation.org
Cc: sj@kernel.org,
	corbet@lwn.net,
	linux-mm@kvack.org,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	damon@lists.linux.dev
Subject: [PATCH 1/2] mm/damon: implement a new DAMOS filter type for active pages
Date: Tue, 18 Mar 2025 11:30:28 -0700
Message-ID: <20250318183029.2062917-2-nphamcs@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250318183029.2062917-1-nphamcs@gmail.com>
References: <20250318183029.2062917-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement a DAMOS filter type for active pages on DAMON kernel API,
and add support of it from the physical address space DAMON operations
set (paddr).

Suggested-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 include/linux/damon.h    | 2 ++
 mm/damon/paddr.c         | 3 +++
 mm/damon/sysfs-schemes.c | 1 +
 3 files changed, 6 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 3db4f77261f5..47e36e6ea203 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -334,6 +334,7 @@ struct damos_stat {
 /**
  * enum damos_filter_type - Type of memory for &struct damos_filter
  * @DAMOS_FILTER_TYPE_ANON:	Anonymous pages.
+ * @DAMOS_FILTER_TYPE_ACTIVE:	Active pages.
  * @DAMOS_FILTER_TYPE_MEMCG:	Specific memcg's pages.
  * @DAMOS_FILTER_TYPE_YOUNG:	Recently accessed pages.
  * @DAMOS_FILTER_TYPE_HUGEPAGE_SIZE:	Page is part of a hugepage.
@@ -355,6 +356,7 @@ struct damos_stat {
  */
 enum damos_filter_type {
 	DAMOS_FILTER_TYPE_ANON,
+	DAMOS_FILTER_TYPE_ACTIVE,
 	DAMOS_FILTER_TYPE_MEMCG,
 	DAMOS_FILTER_TYPE_YOUNG,
 	DAMOS_FILTER_TYPE_HUGEPAGE_SIZE,
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index b08847ef9b81..1b70d3f36046 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -217,6 +217,9 @@ static bool damos_pa_filter_match(struct damos_filter *filter,
 	case DAMOS_FILTER_TYPE_ANON:
 		matched = folio_test_anon(folio);
 		break;
+	case DAMOS_FILTER_TYPE_ACTIVE:
+		matched = folio_test_active(folio);
+		break;
 	case DAMOS_FILTER_TYPE_MEMCG:
 		rcu_read_lock();
 		memcg = folio_memcg_check(folio);
diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 5023f2b690d6..23b562df0839 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -344,6 +344,7 @@ static struct damon_sysfs_scheme_filter *damon_sysfs_scheme_filter_alloc(
 /* Should match with enum damos_filter_type */
 static const char * const damon_sysfs_scheme_filter_type_strs[] = {
 	"anon",
+	"active",
 	"memcg",
 	"young",
 	"hugepage_size",
-- 
2.47.1

