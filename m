Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B5F26F462;
	Wed, 26 Feb 2025 06:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740551824; cv=none; b=HcEbITuIeDoWPwt9bJYISnhmnC0wbhdV6rFkQIvPHQJsYKBEkoBymjFsOzIlr8hPiVa3WY5nOK/ZqXL+QlnJdPBDLKycOinCZQuCiGRfbvWBhZoOQgzlohUDmfAgbiwFFj6+S3PTlckEcqdCrYaeRoxhIytpiU5FGjjgt2A9/Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740551824; c=relaxed/simple;
	bh=CtrMG3b7XVPdT3oTv/pTE3ihT4fR44kaP9KWdR8X7yY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fv6QFyrN/yFmbJUdcbGoJlRkz2jvoauVJqSdZ1G1XOGuAONosRsZa2IziQGorHM2+BFwAeSdmHG+2tzFvsZ7YJIKeeTCzXcahwAvT5BVdOxB1hXZwyB3+vTsmhH04zgxAInUeQliCSQ+F5eOVS8BtBFG7mlQk0LB+pQo2qigsXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rgk7xIYf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rgk7xIYf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6576C4CEEC;
	Wed, 26 Feb 2025 06:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740551823;
	bh=CtrMG3b7XVPdT3oTv/pTE3ihT4fR44kaP9KWdR8X7yY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rgk7xIYf3uct/Bru8Ihtd41lN4L529TO1m3KX1Dc8PXuXuthMn4rHZrRsk/mmkrnK
	 Apxx/MqDzsD8GMC1087yex2BQnHxNoWJ+CyVuVR24lv2CO89Xusu2gCF3x+XsQdBRt
	 5XRq7mSJ3gZHpjRAJDgs71Frh6f0C4UH+rEgIebK4gEzfYdsiujh8LgrbGSayJm14v
	 8XKrOppXa45/2KvwpVC3rjn6marRIl5Di23tF9Kcp3hEZaeMP+Q+AH9YHZCJxgF9uR
	 SHm6TU42cy3/Do4NvwpVF3b4YZF2Ugvsty/3yxwagOLGXHKQBPOQByXTGSyx4RN8Js
	 wH2Vb89PCJhwQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 08/13] mm/damon/sysfs-schemes: remove obsolete comment for damon_sysfs_schemes_clear_regions()
Date: Tue, 25 Feb 2025 22:36:46 -0800
Message-Id: <20250226063651.513178-9-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250226063651.513178-1-sj@kernel.org>
References: <20250226063651.513178-1-sj@kernel.org>
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
