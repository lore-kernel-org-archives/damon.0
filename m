Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43B02DFA3A;
	Tue, 28 Apr 2026 01:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777340072; cv=none; b=YcEhDcyap2qH0UbNPr/5EDYIpJRtMW1AJCo/sWqacYHuueVMEe8ITjAJY+MPTevAvcxqJ0WwSQX9OySRbibDYEJBsl+a/bOZ8o8AcJTFCY0jPwO0+OYKI50SYjak9HMjqJ+0NAvxnSpdQLuKpOW58LI0cbIwxQv5uSgD/PIrI+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777340072; c=relaxed/simple;
	bh=x42u0yyujS0MNNJ5zIzlJ5WzcqjchBB5xjDhcoIlpNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RvITStFBqRuRA2ZpkGP9KhwVF2x7TSgCh5LBW1aE0U1thvSR9ehzYaG7ZT+Yrggml7GSdq5uK6+NVqU+NCuec/8eBNO5faQfeEv9KDSfOHlxeO7q6Wxg0l4/zU5ZpFSB6RtsLg5CwP/UVV/a90ibmOPtGw8KspWm7jNBiCOh11c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eRybFt+i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eRybFt+i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44CB6C2BCB7;
	Tue, 28 Apr 2026 01:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777340071;
	bh=x42u0yyujS0MNNJ5zIzlJ5WzcqjchBB5xjDhcoIlpNo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eRybFt+iabvl4JrFNGv5dY/wGWUCCwzlEEXQfKsMxsxrjea++yxvDR5XF/u7ItIK2
	 35B80+wBa+TSMM55i0ITO+dRZe3C+noXe0rY/avkO7Iu3UHGjA/N8LMvuTN3edUtme
	 tlc6oZAO9Sts5ivM85kHYH8EjfZSdq+kLTAC1hdaySyumzvR6sF/jOSmVv/jfOnA0N
	 7+W8JJqt1XI9HLfntRLLiKfhFinQNcNVicI/r8wNcxnyysXWXJhGFgkeZoShpw/uej
	 rfAK1I8xSUTD/18PKOnSNwrjSd49U2sel/eLfPrBXl29Enh9AeWFckvmPMznQvbSmA
	 OIoRm3UgAu+Qg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
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
Subject: [PATCH 05/11] Docs/mm/damon/design: document fail_charge_{num,denom}
Date: Mon, 27 Apr 2026 18:33:54 -0700
Message-ID: <20260428013402.115171-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260428013402.115171-1-sj@kernel.org>
References: <20260428013402.115171-1-sj@kernel.org>
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
index 622d24e35961e..fa7392b5a331d 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -576,6 +576,28 @@ interface <sysfs_interface>`, refer to :ref:`weights <sysfs_quotas>` part of
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
