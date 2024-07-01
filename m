Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0195172BD1;
	Mon,  1 Jul 2024 19:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719862038; cv=none; b=VODGaWEuDdCX+JRqS0gf0r8dun5Wpfouzy1HjNiDDkOEEl7B8GoHpfDS4Zb4ANFpNejhW5sjCBe4I3nQiXeq6GphWxyZ/3xacQdUzgHnFZ7+ba1cpxfjzncGwbOnbm1xMKDv2EywZN9jC448kkAaN1GOY9+toHxgCivV6zSpGZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719862038; c=relaxed/simple;
	bh=fBlkxk1Ff29Zv5hf2sNJnmiHJF0MltvzTSJLNhDvsG8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C1LCS26pfOteAuIrFxPbjbCFXYyN7nGti7dHfZhwSwZxDjkNlTvX5Qszb1AvXSEZfXn3ZSM5JJHuTTwaXP4yjPeHEwtFsz4yQ9Ci4cQRz4M1vCZZsjfNSyQz++au13K0O8IpW8V4SFtO/TVp41oD9hC7T59jeIA3wr8X4w5aPuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X4uyulKb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X4uyulKb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BA6FC32786;
	Mon,  1 Jul 2024 19:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719862037;
	bh=fBlkxk1Ff29Zv5hf2sNJnmiHJF0MltvzTSJLNhDvsG8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X4uyulKbdcl37BYLf/rxxpfmLRRiHxgo0DdJC/AznGxFaPaD2j5tC1707zu7MB4m+
	 oJHVeSBr7Hsz/iQ3j/bCS+ZvrNDhcRNnbYDp38oh1BejNsY6D2hqBEd7NFK9vT7oPL
	 F9tXsQ2/A3l7gcSZ0M8xHvwtA/eaBmHnRDfcG8tEVoGMwvD/AvmZpVT3QDVEMiZ+1r
	 NTLTFMinIq0OI2PmAO8xdUtoayV+W+xeFoncTB63jXwm2TR/4ALWSu+g6IBJW38x1P
	 4iPYzXgQ/QfldH4VQCg/4E/SXPmzn6KWDXXGiOWQGfl6aYfF94MwLNs97Pu3CFNO6b
	 AFaxzonaM27Cg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 9/9] Docs/mm/damon/index: add links to admin-guide doc
Date: Mon,  1 Jul 2024 12:27:06 -0700
Message-Id: <20240701192706.51415-10-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240701192706.51415-1-sj@kernel.org>
References: <20240701192706.51415-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Readers of DAMON subsystem documents index would want to further learn
how they can use DAMON from the user-space.  Add the link to the admin
guide.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/index.rst | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/Documentation/mm/damon/index.rst b/Documentation/mm/damon/index.rst
index 3d3b345d8889..dafd6d028924 100644
--- a/Documentation/mm/damon/index.rst
+++ b/Documentation/mm/damon/index.rst
@@ -16,16 +16,16 @@ monitoring :ref:`mechanisms <damon_design_monitoring>` of DAMON make it
    of the size of target workloads).
 
 Using this framework, therefore, the kernel can operate system in an
-access-aware fashion.  Because the features are also exposed to the user space,
-users who have special information about their workloads can write personalized
-applications for better understanding and optimizations of their workloads and
-systems.
+access-aware fashion.  Because the features are also exposed to the :doc:`user
+space </admin-guide/mm/damon/index>`, users who have special information about
+their workloads can write personalized applications for better understanding
+and optimizations of their workloads and systems.
 
 For easier development of such systems, DAMON provides a feature called
 :ref:`DAMOS <damon_design_damos>` (DAMon-based Operation Schemes) in addition
-to the monitoring.  Using the feature, DAMON users in both kernel and user
-spaces can do access-aware system operations with no code but simple
-configurations.
+to the monitoring.  Using the feature, DAMON users in both kernel and :doc:`user
+spaces </admin-guide/mm/damon/index>` can do access-aware system operations
+with no code but simple configurations.
 
 .. toctree::
    :maxdepth: 2
@@ -34,3 +34,6 @@ configurations.
    design
    api
    maintainer-profile
+
+To utilize and control DAMON from the user-space, please refer to the
+administration :doc:`guide </admin-guide/mm/damon/index>`.
-- 
2.39.2

