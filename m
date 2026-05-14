Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912343F4127
	for <damon@lists.linux.dev>; Thu, 14 May 2026 07:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778744999; cv=none; b=lqcKIATTQuh0wljNfngFtnLgbHPx//Do/+5lhsHxieLt0sApNtOw0iWCvOxJwubUef6fCY51HQ6Ac0iIVeh65wAAyHqqU9Vw/u6XSUJj/BZQ7EDP5kJ5hWhxg7slmQJ1nh4vNmcMv7+s2mbCfK9MTVTA0ApyF7omz+DHH3doM1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778744999; c=relaxed/simple;
	bh=yOQklVrPZGT/JM5tw3IpFc1+38nRlLVCKU9WuLWPDaM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FwDWboQPNY0KnV8aFgPy9Ghqm3Lj3bq3aUVSnLB9owun7fYDo8bVFo0DkBMgHhOmlUhK1r4vhZGyUsFpJ00rtS/IEsE/gzyHWa3XJX3vv4T30lhHJn/gBvCv9jz6JbPs91hxvh2ZPxQ3Zra5auhJyGZMyqYxOoQ06Lf56ZPvyLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=ghy2H9bV; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="ghy2H9bV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1778744950;
	bh=pKTqojM/V0cbc3/HlhyNeRdXjdESyH/Mqh9A6SdRWzA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=ghy2H9bViOMcVFvaZKc9SDkDZJg2JlNNpMTOR26JDsvXw5sR4QsVv6MAZksxrTWq6
	 m8bq5HyEDevVvKVPH1YL40lavNIhomiyLDVqq+c27Nj2XCe9EtBOHHEffgM4xfhgsI
	 4EIkFN949P+FJxbhKb/aFi8oxe9TIn95C9+04VCQ=
X-QQ-mid: esmtpsz20t1778744937t882aa529
X-QQ-Originating-IP: t4JR6FDlpu7PnX2nSsNg47MmTk9Aj1uuNgDI/hu0pGA=
Received: from PEN1097 ( [61.183.83.60])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 14 May 2026 15:48:49 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 10419003516767972258
EX-QQ-RecipientCnt: 7
From: niecheng <niecheng1@uniontech.com>
To: sj@kernel.org
Cc: akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel@uniontech.com,
	niecheng <niecheng1@uniontech.com>
Subject: [PATCH] mm/damon/core: recalculate intervals tuning deadline on attrs update
Date: Thu, 14 May 2026 15:48:46 +0800
Message-ID: <7946CE4E0773AEF7+20260514074846.3258908-1-niecheng1@uniontech.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: N76rkG23tQ5KrkmKH08ZmRRLUXZwvZbJ9KW2lohhC9Kcjnyc+p3IwnI7
	AY1of18aTLESjkHQtZfSJ2xloiTAtQ6NW/FJquxJAKky2tM/mwxKtIsFjqLVue+0w5QWvsV
	VffYrNet0Z8i4EWVIpBBuMnrk3iJQx3yGEArHJpp68+wfHb3CWk9QZqyJU82jWRCDtD5Q97
	WkVG/CItbj/yLi7MIkWSDAWjPmOCF8L1EoYyVOhkqw5bGJ1XeB5YUPnmZg47hKECfrH/nk+
	KS+YnMnvbi/uAXpVwMGj00cZF+upD7mCDD28TKsVZRQkBqELAGxoG31NMybR00W0kFrz9vM
	nxoejCsps1/SnhPN9qoSMI2k7fyvidilc1R7wh2TIpAnn5nwvovDgLaYmzUGfgTWc+qKgab
	qh+oKJbPgtZ158SZlzbf5Et7VirM0ibTMnD+SkAu+BmycKCPdHmsU2agY0Bp7VSGt3GsPlg
	UdmSyBEDrbRRU0oqitxM+eVg1lIZSrgIN3Kz59Lnblw99u/cf854pgf5mqdoCJu+1o3nB2z
	CKPIsKb8taCe33O3dHJmSR5z1IBAo/J6i5fnhcWoCmSB57Ia215zkvSr0qeI2qBeyUbbQiX
	opOpEKsHFExaVQmU6bK1qTlbnfZsnmu2JzB9F8XlAk7g3+QDYdzYzPzwa/t+WpDNtxCN3UG
	6jsQCyZnPc0L4g0pezq5YpUX9pKOmH0AEIq8P4tYSGKpqqoZ3ADOzTH5ch0aiRaIGk1QVTv
	a84Vo2OTIxdgGZpcQ4bcfn3lZ35nBLiZS9O3CoNwksM7gBInIzkH2Z1VI63d3BeZBi6nNpp
	/7UQTLU8iTJsNB0cjLbgqNizVxdIfIZ/k8iD4AKH2rd1htqtc7ZwHrQsfaDgWuktaMtljg6
	uNWnYUKxEPo8p5M8+mIqkSgsZUGwENr0IhECf230Rne2VrVuXjZaICKPvQTxswN81Z0Vi5O
	nbWoGu0UWR90ofhe3Dwae2okMIGFZaexypePizZjatJuhnvo1j6bEWMaI9CuIzDWtkyjrl0
	cUdjJeJKQLZmE+BAKEaTuUX9+AeJ3CYl0dTZKz/vWMANBGsTqK4oMAhTt0yE1FOQa6SVim9
	DTLUnfzJVrLMbERMl7Nhf0VgB54giKSi0XRkB4D3RnV
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0

damon_set_attrs() refreshes next_aggregation_sis and
next_ops_update_sis for online monitoring attribute updates, but it
does not refresh next_intervals_tune_sis.

Because of that, enabling intervals auto-tuning via an online attrs
commit can leave next_intervals_tune_sis stale.  If a context starts
with intervals_goal.aggrs == 0 and later updates attrs online to set it
non-zero, kdamond_fn() can treat the tuning deadline as already expired
and tune the intervals earlier than intended.

This has been possible since the intervals auto-tuning feature was
introduced, because that commit initialized the deadline at kdamond
start but did not refresh it on later attrs updates.

Fix it by recalculating next_intervals_tune_sis in damon_set_attrs(),
using the same passed_sample_intervals-based schedule as the other
runtime deadlines.

Fixes: f04b0fedbe71 ("mm/damon/core: implement intervals auto-tuning")
Signed-off-by: niecheng <niecheng1@uniontech.com>
---
 mm/damon/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 3dbbbfdeff71..501694d4a590 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -797,6 +797,8 @@ int damon_set_attrs(struct damon_ctx *ctx, struct damon_attrs *attrs)
 		attrs->aggr_interval / sample_interval;
 	ctx->next_ops_update_sis = ctx->passed_sample_intervals +
 		attrs->ops_update_interval / sample_interval;
+	ctx->next_intervals_tune_sis = ctx->passed_sample_intervals +
+		attrs->aggr_samples * attrs->intervals_goal.aggrs;
 
 	damon_update_monitoring_results(ctx, attrs, aggregating);
 	ctx->attrs = *attrs;
-- 
2.51.0

