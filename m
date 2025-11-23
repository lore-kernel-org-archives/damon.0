Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D558A2D73A6;
	Sun, 23 Nov 2025 18:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763923425; cv=none; b=MpA54GHRj1ml8brCGYaeP+K/MHs4NB1WTZBxZYPKGcRqYaruqbWVJ1k+KVviLsPY7yiwUEOaGCsPOCTIdR6uHrwztuoC0djRByl2HIxzieGToDTsYcTJm/Z+CD/XeLWyBT3PFEYgvFpDV/fq74i5DR57KdHvvyfh0+SEyhRFGQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763923425; c=relaxed/simple;
	bh=/pmP4EMktKLgoBMD3SKTislBGBhK+hMUMXr37vr1LCI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V0ZoaYcRxPqrK+ym+YZjhJkddeJwO0FAzgMG+J+sfxuMHLpNyd2qO7A2eh3fBA6m8OZutMxAGLXFC8Hf2UdR1qbqjpuDuWY22VEZByqbRPWkQQLqwm2N2GSRsKYnfMy/y/cTM4J7ptVSBRToi8SYTEVeCVhAv+AhqL4bbh5qtdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oDw1OiBu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oDw1OiBu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3232C113D0;
	Sun, 23 Nov 2025 18:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763923424;
	bh=/pmP4EMktKLgoBMD3SKTislBGBhK+hMUMXr37vr1LCI=;
	h=From:To:Cc:Subject:Date:From;
	b=oDw1OiBulVb+4PyhHj5wlxnpIfFM+xbGBo4ATR75+jNlSxbNZhRjH0NHtSbhjmqbc
	 TzaU5F/Qzn30oaaDFAj5gdv0o1NwIAsVtuu0JsBtJNed0B0ldqG8wkOn+dpV8h1d0g
	 IHfAr8Mi7popi/bTlxl1DkMVK2OdOkrqHuadzz+1UHHMMq1ZZ2K773qLVs+E/ytrZ4
	 2NnIvc2R0mseiG7Udoky0YvPzkPNcN0rni+vXUZFkke2RWxzxHmIwN4pY9lJlQj+c4
	 avlYSdc2Dd/x0eDNBe6oLJ5Z3lrr5egqR2SoZPFeeoXipABFxSaRDBMkoPnYEf26Ky
	 N6DtTG4QYgDpQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Subject: [RFC PATCH 00/12] mm/damos/stat: introduce nr_snapshots, max_nr_snapshots and tracepoint
Date: Sun, 23 Nov 2025 10:43:14 -0800
Message-ID: <20251123184329.85287-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce three changes for improving DAMOS stat's provided information,
deterministic control, and reading usability.

DAMOS provides stats that are important for understanding its behavior.
It lacks information about how many DAMON-generated monitoring output
snapshots it has worked on.  Add a new stat, nr_snapshots, to show the
information.

Users can control DAMOS schemes in multiple ways.  Using the online
parameters commit feature, they can install and uninstall DAMOS schemes
whenever they want while keeping DAMON runs.  DAMOS quotas and
watermarks can be used for manually or automatically turning on/off or
adjusting the aggressiveness of the scheme.  DAMOS filters can be used
for applying the scheme to specific memory entities based on their types
and locations.  Some users want their DAMOS scheme to be applied to only
specific number of DAMON snapshots, for more deterministic control.  One
example use case is tracepoint based snapshot reading.  Add a new knob,
max_nr_snapshots, to support this.  If the nr_snapshots parameter
becomes same to or greater than the value of this parameter, the scheme
is deactivated.

Users can read DAMOS stats via DAMON's sysfs interface.  For deep level
investigations on environments having advanced tools like perf and
bpftrace, exposing the stats via a tracepoint can be useful.  Implement
a new tracepoint, namely damon:damos_stat_after_apply_interval.

First five patches (patches 1-5) of this series implement the new stat,
nr_snapshots, on the core layer (patch 1), expose on DAMON sysfs user
interface (patch 2), and update documents (patches 3-5).

Following six patches (patches 6-11) are for the new stat based DAMOS
deactivation (max_nr_snapshots).  The first one (patch 6) of this group
updates a kernel-doc comment before making further changes.  Then an
implementation of it on the core layer (patch 7), an introduction of a
new DAMON sysfs interface file for users of the feature (patch 8), and
three updates of the documents (patches 9-11) follow.

The final one (patch 12) introduces the new tracepoint that exposes the
DAMOS stat values for each scheme apply interval.

SeongJae Park (12):
  mm/damon/core: introduce nr_snapshots damos stat
  mm/damon/sysfs-schemes: introduce nr_snapshots damos stat file
  Docs/mm/damon/design: update for nr_snapshots damos stat
  Docs/admin-guide/mm/damon/usage: update for nr_snapshots damos stat
  Docs/ABI/damon: update for nr_snapshots damos stat
  mm/damon: update damos kerneldoc for stat field
  mm/damon/core: implement max_nr_snapshots
  mm/damon/sysfs-schemes: implement max_nr_snapshots file
  Docs/mm/damon/design: update for max_nr_snapshots
  Docs/admin-guide/mm/damon/usage: update for max_nr_snapshots
  Docs/ABI/damon: update for max_nr_snapshots
  mm/damon/core: add trace point for damos stat per apply interval

 .../ABI/testing/sysfs-kernel-mm-damon         | 13 ++++++
 Documentation/admin-guide/mm/damon/usage.rst  | 11 ++---
 Documentation/mm/damon/design.rst             |  7 +++
 include/linux/damon.h                         | 12 ++++--
 include/trace/events/damon.h                  | 41 ++++++++++++++++++
 mm/damon/core.c                               | 37 ++++++++++++++--
 mm/damon/sysfs-schemes.c                      | 43 +++++++++++++++++++
 7 files changed, 153 insertions(+), 11 deletions(-)


base-commit: 522f1a9fc5f1f0a11af39ba5bedae446322ca0a2
-- 
2.47.3
