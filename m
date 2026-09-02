Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B8149F11D;
	Wed,  2 Sep 2026 14:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788357819; cv=none; b=eG/VJxVoAG74j3KhN0tPqXGToAShMCJggmtvdVImXyK04xi0vnYPgvAE8FfoS2W+EFsRNgpYHOUmJtDjVxbGJwUKqph39eS2sjtczQVbb840BMbiXIjNepTwfYbTz6jRoMC8S1Z9FZidQ/JKgS7q5a4hDCpRZ1faGkrQS8TyBVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788357819; c=relaxed/simple;
	bh=3AUUhSOGIPkfJkx7fmj3iAuuCWTbyLEC82+rE2YlVVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fmi/3U411iO4R5TJqP7DoAOhg0N+jKIvRh6kfYN+mAVUuVP5cNuThBWyB/wOmNbs4YRkbqShN5c74mcEn5U4/VlH4aSKiK0NoCMZsUwV/vH4zvi+qZhqj+6UUYplM09kgB0e92YfcpiNeHzJL5qCMMl2o+qRudT92SjYpcaUIAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UsqQvQ8H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UsqQvQ8H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DF981F000E9;
	Wed,  2 Sep 2026 14:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788357817;
	bh=JPsgTQPkQ0G2HH8q6SAx35JPDkb7YxAfcT2O6alXh78=;
	h=From:To:Cc:Subject:Date;
	b=UsqQvQ8HDnmGWzvCGjsPBonrrTKK5dy3EzkcWm/uNs5Dr3z+DM+6hAlaFp5N6tjoK
	 ub0tZMjAe8zSq76jtep+Olrvh6lZs2MlJgVxxZpCTqcgxt03o7z7qLjDNEvbofjfLc
	 SaC8xneiRD3fL+N11m+4GnxDBYwWwQIMfhi8WqkwkGD71IgfIc/MHktzwTC9/XklML
	 rrxJYF64M5CHFZP15R3APJK6EEtQbJLPHpgTIQ+OvmUR3HPwDMTYSCxb8MnPTH1Kg7
	 hcGFN+/LxNbRPMiHNA38TPwVwlOVIHCIKC9msHiyO/B8I4lYbJhS2+4qMidhqYOyHF
	 S1daC8YZY0LfQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/6] mm/damon: add kunit and selftests for probes and probe weights
Date: Wed,  2 Sep 2026 07:03:06 -0700
Message-ID: <20260902140313.85983-1-sj@kernel.org>
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

Changes from RFC v1.1
- RFC v1.1: https://lore.kernel.org/20260730043944.146030-1-sj@kernel.org
- Drop RFC tag.
- Rebase to latest mm-new.
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


base-commit: 7b23d7e8fa8464c92cf577d01b1ccc2f9a991cba
-- 
2.47.3
