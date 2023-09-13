Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0F162E
	for <damon@lists.linux.dev>; Wed, 13 Sep 2023 02:20:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B026C433C8;
	Wed, 13 Sep 2023 02:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694571656;
	bh=p0CHdZa8KlXcbj//65Q/lcW6/zB0JeOD1X2rYK6IK3Q=;
	h=From:To:Cc:Subject:Date:From;
	b=kBFiF8/35PXtPRvBqYjCRXhdoO+UEarSh5dbUSwBAEPJQwlMdFjuZ/luXqYQjywNx
	 IAOQRFOepkA7K46VtpVJyeAAT3o+LAK4Pm5W9B/LnAW7oSNGi06iJ/aCi31xgkGON2
	 drn6ldmGNdsRsnIzYZQOz+0XeEm1Tzr0cft9MKRxAJtCiF67e286w17/fn31fxgM3H
	 X4xLHQDT3gqPdbuWsILNkawG67XKIbdo2MLA5rF0N8vRx2ozhJMGkcsMYojfW5ycH1
	 QZXMk5Wyhkp2aOcJaD4sCTjBcHn8djIau9974JIgR1bKRbeF5e9IyiALHuu2RE7AGl
	 U+OCdUUACJAsQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Steven Rostedt <rostedt@goodmis.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v2 0/2] mm/damon: add a tracepoint for damos apply target regions
Date: Wed, 13 Sep 2023 02:20:48 +0000
Message-Id: <20230913022050.2109-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changlog
--------

From original v2 post
(https://lore.kernel.org/damon/20230912183559.4733-1-sj@kernel.org/)
- Fix header
- Rebase on latest mm-unstable

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


base-commit: 8abeac23845e94681a163299a52d802b82475761
-- 
2.25.1

