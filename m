Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D877261A
	for <damon@lists.linux.dev>; Mon,  1 Jun 2026 03:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780284257; cv=none; b=aIOiy9kAN/Rc0u/k23YTBrqMdD+mBc/K8Fn1PyLcYL8qJ7iuf7QvmdKTDfMgFDFLxO6MlyJWQmFw57b7oxetGaA8oNBqmH5NPq5m8jsSPPP2wEPCjDemMCMRzoUe/kKi2SFwHZo4zA3ozRKJcRcV3SKCWGuQbCvI9ffsDmkmCXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780284257; c=relaxed/simple;
	bh=PPC0trvVEMhh7Gn7QbwvNLxoBTdkzpP5yOK+IXP9gTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sEmFHCLITolw2YXaG+FUeLvhY+iNsLA98XwVOdneEdKkwb3IUH89mFA6BXxuqkzR4P4wXMLpeeAbaqWdlqq2jFmkfGDlwmr7a/FkGtEMIPePOGJgBk3keIixbusYJ4OeF7PGwUScy/07J1I8JwOClF2ttdhgCz2hUTSLscSyelo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OcBABwj2; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OcBABwj2"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780284253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=owbSZscWo6ckrHxeD2gTgVyp3+xCiVnDi/pqi0ynZbk=;
	b=OcBABwj2vtNXSS2l/hQDzcSyapMyDYAs6pzuODWBCnjvpw93Q74oDel6q/XpuiZUHcJtl+
	48YpqJ3YbYDbOsIdOvl31IpuX90KM0JHdmK84PfYb8PCl2fdvvmyyMYc8QQnj1wPAjllJX
	vlntAjhWCkcZpmA2GMDLVnc4/5s8DLU=
From: Kunwu Chan <kunwu.chan@linux.dev>
To: sj@kernel.org,
	shuah@kernel.org
Cc: damon@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH v2 0/3] selftests/damon: misc fixes for test bugs
Date: Mon,  1 Jun 2026 11:23:11 +0800
Message-ID: <20260601032314.424013-1-kunwu.chan@linux.dev>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Kunwu Chan <chentao@kylinos.cn>

This series fixes several bugs in the DAMON selftests.  Most are
trivial but cause tests to silently pass when they shouldn't, or
fail prematurely on slow machines.

Patch 1 fixes mutable default arguments in DamonCtx.__init__()
that cause state to leak between test instances.

Patch 2 fixes wrong operator precedence and join TypeError in
damos_tried_regions.py.

Patch 3 fixes several wrong strings that produce dead elif
branches, skipped file existence checks, and broken dict key
lookups.

Based on next-20260529.
base-commit: 7da7f07112610a520567421dd2ffcb51beaefbcc
---
Changes in v2:
- Fix From:/Signed-off-by mismatch.
- Add Reviewed-by tags from SeongJae Park.
- Drop the duplicate memcg_path fix.
- Drop the empty aggregation-cycle retry fix pending root-cause
  investigation.
- No code change


Kunwu Chan (3):
  selftests/damon: prevent cross-context state pollution in DamonCtx
  selftests/damon/damos_tried_regions: fix expectation output and join
    TypeError
  selftests/damon: fix dead code, skipped checks, and broken lookups

 tools/testing/selftests/damon/_damon_sysfs.py        | 12 +++++++++---
 .../testing/selftests/damon/damos_apply_interval.py  |  2 +-
 tools/testing/selftests/damon/damos_quota_goal.py    |  2 +-
 tools/testing/selftests/damon/damos_tried_regions.py |  4 ++--
 .../selftests/damon/drgn_dump_damon_status.py        |  2 +-
 tools/testing/selftests/damon/sysfs.py               |  4 ++--
 tools/testing/selftests/damon/sysfs.sh               |  6 +++---
 ...fs_update_schemes_tried_regions_wss_estimation.py |  2 +-
 8 files changed, 20 insertions(+), 14 deletions(-)

-- 
2.43.0

