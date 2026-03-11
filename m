Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9153A29B764;
	Wed, 11 Mar 2026 05:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773206971; cv=none; b=fS+tt1bfirYXy+nLjUrOgVMuEMu+2q8f3HWaZS5jqCSVXuAVwc/yWOvbvzgYkIXruTxhiiBVmSTxEOkmpJYJk8GVImTjamHQU/oAp1zASNUo54BAYIZAkn6jXA7Ic11RxotVyz1O0ntHvK7d9Ewkx6x7tqH9nVzkmHaYmxdCYR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773206971; c=relaxed/simple;
	bh=MsnD34og9TPgOPIjlBEppgUcQgWLwRdH7Kj1yj820Oc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lbf6Y+eE+Z+CuizjyALdw/3ZZP7YtYoGZnU66TrHkG7St4jgQv3sDKeyA+5Nuqn+ysnzJDXWB7ab+8cWWCwg3GEP7GQfjpV8aAFA9vImRcZS5E2LImWlAiIH8E3fmb4y1ceeAdXSIJvO079zdjrp3DyWsrwDiyQhKCwn0a7fUxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s1ECR/9t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s1ECR/9t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEF7CC4CEF7;
	Wed, 11 Mar 2026 05:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773206971;
	bh=MsnD34og9TPgOPIjlBEppgUcQgWLwRdH7Kj1yj820Oc=;
	h=From:To:Cc:Subject:Date:From;
	b=s1ECR/9t3rMYltdpRky5k4tc5oi0AN31gSxiMHV1z5ZEZ26Xx2H0XdUiOunVwNmPu
	 sNxYd8F4VK4ukwHspGVYDQ2cf5gZ+3026sLj9xy5Dvgh8YIg+XSoPZ0BSCGWxZ8VCd
	 Mr92YciAtrqdr3Wuizf469sMc+u7//DVnRf4emCHMSdmlt9m6RD/u9W0owd5HBUfYg
	 FXN7y62KbjqnoY8/pJhbP1lmGzgcspQXN+M0JNVhM2NcbCJJMBCj4jr4qj2Hji+Htu
	 4TlH4JmPy8GD+nVtKBvPralqe1WeI/UFIR2/YzFjBV4n9soJlSpAP5gam+3x7T2O7T
	 XwVOuw/DaGNNA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Yang Yingliang <yangyingliang@huawei.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/5] mm/damon: support addr_unit on default monitoring targets for modules
Date: Tue, 10 Mar 2026 22:29:21 -0700
Message-ID: <20260311052927.93921-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON_RECLAIM and DAMON_LRU_SORT support 'addr_unit' parameters only
when the monitoring target address range is explicitly set.  This was
intentional for making the initial 'addr_unit' support change small.
Now 'addr_unit' support is being quite stabilized.  Having the corner
case of the support is only making the code inconsistent with implicit
rules.  The inconsistency makes it easy to confuse [1] readers.  After
all, there is no real reason to keep 'addr_unit' support incomplete.
Add the support for the case to improve the readability and more
completely support 'addr_unit'.

This series is constructed with five patches.  The first one (patch 1)
fixes a small bug that mistakenly assigns inclusive end address to open
end address, which was found from this work.  The second and third ones
(patches 2 and 3) extend the default monitoring target setting functions
in the core layer one by one, to support the 'addr_unit' while making no
visible changes.  The final two patches (patches 4 and 5) update
DAMON_RECLAIM and DAMON_LRU_SORT to support 'addr_unit' for the default
monitoring target address ranges, by passing the user input to the core
functions.

[1] https://lore.kernel.org/20260131015643.79158-1-sj@kernel.org

Changes from RFC
(https://lore.kernel.org/20260305053918.83786-1-sj@kernel.org)
- Rebase to latest mm-new.
- Wordsmith commit messages.

SeongJae Park (5):
  mm/damon/core: fix wrong end address assignment on walk_system_ram()
  mm/damon/core: support addr_unit on damon_find_biggest_system_ram()
  mm/damon/core: receive addr_unit on
    damon_set_region_biggest_system_ram_default()
  mm/damon/reclaim: respect addr_unit on default monitoring region setup
  mm/damon/lru_sort: respect addr_unit on default monitoring region
    setup

 include/linux/damon.h |  1 +
 mm/damon/core.c       | 36 +++++++++++++++++++++++++-----------
 mm/damon/lru_sort.c   |  7 +------
 mm/damon/reclaim.c    |  7 +------
 mm/damon/stat.c       |  2 +-
 5 files changed, 29 insertions(+), 24 deletions(-)


base-commit: 31ae3f4d2741372ab511aeefc5e6898d12971fcd
-- 
2.47.3
