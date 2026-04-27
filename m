Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EA732FA14;
	Mon, 27 Apr 2026 15:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777302762; cv=none; b=AZMtNSywsuQqylh4G7tuRzwUC8IRVhuXmQqqQkQsq6/17aKinfBdabf4hHQVLk3/69P3UTUlQbmNilVISHwg1JdfkUsZQnnCIvn7+Gce6adNE14tQHTkWttav+hfaHs28/jBNn22miv73Q0NStP+elAAQ7ZIDIu4c9Ao0A38T0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777302762; c=relaxed/simple;
	bh=acrZio7SwTIWWe0wc5YY1SpE9hMTqgCgT01pPcG9A6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a2x3uxLOQfma2mvTK6FYG3Z9EsVH5pNDZEzWHP1XcyGGpRIOe4WTDmfzmsZnbMKVEZ+Smf0qYPQv9uYZ5dZ5AhZriQR7TA9IcR33cO0f60UiCzUOdYwHQX0ezhO6+HZEoSCkqfUQ+5OQwRpasfIrhACZL/rC6L1he78LiOFDbG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C5bNnQW9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C5bNnQW9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EFB2C19425;
	Mon, 27 Apr 2026 15:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777302762;
	bh=acrZio7SwTIWWe0wc5YY1SpE9hMTqgCgT01pPcG9A6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C5bNnQW9w6UfmygfZeMPknLdHTYsBUe+1OlK5Dgp2HD+DcUzmdn9PKZJEGpQ1Spe6
	 Akt3bXbTxUhgwbcstxO07AF9aIriIy65eDAMGuhsn8p25p1Wm/bE/xoL8n3MeRAFgr
	 g3Zzcq4zNRsB0a/pJ+uVN5G3mpjU7DcmTjrXdY+xxqvkx2E34OhRn54wnvTx8rLogz
	 n0w+a+ZYAumiZNlUcrSmbgmEipQDztN36RF1erxzL0uIz6abHHGcotBS65ehtYSMQI
	 FYEVRVedJlDEFiLRVYxB1owgQzHCbHvzLdZaktoDdYD/r6CuY+VWllhtDYBwgoJWC5
	 ZQd3jG+u5ASug==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 05/10] Docs/ABI/damon: update for pause sysfs file
Date: Mon, 27 Apr 2026 08:12:24 -0700
Message-ID: <20260427151231.113429-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260427151231.113429-1-sj@kernel.org>
References: <20260427151231.113429-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DAMON ABI document for the DAMON context execution pause/resume
feature.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/ABI/testing/sysfs-kernel-mm-damon | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index 2424237ebb105..7059f540940f0 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -84,6 +84,13 @@ Description:	Writing an integer to this file sets the 'address unit'
 		parameter of the given operations set of the context.  Reading
 		the file returns the last-written 'address unit' value.
 
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/pause
+Date:		Mar 2026
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing a boolean keyword to this file sets the 'pause' request
+		parameter for the context.  Reading the file returns the
+		last-written 'pause' value.
+
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/intervals/sample_us
 Date:		Mar 2022
 Contact:	SeongJae Park <sj@kernel.org>
-- 
2.47.3
