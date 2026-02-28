Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EDB823DD;
	Sat, 28 Feb 2026 22:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772317720; cv=none; b=Ri6scqicktdUilhYyL0IqgG3Bg8WV2TDlMANHjr3ZAziQ6/K7gH/gESU2HBgsexoHVjILkp6AVee13LIlud5by6+ATpVSrZG4lOSi2pJUvDcgahyAJjMfMNPpZejyoAuFeMZPcLTJehVMKIbZKTcXSagU+FSh6C+UwGcUmXU8CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772317720; c=relaxed/simple;
	bh=3nM294S6J5PfuhiMKe5iqRSZkPsVsLyIz8tFcgHPvZA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ADjJwImYJguBShVhS9fpj8cT/Tx95meg/phnI4U5FPm0jU2pH+piKmc5VVurMZ6kSDtI51twxmafgTTJXlJWqZJv7psHR756zCNj45Atkq1pQp5GvX3gymxBSBONwX4+NU1VbyXTe2hpjK+nDsRO3CJDGisbamGCz3/QfgtuqYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eExcrfpI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eExcrfpI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EC3EC116D0;
	Sat, 28 Feb 2026 22:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772317719;
	bh=3nM294S6J5PfuhiMKe5iqRSZkPsVsLyIz8tFcgHPvZA=;
	h=From:To:Cc:Subject:Date:From;
	b=eExcrfpITzO0YCE1K6TX5+Qsc3Dba7Va+Tuai7Z1Evt+mjN3FhhBNp+VMYOyjAXz+
	 IAxVuGkfbeRO/kOxzQKxDLdYj/VfcQp7DpISeFgVOoUrq2gZul6kxsAB1O7ZlhXifT
	 PZRDY6GtNzg8VJuN8Be8JubTnckhpWWU3sAcppxCYiCwZ7my1kv02B/7wwXAmvjugf
	 0v7Nsq7zidWeNHJFhu4FHfie1e+G3vcPyt4U0rfqMDCKSor52gIkan+tst0HeEL9HI
	 tq63kx6cOnSmmTYgZF6zo2FRPLJ5VXfnYyZusBEXHsmmbEKQMEF8ApbNRbfb2Jcm6E
	 6/j7OZl7ISnpg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/3] mm/damon: strictly respect min_nr_regions
Date: Sat, 28 Feb 2026 14:28:24 -0800
Message-ID: <20260228222831.7232-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON core respects min_nr_regions only at merge operation.  DAMON API
callers are therefore responsible to respect or ignore that.  Only vaddr
ops is respecting that, but only for initial start time.  DAMON sysfs
interface allows users to setup the initial regions that DAMON core also
respects.  But, again, it works for only the initial time.  Users
setting the regions for min_nr_regions can be difficult and inefficient,
when the min_nr_regions value is high.  There was actually a report [1]
from a user.  The use case was page granular access monitoring with a
large aggregation interval.

Make the following three changes for resolving the issue.  First (patch
1), make DAMON core split regions at the beginning and every aggregation
interval, to respect the min_nr_regions.  Second (patch 2), drop the
vaddr's split operations and related code that are no more needed.
Third (patch 3), add a kunit test for the newly introduced function.

[1] https://lore.kernel.org/CAC5umyjmJE9SBqjbetZZecpY54bHpn2AvCGNv3aF6J=1cfoPXQ@mail.gmail.com

Revision History
================

Changes from RFC v2
(https://lore.kernel.org/20260221180341.10313-1-sj@kernel.org)
- Drop RFC
- Rebase to latest mm-new

Changes from RFC v1
(https://lore.kernel.org/20260217000400.69056-1-sj@kernel.org)
- Split regions every aggregation interval

SeongJae Park (3):
  mm/damon/core: split regions for min_nr_regions
  mm/damon/vaddr: do not split regions for min_nr_regions
  mm/damon/test/core-kunit: add damon_apply_min_nr_regions() test

 mm/damon/core.c              | 45 ++++++++++++++++++---
 mm/damon/tests/core-kunit.h  | 52 ++++++++++++++++++++++++
 mm/damon/tests/vaddr-kunit.h | 76 ------------------------------------
 mm/damon/vaddr.c             | 70 +--------------------------------
 4 files changed, 93 insertions(+), 150 deletions(-)


base-commit: e4506bd63542dc58b2913cd374c518526c008a2c
-- 
2.47.3
