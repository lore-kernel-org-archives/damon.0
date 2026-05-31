Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E352E7382
	for <damon@lists.linux.dev>; Sun, 31 May 2026 08:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780217850; cv=none; b=oK9Y/bX2jCt/QS/nncgeQkv3CRV6puCitI17HWEWpofwKtYNi0kPpm1sCMVHMFfHmh/Xc3244Kvy/lkLmTcUfXiaTCppXyCw2BePiutZi4L3ML9RSIxQrfumUUAdbGYBlOzNGpQWngPC5h4n2J9wQC1yU20yTYBUkG1FhM9EXa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780217850; c=relaxed/simple;
	bh=kaJyk/3fbpHsuOzEq+fQVHrg3XAqinpl7/PARKXBC0o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gSUzkBK+zczBaNX1YAmG4db4Ry7b15wdSXh4kLAQ7SrM1W7UdUqniJ35Y3iQ5xDW+FOlgXnYvtF3O2OcHf7Plfd3bU7QjEMM3eKcS3g9thw08OCEoaDmkiLK7ZF95BuvK8b4rKzL5wN00o1BcAJJFPe8UnFesXCII/3LG4Cfwrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=I1ib2Tdv; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="I1ib2Tdv"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780217847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iiJNrzdhmETedEmIXH5LzZ4qCUgffcIFtMWEWQCqUyg=;
	b=I1ib2TdvfLWD0ag/Tn7NwVs7KCqNVBsMX9C6ZwMs7x0kANWNk43SwvDWiUVk/klTEd0UEn
	d4a0rOForr1bHx2ntIF9xwXSab40PNCukXvrbaF4e9pKQaQ9/PKIBsEdyr/bIXcNHAA/o8
	ZQdDtqmwXY/IboWXT9k5dwfAvZAYEmg=
From: Kunwu Chan <kunwu.chan@linux.dev>
To: sj@kernel.org,
	shuah@kernel.org
Cc: damon@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Kunwu Chan <kunwu.chan@gmail.com>
Subject: [PATCH 0/5] selftests/damon: misc fixes for test bugs
Date: Sun, 31 May 2026 16:56:28 +0800
Message-ID: <20260531085633.48626-1-kunwu.chan@linux.dev>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Kunwu Chan <kunwu.chan@gmail.com>

This series fixes several bugs in the DAMON selftests.  Most are
trivial but cause tests to silently pass when they shouldn't, or
fail prematurely on slow machines.

Patch 1 fixes mutable default arguments in DamonCtx.__init__()
that cause state to leak between test instances.

Patch 2 fixes a trailing comma in DamosFilter that turns
memcg_path from a string into a tuple, silently breaking memcg
filter setup.

Patch 3-4 fix bugs in damos_tried_regions.py: wrong operator
precedence drops the "not met" prefix from failure output, and
empty early aggregation cycles cause premature test failure.

Patch 5 fixes several wrong strings that produce dead elif
branches, skipped file existence checks, and broken dict key
lookups.

Based on next-20260529.
base-commit: 7da7f07112610a520567421dd2ffcb51beaefbcc

Kunwu Chan (5):
  selftests/damon: prevent cross-context state pollution in DamonCtx
  selftests/damon: fix memcg filter path handling
  selftests/damon/damos_tried_regions: fix expectation output and join
    TypeError
  selftests/damon/damos_tried_regions: handle empty tried regions in
    early cycles
  selftests/damon: fix dead code, skipped checks, and broken lookups

 tools/testing/selftests/damon/_damon_sysfs.py | 14 +++++++++----
 .../selftests/damon/damos_apply_interval.py   |  2 +-
 .../selftests/damon/damos_quota_goal.py       |  2 +-
 .../selftests/damon/damos_tried_regions.py    | 20 ++++++++++---------
 .../selftests/damon/drgn_dump_damon_status.py |  2 +-
 tools/testing/selftests/damon/sysfs.py        |  4 ++--
 tools/testing/selftests/damon/sysfs.sh        |  6 +++---
 ...te_schemes_tried_regions_wss_estimation.py |  2 +-
 8 files changed, 30 insertions(+), 22 deletions(-)

-- 
2.43.0

