Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A152C08D0;
	Wed, 17 Jun 2026 14:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781707729; cv=none; b=XdcbmGoTExSAkSFHfCpqRyTJ7P1dvBT6cY7NgWsfG8ojilc5Dsl1SxgMtMPxuShYY1FtfgRdMtqcCPWjNSMZrU1JvuK51zD+jiH7lLvWkEoxAGJpogZ9EZ5OyvbIZaUcpr9cdTRIVZj/13AaiOG9MmvX8uX7KhqcHny8xvkf+v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781707729; c=relaxed/simple;
	bh=VFyqZtISDTRdnQQFLxP8APSXzrGkHCGo4MYo73XDt2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RvUtWbUmTiD4gErZTcnE9GXCrZYIx6jAnjBC/36QXwUvn6R59Fcxnq6Ijz/upwRk/GeJHce/UQHUJXz47wTf3bA1/6qPHh/3x3uFYHAcuY+TDCVwFnZYHKUgs3a8pv8+Ct/VyhvF2WWiEncBMXNm+m+xbpnt0wpbWQvswMrV9aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bahdETyk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bahdETyk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F16F1F00A3A;
	Wed, 17 Jun 2026 14:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781707728;
	bh=84/qqfM7ZmuFKR3xy/NTI5td5S5y80iivZPv289eNEA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bahdETykUd77T1Yj7mG+QVT9cX9iWRF+x73GqFpmwVMHSxAAzDLHgTyWcZXeCi3Zz
	 /jEkHlOBs1YNKRyu1VCxqM4JmVp8zFlF3v+CqEHhsf+JlfyOrtacjBah/tGgEg/fT1
	 ROgd4LU/nSV2Q+LvRcKYdbtZwjHAx3jZSQ2WZSQ6aW8CWUZuiRWoV4VprN/WShtJBt
	 MKmVnaia7K9diWE5SLN5bXtUlKMyWRDXxOaBo6nG5ZYCJtmf3lQoZEWUHJGnf9M5iZ
	 O8Mnn2psjX52MFFSQHEPU8p2TdSwonMsomDQlur7aYhlvlA6Qx6T3FTl2lximmymQu
	 8gczbC3BtG+oQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 11/11] mm/damon/sysfs-schemes: kobject_del() region for populate_region error
Date: Wed, 17 Jun 2026 07:48:05 -0700
Message-ID: <20260617144807.91441-12-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260617144807.91441-1-sj@kernel.org>
References: <20260617144807.91441-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On CONFIG_DEBUG_KOBJECT_RELEASE enabled kernel, lack of kobject_del()
could cause directories creation failures due to the name conflicts.
Fix the issue for tried region directories in the error handling path of
damon_sysfs_populate_region_dir() by adding a kobject_del() call.

Fixes: b574a82d10de ("mm/damon/sysfs-schemes: implement tried_regions/<r>/probes/")
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 0c0c9637b594e..d3b414f7bd205 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -3132,12 +3132,14 @@ void damos_sysfs_populate_region_dir(struct damon_sysfs_schemes *sysfs_schemes,
 				sysfs_regions->nr_regions))
 		goto out;
 	if (damos_sysfs_region_add_dirs(region, ctx, r))
-		goto out;
+		goto del_out;
 
 	list_add_tail(&region->list, &sysfs_regions->regions_list);
 	sysfs_regions->nr_regions++;
 	return;
 
+del_out:
+	kobject_del(&region->kobj);
 out:
 	kobject_put(&region->kobj);
 }
-- 
2.47.3
