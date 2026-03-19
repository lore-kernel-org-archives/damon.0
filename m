Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED34B39B97D
	for <damon@lists.linux.dev>; Thu, 19 Mar 2026 07:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773904422; cv=pass; b=dFUh/ui0EJNAhTVcuijMo27iThn3YoDTAWVymV8JYckVPPVg/4Vg/7ohtZBnjZIz/iJhq+imZ+9Wq1Z/gIQh09i+Y2lJVZi7mLmOK4dHYrtr4/zHUVBmY7QKIwZ2OhZgidyKG8VBaj1QvsSg9vXqxH71j8NJqUCFh+DUke+oiXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773904422; c=relaxed/simple;
	bh=hl6TiOyWIdXS7+5Yp2HUwRvKG1yG2m26Thb3UhFVXTw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=VMqwd7NS20wj0QxCjo6SZQaGVRI/sfpxcqIIPocXT3l84LBYIFo1pVS9x2KauvaykaPN2Phcf8MWA6jcKbEgj1RjwiRyCY/FH7gVLCq1T1IZiWhPFm+ezH2EfTED592on7DmDjj+2EzgsfbVAekS2Nraf0dDuNb/ukGIF0SIbEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=bl6C6JqH; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="bl6C6JqH"
ARC-Seal: i=1; a=rsa-sha256; t=1773904417; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=Ad24VfB+MUKu68AZvMRzCGH/b1nuGKsakSv5Zjpi3xe68he7O2d6BLkLfZ1sGp6uinu3v/5ISQxx2oEvY5yRifV3MN2WH9+9aWCqaeEQE6+Y+VdozjdEKKddjyoiTg5N6c7de3oiShy/4nstmqWGdOsT4DN+PYSSokxIsjUeyPE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773904417; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=UT1ydfwXPd3Q3RW4yJjBz4iIolylIWtotzA2B7Dbsus=; 
	b=YBpcU24zmCm6mEIKMoLUWbA8ULRd5XcRSaIG5cS1awEWccyQq0E3F3I/HnOqxVAq2vfLeYpzUtj+rnKTRkJijQpFfY4G74zeUg5UT9V0ZxtArv8bQch7PENwvxNo+zP94kFxsfnlFdq5eGKV8DTHS2Mgn57sQr5LhlVGYGjnzik=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773904417;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:Reply-To;
	bh=UT1ydfwXPd3Q3RW4yJjBz4iIolylIWtotzA2B7Dbsus=;
	b=bl6C6JqH07NsBSuzRUhUCG6GznJhwrYkjPgFUwaK3Tb9gf+a/A1mhDRN4vy+ZaXj
	tsBgfIOHPNww0ZqEe35xb57GueeZ5LTlA0W5Qzd1tmgFuQAfqSZJZBmctQFkUNKlvG1
	DI7zpjBdVTX1flAHOIWvJFiIx81RA4CnjdyFFBTg=
Received: by mx.zoho.eu with SMTPS id 1773904415172769.0909205214978;
	Thu, 19 Mar 2026 08:13:35 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH] mm/damon/core: document damos_commit_dests() failure semantics
Date: Thu, 19 Mar 2026 07:13:32 +0000
Message-Id: <20260319071332.114595-1-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Add a kernel-doc comment to damos_commit_dests() documenting its
allocation failure contract: on -ENOMEM, the destination structure is
left in a partially torn-down state that is safe to deallocate via
damon_destroy_scheme(), but must not be reused for further commits.

This was unclear from the code alone and led to a separate patch
attempting to reset nr_dests on failure.  Make the intended usage
explicit so future readers do not repeat the confusion.

Signed-off-by: Josh Law <objecting@objecting.org>
---
 mm/damon/core.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index e233eb84a2d5..c884bb31c9b8 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1054,6 +1054,23 @@ static void damos_set_filters_default_reject(struct damos *s)
 		damos_filters_default_reject(&s->ops_filters);
 }
 
+/**
+ * damos_commit_dests() - Copy migration destinations from @src to @dst.
+ * @dst:	Destination structure to update.
+ * @src:	Source structure to copy from.
+ *
+ * If the number of destinations has changed, the old arrays in @dst are freed
+ * and new ones are allocated.  On success, @dst contains a full copy of
+ * @src's arrays and count.
+ *
+ * On allocation failure, @dst is left in a partially torn-down state: its
+ * arrays may be NULL and @nr_dests may not reflect the actual allocation
+ * sizes.  The structure remains safe to deallocate via damon_destroy_scheme(),
+ * but callers must not reuse @dst for further commits — it should be
+ * discarded.
+ *
+ * Return: 0 on success, -ENOMEM on allocation failure.
+ */
 static int damos_commit_dests(struct damos_migrate_dests *dst,
 		struct damos_migrate_dests *src)
 {
-- 
2.34.1

