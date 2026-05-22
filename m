Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339E546AED8;
	Fri, 22 May 2026 15:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779464436; cv=none; b=BEDzHxIqtTdJjTCm9GmImeIETXlaBrEORTo9knUBJ8CzTT/nS4ihPlKnbkh1DoenGqoCdPBav/TVOqfvnc8vXwWQ7lKHJ6taf7yMqz0e7sq4u9D+SX8Ww/e70rEkEUMTOUQKBcOU3+WVntVNkuvJ9CJNz74dfUOr+TTu9xMkLdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779464436; c=relaxed/simple;
	bh=8B9IiCSCXwYFGO3g7QwEtxLcmC3JtXQgAOF4um9StEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fPYi8Zg0yan3GTgXZqVaB/TnrnK5Dt61aDekLFTYBdDevKl2MKhTu1OX/N0PlMLFkf9Kw1doIMDBLfP5yyg/senVh9dDOmLFKwuvGn/iqcruza2u9+RRj+1ARS+BbSiPnCV+aAuTTcCJd9K8XI7ud8B9ZO0aLZGwT1k2Aew387I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nu6VHVgr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nu6VHVgr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D35231F0155A;
	Fri, 22 May 2026 15:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779464435;
	bh=5i2WVbg2PjBsmn2NfpjKEh0VGjqNajgL/l9BFto2EhQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Nu6VHVgruu3i1j8InZ3IPJtcExdnKay13YJBkyCUQ48XduMjG2pcmZ9zkw2Vr0fy5
	 a4KkCmYBcV9WIDg30+/K98YB8sPiUuIwG4pnALMEr0Mvq9g8ZHTSZxLYwLv93nv2hK
	 0oPhnfylfUCfivCF6F4ucOp5Dr14CBiYUE6cHHbXldp5xNFXrivwYfmKh7ij5cSMQt
	 rhWU/SmOHjvDnI4naPoyhQQmak5wYbMZeZgzpTILPwda4USVrDM0HraeGCx+UOen/e
	 bBD8tYmINrQQuPRr92HOJZi7qAlMp8A4KVmpwMFOc2ttz9HgXEidQBv4rbgInb9OSJ
	 N1THtg4BC2DZQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 01/14] mm/damon/core: safely handle no region case in damon_set_regions()
Date: Fri, 22 May 2026 08:40:12 -0700
Message-ID: <20260522154026.80546-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260522154026.80546-1-sj@kernel.org>
References: <20260522154026.80546-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_set_regions() calls damon_first_region() regardless of the number
of DAMON regions in a given DAMON target.  damon_first_region()
internally uses list_first_entry(), which clearly documents the list is
expected to be not empty.  Due to the internal implementation of the
macro, damon_set_regions() is safe for now.  But the internal
implementation of the macro can be changed in future.  Refactor the
function to explicitly and safely handle the empty region list case
without depending on the internal implementation.

No behavioral change is intended.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 0267faf216b95..40946a7f6f549 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -356,6 +356,19 @@ int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
 			damon_destroy_region(r, t);
 	}
 
+	if (!damon_nr_regions(t)) {
+		for (i = 0; i < nr_ranges; i++) {
+			r = damon_new_region(
+					ALIGN_DOWN(ranges[i].start,
+						min_region_sz),
+					ALIGN(ranges[i].end, min_region_sz));
+			if (!r)
+				return -ENOMEM;
+			damon_add_region(r, t);
+		}
+		return 0;
+	}
+
 	r = damon_first_region(t);
 	/* Add new regions or resize existing regions to fit in the ranges */
 	for (i = 0; i < nr_ranges; i++) {
-- 
2.47.3
