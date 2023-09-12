Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A20567E
	for <damon@lists.linux.dev>; Tue, 12 Sep 2023 18:36:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ADCBC433C7;
	Tue, 12 Sep 2023 18:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694543762;
	bh=sIE7XusR8HEiVTTAGJWiBafgMfTjtTZ475tcPsexnh8=;
	h=From:To:Cc:Subject:Date:From;
	b=FczWdyocMbir8+14OTgsluwARC/tF+bagortZhA8weYxUN5RLjbo0l7GWzqGpQ5iD
	 VZ5reLr3U9U45keAY4HJmnadnkyywAFDaCAJ6dTI34FtuqUAs4eY5LYpLQsFukH0gR
	 RfIxDwnQfr2tixWuf0rpwfR+Ix+op/0OWqUwxSaBt1zxbIwnF47QITEoNv1crbSTGA
	 UMXyQ3wQ6eqsHu48oV5Z/LvPHIlYgbYIcrxdkmTXq4N+OLYEObngAxCSFu7L+eq7Cj
	 OhVs5LZIz1aJ7bk+uKnSDQsG9lZpSjIeTY0Dhb2GOCJ/+7Juyi1grMymJXGQg0UPl2
	 ErQ9xzS/EfK/Q==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Steven Rostedt <rostedt@goodmis.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: 
Date: Tue, 12 Sep 2023 18:35:57 +0000
Message-Id: <20230912183559.4733-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Date: Tue, 12 Sep 2023 02:24:11 +0000
Subject: [PATCH v2 0/2] mm/damon: add a tracepoint for damos apply target regions

Changlog
--------

From v1
(https://lore.kernel.org/damon/20230911045908.97649-1-sj@kernel.org/)
- Get scheme/target indices only when the trace is enabled (Steven Rostedt)

From RFC
(https://lore.kernel.org/damon/20230827004045.49516-1-sj@kernel.org/)
- Fix the 4 byte hole (Steven Rostedt)
- Add documentation

Description
-----------

DAMON provides damon_aggregated tracepoint to let users record full monitoring
results.  Sometimes, users need to record monitoring results of specific
pattern.  DAMOS tried regions directory of DAMON sysfs interface allows it, but
the interface is mainly designed for snapshots and therefore would be
inefficient for such recording.  Implement yet another tracepoint for efficient
support of the usecase.


SeongJae Park (2):
  mm/damon/core: add a tracepoint for damos apply target regions
  Docs/admin-guide/mm/damon/usage: document damos_before_apply
    tracepoint

 Documentation/admin-guide/mm/damon/usage.rst | 37 +++++++++++++++----
 include/trace/events/damon.h                 | 39 ++++++++++++++++++++
 mm/damon/core.c                              | 32 +++++++++++++++-
 3 files changed, 100 insertions(+), 8 deletions(-)


base-commit: b67dc18d1406be3598248d2cc78904a81176fa13
-- 
2.25.1

