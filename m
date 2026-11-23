Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795446797;
	b=zN1FR6JRmH7wbr0/FYGb3GkYIsJX86wv6VgB5X3FTVX0iutmkEqjP0L79wuq3zxN1FjF
	 RFILNF0bF1CyIg3rHqJg+akFFFjIL8HaQ5298BS5lrioPqYL0MDd+wqunj9Cj+j3gYlpV
	 cqNZjIehfaqZFyuxUC0mCTXjI28xD17tv2lgQxcC+zI4105LebXEHPFQtmLwiCGghbMSV
	 OrmFnvh1TFz9IiE5omt2danGA7UWkb2xcOx3HRFdeHf9EvwiXhRkAjDcMD0kg5N+orCqa
	 EDL4W82ghTsiQFn3DxTGx3wToC5h/0RzNLMdZ/RO2AWT1mzP1yzOtz+SizMBGEDZbvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795446797;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Rgusygp+RlAE67y/ngtutPu5kD5yNG5Fz8DTmip9El4=;
	b=kf5Zx52esWVP6Xjq2dDLDMEISH1KCov2ES/JVyWtc9bqp0Zj7NBRiDGlma2Hsy9HK35t
	 it1mrjwinAJdWhBaJR7vKaD4jaxl0CdzdF+F5hIuyG9reU5QpSfGTqhviTRDTu6Q9gLoj
	 5qyZlujxtsWb7T3Q2c3dFWpPte1rYcJBvgCdOMdZB9lcdEa7kZh4QiQamxPZLoVEI8Coj
	 0fE2b/8G7Nyk2n5kbcAaANoxVvkxdnHJawDrfGurUtKaRahECM9u8tMe1dC1GiDYd96+4
	 /S1yVQyaycMxDo/v6hNXPKvDRCCNo0p5p+vGbjKNWxlRLe42ojiX3dlqDh3RWprYHHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ie1STN6V;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68F8606A31A;
	Mon, 23 Nov 2026 15:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ie1STN6V
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C3601F000CA;
	Mon, 23 Nov 2026 15:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795446796;
	bh=Rgusygp+RlAE67y/ngtutPu5kD5yNG5Fz8DTmip9El4=;
	h=From:To:Cc:Subject:Date;
	b=ie1STN6VSXka1O5wuIlHmb2D+6VN2EcNXv6egd3sZtpNduYhKEt/3sI8rK2YwKQ9V
	 FjjIiDBGekIsRy7TiF9wgpxj8EZuar+wU6vXs4hCw9dNwIFEm2WApWuZ728w6Xoz0q
	 0cqvdn2Ox02VUSJZaJG5Yjv4Vq61qxeX49R8vFzRGTJyxkxrrFswoeC94M/ufSy/M3
	 f/bIrYcFlRTJbVoKXRi9NgEcnN8q8PwybX2QkSD2/ZFd8BZTctau+LmZZ7aUjIJASR
	 0UoX81gFt4ylmLkQd2OEaOZ+m41nB6t69/Vh2hDlqC9MSn3GDzeKDaHhUJopqTg3VE
	 eiTls4YAeRpyA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v3 0/6] mm/damon: add sz_ops_filter_passed_last DAMOS stat
Date: Mon, 23 Nov 2026 07:13:01 -0800
Message-ID: <20261123151309.82675-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mattathias Pinchover <mattathias.pinchover@uber.com>

DAMOS stat sz_ops_filter_passed shows the total bytes that passed
operations layer-handled DAMOS filters, accumulated from the beginning
of the scheme's execution.  Users who want the amount for only the
latest apply interval, e.g., the size of a workload's anonymous memory
that is cold as of now, have to keep the previous value in user space
and compute the difference.  To know how many apply intervals a
difference covers, they have to rely on nr_snapshots.  But nr_snapshots
is increased once per target per apply interval, so the computation is
complicated for contexts having multiple targets.

