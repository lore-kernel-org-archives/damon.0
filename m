Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D480F267B0F;
	Wed,  5 Mar 2025 22:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741213667; cv=none; b=DKIbYWO7AJoA85J5bVZWbkEtyKlMHPIYQ3u0s14iCqCl7Rdu1fNOAMvLv9pDJc7LRNuoEj4vORX+4ggmWu5q+637xI3Ne5OwM4aKEYl4Mb6FaDLzzoh4BQ6Dji/FqPwHuTFt8fBBtmOjuRfE0QcJWGQ5Z8KKmRjQ7uabZpoOsQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741213667; c=relaxed/simple;
	bh=LQ57T8uZEfXJqRz+pJDK96lN4rwQ3E6I/AuuNUmLtpE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HyhpJqelyoAtTzw+EGkZN9hQ3QYm53ymEQjHJVCA9wRdyvjeNM3+Gfp2CgNWAsJKhNqsFwDAmLjY3n/ry/OshFlJqvTtMKxP/3Qv+qGkpnJqci8nJa+7wy8jfaj1of3PdBAQ/HXcZlG8v92oDj/1W38xz0xnHa9GtdKE08SYpNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G1sZRBPm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G1sZRBPm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E4D8C4CEE8;
	Wed,  5 Mar 2025 22:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741213667;
	bh=LQ57T8uZEfXJqRz+pJDK96lN4rwQ3E6I/AuuNUmLtpE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G1sZRBPmlSradLgfTY8Wkkc3WmAPdnOChvdMQ/QNf7Qj1Fi8Igg1jebiMMri7A425
	 +4DHZ327YpDb+aBY8hx3FRdyRVP8cgAXH5ecp3qpHk1nn76aMUr8BI2v/HQnng0YOL
	 aEMZsi1xHCpa7ArUaAz7zUtwJ5cLTx6+xQRq9/Y9IBzhZ9OYQrtwM9jzagWCSJBYZo
	 RKoPRPZRFRnH2WHDIXexP2uMoAySqiGvN6XKkV5XF4EIzjbHNLQfU/wUswZ1ftmIRM
	 PLic60AraWQWa9PnEUUf3vUDk1bC5N+HFYypf8ymHa15hcxDvBq4V8Dk7wUJsUlmJN
	 QGUpA9eKKMlzA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 6/8] mm/damon/sysfs-schemes: return error when for attempts to install filters on wrong sysfs directory
Date: Wed,  5 Mar 2025 14:27:31 -0800
Message-Id: <20250305222733.59089-7-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250305222733.59089-1-sj@kernel.org>
References: <20250305222733.59089-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Return error if the user tries to install a DAMOS filter on DAMOS
filters sysfs directory that assumed to be used for filters that handled
by a DAMON layer that not same to that for the installing filter.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index b9f035f4b00f..ed834622df2a 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -362,6 +362,23 @@ static ssize_t type_show(struct kobject *kobj,
 			damon_sysfs_scheme_filter_type_strs[filter->type]);
 }
 
+static bool damos_sysfs_scheme_filter_valid_type(
+		enum damos_sysfs_filter_handle_layer layer,
+		enum damos_filter_type type)
+{
+	switch (layer) {
+	case DAMOS_SYSFS_FILTER_HANDLE_LAYER_BOTH:
+		return true;
+	case DAMOS_SYSFS_FILTER_HANDLE_LAYER_CORE:
+		return !damos_filter_for_ops(type);
+	case DAMOS_SYSFS_FILTER_HANDLE_LAYER_OPS:
+		return damos_filter_for_ops(type);
+	default:
+		break;
+	}
+	return false;
+}
+
 static ssize_t type_store(struct kobject *kobj,
 		struct kobj_attribute *attr, const char *buf, size_t count)
 {
@@ -373,6 +390,9 @@ static ssize_t type_store(struct kobject *kobj,
 	for (type = 0; type < NR_DAMOS_FILTER_TYPES; type++) {
 		if (sysfs_streq(buf, damon_sysfs_scheme_filter_type_strs[
 					type])) {
+			if (!damos_sysfs_scheme_filter_valid_type(
+						filter->handle_layer, type))
+				break;
 			filter->type = type;
 			ret = count;
 			break;
-- 
2.39.5
