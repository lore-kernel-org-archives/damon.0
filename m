Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5E83DB621;
	Thu,  9 Apr 2026 14:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775744519; cv=none; b=bBBhlrYQC5HUvcUpsAcZrnsnpDskNeMw9uORfeWbKftPJSJWuJX31J5W89Ur8HeJiN/Dr+eZSqxrJp1IsJ+GEMxru5zRDBUMeQ1ZBpNx6oDmilumEtofBCEE0BUoX+a6OkdwBIRiRNeKNCDaW25B0Wa2KTsbJqbdWHNZA3dLdg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775744519; c=relaxed/simple;
	bh=88ilcTiVHxOBPfSO6beti3cUyMc/KjPaTfyvCKtApUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VaNt0usDHREjfnlbQE0+IDDzLeqzUh4ii86Y8Tqkrz4HUQRYWnNiEifWNXRWPtL4QtmJg0ei5ZRKlgsZLrlUSruaoLix1woL+L0dc9ueKNuuZbwXNHk56xhEt8vSI3d35aU7tZlJGRtgJuoF/dWmUp+SSrMCfInQmFNJUOjvGeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CkDeT/lm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CkDeT/lm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18CFEC116C6;
	Thu,  9 Apr 2026 14:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775744519;
	bh=88ilcTiVHxOBPfSO6beti3cUyMc/KjPaTfyvCKtApUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CkDeT/lmDk6C/Sl+XwY4s0Pbx75AJHzSyiv62uorGOZwQhxrHXj3fyGZJ3zpnuUrP
	 sNArzdquT+YjNnnriUtVSrjbIkPxrVA3ea0VYeJGVmCd9rzrzA9Cvrr4Xvt8PhJBNM
	 MKR+rUxXJltnKqciSCdSKCRaXGcR2hJAWYw778XEP/jSIP+Eaf72IB7wpf2TzAPnoa
	 VIYefws8DpGNUQs4u8IWm68FnFnJ4j0xoXp3ruP1MoK3wyX+FJhIzxJ1t4lP2VMGqr
	 Hx+8aScbKI8cI2qhDJUFmhSpQSpFwHP88SjHP24EZvveE4orT2EbzIUhvYzXKNwjSg
	 YpNaUYx6nC/jw==
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
Subject: [RFC PATCH v4 05/11] Docs/mm/damon/design: document fail_charge_{num,denom}
Date: Thu,  9 Apr 2026 07:21:40 -0700
Message-ID: <20260409142148.60652-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260409142148.60652-1-sj@kernel.org>
References: <20260409142148.60652-1-sj@kernel.org>
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
 Documentation/mm/damon/design.rst | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 510ec6375178d..94e898b671d15 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -572,6 +572,28 @@ interface <sysfs_interface>`, refer to :ref:`weights <sysfs_quotas>` part of
 the documentation.
 
 
+.. _damon_design_damos_quotas_failed_memory_charging_ratio:
+
+Action-failed Memory Charging Ratio
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+DAMOS action to a given region can fail for some subsets of the memory of the
+region.  For example, if the action is ``pageout`` and the region has some
+unreclaimable pages, applying the action to the pages will fail.  The amount of
+system resource that is taken for such failed action applications is usually
+different from that for successful action applications.  For such cases, users
+can set different charging ratio for such failed memory.  The ratio can be
+specified using ``fail_charge_num`` and ``fail_charge_denom`` parameters.  The
+two parameters represent the numerator and denominator of the ratio.  The
+feature is enabled only if ``fail_charge_denom`` is not zero.
+
+For example, let's suppose a DAMOS action is applied to a region of 1,000 MiB
+size.  The action is successfully applied to only 700 MiB of the region.
+``fail_charge_num`` and ``fail_charge_denom`` are set to ``1`` and ``1024``,
+respectively.  Then only 700 MiB and 300 KiB of size (``700 MiB + 300 MiB * 1 /
+1024``) will be charged.
+
+
 .. _damon_design_damos_quotas_auto_tuning:
 
 Aim-oriented Feedback-driven Auto-tuning
-- 
2.47.3