This series introduces a new DAMOS stat, sz_ops_filter_passed_last.  It
shows the amount of sz_ops_filter_passed increase in the last apply
interval of the scheme.  It is updated at the end of each apply
interval, and kept unchanged until the next apply interval is
completed.  Like the other DAMOS stats, it is exposed under the stats/
directory of the scheme in the DAMON sysfs interface, and refreshed
together with the other stats when refresh_ms expires or
update_schemes_stats is written.

Patches sequence
================

Patch 1 introduces the stat to the DAMON core.  Patch 2 exposes it via
the DAMON sysfs interface.  Patch 3 adds a kunit test.  Patches 4-6
update the design, usage, and ABI documents, respectively.

Tests
=====

I ran the DAMON kunit tests (all 50 pass, including the new one), built
mm/damon/ with W=1 (no warnings), built htmldocs (no new warnings
compared to mm-new), and ran checkpatch.pl --strict on the patches (it
reports a warning and an error on each patch because it does not
recognize the Assisted-by tag, and four alignment checks on patches 2
and 3 for the continuation line alignment that the existing DAMON code
uses).

I also ran the DAMON selftests in a QEMU VM without KVM, on mm-new and
on mm-new with this series.  On mm-new, 12 tests pass, 2 fail
(sysfs_update_schemes_tried_regions_wss_estimation.py and
damos_tried_regions.py), and 1 is skipped (sysfs_memcg_path_leak.sh,
because kmemleak is not available).  With this series, 13 pass, 1 fails
(the wss_estimation one), and the same one is skipped, so I saw no
failure that mm-new does not also have.

None of the selftests read the new stat, so I also checked it on a
live kernel.  In the same kind of VM running this series, I started two
Docker containers, each running a Python process that allocates 512 MiB
and 2 GiB of anonymous memory and then holds it.  Each process was
monitored by its own kdamond, using the vaddr operations set and a
stat scheme with an anon operations layer filter, with refresh_ms set
to 1000.  Output from sz_ops_filter_passed_last was correct:

    # cd /sys/kernel/mm/damon/admin/kdamonds
    # cat 0/contexts/0/schemes/0/stats/sz_ops_filter_passed_last
    546385920
    # cat 1/contexts/0/schemes/0/stats/sz_ops_filter_passed_last
    2157043712

Tool use
========

Claude (Anthropic) assisted with the code, kunit test, documents, and
changelogs of this series, as noted by the Assisted-by: tags.  I
reviewed all of it and ran the tests listed above.

Changes from v2
- v2: https://lore.kernel.org/20261117-damon-sz-ops-b4-v2-0-439888fa04ac@uber.com
- Collect R-b: from SJ.
Changes in v2:
- Patch 2: join the attribute declaration onto one line
- Patch 3: call damos_set_filters_default_reject() before adding the
  scheme
- Patch 4: keep only the stats list bullet, dropping the explanation
  that the stat is not accumulated
- Patch 5: wrap the stats line in the usage document
- Link to v1: https://patch.msgid.link/20261116-damon-sz-ops-b4-v1-0-1cffe7227e6d@uber.com

Mattathias Pinchover (6):
  mm/damon/core: introduce sz_ops_filter_passed_last stat
  mm/damon/sysfs-schemes: add sz_ops_filter_passed_last file
  mm/damon/tests/core-kunit: test sz_ops_filter_passed_last
  Docs/mm/damon/design: update for sz_ops_filter_passed_last
  Docs/admin-guide/mm/damon/usage: update for sz_ops_filter_passed_last
  Docs/ABI/damon: update for sz_ops_filter_passed_last

 .../ABI/testing/sysfs-kernel-mm-damon         |  7 ++
 Documentation/admin-guide/mm/damon/usage.rst  |  9 +-
 Documentation/mm/damon/design.rst             |  2 +
 include/linux/damon.h                         |  6 ++
 mm/damon/core.c                               |  5 +
 mm/damon/sysfs-schemes.c                      | 16 ++++
 mm/damon/tests/core-kunit.h                   | 93 +++++++++++++++++++
 7 files changed, 135 insertions(+), 3 deletions(-)


base-commit: 60a393b8ae5d63691c0ea9b21571441911afd81a
-- 
2.47.3
