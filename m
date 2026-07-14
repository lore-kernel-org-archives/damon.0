Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC2647CC6A;
	Tue, 14 Jul 2026 14:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784039758; cv=none; b=KZeFYplk7p4BN8CWWAYqB2zLMk/HKGuSS6d1iCEyl+HIqnU5cCbkh5YKS4Xh7ORqMP/cA0IHqWR7m4aBauPakLUvUwI18td1nxXU0gk3IuAw4BmC/Gqt5jmjIBeBHOqetq9sTWvGZTrs5WS/kl40LF1cN87hITZZ8HzXrqT1WKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784039758; c=relaxed/simple;
	bh=IivE0CWKTdcUn47+Hm3ucbbgQtvBEUhe8axmDQs6bPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i3LsKVvmYXP0hoBNsRWe8lc2XfOC+fOhQmKnG0KLXqAplVvgx6DncVyLwAkArRmNWnHV85V6MpGbGKthvh0PQoG0GBaCKNsfD0qQWU3rDHgW6fAZGdZ+KuU6Hm2WJPzExEm71HGmiof3asaXGvhFDwoC4tgPWQ/fJD6lBQSBEIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gVRY1QaL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gVRY1QaL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D6B01F00A3D;
	Tue, 14 Jul 2026 14:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784039757;
	bh=OgmQTZfSicG2akeujY0x1j+uFMrq86YzkqctonivABI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gVRY1QaLUrnENVs/P6aecaAsLZJDki8N5Y9dQKHfDc9nig/jiF76Q0r58NFLrmaj/
	 ihSLl7NALNFXfpeSQSwl37bMGd9kSgnNCzoU8F/SBs9UEe4G3Mt+ZPD5g9gWvlYL7c
	 lamxCU932bBFGApJ7w7+54iPHXXFC61uIvb7ofYIr7u1EqRa9DpRoFrcKNJDLqwJCM
	 GNw2B1QrN8hmwOyszVwrZ6GGu6VaDtDJmon56hPOztKv9QMEDE5Yq1YeMnALd4Rw2A
	 2Cm2KNj63xEM9B3qt0VW/KzYvmxreAoLhjc/2OJ6sAuuMmRpsetl+DjkDIfJERn+J3
	 Ah6AaN9gQUJ9A==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 07/10] mm/damon/core: hide private damon_filter fields
Date: Tue, 14 Jul 2026 07:35:40 -0700
Message-ID: <20260714143544.101305-8-sj@kernel.org>
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

damon_filter->list is intended to be used by only the DAMON core layer.
However, it is mistakenly not marked as private.  Mark as private.

Signed-off-by: SJ Park <sj@kernel.org>
---
 include/linux/damon.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 907d65f03d083..6c3c7c75b6ca3 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -758,7 +758,6 @@ enum damon_filter_type {
  * @matching:	Whether this filter is for the type-matching ones.
  * @allow:	Whether the @type-@matching ones should pass this filter.
  * @memcg_id:	Memcg id of the question if @type is DAMON_FILTER_MEMCG.
- * @list:	Siblings list.
  */
 struct damon_filter {
 	enum damon_filter_type type;
@@ -767,6 +766,8 @@ struct damon_filter {
 	union {
 		u64 memcg_id;
 	};
+/* private: */
+	/* Siblings list. */
 	struct list_head list;
 };
 
-- 
2.47.3
