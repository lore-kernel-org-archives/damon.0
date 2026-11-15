Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794774550;
	b=ylv5Z26SDVOVU1jjdTM4LA6lWInIJmC1P/uMieTU7rVTSZxTERZD/c7kByog3PW44maQ
	 AgwzfBlg4vIeXRbUvKH5mt6I68irZydktqWYu3mV/3PrZxRzvT3g6YLnXNSmCwjiUiwC5
	 K50RotZ1T+YfsHoIqSy/oxnliELezKytRmu5shU95Un9kxUZNSIMvxEL8eRglaa6Ql5rL
	 tp289qTEjshnImsjYtH/245OQJI/n4zvs7HGQOrf2TzUQx1GDOFyct15R0T7n6RiVwNF2
	 e1aRbkNllyWsxE8/u3QXUU1uXgxsRGQ6DjdhDO1LH567RWtv2WWb7vhQCJJK+kU3/Dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794774550;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=YDurKzhLIi0mIdGpL4ZrXZs3NcRPuPDRtfbfQ8ZOhNQ=;
	b=d7hXib2RbVVAKXvT8DC5nFRAqYSrFLp8n662PEvZWCjdKBrR1Qj3FHIksIkWc+VcCBRz
	 /WVjr9Pg5ziTA1W77HZYLTtbh0U0FlMQUZUk483ruiz0ApXeZ2+xORB6hkTPsls8EuEEl
	 WPwCInQQMschLGHdhnUXTE+vBvLAxzmJfYEhG19j5a5clRPoD9z8gSBrbZ9qcrj2PTszN
	 bgFbcfGsFpA+bSosqV3yrmf3X3scNtuBH/uowb0kmstIQ/KghEy0vXfpRnatB03zA7UOL
	 iUJDwwnL7hseUQhfVyT9IrbkLgAVo172aTZuO3EpycpXb5Mw2aoQun3tgBBsi52SXOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pw4tjcVW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E938C606CCB9;
	Sun, 15 Nov 2026 20:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pw4tjcVW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3F291F000C6;
	Sun, 15 Nov 2026 20:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794774549;
	bh=YDurKzhLIi0mIdGpL4ZrXZs3NcRPuPDRtfbfQ8ZOhNQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Pw4tjcVWzqwJg7iRBiFDM7FkP8k5OwGqzmaFn2WB09w2liP193bNY1i9mjNhoVfc5
	 WlIqgcZLJyfNI2e9C5ClAxljazHrJi70+smYiMG2G4Z9N/EjuH57pDZnFTade0iKGZ
	 LwtEYvOcqznmJMckK5Da3hEvl6NfhGRRLWHUsYAR3Fv8pMOnrzUWsTe+6y8JwnTble
	 iiCkj5z+hoG2cq2dVjWr70wrKrc6Vjh0bPCYsUtXBLx3HxgkkaLNaTV5a+4Jzt/f7G
	 IayqTi3+pkEoQWTLUVPSfX74xuyOYzDk9BxphvRIs/kGL4D83MyNKotLk0+SfgUmCU
	 UdsLOkXUUhYhw==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 22/27] mm/damon/sysfs: implement report producer addr_{start,end} files
Date: Sun, 15 Nov 2026 12:28:40 -0800
Message-ID: <20261115202849.99134-23-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261115202849.99134-1-sj@kernel.org>
References: <20261115202849.99134-1-sj@kernel.org>
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
