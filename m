Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFA32690CB;
	Wed, 26 Feb 2025 06:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740551816; cv=none; b=UCduijGWK53ktQzYoO1pJsw8lwioTxpeKoj2KcNnsCY31XGp/2s8RuWYQNMZy564l+FuV+ckyBhI7h8yUEqs9Q0FcrMgpdD0Im2E4bAwv02L45vsD7T/1NBddZKxWRJH5tluJ9f7WG9RiPkBQS8dtnktX42VNSEK2vB+eVyJNYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740551816; c=relaxed/simple;
	bh=o9SH1fYNEiXRwA3ASfhCRrr0awf72UpFI9T0tEvO0B4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e0EOnsKWwLTCVjjDPr8Z3BwMtRRYH7nIGqyWW/UbER9xUuTq4u9tglE3nMVyBUvr/k9nF6O3EdjpR1G7YGnw9xlSDw5ce223aYkALINj5bpHVRsmQXXtEkESPrleyHsfD0wu3I25WNp7dVrkPSL1FIhEDEx+Xuw6dQ3mYjUBmrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=McqekDSH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="McqekDSH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D626AC4CEE9;
	Wed, 26 Feb 2025 06:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740551815;
	bh=o9SH1fYNEiXRwA3ASfhCRrr0awf72UpFI9T0tEvO0B4=;
	h=From:To:Cc:Subject:Date:From;
	b=McqekDSHQBLBG01+fsprPuEEjq5qcyvwqIxnqm8czWE9y1eRC+56tQ+ZOPd3ro14x
	 fhS6lN0RQ82pKDDV81GBRQID9MsXupHmpNldEoSobHPI4mB9evfLy6h4sLoBsqMgoi
	 iR2O7TnWH6Xj6QZMSmKFEcoLlEpOo+J5hBbrbYXufGhfGhF04AXhPV2gYgxBaWv7pV
	 pjpy3gd0705F0mva2I8E//lajwf9aa222i0xsBd4qWEZKxo1M6arybVOP/Ji5GyfbW
	 iL2sb1kvQJZ5/evYC7KRfassxmiLrO1qrgB6e8yLQaZdJkmiB/7PSn4sY3ovSLg5Lc
	 Q1slVzU7cAt4Q==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 00/13] mm/damon/sysfs: commit parameters online via damon_call()
Date: Tue, 25 Feb 2025 22:36:38 -0800
Message-Id: <20250226063651.513178-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Due to the lack of ways to synchronously access DAMON internal data,
DAMON sysfs interface is using damon_callback hooks with its own
synchronization mechanism.  The mechanism is built on top of
damon_callback hooks in an ineifficient and complicated way.

Patch series "mm/damon: replace most damon_callback usages in sysfs with
new core functions", which starts with commit e035320fd38e
("mm/damon/sysfs-schemes: remove unnecessary schemes existence check in
damon_sysfs_schemes_clear_regions()") introduced two new DAMON kernel
API functions that providing the synchronous access, replaced most
damon_callback hooks usage in DAMON sysfs interface, and cleaned up
unnecessary code.

Continue the replacement and cleanup works.  Update the last DAMON
sysfs's usage of its own synchronization mechanism, namely online DAMON
parameters commit, to use damon_call() instead of the damon_callback
hooks and the hard-to-maintain own synchronization mechanism.  Then
remove the no more be used code due to the change, and more unused code
that just not yet cleaned up.

The first four patches of this series do the replacement.  Then,
following three patches (patches 5-7) remove the DAMON sysfs interface'
own synchronization mechanism and its usages, which is no more be used
by anyone due to the first four patches.  Finally, six patches (8-13)
doing more cleanup of no more valid comment and no more used code
follow.

SeongJae Park (13):
  mm/damon/sysfs: validate user inputs from damon_sysfs_commit_input()
  mm/damon/core: invoke kdamond_call() after merging is done if possible
  mm/damon/core: make damon_set_attrs() be safe to be called from
    damon_call()
  mm/damon/sysfs: handle commit command using damon_call()
  mm/damon/sysfs: remove damon_sysfs_cmd_request code from
    damon_sysfs_handle_cmd()
  mm/damon/sysfs: remove damon_sysfs_cmd_request_callback() and its
    callers
  mm/damon/sysfs: remove damon_sysfs_cmd_request and its readers
  mm/damon/sysfs-schemes: remove obsolete comment for
    damon_sysfs_schemes_clear_regions()
  mm/damon: remove damon_callback->private
  mm/damon: remove ->before_start of damon_callback
  mm/damon: remove damon_callback->after_sampling
  mm/damon: remove damon_callback->before_damos_apply
  mm/damon: remove damon_operations->reset_aggregated

 include/linux/damon.h       |  34 ++-------
 mm/damon/core.c             |  64 ++++++++--------
 mm/damon/paddr.c            |   1 -
 mm/damon/sysfs-schemes.c    |   1 -
 mm/damon/sysfs.c            | 147 +++++-------------------------------
 mm/damon/tests/core-kunit.h |   6 +-
 mm/damon/vaddr.c            |   1 -
 7 files changed, 61 insertions(+), 193 deletions(-)


base-commit: 58f3b385bf3ed67fa989e13620dae8331df515d7
-- 
2.39.5
