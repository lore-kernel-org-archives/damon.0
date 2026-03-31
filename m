Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D403BED28
	for <damon@lists.linux.dev>; Tue, 31 Mar 2026 07:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774942355; cv=none; b=WGoc6sq5ZvjwCs1bKQRACe3Tz/4zsj3OfQsX8lyfET51gFz40JAVql++0hrQC8frRqtTvoAhxVh0CRT1nQkLySQhzo2rRVbb5TjMeeCIxvV23aQgekFh6xjODIrEd8fLSxKinBIECDpvPZ4cCtsCjEtX+kfBrJ5drp0Q6wBzb/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774942355; c=relaxed/simple;
	bh=9B+mMo5Z95RyCd7utySVU9Wi90GnHwMez2op2hh/2jY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=clhpVhFfRoy9Rk5cJQFU4LTm5REXwWKwL9J1EwBaA8RQ/xyKZ51lLdU4EesyhPCV9JCSnnxj/dVdtFtmXZGzzlc5/U0JBYGQlb6mCoHlG1oXsWNmr/i3qCyYS3UPgXo4dJkCWH7q0J0VK3x0lCqrmOZR2P+ydMuVcuJ7Coyz43Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZvEMcP3P; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZvEMcP3P"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-35d99031e4eso1670654a91.1
        for <damon@lists.linux.dev>; Tue, 31 Mar 2026 00:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774942353; x=1775547153; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9lGLRyHekliNWF/e73UsyDVKIPVttJC0CnEap7PKUCs=;
        b=ZvEMcP3PDvUkt4vgpokxZgLvfcJ2627OgtV5Aq1W+ZgHQHMu4bhpxi0FOEVtpcjabO
         Vs/gRqKTRW0fKZImeIynOoQeEjlu4X9bpSqcLNM/5TJOPC9rl1XsIArRDC6eJ0OoQzTo
         YjKr4Yoj4nh/ksOSbyMmhcu/ru/53mVgxS0Jxfb2GHhXMhGehPTuWNIiFL/On6W0UTAz
         i9iU/IH3KxDljDnw+ZowkHw2XDVr7/nMu0MhjAitcxfc2eqDStpNdl7gkK80+cRk9vt7
         mZTap4R9xyulcgS9fm2HbILxiMb4yFZjDUPgrmtikQkKVMOEyavhhycM5mIg8wnW7msP
         nBMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774942353; x=1775547153;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9lGLRyHekliNWF/e73UsyDVKIPVttJC0CnEap7PKUCs=;
        b=i7uiFUnE0qJ7zs0H3Z++lMN6c4uUrXlwqyH4weAZ1mi9W1IuTGBG8bJ3j06ITIBJj6
         jU0lS33rxSas/k3q2EXe2tZfk66C/1Cfv9O7quX6zUMWHKMTws274D1sHxxPBCLAPcLz
         86L5hXioLppyQ8Wmt9SJU3oNGz1smSfDHOErKK1D6AkRVSqqckgaYqbepKRrZfzmlZe5
         gSubW0uy7vSKxpor4JSeYDCaLZ7WjxDRIyqB95cZs1Rk9T1xdCCvjkijnw6lVCH/m98d
         vql7heG+6gQwyPr1+UMr8jSE0pWuE0isEGlDO4Z9TH6egp9btLWlqkLBe9IjPmv+GniH
         644A==
X-Gm-Message-State: AOJu0Yyzx9K7VZnNAjoVp21R0mr6GWjLxMQxyPk2dbEblBL9Sq3Cf2lc
	W0A2Lgva3f6O4PAvt/XBaqntSH8NysnbJ14isNFd+bgpyGsf7D/BiKYhFh3lFg==
X-Gm-Gg: ATEYQzwe5RdZ7vgDCfn5g3d605zMiOj2k/CklzeSL2GBxBYxM7l4oHSQuC+gJAWvgE6
	i6PQLx+CvZHVeuBD1lhtNqAH/nx+ja+hzNwtarBYN+QCbd6A5b8+6cVP/SeUWruHa7guFsEQfaZ
	tq7v51bpkUzzdAtFk9ySWLOb2jOcwGfdYt5UMmZaZ5/e9tws+roN/nLKElL2Pge9EJsDnwDOl4Z
	XGrnsZzZ0BXuWWNWotgMHwkpJvd3sI41EM64Qail1LQCP3JmZMqjl/1ql6B5Q85CUMqZdoTWMHB
	AhXQVxhminuPkIzeLz5S50JQpGHV+rRCLpjAuGzdqHSD+xHnYHi9XUHKUo6USLwIkxij7kPyDKT
	uIyqL5DT210ISMkmbmf0JnH8ii4C8nJqYagvT4csezWRKvSKLPt0HGas+Iy5WKcDaLAggTE7bDh
	hwpdgwjkJ04SVP++x2TSedFH79A8EoT+8Ca/LYxxSSuZMKz5khjH0=
X-Received: by 2002:a17:903:94d:b0:2b2:57df:264d with SMTP id d9443c01a7336-2b257df28acmr50704225ad.33.1774942353119;
        Tue, 31 Mar 2026 00:32:33 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:898b:301c:d085:a35:99e7:ffec])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2427acdb9sm105215045ad.68.2026.03.31.00.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 00:32:32 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	Liew Rui Yan <aethernet65535@gmail.com>
Subject: [PATCH] mm/damon: validate min_region_size to be power of 2
Date: Tue, 31 Mar 2026 15:32:31 +0800
Message-ID: <20260331073231.30060-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Problem
=======
damon_commit_ctx() checks if 'min_region_sz' is a power of 2. But if it
is not, kdamond will terminate unexpectedly due to the user's invalid
input.

Solution
========
Add the same check to damon_{lru_sort, reclaim}_apply_parameters(), but
return -EINVAL immediately. This is to prevent user's invalid input
causing kdamond to terminate unexpectedly.

Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
---
 mm/damon/lru_sort.c | 3 +++
 mm/damon/reclaim.c  | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 554559d72976..205592194efd 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -294,6 +294,9 @@ static int damon_lru_sort_apply_parameters(void)
 	param_ctx->addr_unit = addr_unit;
 	param_ctx->min_region_sz = max(DAMON_MIN_REGION_SZ / addr_unit, 1);
 
+	if (!is_power_of_2(param_ctx->min_region_sz))
+		return -EINVAL;
+
 	if (!damon_lru_sort_mon_attrs.sample_interval) {
 		err = -EINVAL;
 		goto out;
diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 86da14778658..6e29d92670c4 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -204,6 +204,9 @@ static int damon_reclaim_apply_parameters(void)
 	param_ctx->addr_unit = addr_unit;
 	param_ctx->min_region_sz = max(DAMON_MIN_REGION_SZ / addr_unit, 1);
 
+	if (!is_power_of_2(param_ctx->min_region_sz))
+		return -EINVAL;
+
 	if (!damon_reclaim_mon_attrs.aggr_interval) {
 		err = -EINVAL;
 		goto out;
-- 
2.53.0

