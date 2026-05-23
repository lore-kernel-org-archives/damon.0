Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4534E269CE6;
	Sat, 23 May 2026 19:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779565338; cv=none; b=McsN1GLV+Szq9WS8xmrYgXukh4Po9N6l+nKgTWYAbF7qcnxEVjwziMXX7DKJwlDBbR8nyBgsCG8v4jI87BALzNsuaRgCtZpgSlCk79+rARjm2hPFAD6ySXqagOuCd24bV0gVL2KSOdAc15QCKZ7Mv1rEuAVkiORHuVsvWvJD9Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779565338; c=relaxed/simple;
	bh=KS0apBN1XRqwicdwqaX/VzGLx0vlBetTwL5SGo/LME4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ssS8CHNxgyGr0hUOhryG2rY8VW6d/cod2el0ltm3/sI1HvRqV+SSlvxcYeTjDascNddVIDpmicsh/cA5SyQPScUtQOpQl3ac+YrsR33y723pCeKTwi6tiGXTTJK8c4jg52+8SqeUqQ4RPo0SPtgvPkKetN/Y7hpVmPI47cBKZa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CbF9hMJT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CbF9hMJT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E7EE1F000E9;
	Sat, 23 May 2026 19:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779565336;
	bh=het8FaTsHSVHQ3fcgyyduLT5OvVhYs/8Bwvfiz3v2yQ=;
	h=From:To:Cc:Subject:Date;
	b=CbF9hMJTTz5QsL72pa67E3YIzwGtl6x39fJVnc2mgv7FQWFmCF1mle9kIX8mYLSMS
	 OkgA6ZWx9k/EcN8BkjNZ6IcT/W6ojTRLCesM/4lZVVCM6nJYVkHerNG8i7cJHw142t
	 l7YkVyTuVGA4cJseGykYRpezfadMOIur2SVK5dPC3WtgrKm27nNKkxijc7iXGV3Zsw
	 QI+jA2UeoMmdIHD+0WNBaGatK9CZqNxEpXLlMA/qbYJqHgk0mD41Uk+6xAmEr0+PiL
	 qqYWFEcFQpqGDo1foNyZYu86k8rKBxXGwr4eB5lK5qYW7YKdbRb+O6Slf/vrz9olDW
	 bF8a1tC8+j0yw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"# 5 . 15 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Fernand Sieber <sieberf@amazon.com>,
	Leonard Foerster <foersleo@amazon.de>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH] mm/damon/ops-common: call folio_test_lru() after folio_get()
Date: Sat, 23 May 2026 12:41:42 -0700
Message-ID: <20260523194145.93122-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_get_folio() speculatively calls folio_test_lru() before
folio_try_get().  The folio can get freed and reallocated to a tail
page.  In the case, VM_BUG_ON_PGFLAGS() in const_folio_flags() can be
triggered.  Remove the speculative call.

Also do the folio_test_lru() check right after folio_try_get() success,
since it is more likely than folio realloc race.

The race should be rare.  Also the problem can happen only if the kernel
has enabled CONFIG_DEBUG_VM_PGFLAGS.  No real world report of this issue
has been made so far.  This fix is based on only theoretical analysis.
That said, a bug is a bug.  A similar issue was also fixed via commit
3203b3ab0fcf ("mm/filemap: don't call folio_test_locked() without a
reference in next_uptodate_folio()").  I don't expect this change will
make a meaningful impact to DAMON performance in the real world, though
I will be happy to be corrected from the real world reports.

The issue was discovered [1] by Sashiko.

[1] https://lore.kernel.org/20260517234112.89245-1-sj@kernel.org

Fixes: 3f49584b262c ("mm/damon: implement primitives for the virtual memory address spaces")
Cc: <stable@vger.kernel.org> # 5.15.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/ops-common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index 3a0ddc3ac7196..d3404615f9b75 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -32,9 +32,9 @@ struct folio *damon_get_folio(unsigned long pfn)
 		return NULL;
 
 	folio = page_folio(page);
-	if (!folio_test_lru(folio) || !folio_try_get(folio))
+	if (!folio_try_get(folio))
 		return NULL;
-	if (unlikely(page_folio(page) != folio || !folio_test_lru(folio))) {
+	if (!folio_test_lru(folio) || unlikely(page_folio(page) != folio)) {
 		folio_put(folio);
 		folio = NULL;
 	}

base-commit: a94d68c2dfd523cebb2755787fb01c08eef70c43
-- 
2.47.3
