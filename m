Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9098A22157B;
	Thu, 30 Jul 2026 04:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785386394; cv=none; b=nMrUmPtavA4qWoxLPitvBTGQClePZyCqetjnU+rUuBV8ZhagCrXA9r4eX2GwGNqmB+FrDp6rQsAv3JZh7POchR8YH6g3ftFEgWG7uhhXjMRF92L7QUKD49wkLIch6cdOzahCmG61iouY32RIypY37P0UxEllW+dA0YS+IgHQ0SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785386394; c=relaxed/simple;
	bh=4zXbnYQtTX7Ayp/vWxKMzodi3LSusWKERxKqTN93nkk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J8A0/q0QGMphckmP2Z9CHeBUOdg015LQZx6jn8FpyFx/DJqd1iMeWiLx4ZYXsa6jl/P8vhjkmwlMEobdpn3vYo/N1b0shmDxYXZiTGmkByQ5CB418LgxVup+x+0sotoiS74M+lmJLg+PHg6GYaMEfemkKrxt5yeeSux+DXnWeKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FR4wtcsf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FR4wtcsf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E4F21F000E9;
	Thu, 30 Jul 2026 04:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785386393;
	bh=MCnIYPHXEtymrst9y69RVa8dORmSOaA8BOJP/O1Ug4Q=;
	h=From:To:Cc:Subject:Date;
	b=FR4wtcsfp9dA6J8+G5x9tNShj0PoD1NOFtyiZTJZTa7O6JUEI9XbBhqUf9qOgDpJt
	 Z2tBCQjOvVCjBqXd1w4eZ7l/ugyw4zBWwnxv5dfUVGQIJkAA/xXXOpF9pkfnxOXSdn
	 AU4kqC7qghZKggdMeQZANgWlvAeu7SSNobAFY8fDVfqe/ANpOJ1NQTLqihArR3clMj
	 nPK45o0gHnsFeD+N3rB6hgrJ55MjYz18lhGEu8Xb0jIom+uGU3CsItct1O+0JjVUri
	 DuEwhHpYVfyJg0wZL4FRg23HlZ1U0ZC4m7WWxIamJ+ya8XdZvkGXs9qlkBTKyqt58s
	 ik7CizPG6arMw==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 0/6] mm/damon: add kunit and selftests for probes and probe weights
Date: Wed, 29 Jul 2026 21:39:37 -0700
Message-ID: <20260730043944.146030-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON recently introduced probes and probe weights.  Add kunit and
selftests for ensuring the parameters for features can be set using the
core API and the sysfs ABI, respectively.

Changes from RFC v1
- RFC v1: https://lore.kernel.org/20260729144738.90895-1-sj@kernel.org
- Fix a typo, memory leak and NULL dereference in kunit test.
- Fix ignored error in selftest.

SJ Park (6):
  mm/damon/tests/core-kunit: test damon_commit_filter()
  mm/damon/tests/core-kunit: add damon_commit_probes() test
  selftests/damon/_damon_sysfs: implement DamonProbes
  selftests/damon/drgn_dump_damon_status: dump probes
  selftests/damon/sysfs.py: extend commit assertion function for probes
  selftests/damon/sysfs.py: test damon probes

 mm/damon/tests/core-kunit.h                   | 124 +++++++++++++++++
 tools/testing/selftests/damon/_damon_sysfs.py | 125 +++++++++++++++++-
 .../selftests/damon/drgn_dump_damon_status.py |  32 +++++
 tools/testing/selftests/damon/sysfs.py        |  35 ++++-
 4 files changed, 314 insertions(+), 2 deletions(-)


base-commit: 1e413a0c40e2aca4a55f9ba664b2b7ac2a03c9da
-- 
2.47.3
