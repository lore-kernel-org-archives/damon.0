Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293593749F4;
	Sat,  4 Jul 2026 18:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783188707; cv=none; b=qZlJQlOA3w3hssWCEnj9wh+220TV55l2vlT4LgeFu62zByhNpDBWUzyTfqynNJmNwcRsNYQhxs9lmYudJoOlGEdKUfQkwTcYFaILJt8+xXakSZIVUGwq7CsehbVr0d3CDXmrdRRJFfm9wKvEXUw+bjR++xPW0bkDsWG2dC2h0xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783188707; c=relaxed/simple;
	bh=GcM9WomvUelKQMvW2BzflF22wI+CxMC31EP1q4nla1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WqtXFcYprn6wOtVWF+1QLnMKA3rGtrLJdYPJyi8k2wLczLEbI3RnZcdfRCfW0f8k9NFQcvK7QxxR+AAnBxRILfEHGMSmCvXrIXLiH1CengWVHvO4HyFMbC8fABnsdScBZa+VcgEu5A1oiWDKVCsqtbO3GEnmH3ksIanzATus86w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dWzj0rNe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dWzj0rNe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D27D81F00A3F;
	Sat,  4 Jul 2026 18:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783188706;
	bh=iM2Eb2ExS7GI1ym8vhWA/m10zp74Amrd4zSKSC4zHiE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dWzj0rNehdXjgnHmvP2SvRyGTlmdNS1ZLdg1+GnC52ueSO4Mm3a8QznUvmieKUZ+N
	 nsSC0Zfh9MrnVyi8SAq1lxBxNJULRmIWbXkLIXQV6RllnHrsqFZ1udwnYx+CD4W5e/
	 KiIICcOVC+/p+ObNMHa8hLIPFvD2aCZq7O7oDR5AMlxEM0O3VxZyMZe+xfs7j3Uxxw
	 mEyiDjSlpeZUabHMNUAkAY9jhMi3Bzyk9IzHw3yk4hYVIr8LDa8f0UnVx+LGPTPlB4
	 JUkY7RxPUEXuFRZ0YY02FkFwbW9Cp4FdPBujvag7RUtNuII553OMacjjNs9q0URspN
	 eZ+3IFi3mVmUQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 04/11] mm/damon/sysfs: ignore damon_stop() return value
Date: Sat,  4 Jul 2026 11:11:27 -0700
Message-ID: <20260704181135.132956-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260704181135.132956-1-sj@kernel.org>
References: <20260704181135.132956-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_stop() return value is guaranteed to be 0.  Ignore it.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index b65651498e0d1..6d7e36c9e509d 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -2262,12 +2262,13 @@ static int damon_sysfs_turn_damon_off(struct damon_sysfs_kdamond *kdamond)
 {
 	if (!kdamond->damon_ctx)
 		return -EINVAL;
-	return damon_stop(&kdamond->damon_ctx, 1);
+	damon_stop(&kdamond->damon_ctx, 1);
 	/*
 	 * To allow users show final monitoring results of already turned-off
 	 * DAMON, we free kdamond->damon_ctx in next
 	 * damon_sysfs_turn_damon_on(), or kdamonds_nr_store()
 	 */
+	return 0;
 }
 
 static int damon_sysfs_damon_call(int (*fn)(void *data),
-- 
2.47.3
