Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13EA3164A1;
	Thu, 28 May 2026 06:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779948676; cv=none; b=inFVAVk0r7bZNbIR6IlumftS7OOJjserXmSDnXLSz1+56ubo1/U7g6SX1lIM1E2BX2tquS53zKhXRD91m7FBme9IlX2Q38K1Gg/sECJJPIkVCEhoVN64ducJG7Xepl5MeFBXKsCDRfUFOLvbQYqvDVSpbcV2zGxIvE9XcpL1Md4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779948676; c=relaxed/simple;
	bh=AdN/hy8tqgKT4tGivSx63b8BAAWdMuJmHpvP00ByD3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BqoxEZXxrYYjN/nQ/Ce60ixJ64p2o6v+yb61a5pLyiF/f69WTJbV09Sr0TzedIeOU1wLUEg+yOQS1haTO33rjsDWJ7kAI7yY9MBbKlCOCR7ng+oPeqnFKIFA/oUhE1qyS2tnnlQ8dODIDplrgO6DO1r0cBVgfC+YNY28707lX1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P2HFd18d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P2HFd18d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B53B1F00A3A;
	Thu, 28 May 2026 06:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779948675;
	bh=CK6rWCS8LFvFBXjfIvuhhFhQ6PGQWXZdEx0+rj0MOdk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P2HFd18domNKumdoIIHBwF8uHemGwchF21D3CA9EBJFnvRfXOa8fkRnaDoyoUWtJl
	 Smker7kFu8138R2Kspd+I5A39u/cMwQufI2DZwBZZ2v61T7Y4dN62+c9NLEG2ssEj7
	 fOqbyV4KLhMe5HlMfeDdyZdwwYOwgcU25lgjv2bSWjVpA4do6l1vaHWP1f6P5+uVnU
	 sSZrvPauOQbxhh/LWk5qrbEA1Vthcpwmq0ZVZCI1o+FAKQoZ6uBkbQkSfWSX+GQzY9
	 PwZ/IB3qDzaYOOzhThQhavaBcVRqccP6zmSs7s/VtjG9uGjnb1MIEoWH1nsRMkLsTt
	 TV5Y2DUrEQnaQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 18 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 1/2] mm/damon/reclaim: handle ctx allocation failure
Date: Wed, 27 May 2026 23:11:08 -0700
Message-ID: <20260528061110.2172-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260528061110.2172-1-sj@kernel.org>
References: <20260528061110.2172-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON_RECLAIM allocates the damon_ctx object for its kdamond in its init
function.  damon_reclaim_enabled_store() wrongly assumes the allocation
will always succeed once tried.  If the damon_ctx allocation was failed,
therefore, code execution reaches to damon_commit_ctx() while 'ctx' is
NULL.  As a result, it dereferences the NULL 'ctx' pointer.  Avoid the
NULL dereference by returning -ENOMEM if 'ctx' is NULL.

Fixes: 3f7a914ab9a5 ("mm/damon/reclaim: use damon_initialized()")
Cc: <stable@vger.kernel.org> # 6.18.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/reclaim.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index ed446d00ef1cf..ce4499cf4b8b0 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -399,6 +399,10 @@ static int damon_reclaim_enabled_store(const char *val,
 	if (!damon_initialized())
 		return 0;
 
+	/* damon_modules_new_paddr_ctx_target() in the init function failed. */
+	if (!ctx)
+		return -ENOMEM;
+
 	return damon_reclaim_turn(enabled);
 }
 
-- 
2.47.3
