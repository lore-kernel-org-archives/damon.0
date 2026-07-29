Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73201488D98;
	Wed, 29 Jul 2026 14:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785333784; cv=none; b=pvldx1sCK/Z9pTYjvafgknx6pfOzI+ohycOuNdd8tflrobLvo5tgRNbTrHbzosO9fD+rXGbeyJpufkey78vGUBkYt1OHB+aIQ1oCljN//urwn0QsK9yttxLZzxG40BsM1uHa5V1VEDnNn8uwC8VzDj88R5v1R5M0oK7PkJDdiFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785333784; c=relaxed/simple;
	bh=y1Y9SEYPxZnJ9anU7chOJJIJiUhPY5qouRSakLs05ZU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S76T5fUK0KUCyf7ZPtyHogeQF1mEtoI8F3GYxWX206WK35BrLdpl0pveDl0agcRSrAnxevrAe+UvyUjRuEEXF7nmvhMBW91ClYui+Trm3JA6IL+dXDxAjmiX+biP3hHV3lkwZU9SPM6Nluy8N1g7VvqKghs7OBtY+htZCkod3fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K1EQ8Y4A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K1EQ8Y4A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93EF81F00A3A;
	Wed, 29 Jul 2026 14:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785333783;
	bh=m8Jn+I9aOAcyBtSiJa/m93YpxBXIBEC49bNd46v3ohM=;
	h=From:To:Cc:Subject:Date;
	b=K1EQ8Y4ACyg4nu/bytNozyrCTHzJ610qB2Un6xKxTzUUK1DcDQ46YZfR+Rhy11SCC
	 T8SyPdXIYW+XQwGNNMg3oVWZ/QSZuSO0YkSsUc0gmm93fR7FX4YUBnen3MHp839Rq/
	 fe1CYE+Jd9iIMFP6Qg89sbjqK/v4uZuy0mKyBtLhCzHXjEyWuW0HT+dCDFLbPNLVTg
	 X7/PdCTXW+OZKaV4fG4vge7VdZGPQRbCtgHnUXS8ZdmrJjiH3uTEyZPpFjM4IESk4Q
	 SHvBz2ZruhnrXanjrHWE3Fy7aPUH0wYJ8WhBvgnLhnHqZk9o3TpsZwxUR8cFqFA5ue
	 xHl1XlXj2YcHw==
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
Subject: [RFC PATCH v1.2 00/12] mm/damon: cleanup code, add test cases, and update guidances in docs
Date: Wed, 29 Jul 2026 07:02:40 -0700
Message-ID: <20260729140253.87753-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Misc cleanup, improvements and updates of code, test, and documents.

Patches 1-5 cleanup DAMON code.  Patches 6-10 adds kunit and selftest
test cases for recently fixed bugs and a new feature.  Patches 11 and 12
update guidelines for AI review and what document to read, on DAMON
documents.

Changes from RFC v1.1
- RFC v1.1: https://lore.kernel.org/20260729033751.131213-1-sj@kernel.org
- Fix a typo: s/alingment/alignment/.
- Add damon probes parameter validation cleanup (patches 4 and 5).
Changes from RFC
- RFC: https://lore.kernel.org/20260728052811.192712-1-sj@kernel.org
- Remove ctx parameter of __damon_va_init_regions().
- Fix damon_nr_samples_per_aggr() overflow kunit test.
- Rebase to the latest mm-new.

SJ Park (12):
  mm/damon/core: use damon_nr_samples_per_aggr() for max merge threshold
  mm/damon/core: remove debug messages
  mm/damon/vaddr: remove a debug message
  mm/damon/core: validate number of probes in valid_probe_params()
  mm/damon/sysfs: remove probes number validation
  mm/damon/tests/core-kunit: extend set_regions() test for error case
  mm/damon/tests/core-kunit: test <=0 size damon_set_regions() inputs
  mm/damon/tests/core-kunit: test overlapping ranges for set_regions()
  mm/damon/tests/core-kunit: test damon_nr_samples_per_aggr()
  selftests/damon/sysfs.sh: test hugepage_mem_bp quota goal
  Docs/mm/damon/maintainer-profile: update AI review for Sashiko replies
  Docs/ABI/damon: recommend subsystem doc instead of admin-guide

 .../ABI/testing/sysfs-kernel-mm-damon         |  2 +-
 Documentation/mm/damon/maintainer-profile.rst | 19 ++----
 mm/damon/core.c                               | 19 +++---
 mm/damon/sysfs.c                              |  2 +-
 mm/damon/tests/core-kunit.h                   | 65 ++++++++++++++++---
 mm/damon/vaddr.c                              | 16 +----
 tools/testing/selftests/damon/sysfs.sh        |  1 +
 7 files changed, 76 insertions(+), 48 deletions(-)


base-commit: a8aa6f3b608c8c9119a7978f5f4eb083c53ea56b
-- 
2.47.3
