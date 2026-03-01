Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903A833ADB2;
	Sun,  1 Mar 2026 17:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772387013; cv=none; b=NbnUzlbGSrjM3FmKiL40U4sRUUSR6MCGcu6JMGU186aR6WbzEAU6HUl22GMkttU2riY6FOk89vNnuvO6BxEoPHQQafs2yeQIlBbJZbxV8ph0F+IHPFI/zp56Vxp40eH95eKCcOd4jzxxZczQ/yq6y1WcD3V8IThAzubpT6b2bDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772387013; c=relaxed/simple;
	bh=BLMf6S2CwC1uRw1Za6T26Ewe+0K+xw3rETEPypk9tzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y3c0vk0PHvzb/j0KBEF/LBugy9R+G+kkvFajZnsCI0TMtx0/fesniiSz3nqzwdcAu/tu095iNUvSNmLO18kMl7JWrMg7scOwPV7Rg1d+4j6Bu1UVTyJT1pEwpI90BCM3/hH91ieNUkq/6AYThbIOORW33YcdW+TYEF0laR8naOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iflq3Brx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iflq3Brx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38375C116C6;
	Sun,  1 Mar 2026 17:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772387013;
	bh=BLMf6S2CwC1uRw1Za6T26Ewe+0K+xw3rETEPypk9tzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Iflq3Brxo9v9e0Mfqjesq+hY3p90YdnXS535vlVbTEuioLgceNNQroRt+5JdpDq6L
	 Mmghe8B56xb1WbGO/NbtDHcSjbRwWS+mzeibZ2o7xiuAHmgjqj5qCJLx45kZdDcmY5
	 ixbsWkUoWAjromzZ4wqUmoTquiPG8GExSrHuPhv0bFo0J2sp0fUuqfNzGuJHnRA6xl
	 qJcdKkelnJlqOVMgVcto0VlfV4ojGDKwoAFrBiESTZo88u+7ENpj/qis9uMyTIxMJH
	 fOh5L38XoIlbFD9+PxBX8EvEynktGKPY/5+pyAbyeAGzrEyANA2lid5KpVESKkbOoK
	 ZrrMGRSn36O2A==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 09/10] mm/damon/tests/.kunitconifg: enable DAMON_DEBUG_SANITY
Date: Sun,  1 Mar 2026 09:43:24 -0800
Message-ID: <20260301174327.76849-10-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260301174327.76849-1-sj@kernel.org>
References: <20260301174327.76849-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CONFIG_DAMON_DEBUG_SANITY is recommended for DAMON development and test
setups.  Enable it on the default configurations for DAMON kunit test
run.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/tests/.kunitconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/damon/tests/.kunitconfig b/mm/damon/tests/.kunitconfig
index 36a450f57b581..144d27e6ecc5c 100644
--- a/mm/damon/tests/.kunitconfig
+++ b/mm/damon/tests/.kunitconfig
@@ -13,3 +13,6 @@ CONFIG_DAMON_VADDR_KUNIT_TEST=y
 CONFIG_SYSFS=y
 CONFIG_DAMON_SYSFS=y
 CONFIG_DAMON_SYSFS_KUNIT_TEST=y
+
+# enable DAMON_DEBUG_SANITY to catch any bug
+CONFIG_DAMON_DEBUG_SANITY=y
-- 
2.47.3
