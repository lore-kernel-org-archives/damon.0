Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D708B38D3F8;
	Tue, 28 Jul 2026 04:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785211979; cv=none; b=Mt6ukmTforFBe9HyJX/PzUTqdeGVcPLF491d02YrPXmBan8Uuz+vUxYdSV2kyLLUNuiyWCkEknc2m8ElygnbNsxjbB8f0iOjh0Q2i8XAACvEQjQFsiLadDOMCoW1u0F4EP1Z1VksQB3g1esjIPW14bMqZk6MbkutQDheUuxN9OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785211979; c=relaxed/simple;
	bh=BVp9c5hdMqZK4f3puq6W6ae4o58hWsq3N5h/p4mXKxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aE0AL/YDO1KoZolZFsGxYud7TsabNNrzHR6EtkoRP8DJSAiSqwFD7+j+RkDtbhOQcYpKHtUhogHi62w/iGU2NqtnFgxjZ7skFvn6Bw2ogMkAvoAsCSgDrd9o10UyTjxpYeKUvnSHK5YJ2AClken7jrCHM4NoxY1GKF4fPlrHnaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UmuTp6v4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UmuTp6v4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AC951F00ADE;
	Tue, 28 Jul 2026 04:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785211975;
	bh=S9iQ2CUL5Rc0Ka6RGKfOqCWa8tUB1pFEcM1janT09BA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UmuTp6v4hITtNNZ/2H7iOuVZknyvn6HDGNFqlPyxe+Sk39i7lAGnLEkOMq2XFHQwc
	 dlOdghpSfQarFAowtN02qH9bLYT51RisZ0rDUEQcl7/cPzzttuR+/ny0DqokEaEHct
	 pO6CskHRh4XOYrItT35/2HC1QnYcgbOmak1JVcN3TFXxLaN8afIgc/ZabAfZXITpxU
	 /Dr5DrylOm80hZ7zW56r5wfcvFFeGSMwfbV9BmVazE7g5ObPul6k8UFSIthKn8DtAM
	 fITqvPUW/5AnlitXk4T7uRbQIJS00xglF0O3TvOd4HzaM6gK4PwBzsttPNSRjr+UnI
	 3uLps0I0Er9bw==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2.2 10/17] mm/damon/sysfs: implement preps/nr_preps file
Date: Mon, 27 Jul 2026 21:12:31 -0700
Message-ID: <20260728041242.187380-11-sj@kernel.org>
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

Implement nr_preps file under the preps directory.  It will be evolved
to be used for generating sub directories that will represent each probe
preparation action.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 66a3e7de869a8..38affef08d0fb 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -756,6 +756,7 @@ static const struct kobj_type damon_sysfs_intervals_ktype = {
 
 struct damon_sysfs_preps {
 	struct kobject kobj;
+	int nr;
 };
 
 static struct damon_sysfs_preps *damon_sysfs_preps_alloc(void)
@@ -763,12 +764,60 @@ static struct damon_sysfs_preps *damon_sysfs_preps_alloc(void)
 	return kzalloc_obj(struct damon_sysfs_preps);
 }
 
+static void damon_sysfs_preps_rm_dirs(struct damon_sysfs_preps *preps)
+{
+	preps->nr = 0;
+}
+
+static int damon_sysfs_preps_add_dirs(struct damon_sysfs_preps *preps,
+		int nr_preps)
+{
+	preps->nr = nr_preps;
+	return 0;
+}
+
+static ssize_t nr_preps_show(struct kobject *kobj, struct kobj_attribute *attr,
+		char *buf)
+{
+	struct damon_sysfs_preps *preps = container_of(kobj,
+			struct damon_sysfs_preps, kobj);
+
+	return sysfs_emit(buf, "%d\n", preps->nr);
+}
+
+static ssize_t nr_preps_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_preps *preps;
+	int nr, err = kstrtoint(buf, 0, &nr);
+
+	if (err)
+		return err;
+	if (nr < 0)
+		return -EINVAL;
+
+	preps = container_of(kobj, struct damon_sysfs_preps, kobj);
+
+	if (!mutex_trylock(&damon_sysfs_lock))
+		return -EBUSY;
+	err = damon_sysfs_preps_add_dirs(preps, nr);
+	mutex_unlock(&damon_sysfs_lock);
+	if (err)
+		return err;
+
+	return count;
+}
+
 static void damon_sysfs_preps_release(struct kobject *kobj)
 {
 	kfree(container_of(kobj, struct damon_sysfs_preps, kobj));
 }
 
+static struct kobj_attribute damon_sysfs_preps_nr_attr =
+		__ATTR_RW_MODE(nr_preps, 0600);
+
 static struct attribute *damon_sysfs_preps_attrs[] = {
+	&damon_sysfs_preps_nr_attr.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(damon_sysfs_preps);
@@ -1150,8 +1199,10 @@ static int damon_sysfs_probe_add_dirs(struct damon_sysfs_probe *probe)
 
 static void damon_sysfs_probe_rm_dirs(struct damon_sysfs_probe *probe)
 {
-	if (probe->preps)
+	if (probe->preps) {
+		damon_sysfs_preps_rm_dirs(probe->preps);
 		kobject_put(&probe->preps->kobj);
+	}
 	if (probe->filters) {
 		damon_sysfs_filters_rm_dirs(probe->filters);
 		kobject_put(&probe->filters->kobj);
-- 
2.47.3
