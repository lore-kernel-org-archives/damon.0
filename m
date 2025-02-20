Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1AD265624;
	Thu, 20 Feb 2025 19:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740080121; cv=none; b=FsUG0f/ziv3wefCZ5ly4qs44a5FW3dV0Bj/Lzm2upCCwtZB5+CYjLuhhZlJY9Bgqhv/fh9w3Zxq8RZASGeUP98ADaveVTAqHiwiwedr6intHEMt0vPoYZnYBMI/JmyH+Fko1fIyZAtd9YHBOBEfd1lTSIOt1WeUeDWsfarxI5rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740080121; c=relaxed/simple;
	bh=uLWk0L2++5bEUyQjMvEroTzbJCsf/vG0c6VnsayYa2c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N5BxU2P366NcgmzdbmCWhNeXs7N8XpgVMOmdtgfipIvtjqDrJ42yFuFb6EFZMVIeliC01nLAXpPkYW6kBv2tudG7pRnSvnuS1etkU4cwqTkuBow6MCpDtA+7fMWbIlMlXboc0UCmDeRXew6P/RkGWYnamWW3Sfj++IZhv+SEASY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g5wpSXB0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5wpSXB0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE2EBC4CEE8;
	Thu, 20 Feb 2025 19:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740080121;
	bh=uLWk0L2++5bEUyQjMvEroTzbJCsf/vG0c6VnsayYa2c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g5wpSXB0xWAYFdYxadyFQPbgLpDM0/1qjullH3563QQ4FUKx9aM5vHAllNxd3p4n2
	 9tDIUjdHNS+BveHVKwcuesbXd9DyLqOhu+q49vMivrcW7VBXWoiPnJCBLjAXoha/ER
	 RJxZrqCJxX54Llwb3klHpUdvCCL9XpCzNc0E7u2ZDPvolKfgsUQqzDAIxiVWjJW/VV
	 +EtLzWhMcTGpjvxBIUYM4OzkptA96qiEZ7giFBKmVEggopcPCsQYcUSUNAcKmuvVJm
	 g39QdCW4k+2b6xbV2N0OvXTtbRq+6X395aae6l8TOstDmdlN+bNehkjwQZqXYSdREl
	 8Jxhm+V814BgA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 6/9] mm/damon: add default allow/reject behavior fields to struct damos
Date: Thu, 20 Feb 2025 11:35:06 -0800
Message-Id: <20250220193509.36379-7-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250220193509.36379-1-sj@kernel.org>
References: <20250220193509.36379-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is more intuitive to decide the default filtering stage allow/reject
behavior as opposite to the last filter's behavior.  The decision should
be made separately for core and operations layers' filtering stages,
since last core layer-handled filter is not really a last filter if
there are operations layer handling filters.

Keeping separate decisions for the two categories can make the logic
simpler.  Add fields for string the two decisions.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index add82fdc1117..1d8479f57f85 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -497,6 +497,9 @@ struct damos {
 	unsigned long next_apply_sis;
 	/* informs if ongoing DAMOS walk for this scheme is finished */
 	bool walk_completed;
+	/* whether to reject core/ops filters umatched regions */
+	bool core_filters_default_reject;
+	bool ops_filters_default_reject;
 /* public: */
 	struct damos_quota quota;
 	struct damos_watermarks wmarks;
-- 
2.39.5
