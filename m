Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE812F12DA
	for <damon@lists.linux.dev>; Wed,  2 Sep 2026 02:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788317825; cv=none; b=rnB6z+Nw7UJDKoQ+v3Q1Mhz7vzvjS8iU9Hf0xzNbsUMkqKNRA2COCTL+PXChzdFenLtGg/qywTBGD9WNxm3+gXxJdSoUlL4jMeE+ajLyHVYMiAANF9tw21dpK7fo1jOxEtW6qgg1o8M10RssyM+hYMZ7naz2dujLF6baWiUSXtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788317825; c=relaxed/simple;
	bh=yXeP+IrkC+M1kcWMvk/TdYUd0rSIMeVwVvnPZwEW+7c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q5VQkWP/z3BsitVYIXVgYNtFUMKjQojatXBLcsnhoM3R855pgHruSBP13GzN/1UGOU6CikAX5RhebfQJE8qTzwvuXkLZtaWWLITMtbzu3nw+O+sOzrjbBSG3AQ37RilyEn9Al3I4LyPTi2CEMotssE9ykKZDK5a5ZPwOPMQXJvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crusoe.ai; spf=pass smtp.mailfrom=crusoe.ai; dkim=pass (2048-bit key) header.d=crusoe.ai header.i=@crusoe.ai header.b=QJSjVrty; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crusoe.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crusoe.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crusoe.ai header.i=@crusoe.ai header.b="QJSjVrty"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-85339ed040aso462048b3a.1
        for <damon@lists.linux.dev>; Tue, 01 Sep 2026 19:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crusoe.ai; s=google; t=1788317823; x=1788922623; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wx9bliagn1IBSjTmGC+tUrKPBAFTwTk7ga02r1H6dmk=;
        b=QJSjVrtyA6XJQ3knYXmUBHKxkW0FnoIolcgv+XzvFdVAnVpX2xVxMoH2SbHwgqupU1
         HSRCjL7WU16NIcLfXD/gc3/6TgIa7BZ+vF0OcePkSm+XrSCegeW6c0hphW/CFkH+1Wj+
         w+pVwQASokxqDb30J1ys5JFDDYmELdoRUxohZ8ZIBSwnj3S2MlIsGqwU3RH6QbGFF9AL
         VSrvqt986LlDI+/ITwjuQL1hidjsT7VVZBPguoz9FncAFEdMG4ja3DOdhW1xB7dD73e6
         LH5MtPQhpheQJVlO0wMdzPmTEEma6FhXe33kuolOgu09FpEZOww39AV1E7sVGRbkcrgZ
         CNDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788317823; x=1788922623;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wx9bliagn1IBSjTmGC+tUrKPBAFTwTk7ga02r1H6dmk=;
        b=ljdMH2QYIT7qEBSgDBeJMLLNiOGKqWfn2Tqu2D3CxyanV5tUlgJNm643kPr39dm93z
         i3cfUn4zXSHDenL0Vk0D453nn2GFz0mp9z4w6gSTVI0TH5BF6JKss0b60bj3e7Kh5CA7
         7zmN2Bce+gSONwcB+qTRI6QZHptceqcymQxogoHauszUZ2cVYr/WdizcJv5G+zSYj8xG
         wV3QQVjvKZ+aNpMHYpjpbViaVKvSDeywn/Ksd2kePIE9FH0cx/hPwb94Xbe4WPINV71I
         mh3b5QdjfVZci30ej/M/NlJ8HlaWvh6KX1tULtSLJXphpYtWd+cMo24+YvdiNOiZ0QiL
         I4eg==
X-Forwarded-Encrypted: i=1; AHgh+RrSEqbssthc7UHhITVqRZeO4Q2dk+Ly3IniIBONZj4KIcagO7ExOCGbXK8YUFhMmmZSGpR3/g==@lists.linux.dev
X-Gm-Message-State: AFuF++nSYap9TCoA3xr1mwrGi/D/HFIei3y/gxPs6NuwBXplMhLA29Pd
	r7H59/XfJn7FRRIxdG92RrizFguklbwidafiwmS2ER8e/CMGgAUCxif2eDA7j1o/wV4=
X-Gm-Gg: AR+sD13/yeKithyByrM+9k35U6k/FpDoq1iv/WxZR7DcBrfCU2B/CEAAMEUPSSTKq1m
	AhEUybp6OrXa16ZvPGOPmT3SnUN8b4VkxVtzfajxQ6auvJM6Xs5xJG3u8vhYrXsXuXBWYycZbia
	U5uDNAUcXrtW7pqJmIsHcqeDEKSMBcccxlpOA2CH7uozv15AFwAFVVJ7jhCRDAXpyQYUyT+ULZ4
	JPZkvWAzGB6u8KADgDPuljHr1hOEN2f/v7boVTw3OEs6KUraLRVqoy7gqtED2lWgV0pRGl9jHGT
	IvMgorTU9X0+oLw+QciU7KJ8Qt1bQwfyYkGWcMNJ3uUpkLKi/vcoqLBfeZELCSu5PZU6hYcSiWG
	vCqRqTdFBZyWeJ2jo3NPWZilaXQxrFDNBd7vJLoJakH/CvR1/0O+N0zTk6gYJUVID6/ht0tgiu+
	UdZ7ax2mPrMgSg8KxcSZWE+W2bY0Vt5UUH5SmosJu3B+qx73LM2nHs0snXVcNirLXIjDCP3i/W1
	TJrJQY6rGsmY7XXKpTh+8Z2xY3kjEgUTLqL
X-Received: by 2002:a05:6a21:3995:b0:3c4:2b8b:e88f with SMTP id adf61e73a8af0-3d9ad570683mr3116323637.5.1788317823327;
        Tue, 01 Sep 2026 19:57:03 -0700 (PDT)
Received: from MBP-Krishna-Iyer.civet-hops.ts.net ([2601:645:c68a:b830:a1c2:77c:7ab7:f9a0])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32f07bde5bfsm2066469eec.27.2026.09.01.19.57.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 01 Sep 2026 19:57:02 -0700 (PDT)
From: Krishna Iyer <kiyer@crusoe.ai>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] mm/damon: support access monitoring of hugetlb-backed memory
Date: Tue,  1 Sep 2026 19:56:57 -0700
Message-ID: <20260902025700.17975-1-kiyer@crusoe.ai>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

 mm/damon/ops-common.c | 122 +++++++++++++++++++++++++++++++++++-------
 mm/damon/ops-common.h |  10 ++++
 mm/damon/paddr.c      |   4 +-
 mm/damon/vaddr.c      |  27 ----------
 4 files changed, 116 insertions(+), 47 deletions(-)


base-commit: d2aad7fdcda7ae8a726926f2d6de7fe9e8ee7563
-- 
2.54.0

