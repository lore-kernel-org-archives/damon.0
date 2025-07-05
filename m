Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95EF215175;
	Sat,  5 Jul 2025 17:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751737804; cv=none; b=Ola3pbEgaFva6P8SKs/MfqBJP0LYKeu1lfgf9PlyJtZB9UAMUAua3qg4eBXgSatp3Qz1xdhqWfsnkWBVgjrXEYIpIJIO+EalB2rMuejKkjLNqjmU975W9hkgneRoOxsoFVkBF+X2D18NnuCH7a6+IroZEceYZjdr2Arp/Y4vtNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751737804; c=relaxed/simple;
	bh=oSMtWErfIBi3GCTzH1g2nB4nfGeEaP/5IAI//7YlQF4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xtgb8wXHLjt7TT9zr2xagTUp5+xib6VmONyxswJBYoVnS5QEkKjAeN5lobBOGMS5RkOwqmXYprGBBYnXy/vBpi18J9fUXrvwVWp0+9oQCpiA5eJTKHyJiSGFPnUZKjPh4m/idtgw4iQIkOtYIgEijSvjIQbWSN55nbQX0dYYisY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ozWJMjEh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ozWJMjEh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F955C4CEE7;
	Sat,  5 Jul 2025 17:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751737804;
	bh=oSMtWErfIBi3GCTzH1g2nB4nfGeEaP/5IAI//7YlQF4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ozWJMjEhmXzKMXrMGj9bprytQjdSO5GhuM2/HF+/O/EVLS3lcMvCUKDxdw16/jrcA
	 h35ew3vAOfMme4JwwoNoTi7rssbqqKgJTE7D+eUYZ+HR4ygw6fv9n40IgSQESlFzz7
	 GYLx/zjrTfXa3vjjoAg7Cva7Dkb61LTAkLi5tjebYOowQHLi/0D7SPHvkMcgVgvidZ
	 Rgs9br3Rt1odqOO9qci6gg02XlPguJQi3utX45bY9f+gyRjLkkv39l7Y3JIAUZRH9Q
	 NWk1juSDa4fvZkAw0sszoNQETVyupNZPTTxJXrenzrmVbP1SmJjV2hbevQwicCjWPl
	 +m6raNZNW2TAw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 1/6] samples/damon/wsse: rename to have damon_sample_ prefix
Date: Sat,  5 Jul 2025 10:49:55 -0700
Message-Id: <20250705175000.56259-2-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250705175000.56259-1-sj@kernel.org>
References: <20250705175000.56259-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON sample module, wsse has its name 'wsse'.  It could conflict with
future modules, and not very easy to identify it by name.  Use a prefix,
"damon_sample_" for the name.

Note that this could break users if they depend on the old name.  But it
is just a sample, so no such usage is expected, or known.  Even if such
usage exists, updating it for the new name should be straightforward.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 samples/damon/wsse.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/samples/damon/wsse.c b/samples/damon/wsse.c
index e20238a249e7..1e8969a0a626 100644
--- a/samples/damon/wsse.c
+++ b/samples/damon/wsse.c
@@ -12,6 +12,11 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 
+#ifdef MODULE_PARAM_PREFIX
+#undef MODULE_PARAM_PREFIX
+#endif
+#define MODULE_PARAM_PREFIX "damon_sample_wsse."
+
 static int target_pid __read_mostly;
 module_param(target_pid, int, 0600);
 
-- 
2.39.5
