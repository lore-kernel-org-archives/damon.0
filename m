Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433AF27A465;
	Tue, 24 Feb 2026 15:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771947384; cv=none; b=ntByQ1rjNqFITZadyvQAPTSUlguTDViBsL/5tXv1ZNrXbR/eTL4WaJc6kSOE8g4xN0IJwVu5G9uEIpuT/5Doca55vClzwuo7UKPoYLPN8qQIkTi4vO4Yz+vreIHVPHDRadIX+o0JaR/Ql3h3Jh5qg/TmwzD1E8c6sbDD3I/WGzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771947384; c=relaxed/simple;
	bh=inPeW8Ltl8DwsLwViDuuASFW9BZ3AShy+bMVDFviVnw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=miDSXDpIIt0YmCuQtJkAegpad/3TR9BqTH3rUuIzOaFc5IAKI48TzEuI1YFCYYwioGCpSjEyMGXrVq195xvAr3Fec0WxdA5kWs8dgb9YgpPDkzBZybvVlaHz7w7lh+Px/ES0GqZwnvtHC0sWIYSZCf4/ECWL6JzipHJ2EKv/SKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GHPhqRfC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GHPhqRfC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AB61C19422;
	Tue, 24 Feb 2026 15:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771947383;
	bh=inPeW8Ltl8DwsLwViDuuASFW9BZ3AShy+bMVDFviVnw=;
	h=From:To:Cc:Subject:Date:From;
	b=GHPhqRfCTFoL1NJ8zbomiN7PmpKkazXiyFR9razi5rbPhvsDSVSI7Xr67qMwmjOnv
	 sc+1qKEaJDXzEx3U042Dr9s2frcMnUKFR6Gu/bTDGJ1NHTnu51D32njRreOQZCRhxE
	 /OJWmazmsDUc8UvYmzXyqEaoPZyHdnf7vRJoXvAbcrPQ79wiIDZqNDVafJo8QWZi59
	 geK0beCgY7QOKG1W4INaZ2gKJBBEmA7IE59Thvq8so5cfyHCz4vsb6eKQelFA6S71+
	 GYC6q1MXuBfgk61VWzgk6WbTIDeH54wsi2gcxxEyfInrxVfRjpAdElapc93zEsTS58
	 D6LMCgFepC4kQ==
From: SeongJae Park <sj@kernel.org>
To: linux-mm@kvack.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: mm.git dashboard for patches and review status per subsystem
Date: Tue, 24 Feb 2026 07:36:21 -0800
Message-ID: <20260224153622.60028-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,


I'm a super fan of mm.git.  Huge thanks to Andrew for the effort on maintaining
the repo.

I use it as not only the baseline of my works, but also a way to understand the
status of ongoing works.  From mm.git, I find which patches are in what stage
on the road to the mainline, and what patches lack reviews and therefore I
could help.

Nevertheless, because of the volume of the patches, it is not really easy to
use mm.git with only manual git commands.  Therefore I was using a few script
for simplifying and filtering the information for DAMON and myself.  And I
recently further worked on making it more general for any git repos and Linux
kernel subsystems.  I named it 'summary_trees.py' [1].

The script shows the number of commits in given branches in a git repo,
categorized by their review status.  The review status is defined by who wrote
the patch and who reviewed the patch.  The actors are identified based on the
MAINTAINERS file.  It first finds subsystems of the patch based on their
touching files, and then get the roles of the author/reviewers on the
subsystems.  As a result, below 12 review status categories are made.

    Author        Reviewer
    ------------------------
    no-role       nobody
    no-role       no-role
    no-role       reviewer
    no-role       maintainer

    reviewer      nobody
    reviewer      no-role
    reviewer      reviewer
    reviewer      maintainer

    maintainer    nobody
    maintainer    no-role
    maintainer    reviewer
    maintainer    maintainer

For example:

    - baseline: v7.0-rc1
    - mm-hotfixes-stable: 0 total, 0 (0) series, 0 non-series commits
    - mm-hotfixes-unstable: 15 total, 1 (2) series, 13 non-series commits
      - author/reviewer role stat
        - no role, nobody: 5 commits
        - no role, no role : 4 commits
        - no role, reviewer: 1 commits
        - no role, maintainer: 1 commits
        - maintainer, nobody: 3 commits
        - maintainer, maintainer: 1 commits
    - mm-stable: 0 total, 0 (0) series, 0 non-series commits
    - mm-unstable: 94 total, 9 (61) series, 33 non-series commits
      - author/reviewer role stat
        - no role, nobody: 9 commits
        - no role, no role : 13 commits
        - no role, reviewer: 9 commits
        - no role, maintainer: 15 commits
        - reviewer, nobody: 1 commits
        - maintainer, nobody: 35 commits
        - maintainer, maintainer: 12 commits
    - mm-new: 7 total, 1 (3) series, 4 non-series commits
      - author/reviewer role stat
        - no role, nobody: 3 commits
        - no role, no role : 1 commits
        - no role, maintainer: 1 commits
        - maintainer, nobody: 1 commits
        - maintainer, maintainer: 1 commits
    - mm-nonmm-stable: 0 total, 0 (0) series, 0 non-series commits
    - mm-nonmm-unstable: 29 total, 3 (11) series, 18 non-series commits
      - author/reviewer role stat
        - no role, nobody: 14 commits
        - no role, no role : 10 commits
        - no role, maintainer: 4 commits
        - maintainer, nobody: 1 commits

