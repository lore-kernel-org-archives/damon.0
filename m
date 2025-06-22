Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540AC20CCCC;
	Sun, 22 Jun 2025 21:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750628283; cv=none; b=hEwnQArek6EEa79SRJrtuN+3bgQaqKfeE05sGrROABqVwEs/XeMR3a8YL+nqSsXi7wkOX7UMz/Bvs9lvbv4YqoCtITHw41c5uWmbTCZVQkWNCm+BgEE6SiT/C0vDyoS0iW2an92YbFNk88AMB7Tvw8p73wKpFqXsU8unPQDcwQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750628283; c=relaxed/simple;
	bh=LAEGnRSXJ8ztPBM07w/Zqj1EIouxcHhWOQT+7+6XXSc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZgnaBJvnhHBABBhl3MVsNJ9Yay0Wlj1vx3M8kpk1KdOAj3Zn7Tan0y5Rp5fPZH5r5rimePNYEO8k7ISFhs8MGree2oigV/5eu9unbrxwstDganp35T+9oxGoZZniaC1L+JBn3nsh/KfM2nO2V3B4prYoe4gw//O25q9taNrb5yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QPRw3pbn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QPRw3pbn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96B77C4CEE3;
	Sun, 22 Jun 2025 21:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750628282;
	bh=LAEGnRSXJ8ztPBM07w/Zqj1EIouxcHhWOQT+7+6XXSc=;
	h=From:To:Cc:Subject:Date:From;
	b=QPRw3pbnP/GfYBK+ilmRmnAHsZXrk6Qlbzm+R/QTWAi7E0xEaTKP8PAzGAyIGj0Oa
	 11VWDjYlTVa/dwtMp38XfdO5/uvItDRnphW4D15Yr5BNp1BD7PcY5ltlKhb/FNKbmc
	 1pqSylmweuJgRt89zTfYYEI+JuGTz/XM87VCYeKza8QpaQIkBwEchz43WuugfI0FJD
	 Hp5ilzgZK3O9QolQpLv6HEtv5Lqp6CQntrR73G8Mw+vpgpkqD2L/F7uvrPWUlgcwYv
	 EIvW1flg2Prt5ErTdXRwjymB79+daBCNAYJHRsIVwymWqfqLlKBbsypsWS389m+bbi
	 cpifkZD962cHg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/5] mm/damon: decouple sysfs from core
Date: Sun, 22 Jun 2025 14:37:54 -0700
Message-Id: <20250622213759.50930-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON sysfs interface is coupled with core layer.  It maintains some of
its keywords arrays be synchronized with matching DAMON core API enums.
It is unnecessary coupling that makes separated changes for different
layers difficult.  Decouple the layers by introducing new data structure
for the mappings on DAMON sysfs interface.

SeongJae Park (5):
  mm/damon/sysfs-schemes: decouple from damos_quota_goal_metric
  mm/damon/sysfs-schemes: decouple from damos_action
  mm/damon/sysfs-schemes: decouple from damos_wmark_metric
  mm/damon/sysfs-schemes: decouple from damos_filter_type
  mm/damon/sysfs: decouple from damon_ops_id

 mm/damon/sysfs-schemes.c | 251 +++++++++++++++++++++++++++++----------
 mm/damon/sysfs.c         |  56 ++++++---
 2 files changed, 232 insertions(+), 75 deletions(-)


base-commit: fbbe5fa9805364a5d354e7b0fdf0a60c67bdea01
-- 
2.39.5
