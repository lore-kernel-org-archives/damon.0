Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0F43FCB13;
	Thu, 18 Jun 2026 15:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781795738; cv=none; b=XhQDreYnYKKuL36xCXF5GGL5hHbTgR9GfdjnnBq5+9+mB4zGSUll8vQdy7HO3eukynCAeqmFtc2rXy8GyN56l7fNxfRoFyvSNxIN6VD4gkZ4KNF1eU5in2WQx6j5aQV+Y+kOS7A8WxA+CtxRKu3GrKyQVbA5vgxoNkteMnKoDZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781795738; c=relaxed/simple;
	bh=ke/B1GO+KWlUvOAV22leJSyJ7PePA1RsdVGopsukReU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FI3rIe3PaoLCZOlYy0LRWpvnkVgarxivAw/YxxAo5epn2Aw0iikaeV2Fu13gW3B9403XdIMcfFvQCptPh3xsvygph/YrcY6E3u/JXtgEooWCY/3dAPdUWOX/D8fE3i36A+wS6fLqJqcdtVJMzyBR5t1tXX3PyN56p9Gihw3YRbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ALenW2U0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ALenW2U0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A146B1F00A3D;
	Thu, 18 Jun 2026 15:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781795737;
	bh=xDjjHeE3ik/DACcTjgmd/gOCffqc91TStH/d4lyl+0A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ALenW2U0K5kUc27EbhsCZv2lBW6BvHI3zAcUedzVXhwdTPW60prdfnOnJzSD6sboY
	 2Esth1GWP8+y6/iWduNQqFr9wuyGGihgj21KOIrTD2Sut7mREF5aJbWrsthCA4W+L4
	 EDoiMHnlhEZYbp7y7aAFAjUr74Y5N1pnHoJ/FGr2E+VDVvJFM+/OZfZaEuy7g9aJTy
	 rln0BVDly/7Sp0Y9e1UiQln5SFlGwPeRclGXKe9jp5ezyLglUAc1vEkFpfPf23OckL
	 RESd6X6FK8dKbN30OoyuD7QtZFypr9HJNjMwvDZPpReR5Ea3pwUbNA2tOX2vxIxez2
	 auAdbGJ9MQrYg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.2 08/11] mm/damon/sysfs: kobject_del() probe dirs
Date: Thu, 18 Jun 2026 08:15:12 -0700
Message-ID: <20260618151517.5366-9-sj@kernel.org>
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
could cause directories creation failures due to the name conflicts. Fix
those issues for data attribute probe directories by adding
kobject_del() calls.

Fixes: bf3ea3d30880 ("mm/damon/sysfs: implement probe dir")
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 3c349f0fe80f0..5ca45654cdd39 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1139,6 +1139,7 @@ static void damon_sysfs_probes_rm_dirs(
 
 	for (i = 0; i < probes->nr; i++) {
 		damon_sysfs_probe_rm_dirs(probes_arr[i]);
+		kobject_del(&probes_arr[i]->kobj);
 		kobject_put(&probes_arr[i]->kobj);
 	}
 	probes->nr = 0;
-- 
2.47.3
