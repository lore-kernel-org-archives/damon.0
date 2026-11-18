Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794968560;
	b=ecHhAV27ijEaD3jnEDO+7cP0y2zjw7IPXXB5JC4uw561Tmk5+Dl3HtiB9nlgsBrddonI
	 SV1J1x/4FhfHBB7rMUC9jLL7UdUyDu+rZvQeBidxl8nzVSNXolvJZYS89WtxV10m6r9QL
	 4BeMjwX43XWgpGloyV1G71gmqmM3qUIiBr6/LzKGFRzo23gDa4m4BPmwwT3b5Z2Inkb9x
	 VmxynSOQwtM0ppLz5dyuHJuV9Bzzi2dZs3gX84+HGGdXWSZxxNn9F5aXOV5IhxpDYIY4V
	 uEXlRspoHXYPkANixUt0LCQ9FZM4Bv0bRUOJI6QzdW7wJQnFMMvvOOktUXdIIVbORJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794968560;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=YDurKzhLIi0mIdGpL4ZrXZs3NcRPuPDRtfbfQ8ZOhNQ=;
	b=JRDX/s4GYFwPt24P7WYvKVd/GupUJCfAu7new9N4OGvNcifhmMTVr6SfTJdXasg/feKx
	 dEhfhKjcpj1mgUlrQl1ZwHml9tVn6F8GofJRI8jPse9dZ5a2cYo1c8kJf88c5zyDSuizT
	 bmtuMwXVjf89d4lz1AVpCDngKW8FVVlrr0Pf+GP+7heBBgP/LwYMJvirTOlAf5WLuW08/
	 XjLGK/yVzGuxGyWyqHFQf5nvRdC6CWmtOMhXYueLwjR5TIK2CVVQy2ig2KD0aM4GGh8tr
	 ZsJfZF7EoiIikol54hhmR507MuMd35+hkhyZk0BsipfCK5eAsht4M6NXpoh6M8DEKCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dCuDRSCy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1915E606B540;
	Wed, 18 Nov 2026 02:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dCuDRSCy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4CD01F000D4;
	Wed, 18 Nov 2026 02:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794968560;
	bh=YDurKzhLIi0mIdGpL4ZrXZs3NcRPuPDRtfbfQ8ZOhNQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dCuDRSCy7N8EB8YvlAg1D3EprdCOIKwiS2uReNiI2gn/CaK7oPVrWtV+wUQ52dJjk
	 DaMuxrBZ1DAIl5ZUN8wybKfjVc75esWv+9RFZfaEqxZsfpdeOsAi2r0f8Ub7rqBn5z
	 KpL5bOOwQhOe9Ki6o34TSZXHkH5vspjDqZnVoGTX7GgU2uEPxvS972MRb8/fAj2m3k
	 IO4XgBh+CsMMGPOsinWw+BBDahPryIqXffVa38ERqRsDoNZvfDxTuiNtXy3ULkpi44
	 lVlu7d5/J1NHG4xrLLSt3NEDQdV46jy9XB4ydPnJNKQt97PBh+1WPOtjwPDKWX9W4Q
	 kD7ir3kYdrxbA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 22/27] mm/damon/sysfs: implement report producer addr_{start,end} files
Date: Tue, 17 Nov 2026 18:22:17 -0800
Message-ID: <20261118022225.100659-23-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261118022225.100659-1-sj@kernel.org>
References: <20261118022225.100659-1-sj@kernel.org>
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
