Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC123FD14F;
	Thu, 18 Jun 2026 15:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781795743; cv=none; b=BbIcny20j0EvAED2Za4i+uyVXfeHdpI/YzHH8sudqKFZcHgyWMypnt3J+j5bWh0Eay6E4LSg5NTmk7/9GM8xkWEXG5t6HhKGsAcZadcT9pQN2Umkob4jLlj8KUW0nTKHrdNO+kAXmBzRMOM5D8A9vaN/gU7q6NA6V7udRoMo6VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781795743; c=relaxed/simple;
	bh=8Uw1k/kSqhVccvCXvRp0tC02aR3xguABsyRzXPyQr5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hinRi9iBi1TX9rwQs6EI6hBi8/VfkeoafhJrUYsmSElY6qKZEqKx2EgcAzhR4a+tUhDV0cFS/r8fCx17VTV/qp1ZUScC76uN3Fyuxg6pd0Y4qjfpZ5y/z5vubNO26xRZy72qyjk2gP4cASO/rdRP1zUxHiaZp6rd/HOCVttew2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AmQvilKQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AmQvilKQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2704D1F000E9;
	Thu, 18 Jun 2026 15:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781795742;
	bh=8lJ+DfqLbL+e3xmXDpTayP9ovqvMIBlFf/wTcMrXgNU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AmQvilKQKiAQTwPw+BytnN/wnaNJm0hH9+u/3nuAGxdINTbZ5O6sIJ+YT0BYbuMh/
	 JL7sfuiNKOa4v3nsupCan6rkkod6Be3N7qjhpDYVs39NGdZOjo82YwVBViGJP5Nkw1
	 104ONUQZRA9AGCGOo83uYwbE+lB3woEpEfJjegb5p7kFWuaY25vdSsp/8lekzdXLiF
	 dSm5zo2iwOc8KslQErVMka+imOKOs0ujRGFJedfB5ofG6pmhMD9dRSDH4VOabLNKto
	 gSAstARw/s0IMHVJc03jVYLI9aFVl5UMHDcta86Xx4dcdeHW5Owsl6D5OLUC263TGV
	 4djzNQ8RKILcQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.2 11/11] mm/damon/sysfs-schemes: kobject_del() region for populate_region error
Date: Thu, 18 Jun 2026 08:15:15 -0700
Message-ID: <20260618151517.5366-12-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260618151517.5366-1-sj@kernel.org>
References: <20260618151517.5366-1-sj@kernel.org>
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
index 0d4e9b053e381..9d8fab32b80f7 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -3134,12 +3134,14 @@ void damos_sysfs_populate_region_dir(struct damon_sysfs_schemes *sysfs_schemes,
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
