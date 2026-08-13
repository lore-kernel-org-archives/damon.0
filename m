Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6253624D3;
	Thu, 13 Aug 2026 03:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786593012; cv=none; b=DchkbhwioJkAX4J8WEg17+VFJ6od5rzlpVX5ykNDoo4D6wvZSOeF8sDixV7e0yp2EsOCSC8L+hAj2ch2NIHcEqoOoJbPc4RszSj6xF3bteaoZ6nzOzQwRdNcKjgKivuZ5Id86XRuYsCg3rFBpZuapm19k5lmtbtAiFjqPsC/cSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786593012; c=relaxed/simple;
	bh=3DqLA59vlywS3LpEdmH4wjJREFWF8wp2H9osGkp4fGs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S2tibNo75tR3aPkabSS2pio1VlssRmaT8x2it3SkThoso9S9Wfih7Q7noNVw0+mUBjVqozUA5sjxKkR+dHoXmexrNa1/cUTwXaBsh846nbpx79H5KpCh4zfYN8IGmNT+NeCg9Rj60/4Z5mco1QS3nQ3BICKty1veXweW6P4mgfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IuqgpbQf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IuqgpbQf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 730751F000E9;
	Thu, 13 Aug 2026 03:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786593008;
	bh=a47tDKl1k73QAF90ft2RevU02WxBCqQ2EJTbPYNlFRk=;
	h=From:To:Cc:Subject:Date;
	b=IuqgpbQfP+QGjzGZM9WLMbxkwiv9v/WtdS5IyXQnUnqL5JM8z87cgFAzMvLQy4/UQ
	 68IEoed1pmNQxuycnsLr+EiXhkSg+AvDO4ueBQv4kfBCexcU/dGw8ErrGP/ENtIhfn
	 GJwFJakkTOtwEyGgLqw2QU4/dfavcN6ghpBFaJ2P/2t2TAnXexMfU7SDJal2QS2VWV
	 fKuVU1wD2cpukfIdB7+bFlYQavhvlvOB880cr/iG6mpq6sYLioCaO9Djkl2uPZRaYB
	 7F4bQtBTY6FeqmGR0wH2DI3JrdRmPdE3yu0podBkCjn4iJYNnJuYkc6GDpx1J97nth
	 V36XdH8sx04Uw==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 0/4] mm/damon: allow NULL or unstarted damon_ctx parameter for damon_call()
Date: Wed, 12 Aug 2026 20:49:55 -0700
Message-ID: <20260813035001.97364-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Callers of damon_call() should validate the damon_ctx object parameter.
If it is NULL or never damon_start()-ed object, damon_call() could
dereference the NULL pointer or indefinitely hang.  Ensuring all callers
doing the validation correctly has turned out to be difficult.  Handle
the corner cases inside the core layer and remove callers' validations.

Patches 1 and 2 respectively allow passing NULL and not yet
damon_start()-ed ctx parameter to damon_call().  Patches 3 and 4 remove
the callers side validations in DMON_RECLAIM and DASMON_LRU_SORT,
respectively.

SJ Park (4):
  mm/damon/core: handle NULL ctx parameter in damon_call()
  mm/damon/core: set ctx->call_controls_obsolete in damon_new_ctx()
  mm/damon/reclaim: remove unnecessary damon_call() param validation
  mm/damon/lru_sort: remove unnecessary damon_call() param validation

 mm/damon/core.c     | 7 +++----
 mm/damon/lru_sort.c | 8 --------
 mm/damon/reclaim.c  | 8 --------
 3 files changed, 3 insertions(+), 20 deletions(-)


base-commit: c8520e181a2aaf85290d0447656de0df112dbbea
-- 
2.47.3
