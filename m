Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534609;
	b=y/HWboOxrbENJW1PQJx2msY/pi8u/lL3BSTfqkaeWoZEpRaIL/bgx8ptomOBgra2gnz9
	 2guv6MzY3yts9GzD42LKLkCfPwVcaujgkQnVf3XVYaumW1HTDCE5kLsnQZ8c8JkQeBqu8
	 JQDIk/1Od8YvPhCcXI8exNF+vmD1QOkVglZ7olgnu/c//1Su3T6mofRjTJrImAPRpsNvE
	 QnXbi7BWgFg291dt1xi9CAmkNLnRqDXDz79SqgeLth+F4LADl0B7F9zg05dpbZG0gapmM
	 +dV0bR497hURcHusKnBhKi0DoUZpN2cYAni6213yZcnPxZLmN3hnHGRZsPZtgkmxPTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534609;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=8oM0h67SAKmFyTFD9nC0NrJmlaLbWaTm6qMeGXdW4+E=;
	b=IFPuqJDPqpDlu6n9p/DPRLHsLcsVhfvoI1o7iL0xSCQaMF38LqV6hs5FvHfhaVm6NBal
	 6haMxT1ITIXfLZaX3K0pJyXLZ0TkO/XkC3GG8yf+RCCUeLXMgNNhBPIuIPgMjWOXv2RZa
	 cU0u7CTi2BaycXky6HxxyyBoaLfMmXlf6ZnWHj6c7BC13MTPEXoUuCfr2KeAry+WVbSqJ
	 Ih0U8McGkuxPMlalY6kX5bH6CWO2Su+VVFbejv9HejHLp+maOCQCiQGI8lKxeAM1P7gks
	 ns2ihdOORnm+1exv6WBIVsCUvwOdDbsCtr0ZJd0xeHW9n/FyVUAJqn5utddUJtQqrWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j1j0LVS7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C04606A332
	for <damon@lists.linux.dev>; Tue, 24 Nov 2026 15:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j1j0LVS7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40A9E1F000CF;
	Tue, 24 Nov 2026 15:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795534608;
	bh=8oM0h67SAKmFyTFD9nC0NrJmlaLbWaTm6qMeGXdW4+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j1j0LVS7s4HyKVUICEvLqjmnPEZgCbfK0q2A5F70gjZ42p6kppPkJogURG55isoOh
	 R9ZDDnRqHDSMJbzy9H/O2ocxGLrG2vtbFcszYbXGjpGLYJcscg40dDScm2VZHXRz2J
	 kdCOdEXtytNWu6cdH9zgpbXLTwcObGBXmHY5k/ce+7eUOrXv1aBvjgsXNVoUeY0VvK
	 NM9zWcn3z4Jr6ME12JfIzLg3AOcN6WcaqbUfVudRnSTk6b+q7ihOZp6+Nq9cArRmQB
	 +hlPp/lmH15NFMBqa3TQ8LyTHnx8Lj9zqeXf+86vRMB7NQfl2MpJsZZs9U+NQd6veT
	 zplhL9HcS73tw==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	Aveline Noir <jm5905938@gmail.com>,
	Lian Wang <lianux.mm@gmail.com>
Subject: [PATCH v2 06/27] mm/damon/sysfs: add producers/nr_producers file
Date: Tue, 24 Nov 2026 07:36:12 -0800
Message-ID: <20261124153636.91854-7-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261124153636.91854-1-sj@kernel.org>
References: <20261124153636.91854-1-sj@kernel.org>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement a new sysfs file, nr_producers, under the producers/
directory.  The file will be used for generating directories for each
report producer, in a manner that is similar to the nr_kdamonds file.

Reviewed-by: Aveline Noir <jm5905938@gmail.com>
Reviewed-by: Lian Wang <lianux.mm@gmail.com>
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 75701ed662222..d3a7cb170975a 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -2983,6 +2983,7 @@ static const struct kobj_type damon_sysfs_kdamonds_ktype = {
 
 struct damon_sysfs_producers {
 	struct kobject kobj;
+	int nr;
 };
 
 static struct damon_sysfs_producers *damon_sysfs_producers_alloc(void)
@@ -2990,12 +2991,62 @@ static struct damon_sysfs_producers *damon_sysfs_producers_alloc(void)
 	return kzalloc_obj(struct damon_sysfs_producers);
 }
 
+static void damon_sysfs_producers_rm_dirs(
+		struct damon_sysfs_producers *producers)
+{
+	producers->nr = 0;
+}
+
+static int damon_sysfs_producers_add_dirs(
+		struct damon_sysfs_producers *producers, int nr_producers)
+{
+	damon_sysfs_producers_rm_dirs(producers);
+	producers->nr = nr_producers;
+	return 0;
+}
+
+static ssize_t nr_producers_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_producers *producers = container_of(kobj,
+			struct damon_sysfs_producers, kobj);
+
+	return sysfs_emit(buf, "%d\n", producers->nr);
+}
+
+static ssize_t nr_producers_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_producers *producers;
+	int nr, err = kstrtoint(buf, 0, &nr);
+
+	if (err)
+		return err;
+	if (nr < 0)
+		return -EINVAL;
+
+	producers = container_of(kobj, struct damon_sysfs_producers, kobj);
+
+	if (!mutex_trylock(&damon_sysfs_lock))
+		return -EBUSY;
+	err = damon_sysfs_producers_add_dirs(producers, nr);
+	mutex_unlock(&damon_sysfs_lock);
+	if (err)
+		return err;
+
+	return count;
+}
+
 static void damon_sysfs_producers_release(struct kobject *kobj)
 {
 	kfree(container_of(kobj, struct damon_sysfs_producers, kobj));
 }
 
+static struct kobj_attribute damon_sysfs_producers_nr_attr =
+__ATTR_RW_MODE(nr_producers, 0600);
+
 static struct attribute *damon_sysfs_producers_attrs[] = {
+	&damon_sysfs_producers_nr_attr.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(damon_sysfs_producers);
-- 
2.47.3
