Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA6D26F479;
	Thu,  6 Mar 2025 17:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741283962; cv=none; b=UD9gk4z8+/Y9bIggpaD2oCn7OrsBwMBVDgAvliNzMcp1mzlik7qBKJXVxKHSi1qJigiw40s7jpG3VWSyg+hsuSMkBOxDltidIWLvBFEI9ic+ZlxdF2o09mIbVmg8V+pAKzea1+gF/z6eeCKJYA4cElsofL4XroPPnNCgUB9VAaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741283962; c=relaxed/simple;
	bh=CtrMG3b7XVPdT3oTv/pTE3ihT4fR44kaP9KWdR8X7yY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eobsiX67XdOaw7W9xOzfeYP52fVzpP56+Kb5PJjTk3RSG+R3aPs89X8eCyny/grmxgpI+7liCYbRH1S1666EDCxCICAL36e07U3PDJ7ZYtTKtZ509Pyeuk8zw7y/4nnz4KG3SfrW1CvANzRosObtv2Aa96ojfjkW8Prqu5GLNfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bNjKFFQ4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bNjKFFQ4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1518C4CEEC;
	Thu,  6 Mar 2025 17:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741283962;
	bh=CtrMG3b7XVPdT3oTv/pTE3ihT4fR44kaP9KWdR8X7yY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bNjKFFQ4rDBT0cqCm2AT0D+nqoXZvgts3+W3NqHzMf1U+oxW+TcglOC35LUdQVkVp
	 Z936/lHqyHUi4YxJG4dD50mQKP4qakrLcVT5pXJ0XO+kNUsJpkRas/SSW8DeU2fNZf
	 AWMXL2m6qztdxSIityXOiu3DFiRYCDXnsjBLbsFcHrewWvPMAxPwhTRRLd/3U6m1e4
	 AAFDj7tRbac5H8cybPSMKqrsjRwPOOAjYUo8wFOHIKqEr9MN6o95+MiWjBvBEFLrQX
	 6oOl5M6C6zzj3KSSN7CWNxh8zicOJITZ28nDjso82JMSnkW4hzudWVWqDTw2s/k5P6
	 yPOXj7lQmJmCg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 08/13] mm/damon/sysfs-schemes: remove obsolete comment for damon_sysfs_schemes_clear_regions()
Date: Thu,  6 Mar 2025 09:59:03 -0800
Message-Id: <20250306175908.66300-9-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250306175908.66300-1-sj@kernel.org>
References: <20250306175908.66300-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The comment on damon_sysfs_schemes_clear_regions() function is obsolete,
since it has updated to directly called from DAMON sysfs interface code.
Remove the outdated comment.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index ed834622df2a..d50f37ef4eb8 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -2341,7 +2341,6 @@ void damos_sysfs_populate_region_dir(struct damon_sysfs_schemes *sysfs_schemes,
 	}
 }
 
-/* Called from damon_sysfs_cmd_request_callback under damon_sysfs_lock */
 int damon_sysfs_schemes_clear_regions(
 		struct damon_sysfs_schemes *sysfs_schemes)
 {
-- 
2.39.5
