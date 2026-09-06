Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBB53C108E;
	Sun,  6 Sep 2026 17:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788717019; cv=none; b=aVpDitGQuaVJmmtra/QywF+FRfIW0guI4cweGfhqMPslY3fjL5yw1y92lLcC+UjAadpAVJAYIR+ek5ki/bl7kG5Ftw9p4knqgBfCDEYz4aW7aXtv8xG+Au/PBvrtiAt6nMRuSwhMGQGq49hDdnX2x8dIgwDHMVpulO3uVw7NwKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788717019; c=relaxed/simple;
	bh=lG9lqwCCUx3kjP5fIT5XV2njsrpyfjDfi6mbNyCxEpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RvpivaNQVERDVlPqwUA/tpSzBYv4i+9dzhVxYmwpdGQqw2vhNPY49Wk3RHwuUGlI6QZ+ZVGpp64gQmK5LBgSSZZtluXo6cGArRQDpS1BVS6UMg6+05yId6yGHosCPTuSDeJGosIcVrcqtG5NSzEVO5PL8phyb/yZf+FUtBqY220=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kckwBC9L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kckwBC9L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CB631F00A3D;
	Sun,  6 Sep 2026 17:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788717017;
	bh=YFqbfbUKFKtPu4Tcg/+wjsywNqHMCK5UIyCPc9N/dhM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kckwBC9LDnSc9g5Qt9hX2Jg8RpnrPDawioOb7Ip3VrnszHtGfRL56TA9k5YmWynMS
	 WxHegJsm37AtALSqEafJvf+L1neyrMMv2zeh+CUJITuQV1XWhdGKXhKWbR+MbLsEbH
	 IT+pn7A5JQ4emDsCiEs7llAxFOdZrHi0bDjKAAM4lsqa5GIvkCRTWiGMmwaEn8icM1
	 Gf/Yob5fiQsRfeNv0ihDGTW5ODWLVILlLFTETmCw4RdO9wYdY2xzfuKfdyTemVuW+6
	 RJ1CLLIpqCXxiOF8OYN1FnrOnMdk9k2EUSI50cpaqfC6ffixedklo+MqfvW9wU1zyT
	 IEqu+nb23XWgA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 1/5] mm/damon/api: introduce DAMON_FILTER_TYPE_PGIDLE_SET
Date: Sun,  6 Sep 2026 10:50:03 -0700
Message-ID: <20260906175009.93471-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260906175009.93471-1-sj@kernel.org>
References: <20260906175009.93471-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON_FILTER_TYPE_PGIDLE_UNSET matches only memory that was able to
confirm if it is marked as idle.  If the memory cannot be marked as
idle, it simply doesn't match.  Hence, finding memory that was marked as
idle with only DAMON_FILTER_TYPE_PGIDLE_UNSET is impossible.  Introduce
a new filter for the purpose, DAMON_FILTER_TYPE_PGIDLE_SET.

Signed-off-by: SJ Park <sj@kernel.org>
---
 include/linux/damon.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 871d26adf6ae5..16800b3dc379b 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -774,11 +774,13 @@ struct damon_prep {
  * @DAMON_FILTER_TYPE_ANON:		Anonymous pages.
  * @DAMON_FILTER_TYPE_MEMCG:		Specific memcg's pages.
  * @DAMON_FILTER_TYPE_PGIDLE_UNSET:	Pgidle is unset.
+ * @DAMON_FILTER_TYPE_PGIDLE_SET:	Pgidle is set.
  */
 enum damon_filter_type {
 	DAMON_FILTER_TYPE_ANON,
 	DAMON_FILTER_TYPE_MEMCG,
 	DAMON_FILTER_TYPE_PGIDLE_UNSET,
+	DAMON_FILTER_TYPE_PGIDLE_SET,
 };
 
 /**
-- 
2.47.3
