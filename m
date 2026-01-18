Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0153009E2;
	Sun, 18 Jan 2026 18:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768759393; cv=none; b=kOSYDGHb9WZRBZWjwoEBQKGKvdvxxBOkAyICDfDdxrPqYkLVH2K9L8fEJCIt/kX8WgI7G6PbkNi4KcVNrgR/AGoPVPCCKzE9aNOGMeYb5Xwp+zZyAT+g8k1JUO2boC0m+VtciiLXfH1Fol78OgDiv4+WxsuPHQhZaItSZTsD6aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768759393; c=relaxed/simple;
	bh=LR2wVWJnzRZMCJ1oBYDVY/vPM/T4H4yu0kot6/rnmTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tmw2LwgeHeJy/Owi5cYEUSFMFpWGrrRtnOpldXea10WxW94YW+v55H3Cg5fFzrkc7iICekFf+s9Vqm1B08ge+Re4ieJa4hdPxlJePQ7xkDpGNNm/bJt1NaoS2dDynpfrPiVB7UPrfygFtvGZONHkA2+3WTHrUPmTXkWoypOWpCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sdCnazW/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sdCnazW/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89E93C2BC86;
	Sun, 18 Jan 2026 18:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768759393;
	bh=LR2wVWJnzRZMCJ1oBYDVY/vPM/T4H4yu0kot6/rnmTs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sdCnazW/iIGK36SFyGPzvBHD29cEX9ttdnrNaE+GY7XHtI6UxTm3t2YCzci4GXHU3
	 vzCudRiBsmKfqUwW5Ub4hXwIua5SZa/mjLQ1NjR/Q87CCqXqcPWE4e4ZFj6+NrG8es
	 0aogOxs3l2lkit5tFm53tRQ5kPu/PYEhvPLRKyFR1GWYKiJI/Kt4N9AD9V8/5djkd5
	 +T0RcfIKXCj5TVZOCqD5scmxvhmqCHe8IiTwHpZJZPEkaPYmZz/itsDH/UKvOEyMrn
	 P3PXh3buPg2Yx3zJxQkincSsN7OrG2fnnrGgJGfSXdofiqKMVzjRebCB8cMKBTqPCI
	 sncP347ZYAnOw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 6/8] Docs/admin-guide/mm/damon/usage: update stats update process for refresh_ms
Date: Sun, 18 Jan 2026 10:02:57 -0800
Message-ID: <20260118180305.70023-7-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260118180305.70023-1-sj@kernel.org>
References: <20260118180305.70023-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMOS stats on sysfs was only manually updated.  Recent addition of
'refresh_ms' knob enabled periodic and automated updates of the stats.
The document for stats update process is not updated for the change,
however.  Update.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index bfaee977c37c..b0f3969b6b3b 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -549,10 +549,13 @@ online analysis or tuning of the schemes.  Refer to :ref:`design doc
 The statistics can be retrieved by reading the files under ``stats`` directory
 (``nr_tried``, ``sz_tried``, ``nr_applied``, ``sz_applied``,
 ``sz_ops_filter_passed``, ``qt_exceeds``, ``nr_snapshots`` and
-``max_nr_snapshots``), respectively.  The files are not updated in real time,
-so you should ask DAMON sysfs interface to update the content of the files for
-the stats by writing a special keyword, ``update_schemes_stats`` to the
-relevant ``kdamonds/<N>/state`` file.
+``max_nr_snapshots``), respectively.
+
+The files are not updated in real time by default.  Users should ask DAMON
+sysfs interface to periodically update those using ``refresh_ms``, or do a one
+time update by writing a special keyword, ``update_schemes_stats`` to the
+relevant ``kdamonds/<N>/state`` file.  Refer to :ref:`kdamond directory
+<sysfs_kdamond>` for more details.
 
 .. _sysfs_schemes_tried_regions:
 
-- 
2.47.3
