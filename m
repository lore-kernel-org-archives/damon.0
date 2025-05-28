Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F1018DB03
	for <damon@lists.linux.dev>; Wed, 28 May 2025 11:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748430657; cv=none; b=gfscAW1tTfo+1egFyXWItp9kINo06/GcRYpoFbu38M2/m1bF2IOsuLG/eiffKnvJQ1ylfp46/KKw0Z1vWtey2nzpWT9bZd2NAYfAicG6ah5W70YUMonLMHQTcH1flgemWfv4TFDwkZHGwayr/9MVejO741NlmK+j1NyAMv6fjkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748430657; c=relaxed/simple;
	bh=5VNQNJstimj/ysbI3W1CYC1Bg0MkbRJ3HgtLUNEwnOw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gmKsk0lTKDfJ4dJNfWle0vy//WcAFfLygYbBjpbji9lsLcKMviwUEuPg3/lm7+Q7jmD+aRicO+n0U9Ch+00xATKMswpsZUwRIx7adGy9EpKnP4zgSQPTXrT975Fm8hBjbRnsfcwdYIKCgCMEPOgHhvHN6YyFxtOprJfmp21URrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201612.home.langchao.com
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id 202505281910420840;
        Wed, 28 May 2025 19:10:42 +0800
Received: from vbox.home.langchao.com (10.94.6.79) by
 jtjnmail201612.home.langchao.com (10.100.2.12) with Microsoft SMTP Server id
 15.1.2507.39; Wed, 28 May 2025 19:10:41 +0800
From: wangchuanguo <wangchuanguo@inspur.com>
To: <akpm@linux-foundation.org>, <hannes@cmpxchg.org>, <sj@kernel.org>
CC: <david@redhat.com>, <mhocko@kernel.org>, <zhengqi.arch@bytedance.com>,
	<shakeel.butt@linux.dev>, <lorenzo.stoakes@oracle.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <damon@lists.linux.dev>, wangchuanguo
	<wangchuanguo@inspur.com>
Subject: [PATCH 0/2] add a knob to control whether to use other nodes at the same tier of the target node in DAMON
Date: Wed, 28 May 2025 19:10:36 +0800
Message-ID: <20250528111038.18378-1-wangchuanguo@inspur.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
tUid: 20255281910424c625d6493f53ede3c45385c75923c87
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

In DAMON's migrate_hot and migrate_cold features, the code was
intended to migrate pages ​​only to the node specified by target_nid​​.
However, during testing, it was observed that memory allocation
and migration could occur on ​​any nodes​​, which is a BUG.
The first patch in this PR fix this issue.

A use_nodes_of_tier file has been added under the directory /sys/kernel/mm/damon/admin/kdamonds/<N>/contexts/<N>/schemes/<N>/
to control whether to ​​use other nodes in the same tier as
the target node​​ for migration.

wangchuanguo (2):
  mm: migrate: restore the nmask after successfully allocating on the 
    target node
  mm/damon/sysfs-schemes: add use_nodes_of_tier on sysfs-schemes

 include/linux/damon.h        |  9 ++++++++-
 include/linux/memory-tiers.h |  5 +++++
 mm/damon/core.c              |  6 ++++--
 mm/damon/lru_sort.c          |  3 ++-
 mm/damon/paddr.c             | 19 ++++++++++++-------
 mm/damon/reclaim.c           |  3 ++-
 mm/damon/sysfs-schemes.c     | 31 ++++++++++++++++++++++++++++++-
 mm/memory-tiers.c            | 13 +++++++++++++
 mm/vmscan.c                  |  2 +-
 samples/damon/mtier.c        |  3 ++-
 samples/damon/prcl.c         |  3 ++-
 11 files changed, 81 insertions(+), 16 deletions(-)

-- 
2.39.3

