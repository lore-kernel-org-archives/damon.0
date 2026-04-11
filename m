Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300193BA227;
	Sat, 11 Apr 2026 16:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775926169; cv=none; b=CsLsoEDA28XiaIQOgx5bicKHIJkyeA92Rbvc/wAxhStxQmmfYMw91f4LOg2ccCAG6+imNiVA2r/WExRo3WzT7EV9mD+kAlx22fT18vT0Ajeje4KEaR2mRuVAjvlpsnALxDyddCMOKn5n5t9dsvs5I61oz+iqmhy5Q0m9PMQMJ94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775926169; c=relaxed/simple;
	bh=x42u0yyujS0MNNJ5zIzlJ5WzcqjchBB5xjDhcoIlpNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J4zKU3A02WDEHH0uIYR7m63RjaBEJAJG0T94HhwB2+lURwsOQjXLeEIoV4O3dbDVe8gE/Wp3lCA0ce05QQ1/Thh4xBbZQ4PXAnhdQBPSMAtEsFFtv3lxKwnncSPEpvW8K6EFjeX3X45IN+loxQaIkw+8BX3EbzelFcNHwoRLFO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z/FcJ+iy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z/FcJ+iy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33A9FC2BC9E;
	Sat, 11 Apr 2026 16:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775926168;
	bh=x42u0yyujS0MNNJ5zIzlJ5WzcqjchBB5xjDhcoIlpNo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z/FcJ+iy9IwVcBSq8BZODV8vNmnfox9bfxN50LS2S7JpuBtsMGy/TH6y4AfGxoFTI
	 aH097i279rIn3CS/9PQ6QKDB41dcQ/O+VNln+dtk9i3m8t2XI+E8Hu9G3RzBPWBiqG
	 J2jfJ9wDMTXuTqMOjlkwI+Wbv45WSDrtaEgqOu5O/nwn9Qo3+aolLPhscezobi0G1z
	 qroOk625ZB0VTYVP56wUQV2J9B5GzSBL7Hd64WAQuW3fdCBJEuDF45yF16rs3BACyO
	 Wz34u4LrXYYdt8snbWg1avEc73bFWBquYhVdw48ChYEtk4ud1TzMvFOTT4sTs8CbRK
	 0iqoPmFepDJmg==
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
Subject: [RFC PATCH v5.1 05/11] Docs/mm/damon/design: document fail_charge_{num,denom}
Date: Sat, 11 Apr 2026 09:48:58 -0700
Message-ID: <20260411164908.77189-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260411164908.77189-1-sj@kernel.org>
References: <20260411164908.77189-1-sj@kernel.org>
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
