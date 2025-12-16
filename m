Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B47342529;
	Tue, 16 Dec 2025 08:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765872103; cv=none; b=Hoe36B+UHZDx8JC5xPBOfJVFzVr+5cSbXUUl2vK6rcp8xpeVGDdruTVJnJ8T9njoWWxpxNDjJtVyrcEO4xJCWx3FwxDw53bSt7cryL0hXwx4x+b2rDuzlZyhetuKh2qUInrjwAaESjlVV0CjCL+xLI9ls6zqqegMnitfDEd5jX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765872103; c=relaxed/simple;
	bh=qBAnD+Vuikt86PoF0RLrT+1nqQxfYAOJ8cjFF9lggmw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bJDQToKcZ/Ftluop5YeuoDoV5xGQCM4kG5w/AciVuQ9qvTKioI87MacAoMgUYU6AfdX0TbA8HVvA5CQtmU4q6P9jO8TxupejQFJolhypp9vQG6d0X/4A1YqOTCcKvbXsEMPslXgx894oFLH4Jh091tV9RswOHYLJIZqZbHD/wdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UWZCY4TQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UWZCY4TQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0B35C4CEF1;
	Tue, 16 Dec 2025 08:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765872102;
	bh=qBAnD+Vuikt86PoF0RLrT+1nqQxfYAOJ8cjFF9lggmw=;
	h=From:To:Cc:Subject:Date:From;
	b=UWZCY4TQay0i5+f+wObSpeovHyzE1AdyiiPhBbA+OBybOaKJBOffvzeD1Qmc3CuXx
	 /Nv7hIPp3glvMnqXL9ielgEGo9SuGCCd1M0wxcC6XXco9prMW4wgSEMMfG1VH0Z/nR
	 l7dzXAvU0vbkYoZIJZFM7altOH0pGtMStIhHjDNaa6IWTSGgVyym3WEzGnJMSqha8a
	 Hj1DGkXIemcaxBNGUAZt5SIMwvGsXAyDIDKGJS3+E6nwglFWQFy5wI+Vgrm/UfFrMq
	 dlmUcGU8xj0NcwPCoW6GUZF9l/i6dNITXiplFFAsbLYjolGR5tRN+lupGAuGuwz1vR
	 jeyDiyXvJ/6pA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
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
Subject: [PATCH 00/12] mm/damon: introduce {,max_}nr_snapshots and tracepoint for damos stats
Date: Tue, 16 Dec 2025 00:01:13 -0800
Message-ID: <20251216080128.42991-1-sj@kernel.org>
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

Revision History
----------------

Changes from RFC
(https://lore.kernel.org/20251123184329.85287-1-sj@kernel.org)
- Check damos_stat tracepoint enablement inside the trace function.
- Update ABI document's 'Date:' fields.
- Slightly change series subject.

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
 mm/damon/core.c                               | 39 +++++++++++++++--
 mm/damon/sysfs-schemes.c                      | 43 +++++++++++++++++++
 7 files changed, 155 insertions(+), 11 deletions(-)


base-commit: 37164b8fc049b9a72b3f0fa9bf3241e8852931a9
-- 
2.47.3
