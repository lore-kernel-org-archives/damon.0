Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5ECD342CB5;
	Tue, 16 Dec 2025 08:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765872119; cv=none; b=rVeajOjuTTXq4GCG+hr3Tpb2TkoJgas1O8h9sazTfvn442t3ky/SSSW31zgZVAJHmoloYb16YC2MCKDtbYQgw0pALf7v6zQGX/vOKyryVvX736gtxQM9oMrO+A09d2HqjnzxjVNL98ZQ9Q3lGee54uJSpAvLoxjr/ICx6Bnq/nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765872119; c=relaxed/simple;
	bh=iXEcDN8E6cxYy3isQfAsdFaACSzfCgupWIVQKmv8ny4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TpK0tyTn5GtadX77L++rEf/p/xwficPTsCaAjNDo0DmfpuWbSnpGlir4UwHbgaO7KaXc1YsZIZ0H/Q3nHwXw0lll8ETy/+uQI1m27PpwBkfusjOsiXc4xjcks5oGfNJv3yG4TCTSNdsUGhaRqol4fmDXHOQwBBc5reJxU9CqXlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DzFqQZhW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DzFqQZhW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B16C3C4CEF1;
	Tue, 16 Dec 2025 08:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765872119;
	bh=iXEcDN8E6cxYy3isQfAsdFaACSzfCgupWIVQKmv8ny4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DzFqQZhW+kHU5WrBW6RZ23p3Qb2kf/dRFUSMa86acEKSvHeojbpJLeGaMmqexz71o
	 K8kxkxMR210pM3fBllz/7N5XsSpMNgeGU/tIIwcqyK4ub4blSBVCz3+mOQtGXbHxSh
	 AK/v+B/Th0UUrm8Oe+fr6OPKNPlGXS82LoQl2dHHo8yexLPJeq29mJAdhnhwHgTxEi
	 zuHsnDhJ/MqQNaV85OdnvkAgCSYhwQhK0zu9NRJ4+UqwsdTate1Dr9j0dmzfQOZwyt
	 5llRl01Y7mp6mcGyiAXSPlLdHjsvqpRpWesdxzFF2t7mDx4rf/SqgB2cayVzluOtp6
	 eZrA8h/bAgzWg==
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
Subject: [PATCH 09/12] Docs/mm/damon/design: update for max_nr_snapshots
Date: Tue, 16 Dec 2025 00:01:22 -0800
Message-ID: <20251216080128.42991-10-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251216080128.42991-1-sj@kernel.org>
References: <20251216080128.42991-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DAMON design document for the newly added snapshot level DAMOS
deactivation feature, max_nr_snapshots.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 5cc7b7d662be..7fd819b8bbf7 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -720,6 +720,7 @@ scheme's execution.
 - ``qt_exceeds``: Total number of times the quota of the scheme has exceeded.
 - ``nr_snapshots``: Total number of DAMON snapshots that the scheme is tried to
   be applied.
+- ``max_nr_snapshots``: Upper limit of ``nr_snapshots``.
 
 "A scheme is tried to be applied to a region" means DAMOS core logic determined
 the region is eligible to apply the scheme's :ref:`action
@@ -741,6 +742,10 @@ to exclude anonymous pages and the region has only anonymous pages, or if the
 action is ``pageout`` while all pages of the region are unreclaimable, applying
 the action to the region will fail.
 
+Unlike normal stats, ``max_nr_snapshots`` is set by users.  If it is set as
+non-zero and ``nr_snapshots`` be same to or greater than ``nr_snapshots``, the
+scheme is deactivated.
+
 To know how user-space can read the stats via :ref:`DAMON sysfs interface
 <sysfs_interface>`, refer to :ref:s`stats <sysfs_stats>` part of the
 documentation.
-- 
2.47.3
