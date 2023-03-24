Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5BC7471
	for <damon@lists.linux.dev>; Fri, 24 Mar 2023 15:35:38 +0000 (UTC)
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1679672130;
	bh=ckFawQ1qLSFHu7FH9gpxiQREhNiKA5dRZcnPaoegb24=;
	h=From:Date:Subject:To:Cc:From;
	b=bxV7MelJxdH1rg39V3lDEb+JLrqLBP2PKdDLXWxmrJ9dNGp41MhC8Sdqe1y/0PtsI
	 2zkxqzDj/DYAIXDsODYALwK3Ju6mspcHe2xIW4AAs7pIagNfGGmYJUnuMMD3fJRjqh
	 QkOMKShGzw9eP7rD41CXhNfeB9umzb1+rlkwvkds=
Date: Fri, 24 Mar 2023 15:35:27 +0000
Subject: [PATCH] mm/damon/sysfs: make more kobj_type structures constant
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230324-b4-kobj_type-damon2-v1-1-48ddbf1c8fcf@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAD7DHWQC/x2NywrCMBBFf6XM2oGadhH9FRHJ42pHa1KSKi2l/
 +7g8pzL4W5UUQSVzs1GBV+pkpPC8dBQGFx6gCUqk2lN13amZ9/zK/vnbV4ncHTvnAzrZoETbLS
 BtPSugn1xKQzaps84qpwK7rL8ry7Xff8Ba5swy3oAAAA=
To: SeongJae Park <sj@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1679672127; l=1721;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=ckFawQ1qLSFHu7FH9gpxiQREhNiKA5dRZcnPaoegb24=;
 b=Z/mj9pBksJMTxSODV3RjMllkofs/ct51LPHtbxiK/dC93KL/ZL7YClId558U6SprhHAMWSUIs
 xK0D2hUYCFJBAeidOJF/7lUDrF8OYSpPKrQ9XMWC9+EfDqcPIO4oat1
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Since commit ee6d3dd4ed48 ("driver core: make kobj_type constant.")
the driver core allows the usage of const struct kobj_type.

Take advantage of this to constify the structure definition to prevent
modification at runtime.

These structures were not constified in
commit e56397e8c40d ("mm/damon/sysfs: make kobj_type structures constant")
as they didn't exist when that patch was written.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 mm/damon/sysfs-schemes.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 3cdad5a7f936..50cf89dcd898 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -384,7 +384,7 @@ static struct attribute *damon_sysfs_scheme_filter_attrs[] = {
 };
 ATTRIBUTE_GROUPS(damon_sysfs_scheme_filter);
 
-static struct kobj_type damon_sysfs_scheme_filter_ktype = {
+static const struct kobj_type damon_sysfs_scheme_filter_ktype = {
 	.release = damon_sysfs_scheme_filter_release,
 	.sysfs_ops = &kobj_sysfs_ops,
 	.default_groups = damon_sysfs_scheme_filter_groups,
@@ -503,7 +503,7 @@ static struct attribute *damon_sysfs_scheme_filters_attrs[] = {
 };
 ATTRIBUTE_GROUPS(damon_sysfs_scheme_filters);
 
-static struct kobj_type damon_sysfs_scheme_filters_ktype = {
+static const struct kobj_type damon_sysfs_scheme_filters_ktype = {
 	.release = damon_sysfs_scheme_filters_release,
 	.sysfs_ops = &kobj_sysfs_ops,
 	.default_groups = damon_sysfs_scheme_filters_groups,

---
base-commit: 1e760fa3596e8c7f08412712c168288b79670d78
change-id: 20230324-b4-kobj_type-damon2-0238ee9e8d8c

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

