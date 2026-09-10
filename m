Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA22248E0CB;
	Thu, 10 Sep 2026 14:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789050163; cv=none; b=rxr2wBpuS9c9DpgNDbpV2k7XxkdTTHcyddM4iMrKnQX5LlpbK7O0UoKuwk0+L6Mu/DEVnx6ep6njTQaBc2V0I78HYxjuDlcXWfKiMfecErC0TUS4Kom/9ymkKwPZnMBykAn2R3luRU8e55J0xXvNzRwb+bc59K2hB6alO7lb7JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789050163; c=relaxed/simple;
	bh=UYNii2J9N5IeNLw0Yeo1sxB3yu/PmjdINz6uaBoZpFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bpJYbCGvvpsJcxP3jSbvrfPIYKFJvDJVvn9pGb3cvb8rDUt2QV2b8eoIQNWzwZHV9f56omYSkoL5/W3B0HPfIEhyWC+NJwfrja2tGTaBSEVHbqWopNpqNlcG1hqxyeS9/8pylRhHHGi/K9Cr2SgPxVLqvNzV9v/NuXv8sWSpJfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gXpoOmrU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gXpoOmrU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D4DA1F0089B;
	Thu, 10 Sep 2026 14:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789050162;
	bh=2EEU3ekWc3qyXmh8drgRUKtX2xzp7GdjGEtLM6CGh4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gXpoOmrUUCCHE7ni0HxrzQMMywG2pgvriZVJEqxcveZEV4i8ONWVLtiT3IT87qRN2
	 9qiaHF/6LiZEdowdIvncSyHDFIjsVlcCb3Zagivk2h2o75tGk52pLbBSrGJ4nn6TRs
	 drPSgsanau1MhUODggBEAirCYbpAxlAcuQX6M7Z+4YkWHQxR3kP4ZhWwEZPc0vptu0
	 taRDJX2G6J39PJAU13ZJiQ0LrrRk5eUeto94C803Lev1/5EsZ2VIZYA4xFv6LiTqOh
	 DB3coUG59dYH7foek3iOueUTTdQvceWAZIza6U8BjJYCSJ22EsP6uFk8Mw6K+IAKz2
	 Z9Ya46a8KTPbQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 4/5] mm/damon/sysfs: support DAMON_FILTER_TYPE_PGIDLE_SET
Date: Thu, 10 Sep 2026 07:22:31 -0700
Message-ID: <20260910142234.171562-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260910142234.171562-1-sj@kernel.org>
References: <20260910142234.171562-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend DAMON sysfs interface to let users setup
DAMON_FILTER_TYPE_PGIDLE_SET probe filter.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index b576e97cbfdb8..51fa506c879b0 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1001,6 +1001,10 @@ damon_sysfs_filter_type_names[] = {
 		.type = DAMON_FILTER_TYPE_PGIDLE_UNSET,
 		.name = "pgidle_unset",
 	},
+	{
+		.type = DAMON_FILTER_TYPE_PGIDLE_SET,
+		.name = "pgidle_set",
+	},
 };
 
 static ssize_t type_show(struct kobject *kobj,
-- 
2.47.3
