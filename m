Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A22257449
	for <damon@lists.linux.dev>; Tue,  1 Jul 2025 08:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751357987; cv=none; b=GOQ8SkUWxmWs86sp/KcmV7Ij+SuGOrtv+Wmn1Fs4jppET40Lg26IH6D+GnGs6BGY4yGFYEsLKQCanvVI3GBSgfj+S+F9SRd2ca66gsao8hB5hKOiTNhaHnN9FZorUiVQz0KRRa67lbRIIkISbCvegrKvWgqkcvwft4uQAdXLx8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751357987; c=relaxed/simple;
	bh=bM6L6Z8keUQZQfOwf8Hem9xRKtXzpA//SghMYFSIw2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RJ8WoRXbp1KJCwOjGLW/8uIcMIw/JpzqPHiP3o6z6MkDT7urcntbwsK0iil+OicX9q8TFOVyBqWWctRUOaube7793JtsrTbI3pKIrEAZ5uz9PekYnA5UDD9fd1smyfcSbXe+9JGn40m2QIN6uDElA2hNit8XKWnRamvAOTYCqgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-ce-68639a14f4a2
From: Honggyu Kim <honggyu.kim@sk.com>
To: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	kernel_team@skhynix.com,
	Honggyu Kim <honggyu.kim@sk.com>
Subject: [PATCH v2 3/4] samples/damon: fix damon sample mtier for start failure
Date: Tue,  1 Jul 2025 17:19:25 +0900
Message-ID: <20250701081927.1873-4-honggyu.kim@sk.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDLMWRmVeSWpSXmKPExsXC9ZZnoa7IrOQMg0071SzmrF/DZvHk/29W
	i3tr/rNaHP76hsmBxWPTqk42j02fJrF7nJjxm8XjxeaZjAEsUVw2Kak5mWWpRfp2CVwZkx7d
	Yizo4ajYu3AeYwPjebYuRk4OCQETiQ/L7rHD2G9nX2QEsdkE1CSuvJzE1MXIwSEiYCUxbUds
	FyMXB7NAE6PExl+dYL3CAv4Snc+ug9WzCKhKHGtdD2bzCphJdE2dywgxU1Pi8faf7CBzOAXM
	JVbdAVslBFQy78ENFohyQYmTM5+A2cwC8hLNW2czg+ySEOhhkzjTNhfqNkmJgytusExg5J+F
	pGcWkp4FjEyrGIUy88pyEzNzTPQyKvMyK/SS83M3MQLDcFntn+gdjJ8uBB9iFOBgVOLhnXEy
	KUOINbGsuDL3EKMEB7OSCC+fbHKGEG9KYmVValF+fFFpTmrxIUZpDhYlcV6jb+UpQgLpiSWp
	2ampBalFMFkmDk6pBkalzY9vmdnOT/+T46417YXkjY9sjSZV35ZEFC6/XflI/2e8+P9iv3es
	7zrtP+0Ms9175AZTa9lasymLeScbKcmpCjkW/11Sp2o3W0d3zQYVH1u+hZejWldz2JacnVLP
	9lU022LVFM5pHBOSXl1z5rZ6nLn0oEzOokXf7t+Kishe/H1K/r2kzKVKLMUZiYZazEXFiQCz
	iYXDPwIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDLMWRmVeSWpSXmKPExsXCNUNLT1dkVnKGwcUPChZz1q9hs3jy/zer
	xednr5ktDs89yWpxb81/VovDX98wObB5bFrVCSQ+TWL3ODHjN4vHi80zGT2+3fbwWPziA1MA
	WxSXTUpqTmZZapG+XQJXxqRHtxgLejgq9i6cx9jAeJ6ti5GTQ0LAROLt7IuMIDabgJrElZeT
	mLoYOThEBKwkpu2I7WLk4mAWaGKU2PirE6xeWMBfovPZdbB6FgFViWOt68FsXgEzia6pcxkh
	ZmpKPN7+kx1kDqeAucSqO+wgYSGgknkPbrBAlAtKnJz5BMxmFpCXaN46m3kCI88sJKlZSFIL
	GJlWMYpk5pXlJmbmmOoVZ2dU5mVW6CXn525iBIbZsto/E3cwfrnsfohRgINRiYfXIC8pQ4g1
	say4MvcQowQHs5IIL59scoYQb0piZVVqUX58UWlOavEhRmkOFiVxXq/w1AQhgfTEktTs1NSC
	1CKYLBMHp1QD4xYTsYe+SgcYe+KWaRVNYjgnmJk/5eKOiZ4130tSa95MObXw+5u17Re7ljXU
	tPnYvXqXcf3GxYyN226q3ljeytNqULPqUqfjjA83ej7l/7ht+KL2JpeKjvX0o+sXTW//frrx
	u2TFwb3h1qeY5P/a1m9WeFzRfW5j73fLjL7k3U9/FCX6dX517FBiKc5INNRiLipOBADDxOO7
	LwIAAA==
X-CFilter-Loop: Reflected

The damon_sample_mtier_start() can fail so we must reset the "enable"
parameter to "false" again for proper rollback.

In such cases, setting Y to "enable" then N triggers the similar crash
with mtier because damon sample start failed but the "enable" stays as Y.

Fixes: 82a08bde3cf7 ("samples/damon: implement a DAMON module for memory tiering")
Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
Reviewed-by: SeongJae Park <sj@kernel.org>
---
 samples/damon/mtier.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/samples/damon/mtier.c b/samples/damon/mtier.c
index 36d2cd933f5a..c94254b77fc9 100644
--- a/samples/damon/mtier.c
+++ b/samples/damon/mtier.c
@@ -164,8 +164,12 @@ static int damon_sample_mtier_enable_store(
 	if (enable == enabled)
 		return 0;
 
-	if (enable)
-		return damon_sample_mtier_start();
+	if (enable) {
+		err = damon_sample_mtier_start();
+		if (err)
+			enable = false;
+		return err;
+	}
 	damon_sample_mtier_stop();
 	return 0;
 }
-- 
2.34.1

