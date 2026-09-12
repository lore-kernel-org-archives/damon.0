Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D549735E1A4;
	Sat, 12 Sep 2026 20:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789243703; cv=none; b=JAyX9AixjiqdZz4KkwLQZkBNpBBI9XWhaZCMa0F4Onuxb3T+HxJuuYC1rr2n/OWea3mC6lPWvKpWAvH6XH/Dud29gjmaor6kdoHJpFnw5f8RTj5HQGx9lZwnV84jrdqh3/nqcN+6HTo4T1sZZ9Up7TY9PUnknM3mT64oJAkF7Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789243703; c=relaxed/simple;
	bh=hJLrGRH7hMZevIGqxaK2GIdc+TUH4/mbpEfoq2JX9Ss=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fGrsAeYOvgsxEDe3peoZMO3++A2HE2fFE0IucyOU2HD6QYCMEd1yuI5x0fZjjdwkcpVIbDFMxeFd/mtSoHlld/zmsY5G/SRaoYIa7HuM0yWqsWtfq4AOCn2BTJ87g8aBL30RvkQZLKIxI9ClSDKiUqfNgKOhNVtPiRyWNIRo+Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GyP7s0R6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GyP7s0R6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2F541F000FF;
	Sat, 12 Sep 2026 20:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789243702;
	bh=smoUNIlPKQ1+ngX9XR4JYb0EDk9zUK6MJ9A9qAFnTbA=;
	h=From:To:Cc:Subject:Date;
	b=GyP7s0R6uwhKk24TKjL48orriQZnS140dDGxiVVZo8TROSrOXjYvzTCiTQLHx+kna
	 Jbgoalm/05tCAcssJSx0GXakZDREjI0bO2Z5lbYEFSSGNWue9vvl6wh07MJjV7npJV
	 eG2Si86iG90PkubUg5Zrgw8D/Wz/gpP+QjrFyonFZHyLsc9BXg8SKj55xJz2vNZZC5
	 F/JLWgdXwIlveZGqnYHAEPTLzSf/F6ZR9jcmt3vlZEpMTeu08eNBdptNw6QZIRQ6cG
	 G487KL3gQIA8/iBxVsgSHREo0ZsHonuO3oCl/Un5Iuv+qKg/D5sGsg7+IcY62GuB1n
	 2/mBQjg3UBzCA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <shuah@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 0/9] mm/damon: cleanup, clarify, and add/improve test
Date: Sat, 12 Sep 2026 13:08:01 -0700
Message-ID: <20260912200814.145612-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Yet another batch of DAMON overall cleanup.

SJ Park (9):
  mm/damon/api: remove NR_DAMOS_FILTER_TYPES
  mm/damon/core: use abs_diff() in damon_feed_loop_next_input()
  mm/damon/core: use mult_frac() in damon_feed_loop_next_input()
  mm/damon/core: use damos_quota_is_set() in damos_adjust_quota()
  mm/damon/core: document damon_call()/damon_start() race hang issue
  mm/damon/paddr: remove pa parameter from damon_pa_filter_pass()
  selftests/damon/sysfs_memcg_path_leak: fail only for real DAMON leak
  mm/damon/tests/core-kunit: test eligible_mem_bp commitment
  Docs/mm/damon/design: clarify bp is basis point

 Documentation/mm/damon/design.rst                |  5 +++--
 include/linux/damon.h                            |  2 --
 mm/damon/core.c                                  | 16 ++++++----------
 mm/damon/paddr.c                                 |  5 ++---
 mm/damon/tests/core-kunit.h                      | 10 ++++++++++
 .../selftests/damon/sysfs_memcg_path_leak.sh     |  7 +++++++
 6 files changed, 28 insertions(+), 17 deletions(-)


base-commit: f0cc06ae989195d7280e0e7eff9d963ddc056d27
-- 
2.47.3
