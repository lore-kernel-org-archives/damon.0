Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F450282EB;
	Thu, 17 Jul 2025 05:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752731696; cv=none; b=pyDWcZ7tlssDBbAid2Ku58tM1kmgXUm4zYBNSjpsGqCSr1/iS9jt6/Uo7TGUiz+6IoVW5xneHOaLzKE2E80l+hjV1RY56Jg02/xQk5RoUy3Etbx78x3JQJ9NHVHSCeN9ae3s9OJCmMIMf+afLAInKN3YZBjv2+pXxj3V3+1FAxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752731696; c=relaxed/simple;
	bh=/JfI1qVyIG/Mf+m3KGSDeCWLM3l3Dw85BRzvvsCFvP8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XOCZ8azfOnwVIRGWSXxOvq0T/zFdVTdWgLcJTQvb6kCPNkrudKSsaSk9e6Z5vx1p7hGQzxX87PDn0fvz5T/uA/DqqTVAKLPgaXik5ouLL+1YFLoPMgbuz8hHlEPkk8jJjS5cp9j2v2N8aIBUet4v9GlJ9CdjNzCFLpNRPNif4zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WRjxqP06; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WRjxqP06"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65E73C4CEE3;
	Thu, 17 Jul 2025 05:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752731694;
	bh=/JfI1qVyIG/Mf+m3KGSDeCWLM3l3Dw85BRzvvsCFvP8=;
	h=From:To:Cc:Subject:Date:From;
	b=WRjxqP069KuC7kgVsSGZ2dR9YlzrDggLZKgv+4P0nIYETy0tiMqvYVIOxCBi340ln
	 GhqJ5NjcVFILzKwIpObtuER+Y42TH6pDruYRp402JWY84RZYeBvd2FEQymCyTLHiwy
	 AhHiQe0sz44zXq+BOesQAznSXek3vPDSZ16lJJ23l6N/D76D1F7bq+cD3YRH5baFgQ
	 2zu49xzI3Yj3bazhZrNLzqvIaiSzfO2Bbgn0TRtDIxJCvSM+pgAHguhcHL8O+BBvNw
	 U1rgEt4rSjJQjsE6Yg1iucrozQtPqPVQbMMWsvZOuhrfkcNSClI9JokzuN42R1jkGT
	 vBc7A/4GtadEQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/4] mm/damon/sysfs: support periodic and automated stats update
Date: Wed, 16 Jul 2025 22:54:44 -0700
Message-Id: <20250717055448.56976-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON sysfs interface provides files for reading DAMON internal status
including auto-tuned monitoring intervals, DAMOS stats, DAMOS action
applied regions, and auto-tuned DAMOS effective quota.  Among those,
auto-tuned monitoring intervals, DAMOS stats and auto-tuned DAMOS
effective quota are essential for common DAMON/S use cases.

The content of the files are not automatically updated, though.  Users
should manually request updates of the contents by writing a special
command to 'state' file of each kdamond directory.  This interface is
good for minimizing overhead, but causes the below problems.

First, the usage is cumbersome.  This is arguably not a big problem,
since the user-space tool (damo) can do this instead of the user.

Second, it can be too slow.  The update request is not directly handled
by the sysfs interface but kdamond thread.  And kdamond threads wake up
only once per the sampling interval.  Hence if sampling interval is not
short, each update request could take too long time.  The recommended
sampling interval setup is asking DAMON to automatically tune it, within
a range between 5 milliseconds and 10 seconds.  On production systems it
is not very rare to have a few seconds sampling interval as a result of
the auto-tuning, so this can disturb observing DAMON internal status.

Finally, parallel update requests can conflict with each other.  When
parallel update requests are received, DAMON sysfs interface simply
returns -EBUSY to one of the requests.  DAMON user-space tool is hence
implementing its own backoff mechanism, but this can make the operation
even slower.

Introduce a new sysfs file, namely refresh_ms, for asking DAMON sysfs
interface to repeat the update of the above mentioned essential contents
with a user-specified time delay.  If non-zero value is written to the
file, DAMON sysfs interface does the updates for essential DAMON
internal status including auto-tuned monitoring intervals, DAMOS stats,
and auto-tuned DAMOS quotas using the user-written value as the time
delay.  In other words, it is similar to periodically writing
'update_schemes_stats', 'update_schemes_effective_quotas', and
'update_tuned_intervals' keywords to the 'state' file.  If zero is
written to the file, the automatic refresh is disabled.

Changes from RFC
(https://lore.kernel.or/20250712204650.155988-1-sj@kernel.org)
- Wordsmith cover letter to clarify what are updated

SeongJae Park (4):
  mm/damon/sysfs: implement refresh_ms file under kdamond directory
  mm/damon/sysfs: implement refresh_ms file internal work
  Docs/admin-guide/mm/damon/usage: document refresh_ms file
  Docs/ABI/damon: update for refresh_ms

 .../ABI/testing/sysfs-kernel-mm-damon         |  7 +++
 Documentation/admin-guide/mm/damon/usage.rst  | 13 ++++-
 mm/damon/sysfs.c                              | 58 +++++++++++++++++++
 3 files changed, 75 insertions(+), 3 deletions(-)


base-commit: 2951e548fd2e489bdaecf326e1c3d17d4b5663fe
-- 
2.39.5
