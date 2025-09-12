Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F0C74420;
	Fri, 12 Sep 2025 02:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757644791; cv=none; b=Vcko/MllzsGQkRVQPceJVlTed4L0ic/AqU6QKBJcp8AsRy3ka07dq6PUooH9Muu3h/jaFdaxS9sdwrpxcHD+JNdPKQb/SsRfvEjdumYKNB3FLm3zXq8RINwGkBsMUYkeZZfFZSkQjIPvPKec/mG/hg42S7xjCwwkUTVDgVJ4nzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757644791; c=relaxed/simple;
	bh=yE3VMp+2UTdfVTTFqOV7Z0nyOpwlVrjxuafiWpvqlwE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PaOtyOfNb6c/MFnBSJFFLsRLzKUhEzxSTct1AjxDLijA5H5QUbNxA1Qn1qOV0KAsi9ihoPQjE2qUc8YxzsERSp5Zj3raRq8Bf2q0X4fwR4NUqDTQn8QC7mM7Jv8Oxv2qQ7bF3+lxAAnSmq6xUY4HEn35Qoerh8TrWqXc1GUJiZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gjp2JOSR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gjp2JOSR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5ED9C4CEF0;
	Fri, 12 Sep 2025 02:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757644790;
	bh=yE3VMp+2UTdfVTTFqOV7Z0nyOpwlVrjxuafiWpvqlwE=;
	h=From:To:Cc:Subject:Date:From;
	b=Gjp2JOSRRHGG1CZXw+/9INztzNXz/8KDImRW0yh5Zhks9Rn2VEaug46cf/LgKim+t
	 IdkB9zeKcEuZu98IyCGoJwkNKDDVjQz0k/QZO0yt33T0SuXthd2Bqli/G7TvvSLK+Z
	 5fzwzmLEpRDpuT2MpxUpsdBQ60oL9L9oJn3nYxft0PU1T19DaIfaaFBCWSWJoTmMuN
	 YUkkraVh3TH9aG+g0WpI7SuHmtMLDZFgSkUojfd4D7GG6rjrrU2wSnxH5M9tKJEdfL
	 hheXBau+mIXeqrSVhSb3eI0tw5cy2I/qyqgvBglqy6LOH8ewK4PoD29OC4FMk/BTqd
	 uVQEADXIseP7g==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 0/7] mm/damon: define and use DAMON initialization check function
Date: Thu, 11 Sep 2025 19:39:39 -0700
Message-Id: <20250912023946.62337-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If DAMON is tried to be used by its API callers when it is not yet
successfully initialized, the callers could be crashed.  Such issues
actually happened and were fixed [1].  DAMON API callers are therefore
having their own hacks for seeing if it is safe to use DAMON or not.
Those built on an untreliable assumption that DAMON should be ready to
be used on module init time.  DAMON initialization could fail if
KMEM_CACHE() fails, though.  Also those are basically duplications that
make their maintenance difficult.

Make it reliable and easy to maintain, by implementing a new DAMON core
layer API function for seeing if DAMON is ready to be used or not, and
replacing the hacks of DAMON API callers with the new core layer
function.

[1] https://lore.kernel.org/20250909022238.2989-1-sj@kernel.org

SeongJae Park (7):
  mm/damon/core: implement damon_initialized() function
  mm/damon/stat: use damon_initialized()
  mm/damon/reclaim: use damon_initialized()
  mm/damon/lru_sort: use damon_initialized()
  samples/damon/wsse: use damon_initialized()
  samples/damon/prcl: use damon_initialized()
  samples/damon/mtier: use damon_initialized()

 include/linux/damon.h |  1 +
 mm/damon/core.c       | 10 ++++++++++
 mm/damon/lru_sort.c   |  9 +++++++--
 mm/damon/reclaim.c    |  9 +++++++--
 mm/damon/stat.c       | 10 ++++++----
 samples/damon/mtier.c | 11 +++++++----
 samples/damon/prcl.c  | 11 +++++++----
 samples/damon/wsse.c  | 15 +++++++++------
 8 files changed, 54 insertions(+), 22 deletions(-)


base-commit: f115189b48629e7a8aa707112190b7ccf9928d6b
-- 
2.39.5
