Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BDE343D7A;
	Tue, 16 Dec 2025 08:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765872108; cv=none; b=twiKg5Ca0/wx139da2eEQrqX+62ie3EM57ckmQhgaiUff+Cq52vD+acFeMHArH9hX0e4P6NDIDHDn3OETzezD02PMmx5HMc+9EGMGiDvYMhc9+4sMdCDPLGUpRkZ2bs/YJ4d7C9W/K0C1zyW3V9B2oAv4M0Je9q9RkqbnTcsBLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765872108; c=relaxed/simple;
	bh=vPTC/eKfLkll500maYdRrQDlL8kK86gyaCZ9jL7BWDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pPohkOgCqSZLhZyJt9UPlfSwGi10VBNUIteFkefIIqyFofn/CIS13E7iKBmykw8mF5T+g1mcnBFMzf09XTy2fMj/f9tUFdWEdpGx9rIunRdjUIZk1NY79zlPVc/+sqK9+8b5N4KsXreZylutzx7EZ/RDxv2rKNZazTruqR/+rJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jtpzAqkH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jtpzAqkH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4F67C113D0;
	Tue, 16 Dec 2025 08:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765872108;
	bh=vPTC/eKfLkll500maYdRrQDlL8kK86gyaCZ9jL7BWDM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jtpzAqkH2DntmX+MprFRlCH+lIqo86TJxG4y/kKAFPeKlPFv9vGRRySqPPqPcD4ed
	 11YtHV8qLbXjPl2Z4WdT82t1Nd3HKLejcCG/T+nbU5sYpXB3KEOFO4+yDWv2gupU/z
	 6R10ZPyr4X4pEscy4HDRprbkXwzUA+DIuIAhKP8AoPYeFwkNZWRrhkwclKxVMJwpah
	 rymGGtWc4vmj/1TOEURkmP1H+kpMoYJm+HROutNt5GEdeIkVHe7aisLWQvdMM50oyn
	 s9BKuBu+Wy3ZyzsJpU4i3sjHdL6ONOmqDU8i+SgkzbbbHeDjFEBmCcgqJ/ygoaE/2L
	 L4mnR3FuywvZA==
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
Subject: [PATCH 03/12] Docs/mm/damon/design: update for nr_snapshots damos stat
Date: Tue, 16 Dec 2025 00:01:16 -0800
Message-ID: <20251216080128.42991-4-sj@kernel.org>
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

Update DAMON design document for the newly added damos stat,
nr_snapshots.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 2d8d8ca1e0a3..5cc7b7d662be 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -718,6 +718,8 @@ scheme's execution.
 - ``nr_applied``: Total number of regions that the scheme is applied.
 - ``sz_applied``: Total size of regions that the scheme is applied.
 - ``qt_exceeds``: Total number of times the quota of the scheme has exceeded.
+- ``nr_snapshots``: Total number of DAMON snapshots that the scheme is tried to
+  be applied.
 
 "A scheme is tried to be applied to a region" means DAMOS core logic determined
 the region is eligible to apply the scheme's :ref:`action
-- 
2.47.3
