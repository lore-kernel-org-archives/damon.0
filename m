Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD37325716;
	Sat, 21 Feb 2026 19:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771702597; cv=none; b=o/amRd2tbDkniJVK8k26rUfmyRQXxLvSYVsCqsd3EBExE4RIecMiWVjzOjkQ9f3YgOS7DYKmPqgxjtlXxSUHnyPf9g8vDP/SXkmLFTZfNSBo82s3Y6BJITNhRD5bTMeS96SZRv9kvFMAtNPrg5fwQ098HHmWc4zXIG0s/wljIG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771702597; c=relaxed/simple;
	bh=BLMf6S2CwC1uRw1Za6T26Ewe+0K+xw3rETEPypk9tzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NUbR3tBX0qv3K130MByw3439CqjXd0fA5fQT1mbsA7Mlr1YvKT53BeK71KTPPlmSdfjGf2i3fZhQQRECOuGJCtMr/xEg5j+gA0lkFNpM1aqJW4HJzK+uOOLMbTIvylpC5YjOHM1why+DL3jDDw8tNN6XkNMYBNSyx66YKupgRdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C9t+9Jz2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C9t+9Jz2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33CC1C2BC86;
	Sat, 21 Feb 2026 19:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771702597;
	bh=BLMf6S2CwC1uRw1Za6T26Ewe+0K+xw3rETEPypk9tzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C9t+9Jz2hPriFjK93TVr0kL3267n6+R42N2n8VOHwQv5agnOpvqATVqVnAs6mYeJm
	 +jZ4j4ch1N3NYgkCQDXyClUwsO7Pc8NzeLulg0ok3FhJmvecX/JCvcbAl10foHRcuB
	 wLWPSfzEKGFv51WI3SPLtLH1z+U8nZX/2vPST3mDPKjOOAhNB/jBsZhuvJFz3q/4SW
	 q1fGqkjXmcnDd+yGMIWKed55s7RyH8fKJvHntiEQtHC3L3GrwQG4kQjKAoU5pwvi2a
	 c3diqLvXjRbg/Cvnp0m79+SFhrEe43XikHTdiz1L516/jdlbYWtmPA93R3Yn77Jg/Q
	 lCDWB2zdWQ64A==
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
Subject: [RFC PATCH 09/10] mm/damon/tests/.kunitconifg: enable DAMON_DEBUG_SANITY
Date: Sat, 21 Feb 2026 11:36:26 -0800
Message-ID: <20260221193629.19332-10-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260221193629.19332-1-sj@kernel.org>
References: <20260221193629.19332-1-sj@kernel.org>
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
