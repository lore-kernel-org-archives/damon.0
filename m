Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C6F27BF82;
	Tue,  4 Mar 2025 21:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741123164; cv=none; b=gvTvxEAIty6jskTvUrpeMVyt9/OgZ1ea2ERmS8O1K39DUNQ+mbR2HeFz+oCGV69mMhWXChknG36DoDfDajH28tth9O0yH+llujPFxMmt5CoEcCsNHSFbg93up+8g5xom+pOoZrRsfO3hMTpw19ZUwWH1al4TljOCz5nT+EJnVxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741123164; c=relaxed/simple;
	bh=EAOvbQzL6b3K8TBvvaz/3YCTyNwJ67PJ+6i3fHUuYA8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YLso5RSX3vMiWcF9TbZEo3T814UwwcxjNXUUc0piZ5baVsfjPBbISdkdJ2Rfz34JNMS8f16/4ZWgpUJgYnChn61sFQXxHeTjgMNDiXftkpe5bRrjgLg6BCCK/DAlD2xXFHuweU/YJ7gztZg6p+aKXwAfVRdhX2jKbbhdd6vHeZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Svab4fVh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Svab4fVh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0856C4CEE9;
	Tue,  4 Mar 2025 21:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741123163;
	bh=EAOvbQzL6b3K8TBvvaz/3YCTyNwJ67PJ+6i3fHUuYA8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Svab4fVhiOwVzBa67vyOMt5FwC01tvxULzewvGCpuajuPl9b7WMNEIV8xoBj70wOc
	 vib6yUodrAqyupqCTR+6q7WYKRoEe5BiuRW94smu51GxUtm+YOclV1MmD2dPDNiwpE
	 NyvZfq0ROunPGPvGOmozHi34nrq9bGRF6HjZ8AeQNZsr+eCroQnd1UPaJNM5ct8YtR
	 FeMR2UgDRzOcpHfy2VR9yysG8vfMXFB9VTLktCgixYYF1l9bh415K9z7NU1UjF/4sM
	 dHqNVW6I7SvkCa42jaxTMp+4WjexC8zt2/rdkJNFl/2y34j3XPG3eN8Kt74VSx1oiO
	 mM4gtgPkcnoFw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 6/9] mm/damon: add default allow/reject behavior fields to struct damos
Date: Tue,  4 Mar 2025 13:19:10 -0800
Message-Id: <20250304211913.53574-7-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250304211913.53574-1-sj@kernel.org>
References: <20250304211913.53574-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current default allow/reject behavior of filters handling stage has made
before introduction of the allow behavior.  For allow-filters usage, it
is confusing and inefficient.

It is more intuitive to decide the default filtering stage allow/reject
behavior as opposite to the last filter's behavior.  The decision should
be made separately for core and operations layers' filtering stages,
since last core layer-handled filter is not really a last filter if
there are operations layer handling filters.

Keeping separate decisions for the two categories can make the logic
simpler.  Add fields for storing the two decisions.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 7f76e2e99f37..52559475dbe7 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -502,6 +502,9 @@ struct damos {
 	 * layer-handled filters.  If true, operations layer allows it, too.
 	 */
 	bool core_filters_allowed;
+	/* whether to reject core/ops filters umatched regions */
+	bool core_filters_default_reject;
+	bool ops_filters_default_reject;
 /* public: */
 	struct damos_quota quota;
 	struct damos_watermarks wmarks;
-- 
2.39.5
