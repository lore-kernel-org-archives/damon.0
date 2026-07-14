Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9356D371873;
	Tue, 14 Jul 2026 14:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784039756; cv=none; b=f6pos+ghQDnebUpWZEl6+U5mMTWWcD2TGzu1WdTriOsYZ9KY48BizRzPO1cVULkrcTU8DaclDjb73mIDcz/EFdQvp0gWmPNcjTBzW1iQTAOrSqrdT99Bi7TWAv87k2vb7g4gROAU+S0nGLWSr5MVjZrKvul4pYNpdo4ag3Y92z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784039756; c=relaxed/simple;
	bh=28KQrfeI2zvjHjr6PuDX7oyWWH3SuTV6OXLAVtISIPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mTPEuTOkovBpZWqHuWIRDp6uymNPgEj08H416H2vd5a/tj4Il7WgMu2qWGBKvUMJTpTUI1kJEJNQCreikFljzqbRr97DjK21RTzfsGZt9U0RuB+di1/zB3d6VIBgS16Y/3MFnHgQLYy0RHQuPJgWSBjbOBwl2OHYZvbjSGxs9sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vj/BABRE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vj/BABRE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54BED1F00A3D;
	Tue, 14 Jul 2026 14:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784039755;
	bh=O1GFuFV6Qv2wWJnuvFbk/HsH8hWm9YYqEFf3m4C5iW0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Vj/BABREgxJ45Eq0THUdsbJ+Y7Nr2s7nVxZfZ0/tGYE5O3c3SFkc13S+4+AXyGOXA
	 F6c526SxtCDgkpMIEzF4+HaJjj0BcKk9uTdvv8KHyyj0MuQrRxdXYMoyaZqSdjdJz4
	 CLyaH/cFiv3Xzrhystp9gfOWOws/xKcwTdFhpU81euVo8ngs8He4oWgVG+YT7m1/Y+
	 3bzdDfMcIDCiYBLRWVvISdgI2bfyA/YNBGqGixvP4HFrGvbXTHQR9J2rV9E9K9aw4N
	 ZHvI1kBF8tq1Y+WccD0ToAXESh3XkODL0RyDgDM6k9/AU4KWRg6icJNjQXOEgp9joK
	 oZ9aQGRo3masw==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 01/10] mm/damon/core: hide private damon_region fields
Date: Tue, 14 Jul 2026 07:35:34 -0700
Message-ID: <20260714143544.101305-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260714143544.101305-1-sj@kernel.org>
References: <20260714143544.101305-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_region->list is intended to be used by only the DAMON core layer.
But it is mistakenly not marked as private.  Hide it from the callers by
marking it private.

Signed-off-by: SJ Park <sj@kernel.org>
---
 include/linux/damon.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index f69442a9d4312..d32377e7e535e 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -46,7 +46,6 @@ struct damon_size_range {
  * @sampling_addr:	Address of the sample for the next access check.
  * @nr_accesses:	Access frequency of this region.
  * @probe_hits:		Number of probe-positive region samples.
- * @list:		List head for siblings.
  * @age:		Age of this region.
  *
  * For any use case, @ar should be non-zero positive size.  damon_set_regions()
@@ -68,9 +67,11 @@ struct damon_region {
 	unsigned long sampling_addr;
 	unsigned int nr_accesses;
 	unsigned char probe_hits[DAMON_MAX_PROBES];
-	struct list_head list;
 	unsigned int age;
-/* private: Internal value for age calculation. */
+/* private: internal use only. */
+	/* List head for siblings. */
+	struct list_head list;
+	/* for age calculation. */
 	unsigned int last_nr_accesses;
 	unsigned char last_probe_hits[DAMON_MAX_PROBES];
 };
-- 
2.47.3
