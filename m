Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0093225791;
	Sun,  5 Jul 2026 16:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783267314; cv=none; b=RjdP/syUa7ybCq5ygr/PEh7sk2nO41J/XuNd7uwrwb+Q7qIa6vrfqoJmJBM83iSKVCf7p18mSFzCDe976usC0IrB9kaYODmTAVSWG4cOUctm1lvczxPRcldZH4uvI5gWmr/DvVF0/52uJCt3FHZN6kV6uh7GBZC7EFgkgNe7UW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783267314; c=relaxed/simple;
	bh=nnpzAiu7fmMn5MWXUD1UtEgySfqfDzYdrpsL5HH2dJk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TAyUazNklbfmH7VqZFgZ1gCiRoCvyInvEUHb03tR8hPctrKEem6oBNLN+houRLi3lrUILrvYyCePBUm/9HrUIRAE+U/LjNu/nq8C1pSnnMV9ByWzxbTCYqGF9fvxZMMbNKDz0qP2+Ahw2EFVCIhjGFMUA+N5rh1Qtl5DanpKjTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SR0lMN6f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SR0lMN6f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06A951F000E9;
	Sun,  5 Jul 2026 16:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783267312;
	bh=1W0z3ibNTBH982L2YdX0/4RM6hemskh9KnNpifQK0MI=;
	h=From:To:Cc:Subject:Date;
	b=SR0lMN6flT0EFxpBZ+36fDvNVXyyKnZiHs1cFMhGevOEAQItisttVNkv+hCDi2sB1
	 1QIKMFuyhQCnDomigvHYhGY/9qB6ZLJPb28KnkILt/bPc28v4Kq0i0QKZ+S5gVvavV
	 DNbi0/qjtRSoEUxKgNkf16iiSDv9SZSlHkmD8IlOwm79itg2LlUn+GuNg0HBwzNRju
	 HfyGNkPOqXrpR1K2RGRJPCEYqGDUjFPI6Jz5TtRZcgRHg1NhcwZKcj4QQyVs89hcKs
	 YukTjrc8/izh557fMzIcOtwC16xblaHyQMY7god6HFUBodM3PajgMha8AXoA+NQrFT
	 6b6fvUeVlkgqw==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 00/11] mm/damon: refactor damon_{start,stop,commit}() for simple error handling
Date: Sun,  5 Jul 2026 09:01:27 -0700
Message-ID: <20260705160142.97308-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_start() and damon_stop() could leave a few of requested DAMON
contexts running when they return an error.  damon_commit() failure
stops the DAMON context, but in an asynchronous way.  Callers should
stop the left-over DAMON contexts.  It is easy to make mistakes, and
indeed a few bugs from such mistakes were found and fixed.

Refactor the core API functions to guarantee contexts are completely
stopped under failures.  Remove the caller side error handlers that are
no longer needed due to the refactoring.

Patches Sequence
================

Patch 1 refactors damon_start() to ensure all contexts are stopped for
failures.  Patch 2 updates unnecessary damon_start() error handling from
mtier sample module.

Patch 3 refactors damon_stop() to always success.  Patches 4-6 updates
callers (damon_{sysfs,reclaim lru_sort}) to ignore the return value.
Patch 7 update damon_stop() return value to void.  Patch 8 simplifies
damon_stop() error handling in mtier sample module.

Patch 9 refactors damon_call() to return errors only after the context
is completely stopped.  Patches 10 and 11 remove unnecessary error
handlings from callers (wsse and prcl sample modules).

Changelog
=========

Changes from RFC v1
- RFC v1: https://lore.kernel.org/20260704181135.132956-1-sj@kernel.org
- Fix ABBA deadlock in damon_start().
- Wait instead of doing racy-stop in damon_call().

SJ Park (11):
  mm/damon/core: stop ctxs in damon_start() before returning an error
  samples/damon/mtier: do not stop first context for damon_start()
    failure
  mm/damon/core: make damon_stop() never fails
  mm/damon/sysfs: ignore damon_stop() return value
  mm/damon/reclaaim: ignore damon_stop() return value
  mm/damon/lru_sort: ignore damon_stop() return value
  mm/damon/core: change damon_stop() return type to void
  samples/damon/mtier: stop all contexts with single damon_stop() call
  mm/damon/core: wait ctx stop in damon_call() before reruning an error
  samples/damon/wsse: do not stop ctx for damon_call() failure
  samples/damon/prcl: do not stop DAMON for damon_call() failure

 include/linux/damon.h |  2 +-
 mm/damon/core.c       | 37 +++++++++++++++++++------------------
 mm/damon/lru_sort.c   |  6 ++++--
 mm/damon/reclaim.c    |  6 ++++--
 mm/damon/sysfs.c      |  3 ++-
 samples/damon/mtier.c |  5 +----
 samples/damon/prcl.c  |  4 +---
 samples/damon/wsse.c  |  4 +---
 8 files changed, 33 insertions(+), 34 deletions(-)


base-commit: abe5b65a9c676375c3f118d453037f2f9ebbb7ac
-- 
2.47.3
