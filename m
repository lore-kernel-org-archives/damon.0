Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D231B18D;
	Sat, 12 Jul 2025 20:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752353214; cv=none; b=ivUlQjptQ6CViXLJK+wuY8LBNvl99s9o343GOY4qT0RSw+ut7aFcE3mZw591VEU/6XpFaM4KGwxl0me4CtEroTjKOe9q4xBZWIfMVjEnPXxKJBeMBTCrHXJJKQjCeITAGMLzS0hdbIPm87lz9ij51ikVk9wExU1McXlq+VsWvls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752353214; c=relaxed/simple;
	bh=VCSP/Ec4VFDo5yvROyQ5BjizeW111cyGb6Bzolcm5cE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B3FFCFthGjy4SpWNcR/n9uhvRfIL2v6MkR8V8WjudT3wL59JGS+uait7ugSXWZkwsr7iLN8ypeDxHpe0+IupwroFC+9UVQIjOYWzGwzIdgUL2cLu6BKnB5cpkQs+voGByvknUsrVzWEcZFHi7mUbgOECtjE5w8goO/xNMlqDwXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lcEvXsaL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lcEvXsaL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35298C4CEEF;
	Sat, 12 Jul 2025 20:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752353214;
	bh=VCSP/Ec4VFDo5yvROyQ5BjizeW111cyGb6Bzolcm5cE=;
	h=From:To:Cc:Subject:Date:From;
	b=lcEvXsaLHt3TmFr4J5lbIuCMYMZGL/LLChfMR1D3LZBmHo6+F0qwmQKuZHCaOxUIc
	 tlO7+0ndA4S1CfzgOMgGwQEtAFY+Nn38fmaz+wB2r9X3aafMYSOzLaxm1kwYdGcg5c
	 zYb3dRtsGCYuMHLvoO2LtsgRWtJgmVzap53/34FnNFFkMgVh/sVYEm1iQKNdCF1SXA
	 0qOJS9yfRMqNurbPK+otCZb07tha0/PaDyEr6guDQWOqXrqGUrZi7qtM/ns6zZ9ZEh
	 IB+lFH0Ma1OqQpY9dgcOhg+zyr942a5NLxwZohtGhW1Ss2yclfeznG1K5TO3wi1JAL
	 2mNr134bL+YFA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 0/4] mm/damon/sysfs: support periodic and automated stats update
Date: Sat, 12 Jul 2025 13:46:45 -0700
Message-Id: <20250712204650.155988-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON sysfs interface provides files for reading DAMON internal status
including DAMOS stats.  The content of the files are not automatically
updated, though.  Users should manually request updates of the contents
by writing a special command to 'state' file of each kdamond directory.
This interface is good for minimizing overhead, but causes the below
problems.

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
interface to repeat the essential contents update with a user-specified
time delay.  If non-zero value is written to the file, DAMON sysfs
interface does the updates for essential DAMON internal status including
auto-tuned monitoring intervals, DAMOS stats, and auto-tuned DAMOS
quotas using the user-written value as the time delay.  If zero is
written to the file, the automatic refresh is disabled.

SeongJae Park (4):
  mm/damon/sysfs: implement refresh_ms file under kdamond directory
  mm/damon/sysfs: implement refresh_ms file internal work
  Docs/admin-guide/mm/damon/usage: document refresh_ms file
  Docs/ABI/damon: update for refresh_ms

 .../ABI/testing/sysfs-kernel-mm-damon         |  7 +++
 Documentation/admin-guide/mm/damon/usage.rst  | 13 ++++-
 mm/damon/sysfs.c                              | 58 +++++++++++++++++++
 3 files changed, 75 insertions(+), 3 deletions(-)


base-commit: 982b86e9191292ffcd0f30018981cb16f9fac5c1
-- 
2.39.5
