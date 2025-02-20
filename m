Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5536265612;
	Thu, 20 Feb 2025 19:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740080817; cv=none; b=RuF9n1ZPgiRB7uZ9g8X3u/3W9Ihr52AQFtMAMMxzkDW7NBzpC14tEv04GnuR3ysmNOAVbG+D948e6MlElP270bn2Euw4lxTba0s5rI31tB29SPVzeTPkGIYgcSQ4bNT5rusybhQY7Uf33KDImUyQRx1mUp+QWb2mthtAts+V5uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740080817; c=relaxed/simple;
	bh=LQ57T8uZEfXJqRz+pJDK96lN4rwQ3E6I/AuuNUmLtpE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fWlcocc7DhfTNojHRDYeclRCz56l6xWHsdIxUVzNEr2NCSvRk6hWhunTZiEzgGKZ9YNvoQn3fwWtlNt9QnHUmht8rmsi/F5uLCZmcDBi1Bmr0STUrdYOIPVnIRzBJQnPlSwardC3XtRwKiYSKGidG+K5RNcdW0iaSU5BGkGahzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qZNHY0Zy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qZNHY0Zy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E287C4CEEA;
	Thu, 20 Feb 2025 19:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740080817;
	bh=LQ57T8uZEfXJqRz+pJDK96lN4rwQ3E6I/AuuNUmLtpE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qZNHY0ZyUBDQqoyqcF8xXzG5aTN9mOB7+NBUj3oAhIQR7q2ignh449gJSWhBuJnPx
	 kv8MO8bEU0Job844Cpw2DTVwapbIRaiR55bpnwYVJXdI0ugER5GxM7IggwGOTlPcS5
	 niTtkoPczx2sAjwr2Hw2ccuwqCwJ1E8knqHxkAkP0It1SIep4kDjSKWnYyeNDPWeGg
	 LnNsDhURD9BVBoK8UgVfhTVaZDO4XgkRavvGI+/d5nP/GuC/LtRV8Zi6wIQY6e1+qs
	 Csm/bVpSbSqSRRGaEhG6WeQ9g6kbDCLEvWit4MVV4vG3jpkxAL+os0CjAYNGOl/m0P
	 MPlh/ikCgqNDw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 6/8] mm/damon/sysfs-schemes: return error for wrong filter type on given directory
Date: Thu, 20 Feb 2025 11:46:44 -0800
Message-Id: <20250220194646.37726-7-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250220194646.37726-1-sj@kernel.org>
References: <20250220194646.37726-1-sj@kernel.org>
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
