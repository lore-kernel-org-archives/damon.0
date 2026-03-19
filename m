Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F0F397E92;
	Thu, 19 Mar 2026 05:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773897727; cv=none; b=B4rnrHXMoaDT0QtZVJap7DiMGZSp9tdSuQLQiiGkzLBYsnGJEis6EjY0/PaHHx9KstNdaA8e469CVqb4GIObbPY7S7HhvtYp0hN8z+SJGAZClwlcWgo+HgfetXczBYpJNj4t8Fj5nP1xhjReQBzV35vIUMea5pT1EzQCIZwTtS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773897727; c=relaxed/simple;
	bh=o/Ftk1V+walX/j4lo8sRORN5eVEOzqwrT6r4WeWLY1I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vbll24TA/nlNvAphb3We6ZvkVWil39UdD1TMXDVK5CbpCUJYbNigwlm2snbjU0esBZUejfg86iHuabBjK5wWWARK1Io75deYnv2sWxbwEP5jcDv+bbHHz6OI9B0I9VXKyRqA/+RXhuSyHxomHJrLUrO3TuvKcc4n0H1vM/OcAWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gwo2MNMQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gwo2MNMQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B73F5C19425;
	Thu, 19 Mar 2026 05:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773897727;
	bh=o/Ftk1V+walX/j4lo8sRORN5eVEOzqwrT6r4WeWLY1I=;
	h=From:To:Cc:Subject:Date:From;
	b=Gwo2MNMQy0NRf6Y8NkdQ2lcm+gbTmK0nYJ0t8ghYQcdpJboAtu7xhDX6XjLOWIhtq
	 sfPJ64VoJDBlxrSHYdco5I7A+dTs0rgaSVJ+6XvEXZP2IO7rs0HEqgLNqcUDwm/F8r
	 2lR+lByE3vGGLgVy8hZFaPYpeeMCOsb2RwDJNElCOqMR4USYVRBaWjdkKDoe6p5BGN
	 GmDXh26cV++CtbxnEt/UcT/veisfqDLO5BbaQB34Ch03vaHgw7k0KhxRtvyID6YpfH
	 5c0rzPAJO1go2PcUzYbTz9H/grcCAKYtDelVquVq9QXTtCuHxBkWok6ytc+fCuen0T
	 aReCqZT4jDCYg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 00/10] mm/damon: let DAMON be paused and resumed
Date: Wed, 18 Mar 2026 22:21:43 -0700
Message-ID: <20260319052157.99433-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON utilizes a few mechanisms that enhance itself over time. Adaptive
regions adjustment, goal-based DAMOS quota auto-tuning and monitoring
intervals auto-tuning like self-training mechanisms are such examples.
It also adds access frequency stability information (age) to the
monitoring results, which makes it enhanced over time.

Sometimes users have to stop DAMON.  In this case, DAMON internal state
that enhanced over the time of the last execution simply goes away.
Restarted DAMON have to train itself and enhance its output from the
scratch.  This makes DAMON less useful in such cases.  Introducing three
such use cases below.

Investigation of DAMON.  It is best to do the investigation online,
especially when it is a production environment.  DAMON therefore
provides features for such online investigations, including DAMOS stats,
monitoring result snapshot exposure, and multiple tracepoints.  When
those are insufficient, and there are additional clues that could be
interfered by DAMON, users have to temporarily stop DAMON to collect the
additional clues.  It is not very useful since many of DAMON internal
clues are gone when DAMON is stopped.  The loss of the monitoring
results that improved over time is also problematic, especially in
production environments.

Monitoring of workloads that have different user-known phases.  For
example, in Android, applications are known to have very different
access patterns and behaviors when they are running on the foreground
and the background.  It can therefore be useful to separate monitoring
of apps based on whether they are running on the foreground and on the
background.  Having two DAMON threads per application that paused and
resumed for the apps foreground/background switches can be useful for
the purpose.  But such pause/resume of the execution is not supported.

