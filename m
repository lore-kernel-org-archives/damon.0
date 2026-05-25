Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744DA3ECBFE;
	Mon, 25 May 2026 16:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779726189; cv=none; b=eVKPiGoGTl8XhHlfTg8pT2bWDxxZTCeVJrIaRouTPdJ+zs9vsfVgGwdjpPf6UFGgAK1l+ZSFjLk2yowJQs1cjqsRn+BDLU+1hiuyjkfGFFcrVr4wDDpo7ULPNfRqNDe6P2eObcwtiUiKCkAQon83ho7Y1WQi6KzdpmYEXx/dAlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779726189; c=relaxed/simple;
	bh=KhpruursnkuxGvSOAEO1JI0BFq7XSBO+Um0OF8jFXfU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bu/LDhMbKl7h4ynaPJ9z189/DfIySuRNlqNeTpMc4D/LoOZkaFL8aZyJ8VEru5lXO7HMAPhZfS/CZrJ3zogH/0K3qpFCSL68gngQAG+oM5EAxPrh4+bf2Zu8RY8kKmk1ZqXdYim32apGxEB9BTPGsNNRMeCBSrCdDVuBYVOMRWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=epl3SeXk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="epl3SeXk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D11661F000E9;
	Mon, 25 May 2026 16:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779726188;
	bh=syrlMagaAWzZj87W1TAgw6fED2o86tpCAUGW85ijOD0=;
	h=From:To:Cc:Subject:Date;
	b=epl3SeXkn4O51H4a+ydWW9elKLAVc6xYmuQfY5OcIILu9xbmW1rsWJUJcdyFbhrxm
	 FekQzkQdCTnQztYFCoFqoW9D+eNJdRQRi6MJW65zMLXDQkg734VtbTCRa1DRVgo7BZ
	 yhlcZmab7WfkDWrb51g3aqpaSKvtPRsk31HEknajolSZs4/qChdFn1II72DXpwrNGt
	 6giArn4QIcoDmbt7A1q6H9cGaVapUKi93VyHYTZ17u23Ao4KFWKrc8+Iqp6o78ZaRy
	 w4PG4hKA1K8OXkCw0ZlXHk6X/v77BAYHG9V2aeDuUE2/WPdIZWOsuE7phb9YSokrnN
	 qty9VQRf+md2A==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"# 5 . 15 . x" <stable@vger.kernel.org>,
	Fernand Sieber <sieberf@amazon.com>,
	Leonard Foerster <foersleo@amazon.de>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH] mm/damon/ops-common: call folio_test_lru() after folio_get()
Date: Mon, 25 May 2026 09:22:55 -0700
Message-ID: <20260525162256.8317-1-sj@kernel.org>
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

Also mark folio_test_lru() check right after folio_try_get() success as
no more unlikely.

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
Changes from RFC v1.1
- RFC v1.1: https://lore.kernel.org/20260524174608.81112-1-sj@kernel.org
- Drop RFC tag.
Changes from RFC v1
- RFC v1: https://lore.kernel.org/20260523194145.93122-1-sj@kernel.org
- Do not change post-folio_try_get() validation order.

 mm/damon/ops-common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index 3a0ddc3ac7196..5c93ef2bb8a97 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -32,9 +32,9 @@ struct folio *damon_get_folio(unsigned long pfn)
 		return NULL;
 
 	folio = page_folio(page);
-	if (!folio_test_lru(folio) || !folio_try_get(folio))
+	if (!folio_try_get(folio))
 		return NULL;
-	if (unlikely(page_folio(page) != folio || !folio_test_lru(folio))) {
+	if (unlikely(page_folio(page) != folio) || !folio_test_lru(folio)) {
 		folio_put(folio);
 		folio = NULL;
 	}

base-commit: 4901db133abb670b369af93cba9af99c5be0eb0a
-- 
2.47.3
