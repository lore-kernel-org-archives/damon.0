Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D8B7260D;
	Wed, 15 Apr 2026 01:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776216059; cv=none; b=lmluEuRDJ3s16Se0efaNL2+c91SPa7a937ptZm8o9dj9tztsJUPq2JXZ5C4rEFOCIVGWNVxNc+p6OcZTbe0441HV+safqCxScExrrUSDMjNcqs9UT7nGHu00piKk0M/0nBgp/VAStAlCdE8u+6IMctQB10Pi7Ooet5M8CfJREtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776216059; c=relaxed/simple;
	bh=DstdtJTxjDChhGDlgpo8hhIle9ABxcUjhKJsfY7hfhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tvV2qrl4poADsW6kmLrIodZyW0wtlTGYJPmeSR4PGCv9tnfEouwbuTEJCykOtEVsdkV0Wu+ei+7vW2UQ/t9ywZeu5QDK+tQV22ZE2lToDK8HlHC7aUZeDf7FnZ5E4RCmqS1sYIGvlWsdvVx0M+hhzcciDFgp3b9hMmnHaJcilxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X11PWJG3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X11PWJG3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B8B3C2BCB3;
	Wed, 15 Apr 2026 01:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776216059;
	bh=DstdtJTxjDChhGDlgpo8hhIle9ABxcUjhKJsfY7hfhY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X11PWJG3DoyCdwo0kmy8K1QumXjfCBzqpVmpQ8z6UHj45Tx7uZkXnsrlkqQKR/fpA
	 vKiVuxnMUpslv9P9F/VaHo89XVjAcCJHnRVB/HXTBK/9HWJS3d9Dm5+HDAAdmhNr1g
	 VfNO3aEC/3GsPS5oLDVCsgAlUtoh2uHmj1jx2z1OAsc7GYNrqyT5WJJwCxrfW562mC
	 ETt0+5MXhtpvii2faQu/fIRzhfpdyen8YqDfgMf8667O3sqp4a4/oHRnaG0R4Qw8vX
	 uh11VIHnV/wRdEgo5OI83UclPt3xpe2ysGbpDHLX/iXFt/jUoiJbi0BbSSdNbTHb9A
	 TDnP20D5ppmFg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
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
Subject: [RFC PATCH 7/7] Docs/admin-guide/mm/damon/lru_sort: update for entire memory monitoring
Date: Tue, 14 Apr 2026 18:20:35 -0700
Message-ID: <20260415012048.76508-8-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260415012048.76508-1-sj@kernel.org>
References: <20260415012048.76508-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DAMON_LRU_SORT usage document for the changed default monitoring
target region selection.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/lru_sort.rst | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/lru_sort.rst b/Documentation/admin-guide/mm/damon/lru_sort.rst
index 25e2f042a383f..796b0a028555d 100644
--- a/Documentation/admin-guide/mm/damon/lru_sort.rst
+++ b/Documentation/admin-guide/mm/damon/lru_sort.rst
@@ -246,7 +246,8 @@ monitor_region_start
 Start of target memory region in physical address.
 
 The start physical address of memory region that DAMON_LRU_SORT will do work
-against.  By default, biggest System RAM is used as the region.
+against.  By default, the system's entire phyiscal memory is used as the
+region.
 
 monitor_region_end
 ------------------
@@ -254,7 +255,8 @@ monitor_region_end
 End of target memory region in physical address.
 
 The end physical address of memory region that DAMON_LRU_SORT will do work
-against.  By default, biggest System RAM is used as the region.
+against.  By default, the system's entire physical memory is used as the
+region.
 
 addr_unit
 ---------
-- 
2.47.3
