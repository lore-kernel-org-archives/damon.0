Received: from mail.nfschina.com (unknown [42.101.60.213])
	by smtp.subspace.kernel.org (Postfix) with SMTP id B813F2571D0
	for <damon@lists.linux.dev>; Mon, 21 Apr 2025 06:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745216698; cv=none; b=rgMRrn1zuMP4l9Xzn/l3EmUzDew5OWTlv5ckfcUTGCGOodUynGlG3twSfMFCoM3EBoM+gX6/dwte/Kwn9Mmh5bt/tfjZfp/iDh/mpQn0McM0Z1ey2tp+fKpWX1eEeOZfFH2Hzi1AM1V0amm5aKjGd/TyQmgeXUJCnYEsHBtmZbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745216698; c=relaxed/simple;
	bh=Xz2sYyCnNEl5/tPFd4aknG/vUR4x+vy6S0MLkgKEH2A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Nx5lgjxpnCXogyM32H8NHez2ELyilC+ZMMplxSTtuJGNtITNir/OpeN2OibT3M/Jso5LBvCX97SpY8AJiLE8fPcV7HIkojkDR3uJCBeFXBE1PCgrOGCzh7TtFSTOuYcRKMl+VfLqFfosEXvg1gzUKmCnkbonmy6b7dXByamxFbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from longsh.shanghai.nfschina.local (unknown [180.167.10.98])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPSA id 548ED602549D3;
	Mon, 21 Apr 2025 14:24:49 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: Su Hui <suhui@nfschina.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] mm/damon/sysfs-schemes: using kmalloc_array() and size_add()
Date: Mon, 21 Apr 2025 14:24:24 +0800
Message-Id: <20250421062423.740605-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's safer to using kmalloc_array() and size_add() because it can
prevent possible overflow problem.

Signed-off-by: Su Hui <suhui@nfschina.com>
---
 mm/damon/sysfs-schemes.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 23b562df0839..79220aba436f 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -465,7 +465,8 @@ static ssize_t memcg_path_store(struct kobject *kobj,
 {
 	struct damon_sysfs_scheme_filter *filter = container_of(kobj,
 			struct damon_sysfs_scheme_filter, kobj);
-	char *path = kmalloc(sizeof(*path) * (count + 1), GFP_KERNEL);
+	char *path = kmalloc_array(size_add(count, 1), sizeof(*path),
+				   GFP_KERNEL);
 
 	if (!path)
 		return -ENOMEM;
@@ -2035,7 +2036,7 @@ static int damon_sysfs_memcg_path_to_id(char *memcg_path, unsigned short *id)
 	if (!memcg_path)
 		return -EINVAL;
 
-	path = kmalloc(sizeof(*path) * PATH_MAX, GFP_KERNEL);
+	path = kmalloc_array(PATH_MAX, sizeof(*path), GFP_KERNEL);
 	if (!path)
 		return -ENOMEM;
 
-- 
2.30.2

