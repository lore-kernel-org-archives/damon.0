Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78CA2882C5;
	Sun,  5 Jul 2026 16:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783267316; cv=none; b=Z6WNOXMYP0fQAdfo84n1AJh7arZTHel1NHykWd9SwwHBgoZPc2vy0goTG8mkzp/qVrfRAPV+zDpG94bi0IVKBAJ6xrIUwBb77aW++RcHdBpyv8o6iJIEEZrD+LlOpjOj6mKBOtqGsWytR5L3stgyQ9QB/GU+fMtjnYLInC9zNKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783267316; c=relaxed/simple;
	bh=apYwkYgjta09iatlAqcBQzxffoVQ7J1TTsvqhGbrFRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xt6iWSeU4U4itndpBfcjpZmULPDlbjyzvDnFJ3tB4Z3p5oESmUgPtskIMIsHe2+I/rPEd3xibBIESOua18lYv1fW5dEWJkJuHHO8BxXroZjJEII1sZtK5mahrTy0BbaQ6TqpCnEySLD2yP84l/kJ3Zuapd2QHKpnXEKuoZpE/MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJJvjOw+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJJvjOw+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 810E41F000E9;
	Sun,  5 Jul 2026 16:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783267314;
	bh=LS4CO1+OYp8+pSPAS3NbVTVyYCl94ZecPiNEYxC3hmA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CJJvjOw+X6UtTg/lqL8ZVRUh/RVGx5PxK8snE+ZqCeomdOQujflFk2FFHiNvl/ZU1
	 XCTYp0V5Rb+fDuKcpVCgjaW4mQHjo90kKMw7DYWgETVIOnPptF998uTG9ZVl4jS4J4
	 4aa4ROrn8scaihdX1hzjiincl9U4+xjFLpR1zYLc0g6hzrTUn/nayP7tuEkKRPgE0D
	 xTNiqNiAJoirtyFYLFT06snKihTDgdYVWpNLB0xU5RQmAtrJcRy1d8fwA6kZW+GPSe
	 Ur6QkN/Ki7SFOMBfR/InNxVACrwyMdyC1SDzMgbtrODZYUPRA49OgW4u/eAV5QBwL0
	 ylQc/V+mVDeog==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 08/11] samples/damon/mtier: stop all contexts with single damon_stop() call
Date: Sun,  5 Jul 2026 09:01:35 -0700
Message-ID: <20260705160142.97308-9-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260705160142.97308-1-sj@kernel.org>
References: <20260705160142.97308-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_stop() was theoretically able to return failure while keeping the
second context for mtier running.  mtier stops its contexts one by one
with two damon_stop() call for the reason.  damon_stop() is refactored
to always successfully stop all requested DAMON contexts.  The two calls
are unnecessary.  Use only single damon_stop() call for all contexts.

Signed-off-by: SJ Park <sj@kernel.org>
---
 samples/damon/mtier.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/samples/damon/mtier.c b/samples/damon/mtier.c
index 90881e8bd441f..ac9c24b92ead8 100644
--- a/samples/damon/mtier.c
+++ b/samples/damon/mtier.c
@@ -200,8 +200,7 @@ static int damon_sample_mtier_start(void)
 
 static void damon_sample_mtier_stop(void)
 {
-	damon_stop(ctxs, 1);
-	damon_stop(&ctxs[1], 1);
+	damon_stop(ctxs, 2);
 	damon_destroy_ctx(ctxs[0]);
 	damon_destroy_ctx(ctxs[1]);
 }
-- 
2.47.3
