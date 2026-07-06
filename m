Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EC130D40E;
	Mon,  6 Jul 2026 14:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783346799; cv=none; b=aTseGnuJmdrZ7VDM9Gc6DNoU5eirgCVxJyFwPGjSlFQIRAcUI84+CoGxlG0AFeR2iZWn8AhoF0cvpJaxnvdC+Am2W2ikIH95dJBvATn56IRln3G3tA0fuM16jwmKLlRsAB482/Vwes0JSBzWaTKEwtPKCb3tPO7FjSVLWb5LZ/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783346799; c=relaxed/simple;
	bh=qOCkn4AbrZ6JvJMbM9tYfp3IMq2CsIbP1/g2DHXcmmc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dvgr1mdnwh6tbSQCDwFCDFJE2unBn037aazUHTfHcCen38RNJYTSZ4V8u0XKPdv0wit7bq6zPI7XpU+hnS3msz2TEUQrHKf7ldWJr8bDoNTXw62dI6In3aV8ZorW5NkfBdtmaU/sotn4fqZq4tNYKaB92MD6q40z+h1i1hZ+6OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ES6uY66a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ES6uY66a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D88CC1F000E9;
	Mon,  6 Jul 2026 14:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783346798;
	bh=YScqbvC2FcRD4fWbOctqhEtUzflD1TaDoeycdSdZYxo=;
	h=From:To:Cc:Subject:Date;
	b=ES6uY66a/NoD6rtnEolVYYmqIPRmWM/XsrPcOny8u7cLT0mTMvEIEFk0WkipninKv
	 elwfwCzrzdFI+2C+VrhaWJf+m+zywyPo8PTCkKU6FhnRCysQ2YvdxY3VN/F8DPFY1O
	 v21tWpLhregnoQU5P9BInKlC5/1w7/H8O4T26pN97PCXTsLs+WfPRa4uGGPKTUZT35
	 LYDQtUr6wSSrguuiOBcNO2PunxUAlVVNAW4Vx260C0lhcjgmykujl5iiYNcJQ3lAof
	 3C7oisLt++4LFHNi1zJeQnWqXipuMUCQp5jKRH8eAwSDpy7Hs87OQ6LYY2wAZA+i1J
	 Cc0zLvcZhmdJw==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 00/11] mm/damon: refactor damon_{start,stop,commit}() for simple error handling
Date: Mon,  6 Jul 2026 07:06:15 -0700
Message-ID: <20260706140628.87414-1-sj@kernel.org>
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

Changes from RFC v1.1
- RFC v1.1: https://lore.kernel.org/20260705160142.97308-1-sj@kernel.org
- Drop RFC tag.
- Rebase to latest mm-new.
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


base-commit: 3fc9ce1db037091d433cb95dff0ce1cb6815fffe
-- 
2.47.3
