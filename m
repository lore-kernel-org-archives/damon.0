Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D890825DD09;
	Sat, 28 Jun 2025 16:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751129519; cv=none; b=AF1RmfnrAbFISkS13prnqdDbPuQj/ccNOKn/kcyVouaM35kxwOmg/eJeOFfABjFUFLWivPBfaw1F1AXGvDzp1ktbQ4PLGxrBnm0PM06TLZmuxydNi7qKpmII/0J/K7V9F7nb6a17wQlhrvgxfspa6gYDBTm8OSbaNOOEMT2sRMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751129519; c=relaxed/simple;
	bh=fbG+KWln8sAPRrugQfWweISG0dHsqG1V9oMoVBcHL/c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZR+9iUgletjAF5cihr8Ank4RiS/5qK6U09k8Kuhkbv98MQABJxgpGZS3uEFnldAI1R2oteEUgXKLv1UksqCtl1A5xBTwgxCnNXCVBhJeDfEnvhKABw980EIZFEgAdRjzhSp9rmtODNbcrRHF7uuFSefM4BoiPFFgnFzqwH3je3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DS5QeNIM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DS5QeNIM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46876C4CEEA;
	Sat, 28 Jun 2025 16:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751129519;
	bh=fbG+KWln8sAPRrugQfWweISG0dHsqG1V9oMoVBcHL/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DS5QeNIM5rDCiErt/eCcWwMgF688xD5WMGg+fgZXgr0iH8Vc2BlIJI2Xo8MJoi/pi
	 SQmYij/3HDK/RMJex+bjiE/yfsXdHLWXMGCq5+BnPqizg1/tu0ZhuuyWrZq50bjQan
	 tvt3PBUq5oXPSXmyB97t17rlKvbiFa2rYhkV0LVoQjBdy4OkMOe88R7SfuyLYLye84
	 L4gzSp4fdatQmqdN32QeLpODeynJiU4N8Q178q8DfVMO2K4iWh13aMF/DG08xWmcF/
	 Kj35aPZ1VxuuypVPDslwt12oFLwWHX58mKerXkaA4fgoVePzk6D9hjtYb+WFFjpxlP
	 HPG9Dxbs2UpPg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 11/11] Docs/admin-guide/mm/damon/lru_sort: document intervals autotuning
Date: Sat, 28 Jun 2025 09:51:44 -0700
Message-Id: <20250628165144.55528-12-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250628165144.55528-1-sj@kernel.org>
References: <20250628165144.55528-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document a newly added DAMON_LRU_SORT module parameter for using
monitoring intervals auto-tuning feature of DAMON.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/lru_sort.rst | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/admin-guide/mm/damon/lru_sort.rst b/Documentation/admin-guide/mm/damon/lru_sort.rst
index ca4e071b3159..f9dfa8255dda 100644
--- a/Documentation/admin-guide/mm/damon/lru_sort.rst
+++ b/Documentation/admin-guide/mm/damon/lru_sort.rst
@@ -91,6 +91,17 @@ increases and decreases the effective level of the quota aiming the LRU
 
 Disabled by default.
 
+Auto-tune monitoring intervals
+------------------------------
+
+If this parameter is set as ``Y``, DAMON_LRU_SORT automatically tune DAMON's
+sampling and aggregation intervals.  The auto-tuning aims to capture meaningful
+amount of access events in each DAMON-snapshot, while keeping the sampling
+interval 5 milliseconds in minimu, and 10 seconds in maximum.  Setting this as
+``Y`` disables the auto-tuning.
+
+Disabled by default.
+
 filter_young_pages
 ------------------
 
-- 
2.39.5
