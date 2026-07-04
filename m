Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69C034752B;
	Sat,  4 Jul 2026 18:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783188705; cv=none; b=RiJaet6oM5tCr8bzeGeN9RXhQIQJ303E14be5nYysELqtMmDQCt0/ReeZuGhhBxhI7uRx9L2VXNJeQNnBhzQLymAA4y3A6gtGSpqWakVaB8+ZrgDK9OtlMV79Pd/d9vfbH2K/zcWHajf6gIa1kvD+aZWO74hxgjfD5L0//E5aYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783188705; c=relaxed/simple;
	bh=D4HbXwGrhGeq0g95o5OFyyB9XczQy0zRAHosQY88ZiU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rWRKqN8QKcxd76+b4RSKgakxUfzLnHNalkWBY4h5MgQezcHqj2eJMGEGUBrLa8LmEgfodeZCGTkUv8mjGUFXm5uREBE4XPGxdx45BMXo9C60LM5+BI/68T/krHarPZHr/KT/VkKzn4eYo6cMCo0omw3jo3XXQ/14bFjKVYSgXyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h67Rk/Mg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h67Rk/Mg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E83D1F000E9;
	Sat,  4 Jul 2026 18:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783188704;
	bh=02ZrVxmC2Pd3XoWJ6sPqCorhWK9k9abLsU09wkVMoMw=;
	h=From:To:Cc:Subject:Date;
	b=h67Rk/Mgh6v0/yt1TXHrNCtuEEH5o2qoHegLeGlNDBLYcwN1yd4ORLxymfm+mARqx
	 8ykDCr4OlpJd6nqWIU24jSRypkf/8DAhuE7cpAt4IhaJoNw7Rk6IAqSCqto0o/YPzK
	 ilQIHsXaDAAz3AGYtNgiTqdDBmed4sX7dBr3aqjNz/Z9l0ALUsHPym8r5omHRC9+r9
	 Jxy/Uh/wIAjo+kkEZISKORtKQgrPzB5FhVMewrJrsp7a+OZ6daTIn7q4auBq6o4g+B
	 M1iHWqw35cmU/0UvjjsKswrlVPwmWKw5L6bngXUhUHCfevojFI7sdAyLP+qPeEf1+z
	 zKjfMtIp4T0LA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 00/11] mm/damon: refactor damon_{start,stop,commit}() for simple error handling
Date: Sat,  4 Jul 2026 11:11:23 -0700
Message-ID: <20260704181135.132956-1-sj@kernel.org>
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
stop the left-over DAMON contexts.  It is easy to mistake, and indeed a
few bugs from such mistakes were found and fixed.

Refactor the core API functions to stop all contexts to avoid the
mistakes.  Also remove the unnecessary error handlings from callers.

Patches Sequence
================

Patch 1 refactors damon_start() to ensure all contexts are stopped for
failures.  Patch 2 updates unnecessary damon_start() error handling from
mtier sample module.

Patch 3 refactors damon_stop() to always success.  Patches 4-6 updates
callers (damon_{sysfs,reclaim lru_sort}) to ignore the return value.
Patch 7 update damon_stop() return value to void.  Patch 8 simplifies
damon_stop() error handling in mtier sample module.

Patch 9 refactors damon_call() to stop the context before returning the
error.  Patches 10 and 11 remove unnecessary error handlings from
callers (wsse and prcl sample modules).

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
  mm/damon/core: stop ctx in damon_call() before reruning an error
  samples/damon/wsse: do not stop ctx for damon_call() failure
  samples/damon/prcl: do not stop DAMON for damon_call() failure

 include/linux/damon.h |  2 +-
 mm/damon/core.c       | 37 ++++++++++++++++++-------------------
 mm/damon/lru_sort.c   |  6 ++++--
 mm/damon/reclaim.c    |  6 ++++--
 mm/damon/sysfs.c      |  3 ++-
 samples/damon/mtier.c |  5 +----
 samples/damon/prcl.c  |  4 +---
 samples/damon/wsse.c  |  4 +---
 8 files changed, 32 insertions(+), 35 deletions(-)


base-commit: 39f9f608b1858e65db6d2766d692a7a700b1e0fb
-- 
2.47.3
