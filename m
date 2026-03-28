Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A351733DEF7;
	Sat, 28 Mar 2026 17:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774718657; cv=none; b=pIg+mJ5ZxpQe6hTl/2i8XohmbofYQ3makkFc+XaDGuA68R3+2EdexPpavLWund0YvgMkbpmPyjkwhcaAUxhgjkMxJhDrlaR1UMcOlmQo/mWWxnqGbkBetx86TmTtJ4H52wo+HV1ree54gYU0ZSRiGPLBAvxSVGYPaWTq3q54uUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774718657; c=relaxed/simple;
	bh=Sg4pPgwVOhZhBMZ1cwDHLvdBtDs/WT9oPKME7sikV10=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yx24RzFCsw5ewsv0j+QqSte0/37wDJtWUPjtdRxm+rFXDHu9zzl3a7O2x2hizjQLE6hfg1bDqK+oxJXOzc2NhVyKJlfi1mUKf5tYWqEvQWe2g9RLCyQAXlNXxENIZhtFmWhvgr8X8Mo7fnBzpTXcxfjasNQUXAX2wynZSz8AFtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dr2Y0qFn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dr2Y0qFn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E45C8C4CEF7;
	Sat, 28 Mar 2026 17:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774718657;
	bh=Sg4pPgwVOhZhBMZ1cwDHLvdBtDs/WT9oPKME7sikV10=;
	h=From:To:Cc:Subject:Date:From;
	b=Dr2Y0qFnnveSD2QDsnpQj5nKBciHzF3ijremG1VMwYa+vQaWHi685GieXIbEtprMk
	 kO+so/DXrnAwxI03WBDIbVySL7+siiDxjssmHF1A+0Mr8u6vXWy8cUuH7EYSUqirU0
	 C+CIlLZImq/Mq5TX6+1X5oN+ttqWRilpWnGOVYiG1As8fr9ylFbY/QIoqh3DC7lDCk
	 MvClt7V04jSEQAgG22GsSTvOwbwpFQEZ9LL0OudFa/uTIXH3bjDfdqNPF2TfqlC7z3
	 h5T3Sp8FujhN0IKvMUTydB5izRTjp/sQBNMb0jZwlzX2vRtPpDnoTISb/aYMyEpjeM
	 Fz+B35kGKZnig==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	"# 5 . 19 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 0/2] Docs/admin-guide/mm/damon: warn commit_inputs vs other params race
Date: Sat, 28 Mar 2026 10:24:11 -0700
Message-ID: <20260328172415.49940-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Writing 'Y' to the commit_inputs parameter of DAMON_RECLAIM and
DAMON_LRU_SORT, and writing other parameters before the commit_inputs
request is completely processed can cause race conditions.  While the
consequence can be bad, the documentation is not clearly describing
that.  Add clear warnings.

The issue was discovered [1,2] by sashiko.

[1] https://lore.kernel.org/20260319161620.189392-3-objecting@objecting.org
[2] https://lore.kernel.org/20260319161620.189392-2-objecting@objecting.org

SeongJae Park (2):
  Docs/admin-guide/mm/damon/reclaim: warn commit_inputs vs param updates
    race
  Docs/admin-guide/mm/damon/lru_sort: warn commit_inputs vs param
    updates race

 Documentation/admin-guide/mm/damon/lru_sort.rst | 4 ++++
 Documentation/admin-guide/mm/damon/reclaim.rst  | 4 ++++
 2 files changed, 8 insertions(+)


base-commit: 02617badb619e548c4489c371fec5a4ceb0c347e
-- 
2.47.3
