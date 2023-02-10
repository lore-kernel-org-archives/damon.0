Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD8163DA
	for <damon@lists.linux.dev>; Fri, 10 Feb 2023 18:28:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DD29C433D2;
	Fri, 10 Feb 2023 18:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1676053726;
	bh=fbAYtfNLMbGbjUSgWi/1MAsAL/DE+XtVmcxlU54pMLs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bDwVvvVA4Qv04UEwvUWpz+KojtDDV5sIbMQovFCSuUQbJBvJqfqSyqy4Me9RNfi8Q
	 6UHIKyaIhm3bgYB3MHtPiAvNcJ/CdOPw4Z7YaEG0aFcAEUPvp868jYwKXQxw5vDncA
	 WQBUHXPcy30tqAdqxOZa/1xmKeWWaqKf9RqRhmJsKPTo1l6sJEKU20Bfr2VpMIW3vc
	 bDo7u5lnWfkO8tPlAw2tFxHCFZDtxyjaHbK+1tfhMbwv4fz2afBqF26QvkWihm19fQ
	 hFHxy5T+i26uZYHgPrrn+RafnZWwy5WrbOI64vVvrPKgu6AYwvaN3FUXwZPfkKn7EO
	 EVhuI3noRzKbg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2 0/3] mm/damon: deprecate DAMON debugfs interface
Date: Fri, 10 Feb 2023 18:28:43 +0000
Message-Id: <20230210182843.83527-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230210044838.63723-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 10 Feb 2023 04:48:35 +0000 SeongJae Park <sj@kernel.org> wrote:

> Changes from v1
> (https://lore.kernel.org/damon/20230209192009.7885-1-sj@kernel.org/)
> - Split DAMON debugfs file open warning message (Randy Dunlap)

I usually sent this kind of update for after-merged-into-mm-unstable tree
patches individusally as fixup, but this time I sent whole patchset as a new
version, because I was out of my mind.

For someone who may prefer the usual for-fixup individual patch, attaching the
version below.


Thanks,
SJ

================================= 8< ==========================================
From: SeongJae Park <sj@kernel.org>
Date: Fri, 10 Feb 2023 04:37:19 +0000
Subject: [PATCH mm-unstable] mm/damon/dbgfs: break too long deprecation
 warning message

DAMON debugfs interface deprecation message, which is introduced by
commit 234a68e24b12 ("mm/damon/dbgfs: print DAMON debugfs interface
deprecation message") of mm-unstable, is too long.  Break down into
multiple strings for better code readability.

Fixes: 234a68e24b12 ("mm/damon/dbgfs: print DAMON debugfs interface deprecation message") # mm-unstable
Suggested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/dbgfs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
index e551a20b35e3..124f0f8c97b7 100644
--- a/mm/damon/dbgfs.c
+++ b/mm/damon/dbgfs.c
@@ -22,7 +22,10 @@ static DEFINE_MUTEX(damon_dbgfs_lock);

 static void damon_dbgfs_warn_deprecation(void)
 {
-       pr_warn_once("DAMON debugfs interface is deprecated, so users should move to the sysfs interface (DAMON_SYSFS).  If you depend on this and cannot move, please report your usecase to damon@lists.linux.dev and linux-mm@kvack.org.\n");
+       pr_warn_once("DAMON debugfs interface is deprecated, "
+                    "so users should move to DAMON_SYSFS. If you cannot, "
+                    "please report your usecase to damon@lists.linux.dev and "
+                    "linux-mm@kvack.org.\n");
 }

 /*
--
2.25.1
