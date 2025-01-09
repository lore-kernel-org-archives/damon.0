Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7031F12FB;
	Thu,  9 Jan 2025 17:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736445105; cv=none; b=Fd4HF2CJyt2de9LFGrzQQtTaoCENp8zfHh2Xsnz8QJNsFyjitDDbCgK0a1h0xeukIobxVOxHQD1cycO1TtoaGXmpWbQhiJJajSuoC5OtWQs3TvDJ3pqvF8YJs8y6cLq5cLNENLCuSdpZGAp8+CNS7h3kvaZSoZl8h6TlPwTtEwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736445105; c=relaxed/simple;
	bh=D5K8J1LD/PiUXT0vcupBmI3FxsSeWohef6Oiv0g+Rfo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PyxWD8zcP3iMO4y/W1wUpaH/rokJyXRFt5/Qs5ocVx7MyyrrvAIrlilCoTbygyiIkxGA7rgFSXMZzBPTjr2chPvGIrjOpivu+DXUJmFX/37ooDJOFPoy3ryd0H0yCg2WgwRzP1cO+ixBrldIKxGlwJPiATI2MKTGny3YfCvxE9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IMh+T2KB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IMh+T2KB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AC9CC4CEE5;
	Thu,  9 Jan 2025 17:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736445104;
	bh=D5K8J1LD/PiUXT0vcupBmI3FxsSeWohef6Oiv0g+Rfo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IMh+T2KBV7HCpVmbGHyYNBHIs5nafW8flfKwJ8siqr6+f87zJ2q+W0QPIMWaUAbF4
	 YUX11l/s0wpwVZZCj35/WeG8fRW5kuu0xGMp/W+raK3N66kk15nIZV4GG1q95qEa6x
	 0Aap+9qtd1SV8m5hKzSkFVSb6aAvOITaRlZtGEPmP5ZpwJdt3FauH1BzvrhlfeHOs2
	 kqAfpB5VAQS/KTqHBt8Opp/kKhqMxjogmWkBQK94vpWZ4UtxtHhv+4uXpDlLwcyGM2
	 YNkAZZ6SV/v1KJ1Lt0AxMiQgUSzp8CjKKFqN6Ahe7DaKsayGVTcHBdSEA6ZtB9w4bC
	 WSVHI8j/7bvSQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 07/10] Docs/mm/damon/design: document allow/reject DAMOS filter behaviors
Date: Thu,  9 Jan 2025 09:51:23 -0800
Message-Id: <20250109175126.57878-8-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250109175126.57878-1-sj@kernel.org>
References: <20250109175126.57878-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DAMOS filters design document to describe the allow/reject
behavior of filters.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 33 +++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 449eb33688c2..667775bab86c 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -504,9 +504,34 @@ have a list of latency-critical processes.
 
 To let users optimize DAMOS schemes with such special knowledge, DAMOS provides
 a feature called DAMOS filters.  The feature allows users to set an arbitrary
-number of filters for each scheme.  Each filter specifies the type of target
-memory, and whether it should exclude the memory of the type (filter-out), or
-all except the memory of the type (filter-in).
+number of filters for each scheme.  Each filter specifies
+
+- a type of memory (``type``),
+- whether it is for the memory of the type or all except the type
+  (``matching``), and
+- whether it is to allow (include) or reject (exclude) applying
+  the scheme's action to the memory (``allow``).
+
+When multiple filters are installed, each filter is evaluated in the installed
+order.  If a part of memory is matched to one of the filter, next filters are
+ignored.  If the memory passes through the filters evaluation stage because it
+is not matched to any of the filters, applying the scheme's action to it is
+allowed, same to the behavior when no filter exists.
+
+For example, let's assume 1) a filter for allowing anonymous pages and 2)
+another filter for rejecting young pages are installed in the order.  If a page
+of a region that eligible to apply the scheme's action is an anonymous page,
+the scheme's action will be applied to the page regardless of whether it is
+young or not, since it matches with the first allow-filter.  If the page is
+not anonymous but young, the scheme's action will not be applied, since the
+second reject-filter blocks it.  If the page is neither anonymous nor young,
+the page will pass through the filters evaluation stage since there is no
+matching filter, and the action will be applied to the page.
+
+Note that the action can equally be applied to memory that either explicitly
+filter-allowed or filters evaluation stage passed.  It means that installing
+allow-filters at the end of the list makes no practical change but only
+filters-checking overhead.
 
 For efficient handling of filters, some types of filters are handled by the
 core layer, while others are handled by operations set.  In the latter case,
@@ -516,7 +541,7 @@ filter are not counted as the scheme has tried to the region.  In contrast, if
 a memory regions is filtered by an operations set layer-handled filter, it is
 counted as the scheme has tried.  This difference affects the statistics.
 
-Below types of filters are currently supported.
+Below ``type`` of filters are currently supported.
 
 - anonymous page
     - Applied to pages that containing data that not stored in files.
-- 
2.39.5