Tests of DAMON.  A few DAMON selftests are using drgn to dump the
internal DAMON status.  The tests show if the dumped status is the same
as what the test code expected.  Because DAMON keeps running and
modifying its internal status, there are chances of data races that can
cause false test results.  Stopping DAMON can avoid the race.  But,
since the internal state of DAMON is dropped, the test coverage will be
limited.

Let DAMON execution be paused and resumed without loss of the internal
state, to overhaul the limitations.  For this, introduce a new DAMON
context parameter, namely 'pause'.  API callers can update it while the
context is running, using the online parameters update functions
(damon_commit_ctx() and damon_call()).  Once it is set, kdamond_fn()
main loop will do only limited works excluding the monitoring and DAMOS
works, while sleeping sampling intervals per the work.  The limited
works include handling of the online parameters update.  Hence users can
unset the 'pause' parameter again.  Once it is unset, kdamond_fn() main
loop will do all the work again (resumed).  Under the paused state, it
also does stop condition checks and handling of it, so that paused DAMON
can also be stopped if needed.  Expose the feature to the user space via
DAMON sysfs interface.  Also, update existing drgn-based tests to test
and use the feature.

Tests
=====

I confirmed the feature functionality using real time tracing ('perf
trace' or 'trace-cmd stream') of damon:damon_aggregated DAMON
tracepoint.  By pausing and resuming the DAMON execution, I was able to
see the trace stops and continued as expected.  Note that the pause
feature support is added to DAMON user-space tool (damo) after v3.1.9.
Users can use '--pause_ctx' command line option of damo for that, and I
actually used it for my test.  The extended drgn-based selftests are
also testing a part of the functionality.

Patches Sequence
================

Patch 1 introduces the new core API for the pause feature.  Patch 2
extend DAMON sysfs interface for the new parameter.  Patches 3-5 update
design, usage and ABI documents for the new sysfs file, respectively.
The following five patches are for tests.  Patch 6 implements a new
kunit test for the pause parameter online commitment.  Patches 7 and 8
extend DAMON selftest helpers to support the new feature.  Patch 9
extends selftest to test the commitment of the feature.  Finally, patch
10 updates existing selftest to be safe from the race condition using
the pause/resume feature.

Changelog
=========

Changes from RFC v1
(https://lore.kernel.org/20260315210012.94846-1-sj@kernel.org)
- Continuously cancel new damos_walk() requests when paused.
- Initialize damon_sysfs_context->pause.
- Make sysfs.py dump-purpose pausing to work for all contexts.

SeongJae Park (10):
  mm/damon/core: introduce damon_ctx->paused
  mm/damon/sysfs: add pause file under context dir
  Docs/mm/damon/design: update for context pause/resume feature
  Docs/admin-guide/mm/damon/usage: update for pause file
  Docs/ABI/damon: update for pause sysfs file
  mm/damon/tests/core-kunit: test pause commitment
  selftests/damon/_damon_sysfs: support pause file staging
  selftests/damon/drgn_dump_damon_status: dump pause
  selftests/damon/sysfs.py: check pause on assert_ctx_committed()
  selftets/damon/sysfs.py: pause DAMON before dumping status

 .../ABI/testing/sysfs-kernel-mm-damon         |  7 ++++
 Documentation/admin-guide/mm/damon/usage.rst  | 12 ++++---
 Documentation/mm/damon/design.rst             |  7 ++++
 include/linux/damon.h                         |  2 ++
 mm/damon/core.c                               |  9 ++++++
 mm/damon/sysfs.c                              | 31 ++++++++++++++++++
 mm/damon/tests/core-kunit.h                   |  4 +++
 tools/testing/selftests/damon/_damon_sysfs.py | 10 +++++-
 .../selftests/damon/drgn_dump_damon_status.py |  1 +
 tools/testing/selftests/damon/sysfs.py        | 32 +++++++++++++++++++
 10 files changed, 110 insertions(+), 5 deletions(-)


base-commit: 89fea69e3a636d7f4c7a0dee9c25e2b417a74c7a
-- 
2.47.3
