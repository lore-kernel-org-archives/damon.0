Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC6B14B088
	for <damon@lists.linux.dev>; Fri, 29 Nov 2024 08:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732869086; cv=none; b=JjOTqONOHOK10k8MzYpc8Xv6rXBJpeRDEw8m7rJHyKa9YYU77sOqjJah4IwDQKuODQ6tFk00Yg/9axUmMpwsKsqAlJeR1pLtQnlmmaHqbdtzsoBpmeEuQO4Wb+7ZIQZPWknOIjEjRBSCuSVJzU/OPftgYwp195q2OfLPh6Wuxww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732869086; c=relaxed/simple;
	bh=IbDlefQaxLoyA4mm5kQJeJs1i5eTTP9E7YitVTR12eI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uqzroCp/ZGQf44FqFfghpbJ5/GWIqnuEEvr9M5/a7w/LlpHARLuPNXgcAdfbDhlaz80qIJx37Z/vnD3dshEcvOzh2EJNBB/vke+nWTV6W14Fg72TtYq4O23qxyp+j5s3fDnVCCsTTek8zh1veg5KAUSGUY7nV53H9M9FmTnMJr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3c9ff7000001d7ae-b1-67497bd61d45
From: Honggyu Kim <honggyu.kim@sk.com>
To: damon@lists.linux.dev
Cc: SeongJae Park <sj@kernel.org>,
	kernel_team@skhynix.com,
	Honggyu Kim <honggyu.kim@sk.com>,
	Yunjeong Mun <yunjeong.mun@sk.com>
Subject: [PATCH] mm/damon/core: accumulate applied size to quota->charged_sz
Date: Fri, 29 Nov 2024 17:31:01 +0900
Message-ID: <20241129083102.1582-1-honggyu.kim@sk.com>
X-Mailer: git-send-email 2.43.0.windows.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgluLIzCtJLcpLzFFi42LhesuzSPdatWe6wbn/3BZP/v9mtTj89Q2T
	A5PHplWdbB4vNs9kDGCK4rJJSc3JLEst0rdL4Mq4eCiw4BxXxdLpqg2MHzi6GDk5JARMJM7M
	usAEY/ceusQKYrMJqElceTkJLC4iICnx504rexcjFwezQBujxK4NP9hAEsICPhJHfk4GK2IR
	UJXY0buZGcTmFTCTeL5lESvEUE2Jx9t/skPEBSVOznzCAmIzC8hLNG+dzQwyVELgJqvEzM/T
	oa6QlDi44gbLBEbeWUh6ZiHpWcDItIpRKDOvLDcxM8dEL6MyL7NCLzk/dxMjMFyW1f6J3sH4
	6ULwIUYBDkYlHl4BIc90IdbEsuLK3EOMEhzMSiK8VxZ7pAvxpiRWVqUW5ccXleakFh9ilOZg
	URLnNfpWniIkkJ5YkpqdmlqQWgSTZeLglGpgbF/Rtd3WVv1HW+SUmg3aW+ZcFFeXNXb6+XHB
	l3vTJ2lebzt96mtr8Tcf7eD+bVkfxff+iWISeCP6QmbD8TlFv74YhzQ1LV/WXmppJGD4/aC4
	0QzOvXnyCgqx/OtndMRyzd+gnJK4819pkV3ZhyshH5OU7nk5FPlsP621P8/V9bXHglVfnmuW
	K7EUZyQaajEXFScCAIP6xJ4TAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKJMWRmVeSWpSXmKPExsXCNUNLT/datWe6wdMLrBZP/v9mtfj87DWz
	xeG5J1ktDn99w2Txe9sKNgdWj02rOtk8Xmyeyejx7baHx+IXH5gCWKK4bFJSczLLUov07RK4
	Mi4eCiw4x1WxdLpqA+MHji5GTg4JAROJ3kOXWEFsNgE1iSsvJzGB2CICkhJ/7rSydzFycTAL
	tDFK7Nrwgw0kISzgI3Hk52SwIhYBVYkdvZuZQWxeATOJ51sWsUIM1ZR4vP0nO0RcUOLkzCcs
	IDazgLxE89bZzBMYuWYhSc1CklrAyLSKUSQzryw3MTPHVK84O6MyL7NCLzk/dxMjMDCW1f6Z
	uIPxy2X3Q4wCHIxKPLwCQp7pQqyJZcWVuYcYJTiYlUR4ryz2SBfiTUmsrEotyo8vKs1JLT7E
	KM3BoiTO6xWemiAkkJ5YkpqdmlqQWgSTZeLglGpgFPOYKfu9eFVNkoL1lpbq1QdXutRMupAl
	NDu/kv+ciXHrzry6Vq9dPVzXF3m76HoxbC48GdG39Nmu83HuPRVn7A4o7Klj+m+eu7Tyhtnx
	vkyN11ONClMDSzf+Fpy/Ulb/r92ebBdlgy/qHC1ZuRcKHTtur96Vkt9T3ifncvhtqPNJ+e9Z
	KyOUWIozEg21mIuKEwEmrAvmCAIAAA==
X-CFilter-Loop: Reflected

While testing DAMOS_MIGRATE_COLD action, Yunjeong found that the
quota->charged_sz is way less than actually migrated size.

In damos_apply_scheme(), quota->charged_sz is used when checking whether
the quota exceeds the effective size.  The current implementation
accumulates the charged_sz with sz(region size), but many pages in the
region might be discarded by DAMOS filters.

In order to make the quota calculation more accurate, charged_sz is
better to be accumulated by the actually applied size, which is
sz_applied in the code.

Reported-by: Yunjeong Mun <yunjeong.mun@sk.com>
Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
---
 mm/damon/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 511c3f61ab44..dd1b56466650 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1390,7 +1390,7 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 		ktime_get_coarse_ts64(&end);
 		quota->total_charged_ns += timespec64_to_ns(&end) -
 			timespec64_to_ns(&begin);
-		quota->charged_sz += sz;
+		quota->charged_sz += sz_applied;
 		if (quota->esz && quota->charged_sz >= quota->esz) {
 			quota->charge_target_from = t;
 			quota->charge_addr_from = r->ar.end + 1;

base-commit: adc218676eef25575469234709c2d87185ca223a
-- 
2.34.1

