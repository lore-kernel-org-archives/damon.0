Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599A6391E60;
	Sat,  4 Apr 2026 16:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775320795; cv=none; b=r3y8SWsVcM/hkRZJTBNHyZPA27uurO+nbQcwHvlMzJXAKHXbcJi8FSdP445d61EktO76G+ThW1Qt+ydmNM4xammZaBOFX2XgCEp177eMIG4duSCuEPdf8+QaO2jgtzhSEvbeL/1n3WinTBZrXh+WXlyyv3WgXR2baETjGFXr8vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775320795; c=relaxed/simple;
	bh=Egl2SkMuNrTljH9TxpqPoDsyTYmIOrP1f5niqsDd1BA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZGq++a6aeE+FQEkr7ltYnNkB/XhuZkKDrx26rWCu1SRNuhjCd5/CnDGdTlCLqMjaOjtekXhzpASy0rDkLyhcD4Rgrnxr+lrtSeicGo0G/mp4+LobfTfjgQhnBZ5ATK5uzfQwf8xZ7mLfmmX0jOD7PP1jv4oK5S+kiQptP2+XPpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IJEOZTs7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJEOZTs7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8119C19421;
	Sat,  4 Apr 2026 16:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775320795;
	bh=Egl2SkMuNrTljH9TxpqPoDsyTYmIOrP1f5niqsDd1BA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IJEOZTs7RjB5ahLxwXas0E8qadLdvlKQ7QlVoMYlCx8qhy92q1xktWsySWuqWeSOd
	 ejP9tn/GYV9qE0EcWl7i4yFiISDpOmbMZ4P82pseGLq57a8RRridCGmtx4fUCJ6kap
	 iFrZNuZsTt8ivzlFaZxYnMFWt/u6cxROy6ZMZFRRLY3jK4QT/12dL1P5Qi3biD3rop
	 whFVAdwazDBwU5Khz6SbMd5RtZk5F08QZCu0aMq11VUHUsEoNhVMFecXYnJpGNL/e5
	 xNS/84pMMOYHvBMYfivjeT/4my2fPRepWyXTpHBwW5BeyWCFHalIWK5/hNGwsOCytt
	 12979jQnUqfrA==
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
Subject: [RFC PATCH 3/9] Docs/mm/damon/design: document fail_charge_{num,denom}
Date: Sat,  4 Apr 2026 09:39:33 -0700
Message-ID: <20260404163943.89278-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260404163943.89278-1-sj@kernel.org>
References: <20260404163943.89278-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DAMON design document for the DAMOS action failed region quota
charge ratio.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 510ec6375178d..58a72bd26dc11 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -572,6 +572,27 @@ interface <sysfs_interface>`, refer to :ref:`weights <sysfs_quotas>` part of
 the documentation.
 
 
+.. _damon_design_damos_quotas_failed_memory_charging_ratio:
+
+Action-failed Memory Charging Ratio
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+DAMOS action to a given region can fail for sub subsets of the memory of the
+region.  For example, if the action is ``pageout`` and the region has some
+unreclaimable pages, applying the action to the pages will fail.  The amount of
+system resource that is taken for such failed action applications is usually
+different from that for successful action applications.  For such cases, users
+can set different charging ratio for such failed memory.  The ratio can be
+specified using ``fail_charge_num`` and ``fail_charge_denom`` parameters.  The
+two parameters represent the numerator and denominator of the ratio.
+
+For example, let's suppose a DAMOS action is applied to a region of 1 GiB size.
+The action is successfully applied to only 700 MiB of the region.
+``fail_charge_num`` and ``fail_charge_denom`` are set to ``1`` and ``1024``,
+respectively.  Then only 700 MiB and 300 KiB of size (``700 MiB + 300 MiB * 1 /
+1024``) will be charged.
+
+
 .. _damon_design_damos_quotas_auto_tuning:
 
 Aim-oriented Feedback-driven Auto-tuning
-- 
2.47.3
