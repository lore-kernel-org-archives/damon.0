Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C9321129C;
	Thu,  6 Mar 2025 17:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741283953; cv=none; b=nEFSPex0Gsyt0JeASXK5XbqESUWUOdvhf+58N/p/UTHCnLh87SujE9F63YmpCm0YVVKyWenOKhWd20KIU+d0BWk81gWc4YCSRSi2sc4zW55SY6NuCYi7DqG76hiKi+Tv3FXzZUNCmPZlk8gRfyUokC2BdnpgIYVh2rGTdidWDDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741283953; c=relaxed/simple;
	bh=j4BAmkKgo7Cq/w7oh4HOwYboKnOW/VClrDi8rpntWqQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kkR0zy0cmvI0T5Mn90zykEhles14vEnETQmZL5+PkeRQstxhxfiMZ0N3Ccxs1ot0/Db6XOCOmDNjANRj/CW6dc+bT7vMlGD8WcFaZawoiDBHIv0NwGi8dniGFpaGPqwQWOGMbZNpyaugaZmJ00ai2WWNC9weLMNHguA2YINaN1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sy86SIla; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sy86SIla"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B35EC4CEE4;
	Thu,  6 Mar 2025 17:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741283952;
	bh=j4BAmkKgo7Cq/w7oh4HOwYboKnOW/VClrDi8rpntWqQ=;
	h=From:To:Cc:Subject:Date:From;
	b=Sy86SIlaYxt3VmFWaVv2GAiJN0MXlwNyscEMAwqcnEPHySZpL3dG0G3sfhjtjXGUx
	 7CiA5W4NGsrnvjXxt7IuCqfCRUpJ6Llf4g5CbAydycc7FBb5dD0HhyKc1ztDTtyLbk
	 zix90DI/UiFhML2HInxOnUKf4ltHpucq8mo4PItplSDwkRfY8MMBIoMEiHWRlCFPkl
	 B9IWLrg9X1DCRSri1u/4dFxJeN9GQcNUrZissX4QYXNfy/29tXOkluri9H6HijWlj7
	 RUOHh+lDWJ4WYwM3S7VMIfQDEnKQm4lvPvKs//IzYg1NErDZjstg43vS+yRvgXtEVo
	 en01+c12Wys5g==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 00/13] mm/damon/sysfs: commit parameters online via damon_call()
Date: Thu,  6 Mar 2025 09:58:55 -0800
Message-Id: <20250306175908.66300-1-sj@kernel.org>
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
sysfs' usage of its own synchronization mechanism, namely online DAMON
parameters commit, to use damon_call() instead of the damon_callback
hooks and the hard-to-maintain core-external synchronization mechanism.
Then remove the no more be used code due to the change, and more unused
code that just not yet cleaned up.

The first four patches (patches 1-4) of this series makes DAMON sysfs
interface's online parameters commit to use damon_call().  Then,
following three patches (patches 5-7) remove the DAMON sysfs interface's
own synchronization mechanism and its usages, which is no more be used
by anyone due to the first four patches.  Finally, six patches (8-13) do
more cleanup of outdated comment and unused code.

Changes from RFC
(https://lore.kernel.org/20250226063651.513178-1-sj@kernel.org)
- Fix aggregated information double reset problem
- Wordsmith commit messages
- Rebase to latest mm-unstable

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
 mm/damon/core.c             |  82 ++++++++++++--------
 mm/damon/paddr.c            |   1 -
 mm/damon/sysfs-schemes.c    |   1 -
 mm/damon/sysfs.c            | 147 +++++-------------------------------
 mm/damon/tests/core-kunit.h |   6 +-
 mm/damon/vaddr.c            |   1 -
 7 files changed, 79 insertions(+), 193 deletions(-)


base-commit: 1ef510599e7f933f1cd250ba33cd4a1a532a0510
-- 
2.39.5
