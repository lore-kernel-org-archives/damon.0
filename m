Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534621;
	b=cLe8YTdQhbL6+E04mk4CHo91KOVnwiafAaXOxtM5jpFl7y3ypLt4wtgqggPw7dXN7Y1n
	 47gP0aEwm9K/Yi7bNPaSNs8KrbCLs4YRTpPL8hZVAgA1Cj9tObPQyUlFNsoR+z38MHYEs
	 fjX6ZicMsCIUJJOLZ11UthnAySAMeVQxFgFfCUr3MnMedibaDtUdldw/OUGIuGd4qreIu
	 EE4Xv4/U5DPWefsDkK6pEeWsKIpb5/d/a4ga3tBdOprFsiR3KxpiH7Q8XBs0oa0o71FkX
	 jV0pjeYD6vV6exdDizy+/p6FPB5/h30xIVjLdDL+SVGcRI58Z9Ymi/0NX69M4KuLRPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534621;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=DC/+LIj6wa2bI+Fi5zCavOExK7wgUf6SARf9BVg3XsE=;
	b=mxRwUZqE68BlusVhmUuz9n4aMnbqR2fhRE03an0tZvaN60qRA/AUQBnzOlCdX8nN364K
	 zLQ/KiyeV9FQebTRY8T6r3/VP1n31vpjRtqGh7HwLbJxK66QBTkKDygVf7ftDXKDXxl4a
	 fYLVNhRNu3J+Cah23ArWvmTAqGKo642CFGDQyGbll+53bAdqBJUzg94Wc/vNivWSn5d96
	 u0ca39wyW/VKAN1WV6pvB+MgpySVTGvvJnYeIefUiJxVyMgICnQm+EGeqp7lByYJgPDOC
	 FU1s1X6VYjZ7lC+NE47re11WBkN7Q3iy0mkLFtwD5q32RNfSzcPKKhDllhvz1c5eWsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lE9fEpNi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15CE606A326
	for <damon@lists.linux.dev>; Tue, 24 Nov 2026 15:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lE9fEpNi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E4FF1F000C4;
	Tue, 24 Nov 2026 15:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795534621;
	bh=DC/+LIj6wa2bI+Fi5zCavOExK7wgUf6SARf9BVg3XsE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lE9fEpNi9vpjAcKJXktPM6hnlEFGX7K5sxuuqil76G9oqB62DKtmKu6plSoo6/k8p
	 tT5ZU9qj/oWfB5OA8xdWisNRLMzjaX0op1anyh77LJHhuRCtQ6QHZr//n0nOYK6WIk
	 7nBAGSqvoWQVnaVaF1Q12eHkQ7fD2kd36yWvbr7Cg5nHkZl0yYVlG2GU5fsjERlBty
	 gvTNR4G/yufzygXFCSIhu5NWhkBbak7WD0ZRYsiS/aCoBSBNb9hhqFmoi1CEIs9H1+
	 L9w1fQasCmDUodTd6cmZjJS9pm+wHZrboHjFKvmOwbiNQ5p/7yBo8QBKfaUUcshs/T
	 9Wq+3R5znw+zQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	Aveline Noir <jm5905938@gmail.com>
Subject: [PATCH v2 22/27] mm/damon/sysfs: implement report producer addr_{start,end} files
Date: Tue, 24 Nov 2026 07:36:28 -0800
Message-ID: <20261124153636.91854-23-sj@kernel.org>
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

Implement addr_start and addr_end sysfs files under report producer
directory.  Those set and get the address range of the user_report type
data attribute reports.

Reviewed-by: Aveline Noir <jm5905938@gmail.com>
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index b4d898ec0c9f7..5f9bb1955dfd5 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -3047,6 +3047,7 @@ struct damon_sysfs_producer {
 	struct kobject kobj;
 	enum damon_report_type report_type;
 	bool enabled;
+	struct damon_addr_range addr_range;
 };
 
 static struct damon_sysfs_producer *damon_sysfs_producer_alloc(void)
@@ -3116,6 +3117,44 @@ static ssize_t producer_state_store(struct kobject *kobj,
 	return count;
 }
 
+static ssize_t addr_start_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_producer *producer = container_of(kobj,
+			struct damon_sysfs_producer, kobj);
+
+	return sysfs_emit(buf, "%lu\n", producer->addr_range.start);
+}
+
+static ssize_t addr_start_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_producer *producer = container_of(kobj,
+			struct damon_sysfs_producer, kobj);
+	int err = kstrtoul(buf, 0, &producer->addr_range.start);
+
+	return err ? err : count;
+}
+
+static ssize_t addr_end_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_producer *producer = container_of(kobj,
+			struct damon_sysfs_producer, kobj);
+
+	return sysfs_emit(buf, "%lu\n", producer->addr_range.end);
+}
+
+static ssize_t addr_end_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_producer *producer = container_of(kobj,
+			struct damon_sysfs_producer, kobj);
+	int err = kstrtoul(buf, 0, &producer->addr_range.end);
+
+	return err ? err : count;
+}
+
 static void damon_sysfs_producer_release(struct kobject *kobj)
 {
 	struct damon_sysfs_producer *producer = container_of(kobj,
@@ -3127,10 +3166,16 @@ static struct kobj_attribute damon_sysfs_producer_report_type_attr =
 		__ATTR_RW_MODE(report_type, 0600);
 static struct kobj_attribute damon_sysfs_producer_producer_state_type_attr =
 		__ATTR_RW_MODE(producer_state, 0600);
+static struct kobj_attribute damon_sysfs_producer_addr_start_type_attr =
+		__ATTR_RW_MODE(addr_start, 0600);
+static struct kobj_attribute damon_sysfs_producer_addr_end_type_attr =
+		__ATTR_RW_MODE(addr_end, 0600);
 
 static struct attribute *damon_sysfs_producer_attrs[] = {
 	&damon_sysfs_producer_report_type_attr.attr,
 	&damon_sysfs_producer_producer_state_type_attr.attr,
+	&damon_sysfs_producer_addr_start_type_attr.attr,
+	&damon_sysfs_producer_addr_end_type_attr.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(damon_sysfs_producer);
-- 
2.47.3
