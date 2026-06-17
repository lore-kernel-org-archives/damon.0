Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE02A292B2E;
	Wed, 17 Jun 2026 14:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781707726; cv=none; b=oUVFzJJAMMhOx7EeDBSZjw0XNVXYFS5JSxEaWQ5gHPwi+gBRHPr664aaafy/MpHyWpfzGRVwH3+DAt2bU2TK2au0anZwRscrq/slHsPclOqeZYZVp3LEcdt72Wwx7Vct4Lw5nkxK9bkvI6MQOC4vLRWausnvFHsIsgm9nbAOM7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781707726; c=relaxed/simple;
	bh=ke/B1GO+KWlUvOAV22leJSyJ7PePA1RsdVGopsukReU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jSeSR0MKhDjhjC8G6UB5qOGdZZW9+EP9iuZ8SMKx28RSl+KEZxfxH5nBzUXu4uCgh3JuATL2HzX1Q+WofRzzEqW032FR08ifPl05zfuo2Z/7s2OWQY+kQ+25roM6IxfJGVYa7cPAaEDavktXaGedwXlXVOeFnxvzCuKV4+eGoWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fy6S+g/M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fy6S+g/M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F9441F000E9;
	Wed, 17 Jun 2026 14:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781707725;
	bh=xDjjHeE3ik/DACcTjgmd/gOCffqc91TStH/d4lyl+0A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fy6S+g/MK/ISQR2I32EJsEB4grURqXEipGqfk1mscMpuO9ztiidZGhOWTl+BtvkkS
	 iv+WYXxOHxVgrKPmPXkSgeMso+cvjojMoU11EGce1S+fQvG2VHobPCMsvIvyu4zpbC
	 qywaVfNLvJxbkQ9Eg7MSWIhqDPhKX2lC2+DlvZboy7AKRaRQ4AchFCdEs6STZbPl4X
	 hl/OH8PNPLvTYQnYZ5uM0r1J7tTagWMjxH8UG+0Pe8auzYYbyLv8JaAUG3HhxSnBJZ
	 KB+oDvlOECeuyJMwnI99ZC3e8Dom0dWjRnEH1vkSiJIv495Ctw8z4pgcGVfSAfR7u7
	 rIKWhdsszaZVA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 08/11] mm/damon/sysfs: kobject_del() probe dirs
Date: Wed, 17 Jun 2026 07:48:02 -0700
Message-ID: <20260617144807.91441-9-sj@kernel.org>
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
