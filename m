Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA1838945D;
	Tue, 28 Jul 2026 04:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785211976; cv=none; b=LUDNjetN7J3J3vM8xE4HbXP+1ac4x+3u548oTUkDzgoNE6T2OumV5Jqki2oU+1Z7Und5CMj5OYy43wpMnSfH1jTNVEaJDNiNK0SYvHael5ntGwI3kFHytzSgdhAMmY5OEVTDCkBJ4pAHVkWUfy/bTtdRitFp2LZsKPuxRSMe9mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785211976; c=relaxed/simple;
	bh=7h6y5JXBJCETCi8rkys+885y8ALbrOAXXkBkWTxtVTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U6DfshlCeIjPfiDq5TpxDOFremlvdC6IHuEdAsk7N4epL1S+y+0u2YfFt3+H+vAkTf07Uh32462ueWkaxG0s22j09KXXAk4JJ8ehSG2gjxXvws5o3ODvJWZwHbPY0vQPi2CiDrY4dnL5S/rC0VafA/vnz0KFyVEd/2alYxT8PJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hxhTal6M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hxhTal6M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96FBC1F00A3E;
	Tue, 28 Jul 2026 04:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785211972;
	bh=DFWrh4xOzIaVYjLemNkzYWoT3xqfoUiMT/45TgdX42g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hxhTal6MMeichFrwfRBQOj4DGX3b2tJtM7yIdNaplDjfSdKvyAsHKLuHzvpPYwTj+
	 oA8F5F7gixVPOQcRoUQbHyAGqiHF81NQPIPEIGEY+89Rxt35Di5ygsmdz+s973n1dP
	 9YNz77glA2CgBHQT6OEgyX6x7U+hYEB1uu4zXzuXNOkbRpq3Ij/mDfwQaiuZng2FKB
	 rV6hCvqAL8zB4lLX6/MHEkKGfianI4hZbt1CmLIRWcuZmDNbe7thaO+Us/43D66HkN
	 eGQ5933sNTJedBbFTtas3GLA7VPyQwT3Px6fC2N31PsQqL1CCPeG/OSiuFmbTIxSpI
	 5G7gavndbOKPw==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2.2 03/17] mm/damon/sysfs: support pgidle_unset probe filter type
Date: Mon, 27 Jul 2026 21:12:24 -0700
Message-ID: <20260728041242.187380-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728041242.187380-1-sj@kernel.org>
References: <20260728041242.187380-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend DAMON sysfs interface to allow users to set
DAMON_FILTER_TYPE_PGIDLE_UNSET by writing 'pgidle_unset' to the probe
filter type file.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index e3858ffab4b22..50ff1c172d746 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -782,6 +782,10 @@ damon_sysfs_filter_type_names[] = {
 		.type = DAMON_FILTER_TYPE_MEMCG,
 		.name = "memcg",
 	},
+	{
+		.type = DAMON_FILTER_TYPE_PGIDLE_UNSET,
+		.name = "pgidle_unset",
+	},
 };
 
 static ssize_t type_show(struct kobject *kobj,
-- 
2.47.3
