Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6043E7172
	for <damon@lists.linux.dev>; Wed, 22 Jul 2026 09:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784713418; cv=none; b=cTIHTKG44/EMNSVRMgLzk5yqFA++2QZN+BAZge9Ovi0Li0B3v92RcukFhm9s6js3P/BosHb6zfe9GuH3bKvXZNGbHCLrfZDzpJjwegZOx9/EjAEmCatDEZsZl4XtAcNxQ73lhNacu6484Hlgs7v+qEnyXrtndkuZVGnHCi0O8NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784713418; c=relaxed/simple;
	bh=pH1SMtqFwZMNga87+LMfTD9EEc3U2acz/UT6cZwTYp8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OTEJ9HieonvObjPiBhOGEKQcAvCHrLj5vUhcsRkN0XUa2W8wXOX+Z4ZFTdIUs7TJ8lbhlMQCEsbKSq/F10dNfn7tQaGq8My+WEhs5cZD6AKQhnmT09XeKmrhZesGYce/aLhSafgNi0Gm4JA8fRjQUlqlTE0/EibsJc5sLUDABuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=SMm76vhz; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="SMm76vhz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=fY
	6oWj2ZnHEJ6yWb+CYb5tAU/Q+bvJ54oh7QY2YLOxI=; b=SMm76vhzR5xkjPRjOe
	K9MTHIhDttvtUgP2fAHVoR/qZ3HsH3iX7mNoTHLYBYIEF03hOUAZkHTdB3kqpRlY
	NxKmeLVv7jhMvd5EK/Nzjtip7z7KqhrCd04QZzsaayX3UjO9JvxXbARlcy2O8s8e
	lCxm5K9Wt0AE71CP0uz2i1CkI=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgD3vz2pkGBqgmcQIg--.3970S2;
	Wed, 22 Jul 2026 17:43:07 +0800 (CST)
From: dayou5941@163.com
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	liyouhong <liyouhong@kylinos.cn>
Subject: [PATCH] mm/damon/core: reject zero sample_interval
Date: Wed, 22 Jul 2026 17:43:04 +0800
Message-Id: <20260722094304.3132750-1-dayou5941@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgD3vz2pkGBqgmcQIg--.3970S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFW7ZFW7uryrKFyrWw18uFg_yoW8Zr13pF
	W5WryfWFW5try7uw4vya97ua4UZ343GF17urZ3tF45Cw1F93ySqr1jyFy5KF1UGryxZF43
	ZrZFqa4UZa4UJ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UyxRkUUUUU=
X-CM-SenderInfo: 5gd103ivzuiqqrwthudrp/xtbC+QsBr2pgkKslGwAA3T

From: liyouhong <liyouhong@kylinos.cn>

damon_set_attrs() allows sample_interval == 0.  Sysfs likewise accepts
sample_us=0.  kdamond_fn() then calls kdamond_usleep(0) every loop
iteration, so kdamond busy-spins and can peg a CPU.

With a zero sampling interval the access-rate accounting also diverges:
nr_accesses_bp no longer matches nr_accesses * 10000, and
kdamond_reset_aggregated() hits:

  WARNING: invalid nr_accesses_bp at reset: ...

Reject sample_interval == 0 in damon_set_attrs(), which covers sysfs
commit and other callers.  damon_lru_sort already refused a zero
sample_interval; align the core validation with that.

Reproduce:
  echo 0 > .../intervals/sample_us
  echo on > .../kdamonds/0/state
  # kdamond ~100% CPU; may WARN in kdamond_reset_aggregated()

Fixes: 4472edf63d66 ("mm/damon/core: use number of passed access sampling as a timer")
Assisted-by: Cursor Grok 4.5
Signed-off-by: liyouhong <liyouhong@kylinos.cn>
---
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 7e4b9affc5b0..a6d54ec8c4be 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -911,6 +911,8 @@ int damon_set_attrs(struct damon_ctx *ctx, struct damon_attrs *attrs)
 		return -EINVAL;
 	if (attrs->min_nr_regions > attrs->max_nr_regions)
 		return -EINVAL;
+	if (!attrs->sample_interval)
+		return -EINVAL;
 	if (attrs->sample_interval > attrs->aggr_interval)
 		return -EINVAL;
 
@@ -3770,8 +3772,9 @@ void damon_update_region_access_rate(struct damon_region *r, bool accessed,
 	unsigned int len_window = 1;
 
 	/*
-	 * sample_interval can be zero, but cannot be larger than
-	 * aggr_interval, owing to validation of damon_set_attrs().
+	 * sample_interval cannot be zero or larger than aggr_interval,
+	 * owing to validation of damon_set_attrs().  Keep the zero check
+	 * below as defense in depth.
 	 */
 	if (attrs->sample_interval)
 		len_window = damon_max_nr_accesses(attrs);

