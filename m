Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1CA3BBFD6;
	Sun, 28 Jun 2026 22:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782684090; cv=none; b=u363wJRCum1r/LgCCmI76gl3+JRBESvXMwMKfMwlqvoXgCdAnhafcfXNLvwBjSOIGUiRsRgk2e/3VXVpdeeUoKFFMMsGjpgW5uuDp+F5WELFNN0RKXOOLeH9orjCuEWfSJU5D8UW+65w8ssfX7KL6miTWkpWZKbAPrIIwkcGNq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782684090; c=relaxed/simple;
	bh=7/HXKjYKzhVB7T3GbTbFqcXqfdj9ZYACdRB3JoXr9GY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tI9E4Xm/0HKTxrVRtzfXfQ2TYqHRM1LnUyyXuY+K2co8FhFYI5KsxPHN34lMpeCvV1Y6dD24MhtDOr4MuJLZdKRX4LoNOGGH+2ZRLdBcGlExEhED7Mm/ODr7EQEwkMxAlmg7mvso3YiujtPPdvOI73Yn/s9iz1ISpDLJ7oLxgSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xtd7ye5t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xtd7ye5t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C38951F00A3D;
	Sun, 28 Jun 2026 22:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782684089;
	bh=BzlkmUHMQwNBfI6ZKWoROTeHoWiHWufYiXMy5/ROBog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Xtd7ye5t+0FJuF8nAHV0jfglnIAAZe51NQssklYhDhr4+34TWV2UFAJZiK6snzcAH
	 cS9ahdNG10h+9ei/uWYwhu5zBR8o7QKK/IQ8OtN+se4sCTv7xWZzoFl5/DzON9uUJ5
	 rWShMykibSbHJjS4gmcyoXsYbz1lzYEWKakZxgiL2Sj3xcbWU8isJymzL9PLntGaCZ
	 /UqAPS0RsY1zy0JmOv7h+1bjp0fyv2dpTue8h8xPuhzm+GeClMcHhmeaJWM+tdUNUq
	 0iwT/xCT5SOR8XLCWm/l5gMRLihS/23UYLKaB5FGScl5Ar4dfXd6MwGu1/3hoJdWpD
	 1Y8aYdsyBF6pw==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 08/11] mm/damon/sysfs: kobject_del() probe dirs
Date: Sun, 28 Jun 2026 15:01:17 -0700
Message-ID: <20260628220121.97360-9-sj@kernel.org>
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
could cause directories creation failures due to the name conflicts. Fix
those issues for data attribute probe directories by adding
kobject_del() calls.

Fixes: bf3ea3d30880 ("mm/damon/sysfs: implement probe dir")
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 204aed6a3e5da..9f92ebdb28574 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1137,6 +1137,7 @@ static void damon_sysfs_probes_rm_dirs(
 
 	for (i = 0; i < probes->nr; i++) {
 		damon_sysfs_probe_rm_dirs(probes_arr[i]);
+		kobject_del(&probes_arr[i]->kobj);
 		kobject_put(&probes_arr[i]->kobj);
 	}
 	probes->nr = 0;
-- 
2.47.3
