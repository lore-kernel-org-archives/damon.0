Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5050D202995
	for <damon@lists.linux.dev>; Tue,  1 Jul 2025 08:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751357986; cv=none; b=RNzgK0P384zNwdm56fhZ85ANfqTn53z6nmsjRU3hOhCxl9N5d4/P+JyWfdJF7pLqqHwY0DobrD+q/TdfRvfRBCXGGPVcbc5kBQ3pt268dau5L+TBNVIqHMn2AOYQWBumH7p0xaPu5RTceBKe72ON8V7DxCZSxcqLU611PqpFqBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751357986; c=relaxed/simple;
	bh=lEwnSDFcrwBDT3J0G+lACOJmzjSX5u/DfM1CD4eFVyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eqg1UWJg3Tij9EckZibHIwtnmrk9KJkzq2nkXY4oO7Xd+1CGCdpEmuP6z9BjBqXQWB2kp+d3KXB5/GinppyqTsWYLzo6uCrd2uNR2pfSaidZeEV+79A9+b3SvPMZmCVPyqtcA2QXxf0HuTM4vKagg0cJAs2HRF438L0xCoGqr68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-cb-68639a144534
From: Honggyu Kim <honggyu.kim@sk.com>
To: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	kernel_team@skhynix.com,
	Honggyu Kim <honggyu.kim@sk.com>
Subject: [PATCH v2 2/4] samples/damon: fix damon sample wsse for start failure
Date: Tue,  1 Jul 2025 17:19:24 +0900
Message-ID: <20250701081927.1873-3-honggyu.kim@sk.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20250701081927.1873-1-honggyu.kim@sk.com>
References: <20250701081927.1873-1-honggyu.kim@sk.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDLMWRmVeSWpSXmKPExsXC9ZZnoa7IrOQMgzUPhCzmrF/DZvHk/29W
	i3tr/rNaHP76hsmBxWPTqk42j02fJrF7nJjxm8XjxeaZjAEsUVw2Kak5mWWpRfp2CVwZu+9f
	Zipo4aiYuOoUWwPjMbYuRk4OCQETiV/n1zDD2B+ubmYHsdkE1CSuvJzE1MXIwSEiYCUxbUds
	FyMXB7NAE6PExl+dYL3CAn4Sfx72sILYLAKqEks3/gabwytgJjF9zhx2iJmaEo+3/2QHmcMp
	YC6x6g5YWAioZN6DGywQ5YISJ2c+AbOZBeQlmrfOZgbZJSHQwyaxdsJrqDmSEgdX3GCZwMg/
	C0nPLCQ9CxiZVjEKZeaV5SZm5pjoZVTmZVboJefnbmIEhuGy2j/ROxg/XQg+xCjAwajEwzvj
	ZFKGEGtiWXFl7iFGCQ5mJRFePtnkDCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8Rt/KU4QE0hNL
	UrNTUwtSi2CyTBycUg2MDdE64hPFq71ChC/s4xd8ac1+wmJTI3vxgaVnA675Mjcfv3LF1b7j
	+4dZ25MlLgQayR/4eyhng+T5fRJvzp91Ytz3/9LsKKPkxeuVerwKOTVEF6cd+WE4y3A2i4Cu
	iNbye0wn7Q1Tu5U+tbdMfLNNjG9q6BrX2z6dGvvSE3xCPxtuudsY9+muEktxRqKhFnNRcSIA
	IZpz3j8CAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDLMWRmVeSWpSXmKPExsXCNUNLT1dkVnKGwcWprBZz1q9hs3jy/zer
	xednr5ktDs89yWpxb81/VovDX98wObB5bFrVCSQ+TWL3ODHjN4vHi80zGT2+3fbwWPziA1MA
	WxSXTUpqTmZZapG+XQJXxu77l5kKWjgqJq46xdbAeIyti5GTQ0LAROLD1c3sIDabgJrElZeT
	mLoYOThEBKwkpu2I7WLk4mAWaGKU2PirE6xeWMBP4s/DHlYQm0VAVWLpxt/MIDavgJnE9Dlz
	2CFmako83v6THWQOp4C5xKo7YGEhoJJ5D26wQJQLSpyc+QTMZhaQl2jeOpt5AiPPLCSpWUhS
	CxiZVjGKZOaV5SZm5pjqFWdnVOZlVugl5+duYgSG2bLaPxN3MH657H6IUYCDUYmH1yAvKUOI
	NbGsuDL3EKMEB7OSCC+fbHKGEG9KYmVValF+fFFpTmrxIUZpDhYlcV6v8NQEIYH0xJLU7NTU
	gtQimCwTB6dUA2N33+3jlywEa/9J15R7GG22kFuwiKvje+6Ru133mXK1n9qtzK3Um+9wMfzb
	eadZU44nb/0ef7FnbsiBBw/+Cp60+uy9/9i/K/kS960FdvhdKnY8PPFARnEvQ9Zi8bDr8Z+e
	y4b9DWrhuX7hdvGfh0stTc6ov4740TubV8ou/0XeJqe9J/vmhX1WYinOSDTUYi4qTgQAtb8G
	oi8CAAA=
X-CFilter-Loop: Reflected

The damon_sample_wsse_start() can fail so we must reset the "enable"
parameter to "false" again for proper rollback.

In such cases, setting Y to "enable" then N triggers the similar crash
with wsse because damon sample start failed but the "enable" stays as Y.

Fixes: b757c6cfc696 ("samples/damon/wsse: start and stop DAMON as the user requests")
Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
Reviewed-by: SeongJae Park <sj@kernel.org>
---
 samples/damon/wsse.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/samples/damon/wsse.c b/samples/damon/wsse.c
index 11be25803274..e20238a249e7 100644
--- a/samples/damon/wsse.c
+++ b/samples/damon/wsse.c
@@ -102,8 +102,12 @@ static int damon_sample_wsse_enable_store(
 	if (enable == enabled)
 		return 0;
 
-	if (enable)
-		return damon_sample_wsse_start();
+	if (enable) {
+		err = damon_sample_wsse_start();
+		if (err)
+			enable = false;
+		return err;
+	}
 	damon_sample_wsse_stop();
 	return 0;
 }
-- 
2.34.1

