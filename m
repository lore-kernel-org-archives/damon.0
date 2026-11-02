Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793633881;
	b=A0xTK7kgYBLRFbhgoNc+Vhi03Ps5/kn8Zs/VjI/QzB17mo/R46gbYBlR1amkerAXcbUy
	 /Tj82JwGgXI/xW/qJUiQlhVmEiW+O4b5CzJIIk/k/ih0T0PWOUpkx5IAdZZV8btu0l08N
	 /tfTlzOfcpRQ23O7F0rrQ7VnLNtCRBw7c3zp0vxmDfZTolWXiG8afRBjPgpB0VnKvYPwk
	 YuduvHPT2utmUPKnt9XJTjnW0H2oTYMJM5I/9ftNOQG25xWgO8cWKknFcnWk05eIqCT0b
	 nOS9zXg5WvI3GdJiaEWlCqvxvRVUxoH8Ueot2Mfaf73Tzob/NI3K+yXFlAGNzTLE/7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793633881;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=HQ5iEJDd3H6McsliLZtnU2nxiMLxTdJWIHt/2r3Xqjg=;
	b=bKwxhxLi0Jw0qiea46Qum0RSFlEt90PvB/xqpc/TUsdP4yjYbyZ2VpsortSDcrG5s9II
	 vZdCkVAfmH6faR4ftoHmI/8WIuVhL5p79YZdbK3uAAT9qigPClzXxo9Tm4RAYrFLHR9HM
	 JonTPO6d6qjxWPRMsYtNlvZDz0xiMpZhfzHqOvuvPZZDgp+4nTElx2uejt+k30xyc1ZFO
	 vyqlytWFSm7aucVlTC7p0U8x/+EVv158k01sOi51LO2b2f7jtkhieIDFuvTVibYeI3UQh
	 ZB9Ll96oDbm6zh2cyJc60U3+Fsc13+VQ5LqHi/gWFK3IL9e+t2LW+GWYXkLGV4mce/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VfgQ4f4Y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D30606B0E7;
	Mon,  2 Nov 2026 15:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VfgQ4f4Y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC9EE1F00A18;
	Mon,  2 Nov 2026 15:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793633881;
	bh=HQ5iEJDd3H6McsliLZtnU2nxiMLxTdJWIHt/2r3Xqjg=;
	h=From:To:Cc:Subject:Date;
	b=VfgQ4f4YF8xUMeOwRSjd+ce9pq6NJIOWViRmrMp8Jml3Oa7TP8RqCe3Il4g8VUOMw
	 NIhvAY/UTIowFzMfc0PZIrkpZdnoBpFzLBqYMj6kg/z6uQuM6+yrMfleheyliZMbdm
	 lBTxwXJm8w/B+qV+j4TThUFnxe8zpQ2CCVcHdsg4gVIZ5pFpzlyH8dKeOKo98SJxeF
	 p1L1Cpf5lFXA1nUdrojIb9g6+1xwOxeRkpZeLvT3vE1YVgQRDvpOm9roa/ZwNq49/t
	 /LCpSQH4KcrVWgY8OHnqR23p73R3lUDY801WsAsTcNvBvO5J1oLXwSh+Z7DRd1bBBM
	 UcK1ofvR63KJA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v5 0/2] mm/damon/core: iterate over installed probes instead of DAMON_MAX_PROBES
Date: Mon,  2 Nov 2026 07:37:50 -0800
Message-ID: <20261102153753.97769-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Suhaas Joshi <suhaas@s-joshi.in>

There were two "todo: " items of the same nature in mm/damon/core.c.
Both of these suggested that we should iterate over only installed
probes while updating (last_)probe_hits[] during merging/splitting
regions, instead of iterating over the entire array, which may have
empty/unused indices.

So this patch series does exactly that. It replaces the for-loop over
[0, DAMON_MAX_PROBES) with a damon_for_each_probe() over the probe list
of the context.

Reviewer note.

These patches are based off mm-new. They pass all KUnit tests related to
damon. I have boot tested (but nothing beyond) on qemu-x86_64. Please do
let me know if I should do any specific tests and link the logs here.

The series has been tested with mm-new fetched on Oct 14, 2026.

Changes from v4
- v4: https://lore.kernel.org/20261015135533.18761-1-suhaas@s-joshi.in
- Collect R-b: from SJ.
- Remove/separate messages in cover letter that not suitable for commit
  message.
- Wrap cover letter for 75 columns length.
- Rebase to latest mm-new.

Changes v3 -> v4:
1. In some places, kunit_skip() was being called before freeing
   resources.  This is correctly ordered now.
2. In some places, regions were not being freed. In v4, they are being
   freed.
Link to v3: https://lore.kernel.org/damon/20261012145636.168436-1-suhaas@s-joshi.in/T/#t

Changes v2 -> v3:
1. In test functions, new probe and context allocations happen after
   target, region etc have been allocated. Further, target is added to
   the context.  These 2 changes help in reducing allocation code and
   improving simplicity and readability of the patches. This change is
   true for both patches.  (on SJ suggestion)
2. Earlier, if a function's argument list required multiple lines, I was
   aligning these lines to the opening paranthesis of the function. In
   v3, these begin after 2 tab spaces. (On SJ suggestion)
3. damon_test_last_region_quota_reset() uses the older version of
   damos_skip_charged_region().  Make it use the new version.
Link to v2: https://lore.kernel.org/damon/20261008151944.113714-1-suhaas@s-joshi.in/

Changes v1 -> v2:
1. simplified commit message of patch 1 (on Liew's suggestion)
2. wrapped all lines at 80 characters (on SJ's suggestion)
3. added comments for new argument in function (on SJ's suggestion)
4. added damon_ctx_destroy() in r2 failure case in
   damon_test_merge_two() (on SJ/Sashiko/Liew suggestion)
Link to v1: https://lore.kernel.org/damon/20261007154851.45368-1-suhaas@s-joshi.in/

SJ Park (1):
  mm/damon/core: copy only installed probe in damon_split_region_at()

Suhaas Joshi (1):
  mm/damon/core: use only installed probe in damon_merge_two_regions()

 mm/damon/core.c             | 57 +++++++++++++++----------
 mm/damon/tests/core-kunit.h | 84 +++++++++++++++++++++++++++++++------
 2 files changed, 106 insertions(+), 35 deletions(-)


base-commit: 79e2e91bd5a4b213cf40819c2711a9364b2c0f86
-- 
2.47.3