With some options, it can also show the full list of the patches in the
categories per branch, like below:

    - mm-hotfixes-unstable: 15 total, 1 (2) series, 13 non-series commits
      - author/reviewer role stat
        - no role, nobody: 5 commits
        - no role, no role : 4 commits
        - no role, reviewer: 1 commits
        - no role, maintainer: 1 commits
        - maintainer, nobody: 3 commits
        - maintainer, maintainer: 1 commits
      - full commits list
        - bf16641da830 "mm: allow __GFP_RETRY_MAYFAIL in vmalloc"
          - Authored by no role player, reviewed by no role player
          - Link: https://lkml.kernel.org/r/ff48283b-be21-7f9a-d616-e303a4a1ebe6@redhat.com

Also, it can show the changes of the status, such as what patches are newly
added to or dropped from what branch, what tags are added and dropped, like
below:

    - mm-hotfixes-unstable: 10 -> 15 commits
      - series: 0 (0) -> 1 (2)
        - no role, nobody: 2 -> 5 commits
        - no role, no role : 2 -> 4 commits
        - no role, reviewer: 1 -> 1 commits (no change)
        - no role, maintainer: 1 -> 1 commits (no change)
        - maintainer, nobody: 3 -> 3 commits (no change)
        - maintainer, maintainer: 1 -> 1 commits (no change)
      - new commits
        - 7dd859e3fb0b "mm: fix NULL NODE_DATA dereference for memoryless nodes on boot"
          - Link: https://lkml.kernel.org/r/20260222115702.3659-1-ming.lei@redhat.com
        - 3c0cda2b0dda "mailmap: add entry for Daniele Alessandrelli"
          - Link: https://lkml.kernel.org/r/20260223170905.278956-1-daniele.alessandrelli@intel.com
        - a51c6f1008e4 "MAINTAINERS: update Yosry Ahmed's email address"
          - Link: https://lkml.kernel.org/r/20260223160027.122307-1-yosry@kernel.org
        - series "mm: memfd_luo: fixes for folio flag preservation". (2)
          - 76ec99cfed40 "mm: memfd_luo: always make all folios uptodate (0/2)"
            - Link: https://lkml.kernel.org/r/20260223173931.2221759-2-pratyush@kernel.org
          - b6eb2bd40c1b "mm: memfd_luo: always dirty all folios (1/2)"
            - Link: https://lkml.kernel.org/r/20260223173931.2221759-3-pratyush@kernel.org
      - changed commits
        - bf16641da830 "mm: allow __GFP_RETRY_MAYFAIL in vmalloc"
          - added "Acked-by: SeongJae Park <sj@kernel.org>"
          - added "Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>"
          - dropped "Cc: Christoph Hellwig <hch@infradead.org>"
          - dropped "Cc: SeongJae Park <sj@kernel.org>"
          - Link: https://lkml.kernel.org/r/ff48283b-be21-7f9a-d616-e303a4a1ebe6@redhat.com

The script can also make the outputs for only specific subsystems.  For
example, I can get the counts, lists of patches and daily changes for DAMON or
'MEMORY MANGEMENT - CORE' only.

Because I find that information is useful for me, I wrote a wrapper of the tool
that speecialized for mm.git usage [2], namely mm_tree_snapshot.sh.  The
wrapper script runs the tool for mm.git branches (mm-hotfixes-stable,
mm-hotfixes-unstable, mm-stable, mm-unstable, mm-new, mm-nonmm-stable,
mm-nonmm-unstable) and a few mm subsystyems [3] I collected with my best
knowledge and interests.  I started running the wrapper and backing up the
output on a public GitHub repo, mm_git_dashboard [4], from a few weeks ago.

So, from the repo, I can find per-branch per-review status patches counts
summary [5], the counts summary with full list of the patches [6], and the
changes made since last update of the dashboard [7].  Same data is available
for each subsystems.  For example, the data for DAMON is available at
summary/subsystem/DAMON/ [8] of the repo.

I find this is useful for tracking DAMON patches that left my tree and merged
into mm.git.  I was able to easily understand their status and needed actions
from my side.  It was also useful for finding patches that I want to review for
subsystems other than DAMON that I'm interested in.  So I will keep updating
the outputs backup repo unless I find it is no more useful.

The scripts are open source, and the output backup repo is a public GitHub
repo.  So, if you want, you can use the contents of the backup repo for mm.git
info, or modify/use the tool in your way as you need.

I just wanted to share this for a case that someone is also looking for a
similar things, as I was looking for this kind of things for a while.  Any
questions and/or comments on tools and backup will be appreciated.

[1] summary_trees: https://github.com/sjp38/lazybox/blob/master/linux_hack/summary_trees.py
[2] mm_tree_snapshot: https://github.com/sjp38/lazybox/blob/master/linux_hack/mm_tree_snapshot.sh
[3] https://github.com/sjp38/lazybox/blob/master/linux_hack/mm_tree_snapshot.sh#L77
[4] mm_git_dashboard: https://github.com/sjp38/mm_git_dashboard
[5] https://github.com/sjp38/mm_git_dashboard/blob/master/summary/summary.md
[6] https://github.com/sjp38/mm_git_dashboard/blob/master/summary/full_commits_list.md
[7] https://github.com/sjp38/mm_git_dashboard/blob/master/summary/changes_from_last_update.md
[8] https://github.com/sjp38/mm_git_dashboard/tree/master/summary/subsystem/DAMON


Thanks,
SJ
