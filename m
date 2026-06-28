Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49397083C;
	Sun, 28 Jun 2026 22:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782684499; cv=none; b=PEaIJ7vIV9NUfZMXPAHMGUUkWM6p07Eu6mKLVoZfsihlE2V7dDfk41A0/TbVI38JNkjy7oWdMEk6rlWX9sXDlWRHO7tCPtBpbsMM5M3wmfMxx1TzDokrLp4+7dDRtc+ms74J8NcRdIpewK7Vx918qQ2ZStius4o1LViKq7cGdV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782684499; c=relaxed/simple;
	bh=xi4dySetMaLQzI+DRSqLrUhWh41Pu4AnxZsXfXWvpnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ds4mSe0FTyTbma2Zc9iSlOuFYR8FBe+yJmOqGlooegUQhwcDJU1borKl+tC/AG7wuCCdLGYCXvsDPc/BVEnIWOphtJhG0fOAlTQTzghwWteTDHxhpkZDID+dKdtUz8j1DiPczYoWNBQMi+438Jyf66x1gnhOy+x4o6nd7MbnTb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BF9E1F00A3A;
	Sun, 28 Jun 2026 22:08:18 +0000 (UTC)
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 1/2] mm/damon: add a kernel-doc comment for damon_ctx->probes
Date: Sun, 28 Jun 2026 15:08:03 -0700
Message-ID: <20260628220808.98931-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260628220808.98931-1-sj@kernel.org>
References: <20260628220808.98931-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix below document build warning:

    WARNING: ../include/linux/damon.h:909 struct member 'probes' not described in 'damon_ctx'

Fixes: 18c777859f28 ("mm/damon/core: embed damon_probe objects in damon_ctx")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Closes: https://lore.kernel.org/4df95955-b255-4e5a-90c4-35db02f3111f@infradead.org
Signed-off-by: SJ Park <sj@kernel.org>
---
 include/linux/damon.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 783d921075f25..535f675625724 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -841,6 +841,7 @@ struct damon_attrs {
  * including damon_call() and damos_walk().
  *
  * @ops:	Set of monitoring operations for given use cases.
+ * @probes:	Head of probes (&damon_probe) list.
  * @addr_unit:	Scale factor for core to ops address conversion.
  * @min_region_sz:	Minimum region size.
  * @pause:	Pause kdamond main loop.
-- 
2.47.3
