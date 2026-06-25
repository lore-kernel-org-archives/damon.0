Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4622305691;
	Thu, 25 Jun 2026 05:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782364109; cv=none; b=i+RKhArK68Vig+0VFNlFRpXqNCmKueiIxA5hIH07ssf8kBF8dqFAZJ3AcYCveXl6WjZ1isw/9tmw7IGOVmc931U39aYlpagLUHQvJ7R5Qgu3ab8kOBywbtEqpyEKx5XvkWTRjuwlfgVO2eR0QBKY0lmn6nXTqrp2cn6+S0PglRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782364109; c=relaxed/simple;
	bh=nOMs+/z/SrAEJ4IqmwwKaSHP52fTwHkyEWdYdhRQTMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hcWFlTv818aMf2Ijk548PKi7Jfdjf3Wtex5xHMLlWgUhYfQPcjl+V4QUvGyM8T/4ot8RkqiG60OFYMWAQv65KHBtcDvGXkwRktO6PPRoqo/KzQvg4/hvLFa0//rKAHwaL1P/MNSSrdEuwzxGGcxDyFxsXngdL/nVd4UedsBPSGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dhevelcq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dhevelcq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FAA01F00A3D;
	Thu, 25 Jun 2026 05:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782364107;
	bh=sQV3GfOG7VWGJtv7W6ZwKyzWFgMIO6rC7OdU4Z34lgE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dhevelcq64era/6pxT7EePZrcWe7Fj58AEygJmXqmsyOHj7e9N2U9XdcW23kB+J6y
	 6zelKo67pdkntEByDGfpEJJyMrRymy86tDrk0DdQ7OMxEQhhFypV4w9qxP29pwizC5
	 X0MNQ4FTsEB3qrociZXTL83V6tpnE3/44rIJV7tSQukq/q9iUp8oc4pdL02vEV+uRg
	 TOprJwnU3kTSB1rbs6z77SU37b9C2Id5o0XhVjFzOJnpfSPwR6zFVZMZCSByAg+5HV
	 oO7C88H7yXO9nxv5T2s6+W4VO1P6PtYaJdiXXZbbL6+0zGIp4pWcgz8Ne1tgHrfXyU
	 23j2/dcOqJiag==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 11/11] mm/damon/sysfs: fix typos in probe_{add,rm}_dirs: s/attr/probe/
Date: Wed, 24 Jun 2026 22:07:54 -0700
Message-ID: <20260625050756.91115-12-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260625050756.91115-1-sj@kernel.org>
References: <20260625050756.91115-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_sysfs_probe_{add,rm}_dirs names a variable for damon_sysf_probe
as 'attr'.  Probably a trivial copy-pasta error, but it makes the code
not pleasant to read.  Fix those.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index f3bb146b204df..36d71f1675426 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1068,7 +1068,7 @@ static struct damon_sysfs_probe *damon_sysfs_probe_alloc(void)
 	return kzalloc_obj(struct damon_sysfs_probe);
 }
 
-static int damon_sysfs_probe_add_dirs(struct damon_sysfs_probe *attr)
+static int damon_sysfs_probe_add_dirs(struct damon_sysfs_probe *probe)
 {
 	struct damon_sysfs_filters *filters;
 	int err;
@@ -1076,22 +1076,22 @@ static int damon_sysfs_probe_add_dirs(struct damon_sysfs_probe *attr)
 	filters = damon_sysfs_filters_alloc();
 	if (!filters)
 		return -ENOMEM;
-	attr->filters = filters;
+	probe->filters = filters;
 
 	err = kobject_init_and_add(&filters->kobj, &damon_sysfs_filters_ktype,
-			&attr->kobj, "filters");
+			&probe->kobj, "filters");
 	if (err) {
 		kobject_put(&filters->kobj);
-		attr->filters = NULL;
+		probe->filters = NULL;
 	}
 	return err;
 }
 
-static void damon_sysfs_probe_rm_dirs(struct damon_sysfs_probe *attr)
+static void damon_sysfs_probe_rm_dirs(struct damon_sysfs_probe *probe)
 {
-	if (attr->filters) {
-		damon_sysfs_filters_rm_dirs(attr->filters);
-		kobject_put(&attr->filters->kobj);
+	if (probe->filters) {
+		damon_sysfs_filters_rm_dirs(probe->filters);
+		kobject_put(&probe->filters->kobj);
 	}
 }
 
-- 
2.47.3
