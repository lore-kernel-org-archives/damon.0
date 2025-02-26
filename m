Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B6B2222CF;
	Wed, 26 Feb 2025 18:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740595329; cv=none; b=DljvcdxBHfAaX81d97ivdEqcFyz+zkPW5amvVEDHzpjMxIFYLu8KnaGc98GewI7AmE4Ch8HtLgE/qNYWudADq7odg/XECq9R0HOiLl3IgYuHlNK8U0jSoTG3gbyxEBvbVSkovUdoIK2bE2SQmU3SA3kgWmc5tqu/Xvt9iXb3NwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740595329; c=relaxed/simple;
	bh=3/4RYj3Peq9LAIKfSrxEMRx2d7CU/6V42ttG2XzmwuU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mWs6y4bODPWjy3Ppmg3EIRn4dDwLMEmrdVFaX5IYYYVP3F6lrTZ7lKOw18kpzriuMzjq0lB7C+t1xAUUl5PyKJuYI+VZmfekieOVfeC3WFxQJHjzR0n3r8yvfbd+6LLXAXR71ZJQpBa405Z6EHgCysOOua2WYaAOIbmwcJdvSt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s7tyEHQ0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s7tyEHQ0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC630C4CED6;
	Wed, 26 Feb 2025 18:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740595328;
	bh=3/4RYj3Peq9LAIKfSrxEMRx2d7CU/6V42ttG2XzmwuU=;
	h=From:To:Cc:Subject:Date:From;
	b=s7tyEHQ00rVHzmlYEqJ9Le5PmkCHox4ccXkJRN7uH7uGX+8sQjezExCasvhV7eFM1
	 +mcAZgO0xwJJUKkRW53H0zM1x2qeCEM001ilq+cXt4nfwrWX0Z8EoLkYW8PWxK6EL5
	 jtDfHSBnSuT5RyqwLNTwcYNFbJpIknzexuWXZ5xk8AXiUYImkCxGXYFORPM08ZTztS
	 mF7DMZnoj3aemVDENiwETLZNKNmpDtsorc5QydGeCaQRFqd4Tu1OefwXz0gf/Hj0Vv
	 JVBAvPt01v1ZYVuDXtW70unW2gLekOX8d1Pk/TOX5riCUlFwuZPMV3sVOuAeYk0ysS
	 HBFGlpI0jmDlw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: bus710 <bus710@gmail.com>,
	SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH] samples/damon: a typo in the kconfig - sameple
Date: Wed, 26 Feb 2025 10:42:04 -0800
Message-Id: <20250226184204.29370-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bus710 <bus710@gmail.com>

There is a typo in the Kconfig file of the damon sample module.
Correct it: s/sample/sample/

Signed-off-by: bus710 <bus710@gmail.com>
Reviewed-by: SeongJae Park <sj@kernel.org>
Signed-off-by: SeongJae Park <sj@kernel.org>
---

Chagens from v1
(https://patch.msgid.link/20250224180709.2167187-1-bus710@gmail.com)
- Wordsmith the message

 samples/damon/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/samples/damon/Kconfig b/samples/damon/Kconfig
index 63f6dcd71daa..564c49ed69a2 100644
--- a/samples/damon/Kconfig
+++ b/samples/damon/Kconfig
@@ -3,7 +3,7 @@
 menu "DAMON Samples"
 
 config SAMPLE_DAMON_WSSE
-	bool "DAMON sameple module for working set size estimation"
+	bool "DAMON sample module for working set size estimation"
 	depends on DAMON && DAMON_VADDR
 	help
 	  This builds DAMON sample module for working set size estimation.
@@ -15,7 +15,7 @@ config SAMPLE_DAMON_WSSE
 	  If unsure, say N.
 
 config SAMPLE_DAMON_PRCL
-	bool "DAMON sameple module for access-aware proactive reclamation"
+	bool "DAMON sample module for access-aware proactive reclamation"
 	depends on DAMON && DAMON_VADDR
 	help
 	  This builds DAMON sample module for access-aware proactive

base-commit: 489e7430013060843b4f7f1ad3935ff58fbd5bfb
-- 
2.39.5
