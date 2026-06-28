Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F9E3BE64C;
	Sun, 28 Jun 2026 22:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782684092; cv=none; b=vCQxpgVvug8JRV58D4U9asi1rGSP3phORenRG+5/27vASA0J3yiYKvdUEl48Jwi7kZppf1ti/FvOHA93jnlYCrIaldy6oekvh7RYPToQ5KAThkVXRHaxnDd8uT2l1snfcccwXdqW1r0TEEX4/lwRSpwwMafsoS166OFs2c24MY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782684092; c=relaxed/simple;
	bh=wLSIJJxL/N5karrdU0P3w+WOpiSjx28s4i+7MHUL/2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aD+iDm1RI2o7cLxK/Dd7fqTcK0n78T/t5iGf12DwRT65q3rT2h5yqVJJ8S8c3aHqK0GLPeDBYpCzb8zRpGTz3YEdALXM1BV7qguvVSdqfALpzjUV/LQlYPsCgmPd3Kf0F/09xARCJykr1XzrQfWVMF7lxxXHbP87GzcQLcyqSnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BsJUW92c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BsJUW92c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 339DB1F00A3A;
	Sun, 28 Jun 2026 22:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782684090;
	bh=hGvHa5tYAkEF4rEB2p2YMvPKhuvQYixaBRxfKvPf83g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BsJUW92cGcgXzmfE5Cl1tSjzny41PlHDmRuN+PtYodY46D8cHIVHe0C5VL9WO6Qi3
	 LOfS8C/HodvSXQkndzhRImzWg9X2v13W6Gy6DEiSYaYPn+YioEc8BxTgh0mz29bAMR
	 c4JxnIOjXJOswqok3QcLOpFNbujsBEjrxrfEno3HkLRvnubkEWXaP11d8kU/PnTZrF
	 Pm6HO9a8WdwfXRYF30NaIPSOgXcaAPNMiSJ7rK1K/PrgMr6zakhtKOx0kFmw6U6oHZ
	 CQsJNhSXDmVHdzz+ks6i7cQHPvPxsI0kS7PeWkazYCIUM6aJGR1vagMs9T4Kn+3JQ7
	 YkxKf0Khk4Jig==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 11/11] mm/damon/sysfs-schemes: kobject_del() region for populate_region error
Date: Sun, 28 Jun 2026 15:01:20 -0700
Message-ID: <20260628220121.97360-12-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260628220121.97360-1-sj@kernel.org>
References: <20260628220121.97360-1-sj@kernel.org>
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
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index e2c8716be6c9c..41f93a1823bf1 100644
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
