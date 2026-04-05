Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891892FE075;
	Sun,  5 Apr 2026 15:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775401958; cv=none; b=ki9iT5WxdZnj5rP39nRS+IiWqMb5Od44X9HZF5Vh34y34zncm9MKrny6HR2j/vXIrgsHDmnb3BJ+7kSHvd+aa5WYvySKVpUvxhZ1b9C1GU5dHgzo3YiRxH/EqQQEiVucCabyX58pjauvLuY2D4/1Sbma6UVHAkPAFXqoeSxFUIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775401958; c=relaxed/simple;
	bh=wTsJFLfcGLj5hQNAgMMrTSRf9Xxnu3P2tGtJgT/UD5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mjgPMDEJBjm2uYuT6XRcz+jknkxNR53B84XrHNV82jbxc4rxlK1Wfet2NVdylnilqy8g9TJ6by5TWcxHfDIT+r3JGzeF9tKAQ7S8ePMowlPylOXRqftT96+c6K16tUjOs7sITcU69OYwqrMarm6PMjLlsE1Cy+YfKFFUEQJBs1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mzFr1nw+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mzFr1nw+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF2F2C2BCB3;
	Sun,  5 Apr 2026 15:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775401958;
	bh=wTsJFLfcGLj5hQNAgMMrTSRf9Xxnu3P2tGtJgT/UD5c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mzFr1nw+rcLAXTUg+EVg/b6BBnJx1FjVt1a5qCAYYpmhDWqAjJ3yYdFlWunnzRvam
	 S2v6p9qAsl/T4zATyo8fTQQWF1XnnqP2DDs+3C4Gg6L3PvuBpGt0Q1pgaSutQj2mS0
	 X/0TJRfkgObnxwaCGZl8o2kJNQ+rGkIKMxsSP5E/oREiCaCWmprOMUmO0dUnIcL3tr
	 HiROrLEK9WGTFhAanhk/cPDPkPyrzuN5l3F6xBiQbWbyETcohQ14/fr9/ri9b2KKPb
	 JpXz/rlhslBtUFC9BhKrMYDu0NSJzmWDP6Zfhkh67TECektmrGRmtX5WWifcYcVTvM
	 kiy6LRyooJu7A==
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
Subject: [RFC PATCH v2 3/9] Docs/mm/damon/design: document fail_charge_{num,denom}
Date: Sun,  5 Apr 2026 08:12:21 -0700
Message-ID: <20260405151232.102690-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260405151232.102690-1-sj@kernel.org>
References: <20260405151232.102690-1-sj@kernel.org>
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
index 510ec6375178d..3ea9c81b756c8 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -572,6 +572,27 @@ interface <sysfs_interface>`, refer to :ref:`weights <sysfs_quotas>` part of
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
+two parameters represent the numerator and denominator of the ratio.
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
