Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85DD3803C7;
	Thu,  2 Jul 2026 21:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783026375; cv=none; b=Gb17xM5q+0rAB8+vXtceHD7Dgo0sQvIwgf7hNUBCVrOSbN1TFeOw064auYU8p24g/r/j5BYPS04MInYtg48echbkfaiVuDkmr/1kPTVH1/dpsPsB4U6y1Rgxlx7dR8Bkz90S3IXBBLiRuEHPYrHb4bXzUrzkwdBAFJEz05AFXV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783026375; c=relaxed/simple;
	bh=goEuQ34q9K5GCZvxlQ4oxqPzSXhD969gZ0WIrYhCgNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q52wqLY3cgmt3Srw+u8Sq4cuKvPYRU7AWBAdA3zJn7bn0L5S/9BmrdJnnP3GpZb/ZT+2AZu7PnMANT9YlMGzr0wz+ulT+lqAZTnzPfOYo8qGNeDuWqjRzFCDAUgynr02Pnyc+euEDBprrrZokSehDG+78BM4Nii9xb77FKvANJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XjJmr1gQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XjJmr1gQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1F951F00A3E;
	Thu,  2 Jul 2026 21:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783026374;
	bh=3BUtL0wdhRHBCOaPZNQsX8fjUI9m5nC+jbrg8ueFSt4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XjJmr1gQ51HXvJVpcXxk/bKSPfbeoxDgQExOGa2UWh8rMvyKzhr1k4+rn794A4jD1
	 Uncize0oEBLHFHMtajttgUcGKDfZPq128HITOPFHWlO2nezZAyDKmIc5NZgF1QVIJ/
	 +g1Ixii4KVAr1aCJhWnW1P1tQbB0WJJc+6yYap7s9rWM1FyXTSt9K1lNDPXbC+OaeM
	 IABNn7MGGQVgVm1hJbOwakWUajkzQS3e4YECRdaeh+4izzNvjFT8sDJ/QwayXDNe7Y
	 d6aMfWSqftpt+BRoHY+bHJZ4Ic1PXEo8mYk7aBYTCK/5lQdp8dRiEaiGc+kj3OPcwE
	 +WYi6Ms0NAj0g==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 7/8] mm/damon/core: remove start, end check in damon_set_region_system_rams()
Date: Thu,  2 Jul 2026 14:05:49 -0700
Message-ID: <20260702210551.95167-8-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260702210551.95167-1-sj@kernel.org>
References: <20260702210551.95167-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_set_region_system_rams() validates user inputs to avoid creating a
negative size region.  But DAMON core avoids zero size, too.  The check
is incomplete.  The complete check is done inside damon_set_regions(),
which is eventually called from damon_set_region_system_rams_default().
Drop the incomplete and unnecessary check.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index ca301abcb9ec5..3c5a46e1c079a 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3846,9 +3846,6 @@ int damon_set_region_system_rams_default(struct damon_target *t,
 {
 	struct damon_addr_range addr_range;
 
-	if (*start > *end)
-		return -EINVAL;
-
 	if (!*start && !*end &&
 		!damon_find_system_rams_range(start, end, addr_unit))
 		return -EINVAL;
-- 
2.47.3
