Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24AB4D8DA2;
	Tue,  8 Sep 2026 13:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788875544; cv=none; b=jf8LNpaEs0tviWfdh/cw9njyYaRKseNs4lDu2u9bmrbGvJWkvJ55YnO4RDk0MypRJL0WhE7LpWaAGBMBl9cBdKoJcER2V7oYc+pHJBPRd9MpFqvvePrwSpGozz2f7imQlTyYYwERwMevhvrr6a1iZBTGG4RXfJgDj8gf1oi/qw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788875544; c=relaxed/simple;
	bh=hULMSKfgmakM/CctEU6LxMn9zZv+sxlWhQf1Bt8Zt00=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iaOOtvcmvvEH/niqEdudPEDMLGHKLkb+PdKHiBEIGRCpTop4YwmtujOWHe/PdYdm1JD/bRcUA/TOnAhowH6rFfz7XKgrlYloZx7zJDxSAJKaP4FUxDX1eu0HAFoh611ZvBBYYHLmlbJUm9jYqV6JI2jR3r142uaDf8KFZnUwmLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KWAnosmg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KWAnosmg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DCF91F00A3D;
	Tue,  8 Sep 2026 13:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788875523;
	bh=SZt10/kbg4dBrQBGOpfHdt7lQPvcQoF9Yzt06P+161Q=;
	h=From:To:Cc:Subject:Date;
	b=KWAnosmgGjBBtakeFBzQt6a0+nRkTuo9pUfHhAak7/qUDiz8VM3IsGRE0XtHCboIy
	 URa2FeypaVWmYTiTRiqOXIus3LM1hgLS3VoatWswVL4wJqT60k0TKrDyhWJxgihZEH
	 4IivP5Ul/mhbjb/j9GpNx4Jp4QETmCGGUBv7HgK6l3YjN+CDtY+4TmhT4lHK9jmYua
	 T0JQS3aSiNt7klBt13djiCz49JgylFilCtnAiqWfgedkwTnFN7pT+We0bh2mZmh/6J
	 fuLqmhJLq/O84O8MISfe6EQlUM4e/p7hMsmOq0FkNttTPj512evi/FzSGJZcIIU3+y
	 DtC9RnuIWWIyQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v3 0/3] mm/damon: support access monitoring of hugetlb-backed memory
Date: Tue,  8 Sep 2026 06:51:52 -0700
Message-ID: <20260908135156.97481-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Krishna Iyer <kiyer@crusoe.ai>

On virtualization hosts, most system memory is often backed by
hugetlbfs.  On our production hosts, for example, ~95% of RAM is 1 GiB
hugetlb pages backing guest memory.  DAMON's physical address space
monitoring is blind to such memory: every access check starts at
damon_get_folio(), which rejects folios that are not on the LRU lists,
and hugetlb folios are managed outside of the LRU by design.  As a
result, all hugetlb-backed memory is silently reported as never
accessed.  In testing on a 1 TiB host, an hour of 4-thread random
access over 842 GiB inside a guest was statistically indistinguishable
from an idle host.

The first patch moves damon_hugetlb_mkold() from vaddr to ops-common
as a preparation.  The second patch teaches the folio mkold/young rmap
walkers to handle hugetlb folios, aging the huge PTE and notifying
secondary MMUs across the whole huge page size; the secondary MMU
notification is what surfaces guest-side (e.g., KVM/EPT) accessed
bits.  The third patch adds damon_get_monitor_folio() and uses it from
the paddr monitoring primitives only.  DAMOS action appliers such as
DAMON_RECLAIM and DAMON_LRU_SORT keep the LRU-only lookup and are
behaviorally unchanged.

This series is the first half of an earlier six-patch series [1],
split out as SJ suggested [2].  The second half (the 'aging_flush'
TLB-flush-assisted aging) is deferred: we will gather more
quantitative data on the gap it addresses, including the workload-side
impact of the flushes and the working set measurement details SJ asked
about, and post it separately once the data is in hand, aligned with
the ongoing monitoring preparation actions work.

Per Documentation/process/generated-content.rst, this series was
developed with the assistance of an AI coding assistant (Anthropic
Claude, via Claude Code).  The assistant helped draft the code and
changelogs, and applied the v1 review feedback.  All changes were
reviewed by the human submitter, who takes full responsibility for the
contribution.

The series as posted here was regression-tested on its base commit
with a full x86_64 kernel build (no W=1 warnings in mm/damon), the
DAMON kunit suite (41/41 passing) and the DAMON selftests (15/15
passing) on a kernel booted with virtme-ng.

Changes from v2
- v2: https://lore.kernel.org/20260902025700.17975-1-kiyer@crusoe.ai
- Drop verbose comments on damon_get_monitor_folio().
- Collect R-b: from SJ for patches 2 and 3.
- None.
Changes from v1
(https://lore.kernel.org/20260830051407.50008-1-kiyer@crusoe.ai)
- Split the first three patches out as their own series, deferring the
  aging_flush patches (old patches 4-6) until more quantitative data
  is gathered (SJ Park)
- Drop too verbose comments on the hugetlb branches of the rmap
  walkers (SJ Park)
- Factor the non-hugetlb PTE young check out into damon_pte_young()
  to reduce indentation (SJ Park)
- Rename damon_get_folio_incl_hugetlb() to damon_get_monitor_folio()
  and damon_folio_observable(folio, incl_hugetlb) to
  damon_folio_acceptable(folio, monitor) (SJ Park)
- Drop 'kernel' from the host-side monitoring example in the patch 3
  changelog, since kernel memory is not LRU-managed and hence not
  monitorable regardless (SJ Park)
- Add SJ's Reviewed-by to patch 1

[1] https://lore.kernel.org/20260830051407.50008-1-kiyer@crusoe.ai
[2] https://lore.kernel.org/20260830180411.103772-1-sj@kernel.org

Krishna Iyer (3):
  mm/damon: move damon_hugetlb_mkold() from vaddr to ops-common
  mm/damon/ops-common: handle hugetlb folios in folio mkold/young rmap
    walkers
  mm/damon/paddr: support hugetlb folios in access monitoring

 mm/damon/ops-common.c | 123 +++++++++++++++++++++++++++++++++++-------
 mm/damon/ops-common.h |  10 ++++
 mm/damon/paddr.c      |   4 +-
 mm/damon/vaddr.c      |  34 ------------
 4 files changed, 117 insertions(+), 54 deletions(-)


base-commit: 7aef702c0e8b9870275f8ec9ac1d63dc1d254a2a
-- 
2.47.3
