Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA113368AE;
	Mon, 29 Jun 2026 14:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782744416; cv=none; b=r0niGyP+8vneLi5mXGEVYnLrP68UlPd0fkd3c4fE7Nm4WGh0mzC3u+gA9W35eRbf4lJRRRZDGM31fRAqhiamedXDfTC5x7HD2+J5fw1JfPwWlSQIGVJZHTelTQglwVjhVG1NbrsUxRLaYI8vo1Z6XlLyR/hWMfFbyaruREpXZB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782744416; c=relaxed/simple;
	bh=1uD40Df7jwFfKJSPyd6V6VHZU1QHl2suPb391IzKnHo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eIHkEUbdxpaBfSllI3hqd0XOLYl9zd4tzfgyaHBZZwJDiXnontKl1DaSCoaziBiqgoWvN/mp7yE7w7WcQ0yqfjeJx8GOIpetULAyWiuXPiY7YJ7JjtjMxQQ+tqZh/yYRATEYN/iUaH/qlWMmJ2cykoNufSkkwe/+D8PJ8hrxncI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IAD50WWI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IAD50WWI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFC6F1F000E9;
	Mon, 29 Jun 2026 14:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782744414;
	bh=svLSRV5+v1TtKAkU6LuPybep7uMwQKca4/P6Ar1kw+k=;
	h=From:To:Cc:Subject:Date;
	b=IAD50WWIyFXg021KYJrKVqnI+of89mmlTSbWh/RW4ZYIs/eOGjIFA9X0f0TZCqxWk
	 BBQ1VQ+Hu4rUoGaNxktmFdXXaymIrOfbhwYHyzIMdNh58sFKhqOEPfSinO26RqgGeI
	 AB0COGQyob1YpARJ/6QElQuT+Lm0R+QnM5AcZ8pGDKNn0WP5ArcNdceBXZnV6z6n7M
	 DkGD0x2ojQuTFwO41hRkNCCaYRVJmD9U2d24yCfgPSF6dn7i1p4wWM50FlL4y5ACyt
	 8oVvsQwgekQ5JNVkTHXxgYR2tkIJ9Pq3CId/LqNGi1a+tZ6cb3OtC5hNGGAu588eGK
	 +h1duhrIhcKAQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	Kunwu Chan <chentao@kylinos.cn>,
	Shuah Khan <shuah@kernel.org>,
	Wang Lian <lianux.mm@gmail.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v3 0/3] selftests/damon: misc fixes for test bugs
Date: Mon, 29 Jun 2026 07:46:43 -0700
Message-ID: <20260629144648.134092-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes several bugs in the DAMON selftests.  Most are trivial
but makes test output wrong or even silently pass the one test case for
'avail_operation' file existence check.

Patch 1 fixes mutable default arguments in DamonCtx.__init__()
that cause state to leak between test instances.

Patch 2 fixes wrong operator precedence and join TypeError in
damos_tried_regions.py.

Patch 3 fixes several wrong strings that produce dead elif
branches, skipped file existence checks, and broken dict key
lookups.

Changes from v2:
- v2: https://lore.kernel.org/20260601032314.424013-1-kunwu.chan@linux.dev
- Rebase to latest mm-new.
Changes from v1:
- v1: https://lore.kernel.org/20260531085633.48626-1-kunwu.chan@linux.dev
- Fix From:/Signed-off-by mismatch.
- Add Reviewed-by tags from SJ Park.
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


base-commit: 1f7264da0cec89427b167cc51930dd8c169dade4
-- 
2.47.3
