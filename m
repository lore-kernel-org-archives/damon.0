Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6AE36F8EF;
	Thu, 17 Sep 2026 04:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789617947; cv=none; b=XZ04kvDwQNn/b7agft8AB1PkaJyjUtUY5LskY/NX+5nspAbPHhFFOLMTxymE05Qxzobdp8S/MLQM3vyYFSOjDbmGWeWr5y+CD2lVGBPrk0TkVLScAp30Z6QV2niOE74A+INhe0Vt2E4K1FiS4CBTiaLhIKIUz+GicCYbN9oBNq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789617947; c=relaxed/simple;
	bh=NXCRujdGIBQWcx3QoFqBYX3ebJsqZFeo3MOtKblmGTg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sOnOVczWv9/ls8HDaRi9zd8b+pCR6lpVmwmoLh/296IsmrHg+kHC3Z3q8Zbu4XeFMpNkH+mTHY/aG2v0dAokWyV53YUEIF4K7HkStzr27fxZBb+hTANVuDrF1uJj05U9XQw8C3aoigf6L9cKXx6zANUj9XrF7pMw03Qg9ph8Jn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A8eLihI6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A8eLihI6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADB531F000FF;
	Thu, 17 Sep 2026 04:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789617945;
	bh=9Dc5CanTIf6GDg8K6CuoIgCUBKSe5DtyaqsQ5FEzOQU=;
	h=From:To:Cc:Subject:Date;
	b=A8eLihI6td8S+vpQQSmsaa4nza1N6dwTkWhljnrghlXxKhwUtHQcHV3f60xGquklE
	 gdkk+YnXjULAwsEC1kFlGu8zHoV1mpbXvkDR7YH3CL16DleKd+drLkSiJx6v0ARN6E
	 X3hfyMAWZVvv836IH6qVd41lNPI9wVVQ8ssx1RVm+++Et41g5QtRg/s0/OBFnM/d7J
	 omUnHQthRetlCVNRpI0JQ0MBpwAiIqp/W+gmQbEMnO+xJz/5YhNrLbSi9s+QPnOBfw
	 1uEiusobFr8fNv7vGDF8zfTrtUA8O9CeY+TRq10HB4vizboofjUBKK+VQFLiUem3qn
	 qbFSHwdVepHeg==
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
Subject: [RFC PATCH v2 00/10] mm/damon: improve readability, clarity and test coverage
Date: Wed, 16 Sep 2026 21:05:26 -0700
Message-ID: <20260917040537.107341-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Yet another batch of miscellaneous DAMON minor improvements.  Mostly
focused on readability and clarity of code and document, and unit/self
test coverage.  No user-visible behavioral change is intended.

Changes from RFC
- RFC: https://lore.kernel.org/20260912200814.145612-1-sj@kernel.org
- Fix a typo in the selftest warning message.
- Collect A-b: from Randy.
- Split out damos_adjust_quota() fix to an individual hotfix patch.
- Add a patch for initializing walk_control_obsolete in damon_new_ctx().
- Add a patch for probe_hits_wsum damos filter commit kunit test.
- Trivial patch sequence update.
- Rebase to the latest mm-new.

SJ Park (10):
  mm/damon/api: remove NR_DAMOS_FILTER_TYPES
  mm/damon/core: use abs_diff() in damon_feed_loop_next_input()
  mm/damon/core: use mult_frac() in damon_feed_loop_next_input()
  mm/damon/core: set damon_ctx->walk_control_obsolete in damon_new_ctx()
  mm/damon/core: document damon_call()/damon_start() race hang issue
  mm/damon/paddr: remove pa parameter from damon_pa_filter_pass()
  mm/damon/tests/core-kunit: test eligible_mem_bp commitment
  mm/damon/tests/core-kunit: add probe_hits_wsum damos filter commit
    test
  selftests/damon/sysfs_memcg_path_leak: fail only for real DAMON leak
  Docs/mm/damon/design: clarify bp is basis point

 Documentation/mm/damon/design.rst             |  5 ++--
 include/linux/damon.h                         |  2 --
 mm/damon/core.c                               | 19 ++++--------
 mm/damon/paddr.c                              |  5 ++--
 mm/damon/tests/core-kunit.h                   | 30 +++++++++++++++++++
 .../selftests/damon/sysfs_memcg_path_leak.sh  |  7 +++++
 6 files changed, 48 insertions(+), 20 deletions(-)


base-commit: b7c76a308c2afda7cfc2ce98be3eed466be71337
-- 
2.47.3
